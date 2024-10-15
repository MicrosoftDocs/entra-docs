---
title: Flexible federated identity credentials (preview)
description: Learn about Microsoft Entra Workload ID Flexible federated identity credentials and its capabilities.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: faq
ms.date: 08/28/2024
ms.author: cwerner
ms.custom: 
ms.reviewer: ludwignick
#Customer intent: I want to know about Microsoft Entra Workload ID Flexible federated identity credentials.
---

# Flexible federated identity credentials (preview)

The current behavior of [federated identity credentials](/graph/api/resources/federatedidentitycredentials-overview?view=graph-rest-1.0) within workload identity federation requires explicit matching when comparing the defined `subject`, `issuer`, and `audience` in the federated identity credential against the `subject`, `issuer`, and `audience` contained in the token sent to Microsoft Entra. This, when combined with the current limit of 20 federated identity credentials for a given application or user-assigned managed identity, can cause scale limits to be hit quickly. Flexible federated identity credentials extend the existing federated identity credential model by allowing the use of a restricted expression language when matching against incoming `subject` claims. It can also be used to extend the federated identity credential authorization model past `subject`, `issuer`, and `audience` by enabling the inclusion of certain allowed custom claims within your federated identity credentials.

## How do flexible federated identity credentials work? 

Flexible federated identity credentials do not change the baseline functionality provided by federated identity credentials. These “trust relationships” are still used to indicate which token from the external IdP should be trusted by your application. Instead, they extend the ability of federated identity credentials by enabling scenarios which previously required multiple federated identity credentials to instead be managed under a single flexible federated identity credential. 

## Current limitations 

Flexible federated identity credential support is currently provided for matching against GitHub, GitLab, and Terraform Cloud issued tokens. Furthermore, this support exists only for federated identity credentials configured on application objects. Flexible federated identity credential support for managed identities is coming, but it is not included in the initial public preview. Finally, explicit support for flexible federated identity credentials does not yet exist within Azure CLI, Azure PowerShell, or Terraform providers – so, you will initially only be able to create and manage flexible federated identity credentials via Microsoft Graph or Azure Portal UI.

## Set up Flexible Federated identity credentials through Microsoft Graph

> [!NOTE]
>
> You may notice the new `claimsMatchingExpression` property within any federated identity credential you previously configured, but the addition of this property will not affect how your federated identity credential behavior unless configured to do so. 

To accommodate the flexible federated identity credential functionality, the `federatedIdentityCredentials` resource is being extended with a new `claimsMatchingExpression` property. In addition to this, the `subject` property is now nullable. The `claimsMatchingExpression` and `subject` properties have been made mutually exclusive, so you cannot define both within a federated identity credential.

- audiences : The audience that can appear in the external token. This field is mandatory and should be set to `api://AzureADTokenExchange` for Microsoft Entra ID. It says what Microsoft identity platform should accept in the `aud` claim in the incoming token. This value represents Microsoft Entra ID in your external identity provider and has no fixed value across identity providers - you might need to create a new application registration in your IdP to serve as the audience of this token. 
- issuer : The URL of the external identity provider. Must match the issuer claim of the external token being exchanged. 
- subject : The identifier of the external software workload within the external identity provider. Like the audience value, it has no fixed format, as each IdP uses their own - sometimes a GUID, sometimes a colon delimited identifier, sometimes arbitrary strings. The value here must match the `sub` claim within the token presented to Microsoft Entra ID. If `subject` is defined, `claimsMatchingExpression` must be set to null.  
- name : A unique string to identify the credential. This property is an alternate key and the value can be used to reference the federated identity credential via the [GET](/graph/api/federatedidentitycredential-get?view=graph-rest-1.0&tabs=http) and [UPSERT](/graph/api/federatedidentitycredential-upsert?view=graph-rest-1.0) operations. 
- claimsMatchingExpression : a new complex type containing two properties, `value` and `languageVersion`. Value is used to define the expression, and `languageVersion` is used to define the version of the flexible federated identity credential expression language (FFL) being used. `languageVersion` should always be set to 1. If `claimsMatchingExpression` is defined, `subject` must be set to null. 

## Flexible federated identity credential language structure 

A Flexible FIC expression is made up of 3 parts – a claim lookup, the desired operator, and the comparand.

### {INSERT IMAGE HERE}

The claim lookup must follow the pattern of `claims[‘<claimName>’]`. The operator portion must be just the operator name, separated from the claim lookup and comparand by a single space. The comparand contains what you intend to compare the claim specified in the lookup against – it must be contained within single quotes. 

## Flexible federated identity credential expression language functionality  

Flexible federated identity credentials currently support the use of a few operators across the enabled issuers.

| Operator | Description | Example |
| --- | --- | --- |
| `matches` | Enables the use of single-character (denoted by ‘?’) and multi-character (denoted by ‘*’) wildcard matching for the specified claim  | &#8226; `“claims[‘sub’] matches ‘repo:contoso/contoso-repo:ref:refs/heads/*’”` <br/>&#8226; `“claims[‘sub’] matches ‘repo:contoso/contoso-repo-*:ref:refs/heads/????’”` |
| `eq` | Used for explicitly matching against a specified claim | &#8226; `“claims[‘sub’] eq ‘repo:contoso/contoso-repo:ref:refs/heads/main’”`  |
| `and` | Boolean operator for combining expressions against multiple claims | &#8226; `“claims[‘sub’] eq ‘repo:contoso/contoso-repo:ref:refs/heads/main’ and claims[‘job_workflow_ref’] matches ‘foo-org/bar-repo /.github/workflows/*@refs/heads/main’”` |

### Escape characters 

Single quotes are interpreted as escape characters within the flexible federated identity credential expression language.  

## Issuer URLs, supported claims and operators by by platform

Depending on the platform you are using, you'll need to implement different issuer URLs, claims, and operators. Use the tabs below to select your chosen platform.

## [GitHub](#tab/github) 

Supported issuer URLs: `https://token.actions.githubusercontent.com` 

Supported claims and operators per claim: 

Claim `sub` supports operators `eq` and `matches` 

Claim `job_workflow_ref` supports operators `eq` and `matches` 

### [GitLab](#tab/gitlab)

Supported issuer URLs: `https://gitlab.com`, `https://gitlab.example.com`, and `https://gitlab.example.ca` where `example` can be any string.  

Supported claims and operators per claim: 

Claim `sub` supports operators `eq` and `matches` 

### [Terraform Cloud](#tab/terraformcloud)

Supported issuer URLs: `https://app.terraform.io`, `https://app.eu.terraform.io` 

Supported claims and operators per claim: 

Claim `sub` supports operators `eq` and `matches` 

---

## Azure CLI, Azure PowerShell, and Terraform providers 

Explicit flexible federated identity credential support does not yet exist within Azure CLI, Azure PowerShell, or Terraform providers. If you attempt to configure a flexible federated identity credential with any of these tools, you will see an error. Additionally, if you configure a flexible federated identity credential via either Microsoft Graph or the Azure Portal and attempt to read that flexible federated identity credential with any of these tools, you will see an error.  

## See also