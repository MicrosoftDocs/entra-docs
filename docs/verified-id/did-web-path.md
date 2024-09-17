---
title: How to add did:web:path support
description: Learn how to enable support for did:web:path
documentationCenter: ''
author: barclayn
manager: amycolannino
ms.service: entra-verified-id
ms.topic: how-to

ms.date: 12/06/2023
ms.author: barclayn

#Customer intent: As an administrator, I'm looking for information to help me add support for did:web:path.
---

# Enable support for did:web:path

In this article, we go over the steps to enable support for did:web:path to your authority.

## Prerequisites

- Verified ID authority is [manually onboarded](verifiable-credentials-configure-tenant.md) using did:web. [Quick setup](verifiable-credentials-configure-tenant-quick.md) uses a domain name managed by Microsoft which can't be extended by yourself.

## What is did:web:path?

Did:web:path is described in the [did:web Method Specification](https://w3c-ccg.github.io/did-method-web/#optional-path-considerations). If you have an environment where you are required to use a high number of authorities, acquiring domain names for them becomes a problem. Using one single domain and having the different authorities appear as paths under the domain may be a more favourable approach.  

## Enable domain for did:web:path support

By default, a tenant and an authority isn't enabled to support did:web:path. You request enablement of did:web:path for your authority via creating a new support request in the [Entra admin center](https://entra.microsoft.com/#blade/Microsoft_Azure_Support/NewSupportRequestV3Blade/callerName/ActiveDirectory/issueType/technical).

Support ticket details:

- Issue type: `Technical`
- Service type: `Microsoft Entra Verified ID`
- Problem type: `Configuration organization and domains`
- Summary: `Enable did:web:path request`
- Description: Make sure to include
    - Your Entra `tenant ID` 
    - Your `did` (example: did:web:verifiedid.contoso.com)
    - Estimated number of sub paths
    - Business justification 

## How can I test that my authority is enabled?

You will be given confirmation on your support request, but you can also verify if a did:web domain is enabled for did:web:path by testing it in a normal browser. By adding a path that doesn't exist (:do-not-exist in the below case) you will get and error message with code `discovery_service.web_method_path_not_supported` if your authority isn't enabled, but the code `discovery_service.not_found` if it is enabled.

```http
https://discover.did.msidentity.com/v1.0/identifiers/did:web:my-domain.com:do-not-exist
```

## How do I configure an authority using did:web:path?

Once your tenant and authority is enabled for did:web:path, you can create a new authority in the same tenant that uses did:web:path. Currently this requires using the [Admin API](admin-api.md) as there is no support in the portal for it.

1. Get details of your existing authority
    - Go to `Verified ID | Overview` and copy domain (example: https://verifiedid.contoso.com/)
    - Go to `Verified ID | Organization settings` and take a note of which Key vault is being configured.
    - Go to the Key vault resource and copy the `resource group`, the `subscription ID` and the `Vault URI`
2. Call the [create authority](admin-api.md#create-authority) with the following JSON body (modify as required). Note especially the `/my-path` part as that is where you specify the path name to be used.

```JSON
POST /v1.0/verifiableCredentials/authorities

{
  "name":"ExampleNameForPath",
  "linkedDomainUrl":"https://my-domain.com/my-path",
  "didMethod": "web",
  "keyVaultMetadata":
  {
    "subscriptionId":"aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
    "resourceGroup":"verifiablecredentials",
    "resourceName":"vccontosokv",
    "resourceUrl": "https://vccontosokv.vault.azure.net/"
  }
}
```

3. Generate the did document for the new authority by calling [generateDidDocument](admin-api.md#generate-did-document) where `newAuthorityIdForPath` is the id in the create authority response:

```JSON
POST /v1.0/verifiableCredentials/authorities/:newAuthorityIdForPath/generateDidDocument
```

4. Save the did document response to a file named `did.json` and upload it to location on your webserver that matches the `linkedDomainUrl` in the create authority call. If your path is `https://my-domain.com/my-path`, the new did.json file must reside in that location.

5. Retrieve the linked domain did configuration via calling [generateWellknownDidConfiguration](admin-api.md#well-known-did-configuration) API with the following JSON body (modify as required). Note that the domainUrl is the domain name ***without*** the path

```JSON
POST /v1.0/verifiableCredentials/authorities/:newAuthorityIdForPath/generateWellknownDidConfiguration

{
    "domainUrl":"https://my-domain.com/"
}
```

6. From the response, copy the JWT token inside the `linked_dids` collection.

7. On your webserver, open the file `https://my-domain.com/.well-known/did.configuration.json` in an editor and add the JWT token as a new entry inside the linked_dids collection. It should look something like this after adding it.

```JSON
{
  "@context": "https://identity.foundation/.well-known/contexts/did-configuration-v0.0.jsonld",
  "linked_dids": [
    "eyJh...old...U7cw",
    "eyJh...new...V8dx",
  ]
}
```

8. Save the file.

## Creating contracts using the new did:web:path authority

Contracts needs to be created using the [Admin API](admin-api.md#contracts) as there is currently no user interface support for secondary authorities.

## Issuing credentials based contracts in the new did:web:path authority

In order to have apps issue credentials based on contracts in the new did:web:path authority, you only need to change the `authority` field in the request payload to [createIssuanceRequest](issuance-request-api.md#issuance-request-payload) API.

```JSON
{
  "authority": "did:web:my-domain.com:my-path",
  "includeQRCode": false,
  ... the rest is the came...
}
```
