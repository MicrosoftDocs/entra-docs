---
title: Upgrade signing keys
description: Learn how to upgrade Microsoft Entra Verified ID signing keys to become FIPS compliant.
documentationCenter: ''
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 01/31/2025
ms.author: barclayn

#Customer intent: As an administrator, I'm looking for information on how to upgrade signing keys to become FIPS compliant.
---

# Upgrade signing key to become FIPS compliant

In this article, we review the steps to upgrade your Microsoft Entra Verified ID signing keys to become FIPS compliant. 
Most of authorities are already FIPS compliant. It's only authorities created before February 2024 using [Advanced Setup](verifiable-credentials-configure-tenant.md) method that require signing key upgrade. [Quick Setup](verifiable-credentials-configure-tenant-quick.md) authorities are already FIPS compliant and are using P-256 signing keys.

## Do I need to upgrade?

The P-256K key type isn't FIPS compliant. If you want your Verified ID system to become FIPS compliant, and you're using the P-256K key, you need to upgrade your signing key. 

## What happens if I don't need to become FIPS compliant?

Microsoft advises that you upgrade anyway as the support for P-256K signing key in Verified ID could be discontinued in the future.

## How do I check if I need to upgrade?

1. Check that your authority was set up using `Advanced Setup`. If your DID does ***not*** start with `did:web:verifiedid.entra.microsoft.com`, it was set up using `Advanced Setup` method. You can inspect your DID in the `Organization settings` in the portal or via the [Get authority](admin-api.md#get-authority) Admin API.

1. Check if your authority is using the P-256K/secp256k1 signing key. You can determine the key type in two ways:

    1. In Azure Key Vault for your signing key identifier, inspect that the `Elliptic curve name` has a value of `P-256K`. Your Key Vault key is visible in the `Signing key identifier` field in the `Organization settings` in the portal. 

    1. Viewing your DID document, inspect the ***first*** entry of the `verificationMethod` collection and see that the `crv` attribute has a value of `secp256k1`. You can retrieve your DID Document via URL `https://<your-domain>/.well-known/did.json`.

## Prerequisites for upgrading

- The admin user performing key upgrade must have [permission to the keys](verifiable-credentials-configure-tenant.md) in Key Vault.

## Upgrading the signing key

Upgrading the signing key is a seven step operation:

1. Call the [didInfo/signingKeys](admin-api.md#create-signing-key) API to create a new P-256 signing key in Key Vault. The access token in the call must be for an admin user with access to keys in the key vault. The `didDocumentStatus` attribute for the authority changes to an `outOfSync` value, which indicates that there's a discrepancy between Key Vault and the publicly available `did.json` document.

1. Call the [generateDIDDocument](admin-api.md#generate-did-document) API to generate a new DID document. Save the response as a file named `did.json`. The generated DID document contains both the new P-256 key and the old P-256K key.

1. Replace `did.json` on all web servers where it was previously deployed. Before you continue, make sure that you can retrieve the new `did.json` document from the public internet with a browser.

1. Call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) API to start using the new P-256 signing key. This API call validates that Key Vault and the public `did.json` document match. If they match, the Verified ID authority starts signing by using the new key in Key Vault. From this point, your authority signs using the new P-256 key. As your DID document also contains one or more old P-256K key(s), previously issued credentials, signed by a P-256K key, continue to work in presentations. The `didDocumentStatus` in the returned authority JSON object has a value of `published`. If the value still is `outOfSync`, there's a discrepancy between Key Vault and the `did.json` document and the previous key is still used for signing.

1. Call the [generateWellKnownDidConfiguration](admin-api.md#well-known-did-configuration) API to regenerate the linked domain configuration. Save the response as a file named `did-configuration.json`. Technically, you could delay this step as the old P-256K keys that were used to sign the linked domain configuration is still available in the DID document. Performing this step here is a good test that the new signing key is active.

1. Replace `did-configuration.json` on all web servers where it was previously deployed. Before you continue, make sure that you can retrieve the new `did-configuration.json` document from the public internet with a browser.

1. Call the [validateWellKnownDidConfiguration](admin-api.md#validate-well-known-did-configuration) API to set the linked domain status to `verified`. 

## Post upgraded considerations

Any signing activities, like issuing credentials or making presentation requests, are now signed by your new P-256 key. 

Credentials that were issued before the signing key upgrade are signed by your old P-256K key. These credentials continue to work as long as you have the old P-256K keys in your DID document. When time comes to reissue these credentials, they are signed using the new P-256 key. 

Eventually, you have no credentials signed by the old key as they all expire and new ones are issued. If your credentials have a long lifetime before they expire, and you want to stop using the old P-256K key, you should consider instructing your users to reissue in advance.

If you want to remove old P-256K keys from your DID document, ensure that your users have reissued their credentials. Then disable the old P-256K keys in your Key Vault and you regenerate and redeploy your DID document.

## Next steps

- [Tutorial for issuing a verifiable credential](verifiable-credentials-configure-issuer.md)