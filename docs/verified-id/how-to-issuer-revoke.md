---
title: Revoke a verifiable credential as an issuer - Microsoft Entra Verified ID
description: Learn how to revoke an issued verifiable credential.
documentationCenter: ''
author: barclayn
manager: amycolannino
ms.service: entra-verified-id
ms.topic: how-to

ms.date: 07/28/2022
ms.author: barclayn

#Customer intent: As an administrator, I'm trying to learn the process of revoking verifiable credentials that I've issued.
---

# Revoke a previously issued verifiable credential

As part of the process of working with verifiable credentials, you have to issue credentials. Sometimes you also have to revoke them. In this article, we review the `Status` property part of the verifiable credential specification. We also take a closer look at the revocation process, why we want to revoke credentials, and some data and privacy implications.

## Why do you want to revoke a verifiable credential?

Each customer has their own unique reasons for wanting to revoke a verifiable credential. Here are some of the common themes:

- **Student ID**: The student is no longer an active student at the university.
- **Employee ID**: The employee is no longer an active employee.
- **State driver's license**: The driver no longer lives in that state.

## How do I revoke a verifiable credential?

By using the indexed claim in verifiable credentials, you can search for issued verifiable credentials by that claim in the portal and revoke it.

1. Go to the **Verified ID** pane in the Azure portal as an admin user with **sign** key permission for Azure Key Vault.
1. Select the verifiable credential type.
1. On the leftmost menu, select **Revoke a credential**.

   :::image type="content" source="media/how-to-issuer-revoke/settings-revoke.png" alt-text="Screenshot that shows credential revocation.":::

1. Search for the index claim of the user you want to revoke. Indexing a claim is a requirement for being able to search for a credential.

   :::image type="content" source="media/how-to-issuer-revoke/revoke-search.png" alt-text="Screenshot that shows the credential to revoke.":::
  
    Because only a hash of the indexed claim from the verifiable credential is stored, only an exact match populates the search results. The information entered in the text box is hashed by using the same algorithm. It's used as a search criterion to match the hashed value that's stored.
  
1. When a match is found, select the **Revoke** option to the right of the credential you want to revoke.

    The admin user who performs the revoke operation must have **sign** key permission for Key Vault or else the error message "Unable to access Key Vault resource with given credentials" appears.

   :::image type="content" source="media/how-to-issuer-revoke/warning.png" alt-text="Screenshot that shows a warning that tells you that after revocation the user still has the credential.":::

1. After successful revocation, you see the status update and a green banner appears at the top of the page.

   :::image type="content" source="media/how-to-issuer-revoke/revoke-successful.png" alt-text="Screenshot that shows a successfully revoked verifiable credential message.":::

The Request Service API indicates a revoked credential in the `presentation_verified` [callback](presentation-request-api.md#callback-events) as `REVOKED`. Depending on if the presentation request specified that it [allows revoked credentials](presentation-request-api.md#configurationvalidation-type) to be presented, the presentation of a revoked credential either succeeds or fails.

## Set up a verifiable credential with the ability to revoke

Microsoft Entra Verified ID doesn't store verifiable credential data. The issuer needs to index one claim to make the credential searchable. Only one claim can be indexed, and if there's none, you can't revoke credentials. The selected claim to index is then salted and hashed and isn't stored as its original value.

> [!NOTE]
> Hashing is a one-way cryptographic operation that turns an input, called a ```preimage```, and produces an output called a hash that has a fixed length. It isn't computationally feasible at this time to reverse a hash operation.

**Example:** In the following example, `displayName` is the index claim. You can search only via the user's full name and nothing else.

```json
{
  "attestations": {
    "idTokens": [
      {
        "clientId": "8d5b446e-22b2-4e01-bb2e-9070f6b20c90",
        "configuration": "https://didplayground.b2clogin.com/didplayground.onmicrosoft.com/B2C_1_sisu/v2.0/.well-known/openid-configuration",
        "redirectUri": "vcclient://openid",
        "scope": "openid profile email",
        "mapping": [
          {
            "outputClaim": "displayName",
            "required": true,
            "inputClaim": "$.name",
            "indexed": true
          },
          {
            "outputClaim": "firstName",
            "required": true,
            "inputClaim": "$.given_name",
            "indexed": false
          },
          {
            "outputClaim": "lastName",
            "required": true,
            "inputClaim": "$.family_name",
            "indexed": false
          }
        ],
        "required": false
      }
    ]
  },
  "validityInterval": 2592000,
  "vc": {
    "type": [
      "VerifiedCredentialExpert"
    ]
  }
}
```

You can index only one claim from a rules claims mapping. If you accidentally have no indexed claim in your rules definition, and you later correct this oversight, already issued verifiable credentials won't be searchable because they were issued when no index existed.

## How does revocation work?

Microsoft Entra Verified ID implements the [W3C StatusList2021](https://github.com/w3c/vc-status-list-2021/tree/343b8b59cddba4525e1ef355356ae760fc75904e). When presentation to the Request Service API happens, the API checks the revocation status. The revocation check happens over an anonymous API call to Identity Hub and doesn't contain any data about who is checking if the verifiable credential is still valid or revoked. With `statusList2021`, Microsoft Entra Verified ID keeps a flag by the hashed value of the indexed claim to keep track of the revocation status.

### Verifiable credential data

In every Microsoft-issued verifiable credential, there's a claim called `credentialStatus`. This data is a navigational map to where in a block of data this verifiable credential has its revocation flag.

> [!NOTE]
> If the verifiable credential is old and was issued during the preview period, this claim doesn't exist. Revocation won't work for this credential and you have to reissue it.

```json
...
"credentialStatus": { 
    "id": "urn:uuid:625dfcad-0000-1111-2222-333444445555?bit-index=31", 
    "type": "RevocationList2021Status", 
    "statusListIndex": 31, 
    "statusListCredential": "did:web:verifiedid.contoso.com?service=IdentityHub&queries=...data..." 
...
```

### Issuer's Identity Hub API endpoint

In the issuing party's decentralized identifier document, the Identity Hub's endpoint is available in the `service` section.

```json
didDocument": {
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
                   "https://verifiedid.hub.msidentity.com/v1.0/11111111-2222-3333-4444-000000000000"
                ],
                "origins": [ ]
             }
         }
    ],
```

## Next steps

- [Customize your Microsoft Entra Verified ID](credential-design.md)
