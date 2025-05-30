---
title: Rotate signing keys
description: Learn how to rotate Microsoft Entra Verified ID signing keys.
documentationCenter: ''
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: how-to
ms.date: 01/31/2025
ms.author: barclayn

#Customer intent: As an administrator, I'm looking for information on how to rotate signing keys.
---

# Rotate signing keys

In this article, we review the steps to rotate your Microsoft Entra Verified ID signing keys.

## Prerequisites

- Verified ID authority is [manually onboarded](verifiable-credentials-configure-tenant.md), and the signing keys are in your own Azure Key Vault instance. [Quick setup](verifiable-credentials-configure-tenant-quick.md) uses a shared signing key, managed by Microsoft, that you can't rotate yourself.
- The admin user performing key rotation must have [permission to the keys](verifiable-credentials-configure-tenant.md) in Key Vault.

## Rotate the signing keys

The public keys are available in the decentralized identifier (DID) document for anyone who needs to verify signatures produced by an issuer. For an authority using the `did:web` method, the DID document is available at `https://contoso.com/.well-known/did.json`, where contoso.com is an example.

Verified ID shouldn't start signing by using the new key until an updated version is publicly available on the web server. If you're using a multiregion deployment, perhaps with Azure Content Delivery Network, it might take some time for your deployment process to get the updated `did.json` in place.

To help admins perform rotation of signing keys without any service disruption, the process of rotation follows these steps:

1. Call the [signingKeys/rotate](admin-api.md#rotate-signing-key) API to create a new signing key in Key Vault. The access token in the call must be for an admin user with access to keys in the key vault. This action sets a new **Current** key in the key vault. The previous key is moved to older keys, but it can still be enabled. The response is the authority JSON object with the attribute `didDocumentStatus` having an `outOfSync` value, which indicates that there's a discrepancy between Key Vault and the publicly available `did.json` document.

    :::image type="content" source="media/how-to-rotate-keys/new-key-in-key-vault.png" alt-text="Screenshot that shows a new key in Key Vault.":::
1. Go to [Setup](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/SetupBlade) in the Verified ID portal. Select **Register Decentralized ID** and copy or download the updated `did.json` file. It now contains the new and the old keys.

    :::image type="content" source="media/how-to-register-didwebsite/how-to-register-didwebsite-diddoc.png" alt-text="Screenshot that shows did.json.":::
1. Replace `did.json` on all web servers where it was previously deployed. If you edited it manually, make sure it still has valid JSON syntax by using a tool like `https://jsonformatter.org/`. Before you continue, make sure that you can retrieve the new `did.json` document from the internet with a browser.

1. Call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) API to start using the new signing key. This API call validates that Key Vault and the public `did.json` document match. If they match, the Verified ID authority starts signing by using the new key in Key Vault. The `didDocumentStatus` in the returned authority JSON object has a value of `published`. If the value still is `outOfSync`, there's a discrepancy between Key Vault and the `did.json` document and the previous key is still used for signing.

## Do I need to rotate keys in Verified ID?

Technically, you don’t need to rotate signing keys in Verified ID if you're using your own Key Vault instance. The current signing key doesn't expire. As with any public/private key solution, it's a best practice to rotate keys periodically.

## What happens when I rotate the signing key?

After you successfully perform steps 1-4, Verified ID has a new signing key and any JSON web tokens signed from that moment are signed by using the new key. This means issuance and presentation requests and issued credentials are being signed by using the new key.

## What happens to credentials signed by the old key?

Issued Verified ID credentials signed by a key that's no longer current continues to work if the public key is available in the public `did.json` document and the key isn't disabled or deleted in Key Vault.

## What happens when old signing keys are no longer available?

If a key that was used to sign an issued Verified ID credential isn't in the public `did.json` document, any verification attempt fails because the verifier isn't able to resolve the public key used as a signature. There are two scenarios to be aware of.

**First:** Verified ID has a limit of 10 keys that can be used internally. They comprise one current key and nine previous keys. If Key Vault contains 12 keys, Verified ID only loads and uses the first 10. You can't manually edit the `did.json` document to add old keys because that leads to a mismatch between what Verified ID loads and what the `did.json` document holds. Trying to call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) in this case results in `didDocumentStatus` returning `outOfSync`.

For example, say you have 12 keys in Key Vault and you want Verified ID to not load keys 8 and 9 in the list of keys. You must disable keys 8 and 9 in Key Vault and then perform [steps 2-4](#rotate-the-signing-keys).

**Second:** In this example, if you rotate keys 12 times, Verified ID doesn't load the two oldest keys anymore. Any Verified ID credential issued using those two keys can't be verified anymore.

>[!NOTE]
> Your key rotation policy needs to be coordinated with the lifetime of issued Verified ID credentials so that credentials are renewed or reissued before an old key is retired. An example of a solution that doesn't work is issuing Verified ID credentials with an expiration date 12 months away and at the same time having a key rotation policy to rotate keys every month. Such a solution is in trouble the last two months of the year because old keys aren't available anymore.

## Can I rotate keys directly in Key Vault instead of calling the Verified ID API?

You shouldn't use the rotate feature in Key Vault's admin portal. Verified ID performs more tasks when it calls the /signingKeys/rotate API than just rotating the key in Key Vault.

## Next steps

- [Tutorial for issuing a verifiable credential](verifiable-credentials-configure-issuer.md)