---
title: Set up a Flexible Federated identity credential (preview)
description: Learn how to set up a Flexible Federated identity credential in the Azure portal or Microsoft Graph Explorer.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: how-to
ms.date: 08/28/2024
ms.author: cwerner
ms.custom: 
ms.reviewer: ludwignick
#Customer intent: I want to know how to set up a Flexible Federated identity credential in the Azure portal or Microsoft Graph Explorer.
---

# Set up a Flexible Federated identity credential (preview)

This article provides a guide on how to set up a [Flexible Federated identity credential](workload-identities-flexible-federated-identity-credentials.md) in the Azure portal or Microsoft Graph Explorer. Flexible federated identity credentials are an advanced feature of Microsoft Entra Workload ID that enhances the existing federated identity credential model.

## Prerequisites

- An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- [Create an app registration](~/identity-platform/quickstart-register-app.md). Grant your app access to the Azure resources targeted by your external software workload.

> [!NOTE]
> 
> Flexible federated identity credentials support is not yet available for [managed identities](/entra/identity/managed-identities-azure-resources/overview).

## Setting up federated identity credentials through Microsoft Graph

To accommodate the flexible federated identity credential functionality, the `federatedIdentityCredentials` resource is being extended with a new `claimsMatchingExpression` property. In addition to this, the `subject` property is now nullable. The `claimsMatchingExpression` and `subject` properties have been made mutually exclusive, so you can't define both within a federated identity credential.

- `audiences`: The audience that can appear in the external token. This field is mandatory and should be set to `api://AzureADTokenExchange` for Microsoft Entra ID. It says what Microsoft identity platform should accept in the `aud` claim in the incoming token. This value represents Microsoft Entra ID in your external identity provider and has no fixed value across identity providers - you might need to create a new application registration in your IdP to serve as the audience of this token. 
- `issuer`: The URL of the external identity provider. Must match the issuer claim of the external token being exchanged. 
- `subject`: The identifier of the external software workload within the external identity provider. Like the audience value, it has no fixed format, as each IdP uses their own - sometimes a GUID, sometimes a colon delimited identifier, sometimes arbitrary strings. The value here must match the `sub` claim within the token presented to Microsoft Entra ID. If `subject` is defined, `claimsMatchingExpression` must be set to null.  
- `name`: A unique string to identify the credential. This property is an alternate key and the value can be used to reference the federated identity credential via the [GET](/graph/api/federatedidentitycredential-get) and [UPSERT](/graph/api/federatedidentitycredential-upsert) operations. 
- `claimsMatchingExpression`: a new complex type containing two properties, `value` and `languageVersion`. Value is used to define the expression, and `languageVersion` is used to define the version of the flexible federated identity credential expression language (FFL) being used. `languageVersion` should always be set to 1. If `claimsMatchingExpression` is defined, `subject` must be set to null. 

## Set up a Flexible Federated identity credential

### [Azure portal](#tab/azure-portal)

1. Navigate to Microsoft Entra ID and select the application where you want to configure the federated identity credential.
1. In the left-hand navigation pane, select **Certificates & secrets**.
1. Under the **Federated credentials** tab, select **+ Add credential**.
1. In the **Add a credential** window that appears, from the dropdown menu next to **Federated credential scenario**, select **Other issuer**.
1. Under **Connect your account** enter the ***Issuer** URL of the external identity provider. For example;
    - GitHub: `https://token.actions.githubusercontent.com`
    - GitLab: `https://gitlab.example.com`
    - Terraform Cloud: `https://app.terraform.io`
1. In **Value** enter the claim matching expression you want to use, for example `claims['sub'] matches 'repo:contoso/contoso-repo:ref:refs/heads/*'`
1. Select **Add** to save the credential.

### [Microsoft Graph Explorer](#tab/graph-explorer)

1. Open the [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. In the **Request** section, enter the following URL that corresponds to the application; `https://graph.microsoft.com/beta/applications/{objectId}/federatedIdentityCredentials`.
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

1. Select **Run query** to create the federated identity credential.
---

## More examples of Flexible Federated identity credentials

Flexible federated identity credentials can use different issuers, such as GitHub, GitLab, and Terraform Cloud. Use the following tabs to set up a flexible federated identity credential for each of these issuers.

### [GitHub](#tab/github)

This example shows how to set up a Flexible Federated identity credential for GitHub with an expression for the `job_workflow_ref` claim. Use 

```json
{
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "name": "MyGitHubFlexibleFIC",
  "issuer": "https://token.actions.githubusercontent.com",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'repo:contoso/contoso-repo:ref:refs/heads/*' and claims['job_workflow_ref'] matches 'contoso/contoso-prod/.github/workflows/*.yml@refs/heads/main'",
    "languageVersion": 1
  }
}
```

### [GitLab](#tab/gitlab)

```json
{
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "name": "MyGitLabFlexibleFIC",
  "issuer": "https://gitlab.example.com",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'project_path:contoso/contoso-project:ref_type:branch:ref:main'",
    "languageVersion": 1
  }
}
```

### [Terraform Cloud](#tab/terraform-cloud)

```json
{
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "name": "MyTfcFlexibleFIC",
  "issuer": "https://app.terraform.io",
  "claimsMatchingExpression": {
    "value": "claims['sub'] matches 'organization:contoso:project:contoso-proj:workspace:wrk-1:run_phase:*'",
    "languageVersion": 1
  }
}
```
---

## Related content

- [Flexible federated identity credentials](./workload-identities-flexible-federated-identity-credentials.md)
- [Configure a user-assigned managed identity to trust an external identity provider](./workload-identity-federation-create-trust-user-assigned-managed-identity.md)
