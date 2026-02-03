---
title: "Create a custom Data Loss Prevention profile with the Global Secure Access and Netskope integration"
description: "Learn how to protect your organization with a custom Data Loss Prevention (DLP) profile powered by Netskope."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to   
ms.date: 11/07/2025
ms.reviewer: abhijeetsinha
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to Create a custom Data Loss Prevention (DLP) profile so that I can protect my organization from malware and data leaks.
---
# Create a custom Data Loss Prevention (DLP) profile with the Global Secure Access and Netskope integration
Microsoft Entra Internet Access with Global Secure Access integration with Netskope provides comprehensive Data Loss Prevention (DLP) capabilities to help protect your organization's sensitive data from leaks and unauthorized access. By using Netskope's advanced DLP features, you can create and enforce policies that monitor, control, and protect data across your network.    

This guide provides step-by-step instructions to create custom DLP profiles using the Global Secure Access and Netskope integration.

## Prerequisites
To complete these steps, make sure you have the following prerequisites:
- All prerequisites listed in [Global Secure Access integration with Netskope's Advanced Threat Protection and Data Loss Prevention](concept-netskope-integration.md).
- An App Administrator role in Microsoft Entra ID to set up DLP integrations.
- Global Secure Access admins assigned to the app **Netskope GSA SAML SSO**. For more information, see [Manage user and group assignments to an application](../identity/enterprise-apps/assign-user-or-group-access-portal.md).

## Create a custom DLP profile
To create a custom DLP profile, follow these steps:

### Configure SAML SSO using Microsoft Graph API
To enable single sign-on (SSO) authentication between Global Secure Access and Netskope, you need to configure SAML SSO by running the following commands using Microsoft Graph API. Follow these steps:

1. Create a claims mapping policy.
    ```json
    POST https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies 

    { 
    
      "definition": [ 
    
       "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"Id\":\"userprincipalname\",\"SamlClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier\"},{\"Source\":\"user\",\"Id\":\"givenname\",\"SamlClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname\"},{\"Source\":\"user\",\"Id\":\"displayname\",\"SamlClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name\"},{\"Source\":\"user\",\"Id\":\"surname\",\"SamlClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname\"},{\"Source\":\"user\",\"Id\":\"assignedroles\",\"SamlClaimType\":\"admin-role\"},{\"Source\":\"user\",\"Id\":\"mail\",\"SamlClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress\"}]}}" 
    
      ], 
    
      "displayName": "Netskope SAML SSO Claims Policy" 
    
    } 
    ``` 
1. Copy the ID from the response.
1. Get the application ID.
    ```json
    GET https://graph.microsoft.com/v1.0/applications?$filter=displayName+eq+'Netskope+GSA+SAML+SSO'&$select=appId
    ```
1. Associate the claims mapping policy.   
    Replace `<insert app id>` and `<insert claims mapping policy id>` with the respective values obtained from previous steps. 
 
    ```json
    POST https://graph.microsoft.com/v1.0/servicePrincipals(appId='<insert app id>')/claimsMappingPolicies/$ref 

    { 
    
      "@odata.id": "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/<insert claims mapping policy id>" 

    } 
    ```

### Create a DLP policy with a custom DLP profile
To create a DLP policy with a custom DLP profile, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **Data Loss Prevention policies**. 
1. Select **+ Create policy** and select a DLP profile.
1. Select the link to open the Netskope admin center.
1. In the Netskope admin center, [create a custom DLP profile](https://docs.netskope.com/en/create-a-custom-dlp-profile).
1. After creating the profile, return to the Microsoft Entra admin center.
1. The custom DLP profile automatically syncs and appears in the DLP profiles list.
1. Select the custom DLP profile and complete the policy creation workflow.

## Activate a Netskope offer
Netskope’s DLP offering is a value-added enhancement to Microsoft Entra Internet Access. For instructions on how to start a free trial or contact Netskope for a private offer, see [Activate a Netskope offer through the Global Secure Access marketplace](concept-netskope-integration.md#activate-a-netskope-offer-through-the-global-secure-access-marketplace).

## Related content
- [Global Secure Access integration with Netskope's Advanced Threat Protection and Data Loss Prevention](concept-netskope-integration.md)
