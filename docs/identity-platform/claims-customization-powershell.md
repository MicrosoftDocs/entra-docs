---
title: Claims Customization using PowerShell
description: This article describes the how to customize claims in Microsoft Entra ID using PowerShell
services: active-directory
documentationcenter: .net
author: rahul-nagraj
manager: 
ms.service: active-directory
ms.subservice: develop
ms.workload: identity
ms.topic: reference
ms.date: 11/02/2023
ms.author: rahul.nagraj
ms.reviewer: jeedes
ms.custom: aaddev
---

# Customize claims emitted in tokens for a specific app in a tenant using PowerShell

A claim is information that an identity provider states about a user inside the token they issue for that user. Claims customization is used by tenant admins to customize the claims emitted in tokens for a specific application in their tenant. You can use claims-mapping policies to:

- select which claims are included in tokens.
- create claim types that do not already exist.
- choose or change the source of data emitted in specific claims.

Claims customization supports configuring claim-mapping policies for the SAML, OAuth, and OpenID Connect protocols.

> [!NOTE]
This feature replaces and supersedes the [claims customization](saml-claims-customization.md) offered through the Entra Id portal. On the same application, if you customize claims using the portal in addition to the Microsoft Graph/PowerShell method detailed in this document, tokens issued for that application will ignore the configuration in the portal. Configurations made through the methods detailed in this document will not be reflected in the portal.
In this article, we walk through a few common scenarios that can help you understand how to use the [claims-mapping policy type](reference-claims-mapping-policy-type.md).

## Get started

In the following examples, you create, update, link, and delete policies for service principals. Claims-mapping policies can only be assigned to service principal objects. If you are new to Entra Id, we recommend that you [learn about how to get an Entra Id tenant](~/external-id/customers/quickstart-tenant-setup.md) before you proceed with these examples.
When creating a claims-mapping policy, you can also emit a claim from a directory extension attribute in tokens. Use `ExtensionID` for the extension attribute instead of ID in the `ClaimsSchema` element. For more info on extension attributes, see [Using directory extension attributes](~/identity-platform/schema-extensions.md).

> [!Note]
> The [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/PowerShell/microsoftgraph/installation) is required to configure claims-mapping policies.

To get started, do the following steps:

1. Download the latest [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/PowerShell/microsoftgraph/installation).
2. Run the ‘Connect-MgGraph -Scopes’ command to sign in to your Entra Id admin account. Run this command each time you start a new session.

```PowerShell
Connect-MgGraph -Scopes
```

Next, create a claims mapping policy and assign it to a service principal. See these examples for common scenarios:

- [Omit the basic claims from tokens](#omit-the-basic-claims-from-tokens)
- [Include the EmployeeID and TenantCountry as claims in tokens](#include-the-employeeid-and-tenantcountry-as-claims-in-tokens)
- [Use a claims transformation in tokens](#use-a-claims-transformation-in-tokens)

After creating a claims mapping policy, configure your application to acknowledge that tokens will contain customized claims. For more information, read [security considerations](jwt-claims-customization.md#security-considerations).

## Omit the basic claims from tokens

In this example, you create a policy that removes the [basic claim set](reference-claims-mapping-policy-type.md#claim-sets) from tokens issued to linked service principals.

1. Create a claims-mapping policy. This policy, linked to specific service principals, removes the basic claim set from tokens.

    1. To create the policy, run this command:

    ```PowerShell
    New-MgPolicyClaimMappingPolicy -Definition @('{"ClaimsMappingPolicy":{"Version":1,"IncludeBasicClaimSet":"false"}}') -DisplayName "OmitBasicClaims" -Type "ClaimsMappingPolicy"
    ```

    2. To see your new policy, and to get the policy ObjectId, run the following command:

    ```PowerShell
    Get-MgPolicyClaimMappingPolicy
    ```

1. Assign the policy to your service principal. You also need to get the ObjectId of your service principal.
    1. To see all your organization's service principals, you can query the Microsoft Graph API. Or, in Microsoft Graph Explorer, sign in to your Entra Id account.

    1. When you have the ObjectId of your service principal, run the following command:

    ```PowerShell
    New-MgServicePrincipalClaimMappingPolicyByRef -ServicePrincipalId <servicePrincipalId> -BodyParameter @{"@odata.id" = "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/<claimsMappingPolicyId>"}
    ```

## Include the EmployeeID and TenantCountry as claims in tokens

In this example, you create a policy that adds the EmployeeID and TenantCountry to tokens issued to linked service principals. The EmployeeID is emitted as the name claim type in both SAML tokens and JWTs. The TenantCountry is emitted as the country/region claim type in both SAML tokens and JWTs. In this example, we continue to include the basic claims set in the tokens.

1. Create a claims-mapping policy. This policy, linked to specific service principals, adds the EmployeeID and TenantCountry claims to tokens.
    1. To create the policy, run the following command:

    ```PowerShell
    New-MgPolicyClaimMappingPolicy -BodyParameter @('{"ClaimsMappingPolicy":{"Version":1,"IncludeBasicClaimSet":"true", "ClaimsSchema": [{"Source":"user","ID":"employeeid","SamlClaimType":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/employeeid","JwtClaimType":"employeeid"},{"Source":"company","ID":"tenantcountry","SamlClaimType":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/country","JwtClaimType":"country"}]}}') -DisplayName "ExtraClaimsExample"
    ```

    > [!warning]
    > When you define a claims mapping policy for a directory extension attribute, use the ExtensionID property instead of the ID property within the body of the ClaimsSchema array.

    1. To see your new policy, and to get the policy ObjectId, run the following command:

    ```PowerShell
    Get-MgPolicyClaimMappingPolicy
    ```

1. Assign the policy to your service principal. You also need to get the ObjectId of your service principal.
    1. To see all your organization's service principals, you can [query the Microsoft Graph API](https://learn.microsoft.com/graph/traverse-the-graph). Or, in [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), sign in to your Entra Id account.
    1. When you have the ObjectId of your service principal, run the following

    ```PowerShell
    New-MgServicePrincipalClaimMappingPolicyByRef -ServicePrincipalId <servicePrincipalId> -BodyParameter @{"@odata.id" = "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/<claimsMappingPolicyId>"}
    ```

## Use a claims transformation in tokens

In this example, you create a policy that emits a custom claim "JoinedData" to JWTs issued to linked service principals. This claim contains a value created by joining the data stored in the extensionattribute1 attribute on the user object with ".sandbox". In this example, we exclude the basic claims set in the tokens.

1. Create a claims-mapping policy. This policy, linked to specific service principals, adds the EmployeeID and TenantCountry claims to tokens.
    1. To create the policy, run the following command:

    ```PowerShell
    New-MgPolicyClaimMappingPolicy -BodyParameter @('{"ClaimsMappingPolicy":{"Version":1,"IncludeBasicClaimSet":"true", "ClaimsSchema":[{"Source":"user","ID":"extensionattribute1"},{"Source":"transformation","ID":"DataJoin","TransformationId":"JoinTheData","JwtClaimType":"JoinedData"}],"ClaimsTransformations":[{"ID":"JoinTheData","TransformationMethod":"Join","InputClaims":[{"ClaimTypeReferenceId":"extensionattribute1","TransformationClaimType":"string1"}], "InputParameters": [{"ID":"string2","Value":"sandbox"},{"ID":"separator","Value":"."}],"OutputClaims":[{"ClaimTypeReferenceId":"DataJoin","TransformationClaimType":"outputClaim"}]}]}}') -DisplayName "TransformClaimsExample"
    ```

    1. To see your new policy, and to get the policy ObjectId, run the following command:

    ```PowerShell
    Get-MgPolicyClaimMappingPolicy
    ```

2. Assign the policy to your service principal. You also need to get the ObjectId of your service principal.
    1. To see all your organization's service principals, you can [query the Microsoft Graph API](https://learn.microsoft.com/graph/traverse-the-graph). Or, in [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), sign in to your Entra Id account.
    1. When you have the ObjectId of your service principal, run the following command:

    ```PowerShell
    New-MgServicePrincipalClaimMappingPolicyByRef -ServicePrincipalId <servicePrincipalId> -BodyParameter @{"@odata.id" = "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/<claimsMappingPolicyId>"}
    ```
