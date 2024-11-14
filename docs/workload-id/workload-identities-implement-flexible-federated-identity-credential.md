---
title: Set up Flexible Federated identity credential (preview)
description: Learn how to set up a Flexible Federated identity credential in the Azure portal or Microsoft Graph Explorer.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: faq
ms.date: 08/28/2024
ms.author: cwerner
ms.custom: 
ms.reviewer: ludwignick
#Customer intent: I want to know how to set up a Flexible Federated identity credential in the Azure portal or Microsoft Graph Explorer.
---

# How to set up a Flexible Federated identity credentials

> [!NOTE]
>
> This article is a work in progress and may be removed

This article provides a guide on how to set up a Flexible Federated identity credential in the Azure portal or Microsoft Graph Explorer.

## Preqrequisites

- An Azure subscription
- An application registration in Microsoft Entra ID


To accommodate the flexible federated identity credential functionality, the `federatedIdentityCredentials` resource is being extended with a new `claimsMatchingExpression` property. In addition to this, the `subject` property is now nullable. The `claimsMatchingExpression` and `subject` properties have been made mutually exclusive, so you cannot define both within a federated identity credential.

- audiences : The audience that can appear in the external token. This field is mandatory and should be set to `api://AzureADTokenExchange` for Microsoft Entra ID. It says what Microsoft identity platform should accept in the `aud` claim in the incoming token. This value represents Microsoft Entra ID in your external identity provider and has no fixed value across identity providers - you might need to create a new application registration in your IdP to serve as the audience of this token. 
- issuer : The URL of the external identity provider. Must match the issuer claim of the external token being exchanged. 
- subject : The identifier of the external software workload within the external identity provider. Like the audience value, it has no fixed format, as each IdP uses their own - sometimes a GUID, sometimes a colon delimited identifier, sometimes arbitrary strings. The value here must match the `sub` claim within the token presented to Microsoft Entra ID. If `subject` is defined, `claimsMatchingExpression` must be set to null.  
- name : A unique string to identify the credential. This property is an alternate key and the value can be used to reference the federated identity credential via the [GET](/graph/api/federatedidentitycredential-get) and [UPSERT](/graph/api/federatedidentitycredential-upsert) operations. 
- claimsMatchingExpression : a new complex type containing two properties, `value` and `languageVersion`. Value is used to define the expression, and `languageVersion` is used to define the version of the flexible federated identity credential expression language (FFL) being used. `languageVersion` should always be set to 1. If `claimsMatchingExpression` is defined, `subject` must be set to null. 


## Set up a Flexible Federated identity credential

### [Azure portal](#tab/azure-portal)

1. Navigate to Microsoft Entra ID and select the application where you want to configure the federated identity credential.
1. In the left-hand navigation pane, select **Certificates & secrets**.
1. Under the **Federated credentials** tab, select **+ Add credential**.
1. In the **Add a credential** window that appears, from the dropdown menu next to **Federated credential scenario**, select **Other issuer**.
1. In **Value** enter the claim matching expression you want to use.

### [Microsoft Graph Explorer](#tab/graph-explorer)

1. Open the [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer).
1. In the **Request** section, enter the following URL: `https://graph.microsoft.com/beta/applications/{applicationId}/federatedIdentityCredentials`.
1. Add the following request body:

```json
{
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "issuer": "https://token.actions.githubusercontent.com",
  "name": "MyFlexibleFIC",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'repo:contoso/contoso-repo:ref:refs/heads/*'",
    "languageVersion": 1
  }
}
```
---

## See also

[Flexible federated identity credentials](./workload-identities-flexible-federated-identity-credentials.md)