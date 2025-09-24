---
title: Upgrade signing keys
description: Learn how to upgrade Microsoft Entra Verified ID signing keys to become FIPS compliant.
documentationCenter: ''
author: barclayn
manager: pmwongera
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 11/11/2025
ms.author: barclayn

#Customer intent: As an administrator, I'm looking for information on how to upgrate signing keys to become FIPS compliant.
---

# Upgrade signing key to become FIPS compliant

In this article, we review the steps to upgrade your Microsoft Entra Verified ID signing keys to become FIPS compliant. The majority of authorities are already FIPS compliant. It is only authorities created before Februrary 2024 using [Advanced Setup](verifiable-credentials-configure-tenant.md) method that require signing key upgrade. `Quick Setup` authorities are not affected as they already use the compliant P-256 signing key.

## Do I need to upgrade?

The P-256K key type is not FIPS compliant. If you want your Verified ID system to become FIPS compliant, and you are using the P-256K key, you need to upgrade your signing key.

## What happens if I don't need to become FIPS compliant?

Microsoft advises that you upgrade anyway as the support for P-256K signing key could be discontinued in the future.

## How do I check if I need to upgrade?

1. Check that your authority was set up using `Advanced Setup`. If your DID does ***not*** start with `did:web:verifiedid.entra.microsoft.com`, it was set up using `Advanced Setup` method. You can inspect your DID in the `Organization settings` in the portal or via the [Get authority](admin-api.md#get-authority) Admin API.
1. Check if your authority is using the P-256K/secp256k1 signing key. You can determind the key type in two ways:
    1. In Azure Key Vault for your signing key identifier, inspect that the `Elliptic curve name` has a value of `P-256K`. Your Key Vault key is visible in the `Signing key identifier` field in the `Organization settings` in the portal.
    1. Viewing your DID document, inspect the ***first*** entry of the `verificationMethod` collection and see that the `crv` attribute has a value of `secp256k1`. You can retrieve your DID Document via URL `https://<your-domain>/.well-known/did.json`.

## Prerequisites for upgrading

- The admin user performing key upgrade must have [permission to the keys](verifiable-credentials-configure-tenant.md) in Key Vault.

## Upgrading the signing key

Upgrading the signing key is a 7 step operation:

1. Call the [didInfo/signingKeys](admin-api.md#create-signing-key) API to create a new P-256 signing key in Key Vault. The access token in the call must be for an admin user with access to keys in the key vault. The `didDocumentStatus` attribute for the authority changes to an `outOfSync` value, which indicates that there's a discrepancy between Key Vault and the publicly available `did.json` document.
1. Call the [generateDIDDocument](admin-api.md#generatediddocument) API to generate a new DID document. Save the response as a file named `did.json`. The generated DID document contains both the new P-256 key and the old P-256K key. If you have rotated signing keys previously, the DID document will contain several P-256K entries.
1. Replace `did.json` on all web servers where it was previously deployed. Before you continue, make sure that you can retrieve the new `did.json` document from the public internet with a browser.
1. Call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) API to start using the new P-256 signing key. This API call validates that Key Vault and the public `did.json` document match. If they match, the Verified ID authority starts signing by using the new key in Key Vault. From this point, your authority will sign using the new P-256 key. As your DID document also contains the old P-256K key(s), previously issued credentials, signed by a P-256K key, will continue to work in presentations. The `didDocumentStatus` in the returned authority JSON object has a value of `published`. If the value still is `outOfSync`, there's a discrepancy between Key Vault and the `did.json` document and the previous key is still used for signing.
1. Call the [generateWellKnownDidConfiguration](admin-api.md#well-known-did-configuration) API to regenerate the linked domain configuration. Save the response as a file named `did-configuration.json`. Technically, you could delay this step as the old P-256K keys that was used to sign the linked domain configuration is still available in the DID document, but performing this step here is a good test that the new signing key is active.
1. Replace `did-configuration.json` on all web servers where it was previously deployed. Before you continue, make sure that you can retrieve the new `did-configuration.json` document from the public internet with a browser.
1. Call the [validateWellKnownDidConfiguration](admin-api.md#validate-well-known-did-configuration) API to set the linked domain status to `verified`.

## What happens after I've upgraded?

Any signing activities, like issuing credentials or making presentation requests, will be signed by your new P-256 key.
Credentials that were issued before the signing key upgrade, and was signed by your old P-256K key, continue to work as long as you have the keys in your DID document. When time comes to reissue these credentials, they will be reissued using the new P-256 key.
Eventually, you will have no credentials signed by the old key. If your credentials have a long lifetime before they expire, and you want to stop using the old P-256K, you should consider instructing your users to reissue in advance.
If you want to remove old P-256K keys from your DID document, first ensure that your users have reissued their credentials, then disable the old P-256K keys in your Key Vault before you regenerate and redploy your DID document.

## Next steps

- [Tutorial for issuing a verifiable credential](verifiable-credentials-configure-issuer.md)