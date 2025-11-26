---
title: Flexible federated identity credentials (preview)
description: Learn about Microsoft Entra Workload ID Flexible federated identity credentials and its capabilities.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: concept-article
ms.date: 08/28/2024
ms.author: cwerner
ms.custom: 
ms.reviewer: ludwignick
#Customer intent: I want to know about Microsoft Entra Workload ID Flexible federated identity credentials.
---

# Flexible federated identity credentials (preview)

Flexible federated identity credentials are an advanced feature of Microsoft Entra Workload ID that enhances the existing federated identity credential model. This article explains how these credentials work, their benefits, and current limitations. 

Flexible federated identity credentials allow the use of a restricted expression language for matching incoming `subject` claims and enabling the inclusion of custom claims, helping reduce management overhead and address scale limits in workload identity federation. If you're looking to streamline authentication for external workloads with Microsoft Entra, this guide provides you with the necessary insights and steps to use this powerful feature.

## Why use flexible federated identity credentials?

The current behavior of [federated identity credentials](/graph/api/resources/federatedidentitycredentials-overview) within workload identity federation requires explicit matching when comparing the defined `subject`, `issuer`, and `audience` in the federated identity credential against the `subject`, `issuer`, and `audience` contained in the token sent to Microsoft Entra. When combined with the current limit of 20 federated identity credentials for a given application or user-assigned managed identity, scale limits can be hit quickly. 

Flexible federated identity credentials extend the existing federated identity credential model by allowing the use of a restricted expression language when matching against incoming `subject` claims. It can also be used to extend the federated identity credential authorization model beyond the `subject`, `issuer`, and `audience` claims by enabling the inclusion of certain allowed custom claims within your federated identity credentials. 

Flexible federated identity credentials can help reduce management overhead when attempting to authenticate external workloads with Microsoft Entra, and address the scale limits in workload identity federation implementations.

## How do flexible federated identity credentials work? 

Flexible federated identity credentials don't change the baseline functionality provided by federated identity credentials. These trust relationships are still used to indicate which token from the external IdP should be trusted by your application. Instead, they extend the ability of federated identity credentials by enabling scenarios which previously required multiple federated identity credentials to instead be managed under a single flexible federated identity credential. A few examples include:

- GitHub repositories with various workflows, each running on a different branch (or being used across branches). Previously, a unique federated identity credential was required for each of the branches in which workflows could run across. With flexible federated identity credentials, this scenario can be managed under a single federated identity credential.
- Terraform cloud `run_phases` plans, which each requires a unique federated identity credential. With flexible federated identity credentials, this can be managed under a single flexible federated identity credential.
- Reusable GitHub Actions workflows, where wildcards can be used against GitHub's custom `job_workflow_ref` claim.

> [!NOTE]
> 
> Flexible federated identity credentials support is currently provided for matching against GitHub, GitLab, and Terraform Cloud issued tokens. This support exists only for federated identity credentials configured on application objects currently. You can only create and manage flexible federated identity credentials via Microsoft Graph or the Azure portal.

## Flexible federated identity credential language structure 

A flexible federated identity credentials expression is made up of three parts, the claim lookup, the operator, and the comparand. Refer to the following table for a breakdown of each part:

| Name | Description | Example |
| --- | --- | --- |
| Claim lookup | The claim lookup must follow the pattern of `claims['<claimName>']` | `claims['sub']` |
| Operator | The operator portion must be just the operator name, separated from the claim lookup and comparand by a single space | `matches` |
| Comparand | The comparand contains what you intend to compare the claim specified in the lookup against – it must be contained within single quotes | `'repo:contoso/contoso-repo:ref:refs/heads/*'` |

Put together, an example flexible federated identity credentials expression would look like the following JSON object:

```json
"claims['sub'] matches 'repo:contoso/contoso-repo:ref:refs/heads/*'."
```

## Set up federated identity credentials through Microsoft Graph

To accommodate the flexible federated identity credential functionality, the `federatedIdentityCredentials` resource is being extended with a new `claimsMatchingExpression` property. In addition to this, the `subject` property is now nullable. The `claimsMatchingExpression` and `subject` properties are mutually exclusive, so you can't define both within a federated identity credential.

- `audiences`: The audience that can appear in the external token. This field is mandatory and should be set to `api://AzureADTokenExchange` for Microsoft Entra ID. It says what Microsoft identity platform should accept in the `aud` claim in the incoming token. This value represents Microsoft Entra ID in your external identity provider and has no fixed value across identity providers - you might need to create a new application registration in your IdP to serve as the audience of this token. 
- `issuer`: The URL of the external identity provider. Must match the issuer claim of the external token being exchanged. 
- `subject`: The identifier of the external software workload within the external identity provider. Like the audience value, it has no fixed format, as each IdP uses their own - sometimes a GUID, sometimes a colon delimited identifier, sometimes arbitrary strings. The value here must match the `sub` claim within the token presented to Microsoft Entra ID. If `subject` is defined, `claimsMatchingExpression` must be set to null.  
- `name`: A unique string to identify the credential. This property is an alternate key and the value can be used to reference the federated identity credential via the [GET](/graph/api/federatedidentitycredential-get) and [UPSERT](/graph/api/federatedidentitycredential-upsert) operations. 
- `claimsMatchingExpression`: a new complex type containing two properties, `value` and `languageVersion`. Value is used to define the expression, and `languageVersion` is used to define the version of the flexible federated identity credential expression language (FFL) being used. `languageVersion` should always be set to 1. If `claimsMatchingExpression` is defined, `subject` must be set to null. 

## Flexible federated identity credential expression language functionality  

Flexible federated identity credentials currently support the use of a few operators across the enabled issuers. Single quotes are interpreted as escape characters within the flexible federated identity credential expression language.  

| Operator | Description | Example |
| --- | --- | --- |
| `matches` | Enables the use of single-character (denoted by `?`) and multi-character (denoted by `*`) wildcard matching for the specified claim  | &#8226; `"claims['sub'] matches 'repo:contoso/contoso-repo:ref:refs/heads/*'"` <br/>&#8226; `"claims['sub'] matches 'repo:contoso/contoso-repo-*:ref:refs/heads/????'"` |
| `eq` | Used for explicitly matching against a specified claim | &#8226; `"claims['sub'] eq 'repo:contoso/contoso-repo:ref:refs/heads/main'"`  |
| `and` | Boolean operator for combining expressions against multiple claims | &#8226; `"claims['sub'] eq 'repo:contoso/contoso-repo:ref:refs/heads/main' and claims['job_workflow_ref'] matches 'foo-org/bar-repo /.github/workflows/*@refs/heads/main'"` |


## Issuer URLs, supported claims, and operators by platform

Depending on the platform you're using, you need to implement different issuer URLs, claims, and operators. Use the following tabs to select your chosen platform.

## [GitHub](#tab/github) 

Supported issuer URLs: `https://token.actions.githubusercontent.com` 

Supported claims and operators per claim: 

- Claim `sub` supports operators `eq` and `matches` 
- Claim `job_workflow_ref` supports operators `eq` and `matches` 

### [GitLab](#tab/gitlab)

Supported issuer URLs: `https://gitlab.com`, `https://gitlab.example.com`, and `https://gitlab.example.ca` where `example` can be any string.  

Supported claims and operators per claim: 

- Claim `sub` supports operators `eq` and `matches` 

### [Terraform Cloud](#tab/terraformcloud)

Supported issuer URLs: `https://app.terraform.io`, `https://app.eu.terraform.io` 

Supported claims and operators per claim: 

- Claim `sub` supports operators `eq` and `matches` 

---

## Azure CLI, Azure PowerShell, and Terraform providers 

Explicit flexible federated identity credential support doesn't yet exist within Azure CLI, Azure PowerShell, or Terraform providers. If you attempt to configure a flexible federated identity credential with any of these tools, you see an error. Additionally, if you configure a flexible federated identity credential via either Microsoft Graph or the Azure portal and attempt to read that flexible federated identity credential with any of these tools, you see an error.  

You can use Azure CLI's `az rest` method to make REST API requests for flexible federated identity credential creation and management. 

```bash
az rest --method post \
    --url https://graph.microsoft.com/beta/applications/{objectId}/federatedIdentityCredentials
    --body "{'name': 'FlexFic1', 'issuer': 'https://token.actions.githubusercontent.com', 'audiences': ['api://AzureADTokenExchange'], 'claimsMatchingExpression': {'value': 'claims[\'sub\'] matches \'repo:contoso/contoso-org:ref:refs/heads/*\'', 'languageVersion': 1}}"
```

## Related content

- [Implement a flexible federated identity credential](./workload-identity-federation-create-trust.md#set-up-a-flexible-federated-identity-credential-preview)
- [Configure a user-assigned managed identity to trust an external identity provider](./workload-identity-federation-create-trust-user-assigned-managed-identity.md)
- How to create, delete, get, or update [federated identity credentials](./workload-identity-federation-create-trust.md) on an app registration.
- Read the [GitHub Actions documentation](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-azure) to learn more about configuring your GitHub Actions workflow to get an access token from Microsoft identity provider and access Microsoft Entra protected resources.
- Learn about the [assertion format](../identity-platform/certificate-credentials.md#assertion-format).
