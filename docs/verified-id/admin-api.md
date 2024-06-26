---
title: Admin API for managing Microsoft Entra Verified ID
titleSuffix: Microsoft Entra Verified ID
description: Learn how to manage your verifiable credential deployment using Admin API.
documentationCenter: ''
author: barclayn
manager: amycolannino
ms.service: entra-verified-id
ms.topic: reference

ms.date: 07/28/2022
ms.author: barclayn

#Customer intent: As an administrator, I am trying to learn how to use the Admin API and automate my tenant.
---

# Verifiable credentials admin API

  
The Microsoft Entra Verified ID Admin API enables you to manage all aspects of the Verifiable Credential service. It offers a way to set up a brand new service, manage and create Verifiable Credential contracts, revoke Verifiable Credentials and completely opt out the service as well.

> The API is intended for developers comfortable with RESTful APIs and enough permissions on the Microsoft Entra tenant to enable the service

## Base URL

The Admin API is server over HTTPS. All URLs referenced in the documentation have the following base: `https://verifiedid.did.msidentity.com`.

## Authentication

The API is protected through Microsoft Entra ID and uses OAuth2 bearer tokens. The access token can be for a user or for an application.

### User bearer tokens

The app registration needs to have the API Permission for `Verifiable Credentials Service Admin` and then when acquiring the access token the app should use scope `6a8b4b39-c021-437c-b060-5a14a3fd65f3/full_access`. The access token must be for a user with the [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) or the [authentication policy administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) role. A user with role [global reader](~/identity/role-based-access-control/permissions-reference.md#global-reader) can perform read-only API calls.

### Application bearer tokens

The `Verifiable Credentials Service Admin` service supports the following application permissions.

| Permission | Description |
| ---------- | ----------- |
| VerifiableCredential.Authority.ReadWrite | Permission to read/write authority object(s) |
| VerifiableCredential.Contract.ReadWrite | Permission to read/write contract object(s) |
| VerifiableCredential.Credential.Search | Permission to search for a credential to revoke |
| VerifiableCredential.Credential.Revoke | Permission to [revoke a previously issued credential](how-to-issuer-revoke.md) |
| VerifiableCredential.Network.Read | Permission to read entries from the [Verified ID Network](vc-network-api.md) |

The app registration needs to have the API Permission for `Verifiable Credentials Service Admin` and permissions required from the above table. When acquiring the access token, via the [client credentials flow](~/identity-platform/v2-oauth2-client-creds-grant-flow.md), the app should use scope `6a8b4b39-c021-437c-b060-5a14a3fd65f3/.default`.

If the app intends to create a new authority, it needs two things. First, the app registration needs the `VerifiableCredential.Authority.ReadWrite` permission. Second, the app needs have `Create Key` permission in Key Vaults Access Policies. If the app only read/writes existing authorities, it does not need the Key Vault permission.

## Onboarding

This API is to help create a new environment so new authorities can be set up. This can be triggered manually by navigating to the Verifiable Credential page in the Azure portal as well. You only need to call this API once and only if you want to set up a brand new environment just with the API.

#### HTTP request

`POST /v1.0/verifiableCredentials/onboard`

Use this endpoint to finish provisioning of the Verifiable Credential service in your tenant. The system creates the rest of the service principals if these aren't provisioned yet.

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization     | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Return message

```
HTTP/1.1 201 Created
Content-type: application/json

{
    "id": "f5bf2fc6-7135-4d94-a6fe-c26e4543bc5a",
    "verifiableCredentialServicePrincipalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "verifiableCredentialRequestServicePrincipalId": "bbbbbbbb-cccc-dddd-2222-333333333333",
    "verifiableCredentialAdminServicePrincipalId": "cccccccc-dddd-eeee-3333-444444444444",
    "status": "Enabled"
}
```

Repeatedly calling this API results in the exact same return message.

## Authorities

This endpoint can be used to create or update a Verifiable Credential service instance.

### Methods


| Methods | Return Type | Description |
| -------- | -------- | -------- |
| [Get Authority](#get-authority) | Authority | Read properties of an authority |
| [List Authority](#list-authorities)     | Authority array     | Get a list of all configured Authorities/verifiable credential services     |
| [Create Authority](#create-authority) | Authority | Create a new authority |
| [Update authority](#update-authority) | Authority | Update authority |
| [Delete authority](#delete-authority) | Authority | Delete authority |
| [Generate Well known DID Configuration](#well-known-did-configuration) | | |
| [Generate DID Document](#generate-did-document) | | |
| [Validate Well-known DID config](#validate-well-known-did-configuration) | | |
| [Rotate Signing Key](#rotate-signing-key) | Authority | Rotate signing key |
| [Synchronize with DID Document](#synchronize-with-did-document) | Authority | Synchronize DID document with new signing key |


### Get authority

Retrieve the properties of a configured authority or verifiable credential service instance.

#### HTTP request

`GET /v1.0/verifiableCredentials/authorities/:authorityId`

Replace the `:authorityId` with the value of one of the configured authorities.

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method

#### Response message

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
    "name": "ExampleAuthorityName",
    "status": "Enabled",
    "didModel": {
        "did": "did:web:verifiedid.contoso.com",
        "signingKeys": [
            "https://vccontosokv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/5257c49db8164e198b4c5997e8a31ad4"
        ],
        "recoveryKeys": [],
        "updateKeys": [],
        "encryptionKeys": [],
        "linkedDomainUrls": [
            "https://verifiedid.contoso.com/"
        ],
        "didDocumentStatus": "published"
    },
    "keyVaultMetadata": {
        "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "resourceGroup": "verifiablecredentials",
        "resourceName": "vccontosokv",
        "resourceUrl": "https://vccontosokv.vault.azure.net/"
    }
}

```

The response contains the following properties.

#### Authority type

| Property | Type | Description |
| -------- | -------- | -------- |
| `Id`     | string | An autogenerated unique ID, which can be used to retrieve or update the specific instance of the verifiable credential service     |
| `name` | string | The friendly name of this instance of the verifiable credential service |
| `status` | string | status of the service, this value will always be `enabled` |
| [didModel](#didmodel-type) | didModel | Information about the DID and keys |
| [keyVaultMetadata](#keyvaultmetadata-type) | keyVaultMeta data | Information about the used Key Vault  |


#### didModel type

#### Web

| Property | Type | Description |
| -------- | -------- | -------- |
| `did` | string | The DID for this verifiable credential service instance |
| `signingKeys` | string array | URL to the signing key |
| `linkedDomainUrls` | string array | Domains linked to this DID, expecting one single entry |
| [didModel](#didmodel-type) | didModel | Information about the DID and keys |
| `didDocumentStatus` | string | status of the DID, value is always `published` for this method |


#### keyVaultMetadata type

| Property | Type | Description |
| -------- | -------- | -------- |
| `subscriptionId` | string | The Azure subscription this Key Vault resides |
| `resourceGroup` | string | name of the resource group from this Key Vault |
| `resourceName` | string | Key Vault name |
| `resourceUrl` | string | URL to this Key Vault |


### List authorities

Get all configured authorities or verifiable credential services for this tenant

#### HTTP request

`GET /v1.0/verifiableCredentials/authorities`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization     | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

Response message is an array of [Authorities](#authority-type)

Example:
```
HTTP/1.1 200 OK
Content-type: application/json
{
    value:

    [
        {
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "name": "AuthorityName",
            "status": "Enabled",
            "didModel": {
                "did": "did:web:verifiedid.contoso.com",
                "signingKeys": [
                    "https://vccontosokv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/5257c49db8164e198b4c5997e8a31ad4"
                ],
                "recoveryKeys": [],
                "updateKeys": [],
                "encryptionKeys": [],
                "linkedDomainUrls": [
                    "https://verifiedid.contoso.com/"
                ],
                "didDocumentStatus": "published"
            },
            "keyVaultMetadata": {
                "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
                "resourceGroup": "verifiablecredentials",
                "resourceName": "vccontosokv",
                "resourceUrl": "https://vccontosokv.vault.azure.net/"
            }
        },
        {
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "name": "AuthorityName2",
            "keyVaultUrl": "https://vccontosokv.vault.azure.net/",
            "status": "Enabled",
            "didModel": {
                "did": "did:web:verifiedid2.contoso.com",
                "signingKeys": [
                    "https://vccontosokv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/f8f149eaee194beb83dfca14714ef62a"
                ],
                "recoveryKeys": [],
                "updateKeys": [],
                "encryptionKeys": [],
                "linkedDomainUrls": [
                    "https://verifiedid2.contoso.com/"
                ],
                "didDocumentStatus": "published"
            },
            "keyVaultMetadata": {
                "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
                "resourceGroup": "verifiablecredentials",
                "resourceName": "vccontosokv",
                "resourceUrl": "https://vccontosokv.vault.azure.net/"
            }
        }
    ]
}
```

### Create authority

This call creates a new **private key**, recovery key and update key, stores these keys in the specified Azure Key Vault and sets the permissions to this Key Vault for the verifiable credential service and a create new **DID** with corresponding DID Document.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

In the request body, supply a JSON representation of the following

| Property | Type | Description |
| -------- | -------- | -------- |
| `name` | string | The display name of this instance of the service |
| `linkedDomainUrl` | string | The domain linked to this DID |
| `didMethod` | string | Must be `web` |
| `keyVaultMetadata` | keyVaultMetadata | meta data for specific key vault |

Example message:
```
{
  "name":"ExampleName",
  "linkedDomainUrl":"https://verifiedid.contoso.com/",
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

#### Response message

When successful the response message contains the name of the [authority](#authority-type)

Example message for did:web:
```
{
    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
    "name": "APItesta",
    "status": "Enabled",
    "didModel": {
        "did": "did:web:verifiedid.contoso.com",
        "signingKeys": [
            "https://vcwingtipskv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/5255b9f2d9b94dc19a369ff0d36e3407"
        ],
        "recoveryKeys": [],
        "updateKeys": [],
        "encryptionKeys": [],
        "linkedDomainUrls": [
            "https://verifiedid.contoso.com/"
        ],
        "didDocumentStatus": "published"
    },
    "keyVaultMetadata": {
        "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "resourceGroup": "verifiablecredentials",
        "resourceName": "vcwingtipskv",
        "resourceUrl": "https://vcwingtipskv.vault.azure.net/"
    },
    "linkedDomainsVerified": false
}
```


Example message for did:ion:

```
HTTP/1.1 201 Created
Content-type: application/json

{
    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
    "name": "APItest6",
    "status": "Enabled",
    "didModel": {
        "did": "did:web:verifiedid.contoso.com",
        "signingKeys": [
            "https://vccontosokv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/f8f149eaee194beb83dfca14714ef62a"
        ],
        "recoveryKeys": [],
        "updateKeys": [],
        "encryptionKeys": [],
        "linkedDomainUrls": [
            "https://verifiedid.contoso.com/"
        ],
        "didDocumentStatus": "submitted"
    },
    "keyVaultMetadata": {
        "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "resourceGroup": "verifiablecredentials",
        "resourceName": "vccontosokv",
        "resourceUrl": "https://vccontosokv.vault.azure.net/"
    }
}

```

### Remarks

>You can create multiple authorities with their own DID and private keys, these will not be visible in the UI of the Azure portal. Currently we only support having 1 authority. We have not fully tested all scenarios with multiple created authorities. If you are trying this please let us know your experience.

### Update authority

This method can be used to update the display name of this specific instance of the verifiable credential service.

#### HTTP request

`PATCH /v1.0/verifiableCredentials/authorities/:authorityId`

Replace the value of `:authorityId` with the value of the authority ID you want to update.

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization     | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

In the request body, supply a JSON representation of the following.

| Property | Type | Description |
| -------- | -------- | -------- |
| `name` | string | The display name of this instance of the service |

Example message
```
{
  "name":"ExampleIssuerName"
}
```

### Delete authority

This method can be used to delete an authority. Currently only `did:ion` authorities can be deleted. When you delete an authority, any issued Verified ID credentials becomes invalid and cannot be verified anymore as the issuing authority is gone.

#### HTTP request

`DELETE /beta/verifiableCredentials/authorities/:authorityId`

Replace the value of `:authorityId` with the value of the authority ID you want to delete.

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization     | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

No request body

#### Response message

Example response message:

Successful delete authority response.

```
HTTP/1.1 200 OK
```

If delete of authority was successful but cleanup of Azure Key Vault keys had failed, you get the below response.

```
HTTP/1.1 400 Bad Request
Content-type: application/json

{
"error": {
        "code": "deleteIssuerSuccessfulButKeyDeletionFailed",
        "message": "The organization has been opted out of the Verifiable Credentials, but the following keys could not be deleted. To keep your organization secure, delete keys that are not in use. https://kxxxxxx.vault.azure.net/keys/vcSigningKey-9daeexxxxx-0575-23dc-81be-5f6axxxxx/0dcc532adb9a4fcf9902f90xxxxx"
    }
}

```

### Well-known DID configuration

The `generateWellknownDidConfiguration` method generates the signed did-configuration.json file. The file must be uploaded to the `.well-known` folder in the root of the website hosted for the domain in the linked domain of this verifiable credential instance. Instructions can be found [here](how-to-dnsbind.md#verify-domain-ownership-and-distribute-the-did-configurationjson-file).

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/generateWellknownDidConfiguration`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

You need to specify one of the domains in the linkedDomains of the specified authority.

```
{
    "domainUrl":"https://atest/"
}
```

#### Response message

Example response message:

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "@context": "https://identity.foundation/.well-known/contexts/did-configuration-v0.0.jsonld",
    "linked_dids": [
        "eyJhbGciOiJFUzI1NksiL...<SNIP>..."
    ]
}
```

Save this result with the file name did-configuration.json and upload this file to the correct folder and website. If you specify a domain not linked to this DID/DID Document, you receive an error:

```
HTTP/1.1 400 Bad Request
Content-type: application/json

{
  "requestId":"079192a95fbf56a661c1b2dd0e012af5",
  "date":"Mon, 07 Feb 2022 18:55:53 GMT",
  "mscv":"AVQh55YiU3FxMipB.0",
  "error":
  {
    "code":"wellKnownConfigDomainDoesNotExistInIssuer",
    "message":"The domain used as an input to generate the well-known document is not registered with your organization. Domain: https://wrongdomain/"
  }
}

```

#### Remarks

You can point multiple DIDs to the same domain. If you choose this configuration, you need to combine generated tokens and put them in the same did-configuration.json file. The file contains an array of these tokens.

For example:
```
{
    "@context": "https://identity.foundation/.well-known/contexts/did-configuration-v0.0.jsonld",
    "linked_dids": [
        "eyJhbG..token1...<SNIP>...",
        "eyJhbG..token2...<SNIP>..."
    ]
}
```

### Generate DID document

This call generates the DID Document used for DID:WEB identifiers. After generating this DID Document, the administrator has to place the file at the https://domain/.well-known/did.json location.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/generateDidDocument`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "did:web:verifiedid.contoso.com",
    "@context": [
        "https://www.w3.org/ns/did/v1",
        {
            "@base": "did:web:verifiedid.contoso.com"
        }
    ],
    "service": [
        {
            "id": "#linkeddomains",
            "type": "LinkedDomains",
            "serviceEndpoint": {
                "origins": [
                    "https://verifiedid.contoso.com/"
                ]
            }
        },
        {
            "id": "#hub",
            "type": "IdentityHub",
            "serviceEndpoint": {
                "instances": [
                    "https://verifiedid.hub.msidentity.com/v1.0/f640a374-b380-42c9-8e14-d174506838e9"
                ]
            }
        }
    ],
    "verificationMethod": [
        {
            "id": "#a2518db3b6b44332b3b667928a51b0cavcSigningKey-f0a5b",
            "controller": "did:web:verifiedid.contoso.com",
            "type": "EcdsaSecp256k1VerificationKey2019",
            "publicKeyJwk": {
                "crv": "secp256k1",
                "kty": "EC",
                "x": "bFkOsjDB_K-hfz-c-ggspVHETMeZm31CtuzOt0PrmZc",
                "y": "sewHrUNpXvJ7k-_4K8Yq78KgKzT1Vb7kmhK8x7_6h0g"
            }
        }
    ],
    "authentication": [
        "#a2518db3b6b44332b3b667928a51b0cavcSigningKey-f0a5b"
    ],
    "assertionMethod": [
        "#a2518db3b6b44332b3b667928a51b0cavcSigningKey-f0a5b"
    ]
}
```

#### Remark

Requires the caller to have the KEY List permissions on the target key vault.

### Validate well-known DID configuration

This call checks your DID setup. It downloads the well known DID configuration and validates if the correct DID is used and the signature is correct.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/validateWellKnownDidConfiguration`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.


#### Response message

```
HTTP/1.1 204 No Content
Content-type: application/json
```

### Rotate signing key

The rotate signing key creates a new private key for the did:web authority. The DID document should be re-registered to reflect the update. When this is done, the [synchronizeWithDidDocument](#synchronize-with-did-document) tells the system to start using the new key for signing.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/didInfo/signingKeys/rotate`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request Body

Don't supply a request body for this method.

#### Response message

The `didDocumentStatus` will change to `outOfSync`.

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
    "name": "APItesta",
    "status": "Enabled",
    "didModel": {
        "did": "did:web:verifiedid.contoso.com",
        "signingKeys": [
            "https://vcwingtipskv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/5255b9f2d9b94dc19a369ff0d36e3407"
        ],
        "recoveryKeys": [],
        "updateKeys": [],
        "encryptionKeys": [],
        "linkedDomainUrls": [
            "https://verifiedid.contoso.com/"
        ],
        "didDocumentStatus": "outOfSync"
    },
    "keyVaultMetadata": {
        "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "resourceGroup": "verifiablecredentials",
        "resourceName": "vcwingtipskv",
        "resourceUrl": "https://vcwingtipskv.vault.azure.net/"
    },
    "linkedDomainsVerified": false
}
```

### Synchronize with DID Document

After [rotating](#rotate-signing-key) the signing key, the DID document should be [re-registered](how-to-register-didwebsite.md#how-do-i-register-my-decentralized-id) to reflect the update. When this is done, the synchronizeWithDidDocument tells the system to start using the new key for signing.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/didInfo/synchronizeWithDidDocument`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request Body

Don't supply a request body for this method.

#### Response message

The `didDocumentStatus` will change from `outOfSync` to `published` on a successful call.

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
    "name": "APItesta",
    "status": "Enabled",
    "didModel": {
        "did": "did:web:verifiedid.contoso.com",
        "signingKeys": [
            "https://vcwingtipskv.vault.azure.net/keys/vcSigningKey-00aa00aa-bb11-cc22-dd33-44ee44ee44ee/5255b9f2d9b94dc19a369ff0d36e3407"
        ],
        "recoveryKeys": [],
        "updateKeys": [],
        "encryptionKeys": [],
        "linkedDomainUrls": [
            "https://verifiedid.contoso.com/"
        ],
        "didDocumentStatus": "published"
    },
    "keyVaultMetadata": {
        "subscriptionId": "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e",
        "resourceGroup": "verifiablecredentials",
        "resourceName": "vcwingtipskv",
        "resourceUrl": "https://vcwingtipskv.vault.azure.net/"
    },
    "linkedDomainsVerified": false
}
```

## Contracts

This endpoint allows you to create new contracts, and update existing contracts. Contracts consist of two parts represented by two JSON definitions. Information on how to design and create a contract manually can be found [here](credential-design.md).

- The display definition is used by administrators to control the appearance of a verifiable credential, for example background color, logo and title of the verifiable credential. This file also contains the claims that need to be stored inside the verifiable credential. 
- The rules definition contains the information on how to gather and collect attestations like self-attested claims, another verifiable credential as input or perhaps an ID Token received after a user has signed in to an OIDC compatible identity provider.

### Methods

| Methods | Return Type | Description |
| -------- | -------- | -------- |
| [Get contract](#get-contract) | Contract | Read properties of a Contract |
| [List contracts](#list-contracts)     | Contract collection     | Get a list of all configured contracts |
| [Create contract](#create-contract) | Contract | Create a new contract |
| [Update contract](#update-contract) | Contract | Update contract |


### Get contract

#### HTTP request

`GET /v1.0/verifiableCredentials/authorities/:authorityId/contracts/:contractId`

Replace the ```:authorityId``` and ```:contractId``` with the correct value of the authority and contract.


#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

example message:
```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u",
    "name": "contractname",
    "status": "Enabled",
    "issueNotificationEnabled": false,
    "availableInVcDirectory": false,
    "manifestUrl": "...",
    "issueNotificationAllowedToGroupOids" : null,
    "rules": <rulesModel>,
    "displays": <displayModel[]>,
    "allowOverrideValidityIntervalOnIssuance": false
}
```

The response contains the following properties

#### Contract type

| Property | Type | Description |
| -------- | -------- | -------- |
| `Id`     | string | contract ID    |
| `name` | string | The friendly name of this contract |
| `status` | string | Always `Enabled` |
| `manifestUrl` | string | URL to the contract used in the issuance request |
| `issueNotificationEnabled` | boolean | set to true if users will be notified this VC is ready for them to get issued |
| `issueNotificationAllowedToGroupOids` | array of groupId strings | array of group IDs this credential will be offered to |
| `availableInVcDirectory` | boolean | Is this contract published in the Verifiable Credential Network |
| [rules](#rulesmodel-type) | rulesModel | rules definition |
| [displays](#displaymodel-type) | displayModel array| display definitions |
| `allowOverrideValidityIntervalOnIssuance` | boolean | If the createIssuanceRequest API call is allowed to override expiry of the credential. This is only valid for [idTokenHint](admin-api.md#idtokenhintattestation-type) flows. |

#### rulesModel type

| Property | Type | Description |
| -------- | -------- | -------- |
|`attestations`| [attestations](#attestations-type)| describing supported inputs for the rules |
|`validityInterval` | number | this value shows the lifespan of the credential |
|`vc`| vcType array | types for this contract |
|`customStatusEndpoint`| [customStatusEndpoint] (#customstatusendpoint-type) (optional) | status endpoint to include in the verifiable credential for this contract |

If the property `customStatusEndpoint` property isn't specified, then the `anonymous` status endpoint is used.

#### attestations type

| Property | Type | Description |
| -------- | -------- | -------- |
|`idTokens`| [idTokenAttestation](#idtokenattestation-type) (array) (optional) | describes ID token inputs|
|`idTokenHints`| [idTokenHintAttestation](#idtokenhintattestation-type) (array) (optional) | describes ID token hint inputs |
|`presentations`| [verifiablePresentationAttestation](#verifiablepresentationattestation-type) (array) (optional) | describes verifiable presentations inputs |
|`selfIssued`| [selfIssuedAttestation](#selfissuedattestation-type) (array) (optional) | describes self issued inputs |
|`accessTokens`| [accessTokenAttestation](#accesstokenattestation-type) (array) (optional) | describes access token inputs |

#### idTokenAttestation type

| Property | Type | Description |
| -------- | -------- | -------- |
| `mapping` | [claimMapping](#claimmapping-type) (optional) | rules to map input claims into output claims in the verifiable credential |
| `configuration` | string (url) | location of the identity provider's configuration document |
| `clientId` | string | client ID to use when obtaining the ID token |
| `redirectUri` | string | redirect uri to use when obtaining the ID token MUST BE vcclient://openid/ |
| `scope` | string | space delimited list of scopes to use when obtaining the ID token |
| `required` | boolean (default false) | indicating whether this attestation is required or not |

#### idTokenHintAttestation type

| Property | Type | Description |
| -------- | -------- | -------- |
| `mapping` | [claimMapping](#claimmapping-type) (optional) | rules to map input claims into output claims in the verifiable credential |
| `required` | boolean (default false) | indicating whether this attestation is required or not |
| `trustedIssuers` | string (array) | a list of DIDs allowed to issue the verifiable credential for this contract |

#### verifiablePresentationAttestation type

| Property | Type | Description |
| -------- | -------- | -------- |
| `mapping` | [claimMapping](#claimmapping-type) (optional) | rules to map input claims into output claims in the verifiable credential |
| `credentialType` | string (optional) | required credential type of the input |
| `required` | boolean (default false) | indicating whether this attestation is required or not |
| `trustedIssuers` | string (array) | a list of DIDs allowed to issue the verifiable credential for this contract |

#### selfIssuedAttestation type

| Property | Type | Description |
| -------- | -------- | -------- |
| `mapping` | [claimMapping](#claimmapping-type) (optional) | rules to map input claims into output claims in the verifiable credential |
| `required` | boolean (default false) | indicating whether this attestation is required or not |

#### accessTokenAttestation type

| Property | Type | Description |
| -------- | -------- | -------- |
| `mapping` | [claimMapping](#claimmapping-type) (optional) | rules to map input claims into output claims in the verifiable credential |
| `required` | boolean (default false) | indicating whether this attestation is required or not |

> Supported `inputClaim` values for the `mappings` property are: `givenName`, `displayName`, `preferredLanguage`, `userPrincipalName`, `surname`, `mail`, `jobTitle`, `photo`.

#### claimMapping type

| Property | Type | Description |
| -------- | -------- | -------- |
| `inputClaim` | string | the name of the claim to use from the input |
| `outputClaim` | string | the name of the claim in the verifiable credential |
| `indexed` | boolean (default false) | indicating whether the value of this claim is used for searching; only one clientMapping object is allowed to be indexed for a given contract |
| `required` | boolean (default false) | indicating whether this mapping is required or not |
| `type` | string (optional) | type of claim |

#### customStatusEndpoint type

| Property | Type | Description |
| -------- | -------- | -------- |
| `url` | string (url)| the url of the custom status endpoint |
| `type` | string | the type of the endpoint |

example:

```
"rules": {
    "attestations": {
        "idTokens": [
            {
                "clientId": "00001111-aaaa-2222-bbbb-3333cccc4444",
                "configuration": "https://bankofwoodgrove.b2clogin.com/bankofwoodgrove.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_si",
                "redirectUri": "vcclient://openid/",
                "scope": "openid",
                "mapping": [
                    {
                        "outputClaim": "givenName",
                        "required": false,
                        "inputClaim": "given_name",
                        "indexed": false
                    },
                    {
                        "outputClaim": "familyName",
                        "required": false,
                        "inputClaim": "family_name",
                        "indexed": true
                    }
                ],
                "required": false
            }
        ]
    },
    "validityInterval": 2592000,
    "vc": {
        "type": [
            "BankofWoodgroveIdentity"
        ]
    }
}
```

#### displayModel type

| Property | Type | Description |
| -------- | -------- | -------- |
|`locale`| string | the locale of this display |
|`credential` | [displayCredential](#displaycredential-type) | the display properties of the verifiable credential |
|`consent` | [displayConsent](#displayconsent-type) | supplemental data when the verifiable credential is issued |
|`claims`| [displayClaims](#displayclaims-type) array | labels for the claims included in the verifiable credential |

#### displayCredential type

| Property | Type | Description |
| -------- | -------- | -------- |
|`title`| string | title of the credential |
|`issuedBy` | string | the name of the issuer of the credential |
|`backgroundColor` | number (hex)| background color of the credential in hex, for example, #FFAABB |
|`textColor`| number (hex)| text color of the credential in hex, for example, #FFAABB |
|`description`| string | supplemental text displayed alongside each credential |
|`logo`| [displayCredentialLogo](#displaycredentiallogo-type) | the logo to use for the credential |

#### displayCredentialLogo type

| Property | Type | Description |
| -------- | -------- | -------- |
|`uri`| string (uri) | uri of the logo. If this is a URL, it must be reachable over the public internet anonymously. |
|`description` | string | the description of the logo |

#### displayConsent type

| Property | Type | Description |
| -------- | -------- | -------- |
|`title`| string | title of the consent |
|`instructions` | string | supplemental text to use when displaying consent |

#### displayClaims type


| Property | Type | Description |
| -------- | -------- | -------- |
|`label`| string | the label of the claim in display |
|`claim`| string | the name of the claim to which the label applies |
|`type`| string | the type of the claim |
|`description` | string (optional) | the description of the claim |

example:
```
{
  "displays": [
        {
            "locale": "en-US",
            "card": {
                "backgroundColor": "#FFA500",
                "description": "ThisisyourBankofWoodgroveIdentity",
                "issuedBy": "BankofWoodgrove",
                "textColor": "#FFFF00",
                "title": "BankofWoodgroveIdentity",
                "logo": {
                    "description": "Defaultbankofwoodgrovelogo",
                    "uri": "https://didcustomerplayground.blob.core.windows.net/public/VerifiedCredentialExpert_icon.png"
                }
            },
            "consent": {
                "instructions": "Please login with your bankofWoodgrove account to receive this credential.",
                "title": "Do you want to accept the verifiedbankofWoodgrove Identity?"
            },
            "claims": [
                {
                    "claim": "vc.credentialSubject.givenName",
                    "label": "Name",
                    "type": "String"
                },
                {
                    "claim": "vc.credentialSubject.familyName",
                    "label": "Surname",
                    "type": "String"
                }
            ]
        }
    ]
}
```

### List contracts

This API lists all contracts configured in the current tenant for the specified authority.

#### HTTP request

`GET /v1.0/verifiableCredentials/authorities/:authorityId/contracts`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

example message:

```json
{
    "value":
    [
        {
            "id": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u",
            "name": "test1",
            "authorityId": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "status": "Enabled",
            "issueNotificationEnabled": false,
            "manifestUrl" : "https://...",
            "rules": "<rules JSON>",
            "displays": [{<display JSON}]
        },
        {
            "id": "C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w",
            "name": "test2",
            "authorityId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
            "status": "Enabled",
            "issueNotificationEnabled": false,
            "manifestUrl" : "https://...",
            "rules": "<rules JSON>",
            "displays": [{<display JSON}]
        }
    ]
}
```

### Create contract

When creating a contract the name has to be unique in the tenant. In case you have created multiple authorities, the contract name has to be unique across all authorities.
The name of the contract will be part of the contract URL, which is used in the issuance requests.

#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/contracts`


#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body


Example request

```
{
    "name": "ExampleContractName1",
    "rules": "<rules JSON>",
    "displays": [{<display JSON}],
}
```

#### Response message

Example message:

```
HTTP/1.1 201 Created
Content-type: application/json

{
    "id": "GUID",
    "name": "ExampleContractName1",
    "issuerId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
    "status": "Enabled",
    "issueNotificationEnabled": false,
    "rules": "<rules JSON>",
    "displays": [{<display JSON}],
    "manifestUrl": "https://..."
}
```


### Update contract

This API Allows you to update the contract.

`PATCH /v1.0/verifiableCredentials/authorities/:authorityId/contracts/:contractid`

Example request:

```
{
    "rules": "<rules JSON>",
    "displays": [{<display JSON}],}
    "availableInVcDirectory": true
    "allowOverrideValidityIntervalOnIssuance": true
}
```

#### Response message

Example message:

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u",
    "name": "contractname",
    "status": "Enabled",
    "issueNotificationEnabled": false,
    "availableInVcDirectory": true,
    "manifestUrl": "https://...",
    "issueNotificationAllowedToGroupOids" : null,
    "rules": rulesModel,
    "displays": displayModel[],
    "allowOverrideValidityIntervalOnIssuance": true
}
```

## Credentials

This endpoint allows you to search for issued verifiable credentials, check revocation status and revoke credentials.

### Methods


| Methods | Return Type | Description |
| -------- | -------- | -------- |
| [Get credential](#get-credential) | Credential | Read properties of a Credential |
| [Search credentials](#search-credentials) | Credential collection  | Search a list of credentials with a specific claim value |
| [Revoke credential](#revoke-credential) |  | Revoke specific credential |

### Get credential
This API allows you to retrieve a specific credential and check the status to see if it is revoked or not. 

#### HTTP Request
`GET /v1.0/verifiableCredentials/authorities/:authorityId/contracts/:contractId/credentials/:credentialId`

#### Request headers
| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Response message
Example message
```
HTTP/1.1 200 OK
Content-type: application/json

{
    "id": "urn:pic:aea42fb3724b4ef08bd2d2712e79bda2",
    "contractId": "ZjViZjJmYzYtNzEzNS00ZDk0LWE2ZmUtYzI2ZTQ1NDNiYzVhdGVzdDM",
    "status": "valid",
    "issuedAt": "2017-09-13T21:59:23.9868631Z"
}
```

### Search credentials

You are able to [search](how-to-issuer-revoke.md) for verifiable credentials with specific index claims. Since only a hash is stored, you need to search for the specific calculated value. The algorithm you need to use is: Base64Encode(SHA256(contractid + claim value)) An example in C# looks like this:

```csharp
  string claimvalue = "Bowen";
  string contractid = "<...your-contract-id-value...>";
  string output;

  using (var sha256 = SHA256.Create())
  {
    var input = contractid + claimvalue;
    byte[] inputasbytes = Encoding.UTF8.GetBytes(input);
    hashedsearchclaimvalue = Convert.ToBase64String(sha256.ComputeHash(inputasbytes));
    output = System.Net.WebUtility.UrlEncode( hashedsearchclaimvalue );
  }
```

The following request shows how to add the calculated value to the filter parameter of the request. At this moment only the filter=indexclaimhash eq format is supported.

### HTTP request

`GET /v1.0/verifiableCredentials/authorities/:authorityId/contracts/:contractId/credentials?filter=indexclaimhash eq {hashedsearchclaimvalue}`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

Example message

```
HTTP/1.1 200 OK
Content-type: application/json

{
    "value": [
        {
            "id": "urn:pic:aea42fb3724b4ef08bd2d2712e79bda2",
            "status": "valid",
            "issuedAtTimestamp": "Sat, 5 Feb 2022 03:51:29 GMT"
        }
    ]
}
```

### Revoke credential

This API allows you to revoke a specific credential, after you searched for the credential by using the search API the credential can be revoked by specifying the specific credential ID.


#### HTTP request

`POST /v1.0/verifiableCredentials/authorities/:authorityId/contracts/:contractId/credentials/:credentialid/revoke`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method.

#### Response message

```
HTTP/1.1 204 No Content
Content-type: application/json
```


## Opt-out

This method will completely remove all instances of the verifiable credential service in this tenant. It removes all configured contracts. Every issued verifiable credential can't be checked for revocation. This action can't be undone.

>[!WARNING]
> This action cannot be undone and will invalidate all issued verifiable credentials and created contracts.
 
#### HTTP Request
`POST /v1.0/verifiableCredentials/optout`

#### Request headers

| Header | Value |
| -------- | -------- |
| Authorization     | Bearer (token). Required |
| Content-Type | application/json |

#### Request body

Don't supply a request body for this method

#### Response message

Example response message

```
HTTP/1.1 200 OK
Content-type: application/json

OK
```

#### Remark

>[!NOTE]
> If you don't have delete permissions on Key Vault we will return an error message and still opt-out

## Next steps

- [Specify the request service REST API issuance request](issuance-request-api.md)
- [Microsoft Entra Verified ID Network API](issuance-request-api.md)
