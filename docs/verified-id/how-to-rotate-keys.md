---
title: How to rotate signing keys
description: Learn how to rotate signing keys
documentationCenter: ''
author: barclayn
manager: amycolannino
ms.service: decentralized-identity
ms.topic: how-to
ms.subservice: verifiable-credentials
ms.date: 06/14/2022
ms.author: barclayn

#Customer intent: As an administrator, I am looking for information how to rotate signing keys 
---

# How to rotate signing keys

[!INCLUDE [Verifiable Credentials announcement](~/../azure-docs-pr/includes/verifiable-credentials-brand.md)]


## Prerequisites

- Verified ID authority is [manually onboarded](verifiable-credentials-configure-tenant.md) and the signing keys are in your own Azure Key Vault. [Quick setup](verifiable-credentials-configure-tenant-quick.md) uses shared signing key, managed by Microsoft, that you can’t rotate yourself.
- Admin user performing key rotation must have [permission to keys](verifiable-credentials-configure-tenant.md#set-access-policies-for-the-verified-id-admin-user) in Azure Key Vault.


## Steps to rotate signing keys

The public keys are available in the DID document for anyone in need of verifying signatures produced by an issuer. For an authority using the did:web method, the did document is available at https://contoso.com/.well-known/did.json, where contoso.com is just an example. This means that Verified ID shouldn’t  start signing using the new key until an updated version is publicly available on the webserver. If you're using a multi-region deployment, perhaps with CDN, it may take some time for your deployment process to get the updated did.json in place. To help admins perform rotation of signing keys without any service disruption, the process of rotation follows these steps:

1.	Call the [signingKeys/rotate](admin-api.md#rotate-signing-key) API to create a new signing key in Azure Key Vault. The access token in the call must be for an admin user with access to keys in the Azure Key Vault. This sets a new Current key in Key Vault and the previous key moved to older keys but still be enabled. The response is the authority JSON object with the attribute `didDocumentStatus` having a value `outOfSync` indicating that there's a discrepancy between Key Vault and the publicly available did.json document.
   :::image type="content" source="media/how-to-rotate-keys/new-key-in-key-vault.png" alt-text="Screenshot of new key in Key Vault.":::
1.	Go to [Setup](https://entra.microsoft.com/#view/Microsoft_AAD_DecentralizedIdentity/SetupBlade) in Verified ID portal and click on Register Decentralized ID and copy or download the updated did.json file. It now contains the new and the old keys.
   :::image type="content" source="media/how-to-register-didwebsite/how-to-register-didwebsite-diddoc.png" alt-text="Screenshot of did.json.":::
1.	Replace did.json on all webservers it was previously deployed at. If you edited it manually, make sure it still has valid JSON syntax with a tool like https://jsonformatter.org/. Before continuing, make sure that you can retrieve the new did.json document from the public internet with a browser.
1.	Call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) API to start using the new signing key. This API call validates that Key Vault and the public did.json document matches. If they match, the Verified ID authority starts signing using the new key in Key Vault. The `didDocumentStatus` in the returned authority JSON object have a value of `published`. If the value still is `outOfSync`, then there is a discrepancy between Key Vault and the did.json document and the previous key is still used for signing.

## Do I need to rotate keys in Verified ID?
Technically you don’t need to rotate signing keys in Verified ID if you're using your own Azure Key Vault. The current signing key does not expire. However, as with any public/private key solution, it's best practice to rotate keys periodically.

## What happens when I rotate the signing key?
After successfully performing step 1-4, Verified ID has a new signing key and any JWT tokens signed from that moment is signed using the new key. This means issuance and presentation requests and issued credentials are being signed using the new key.

## What happens to credentials signed by the old key(s)?
Issued Verified ID credentials signed by a key that is no longer current continues to work as long as the public key is available in the public did.json document and the key is not disabled or deleted in Key Vault.

## What happens when old signing keys are no longer available?
If a key that was used to sign an issued Verified ID credential isn't in the public did.json document, any verification attempt fails as the verifier is not able to resolve the public key used as signature. There are two scenarios to be aware of.
 
**First**, Verified ID has a limit 10 keys being used internally. It's one current key and nine previous keys. If Key Vault contains 12 keys, Verified ID only loads and use the first 10. You can’t manually edit the did.json document to add old keys as that leads to a mismatch between what Verified ID loads and what the did.json document holds. Trying to call the [synchronizeWithDidDocument](admin-api.md#synchronize-with-did-document) in this case results in `didDocumentStatus` returning `outOfSync`. If, for example, you have 12 keys in Key Vault and you want Verified ID not to load keys 8 and 9 in the list of keys. Then you need to disable keys 8 and 9 in Key Vault, then perform [steps 2-4](#steps-to-rotate-signing-keys).

**Second**, if you, for example, rotate 12 times, the two oldest two keys aren't used loaded by Verified ID anymore. Any Verified ID credential issued using those two keys can’t be verified anymore.

>[!NOTE]
> Your key rotation policy needs to be coordinated with the lifetime of issued Verified ID credentials so that credentials are renewed/reissued before an old key is retired. An example that doesn't work is issuing Verified ID credentials with an expiry date 12 months away and at the same time have a key rotation policy to rotate keys every month. Such a solution is in trouble the last two months of the year as old keys are not available anymore.

## Can I rotate keys directly in Azure Key Vault instead of calling the Verified ID API?
You shouldn't use the rotate feature in Azure Key Vault’s admin portal as Verified ID performs more tasks when calling the /signingKeys/rotate API than just rotating the key in Key Vault.

## Next steps

- [Tutorial for issue a verifiable credential](verifiable-credentials-configure-issuer.md)