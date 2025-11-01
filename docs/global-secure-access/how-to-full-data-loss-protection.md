---
title: "Set up full Data Loss Prevention with the Global Secure Access and Netskope integration"
description: "Learn how to protect your organization a full Data Loss Prevention (DLP) policy powered by Netskope."
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to   
ms.date: 10/31/2025
manager: dougeby
ms.reviewer: abhijeetsinha
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to configure Data Loss Prevention policies so that I can protect my organization from malware and data leaks.
---
# Set up full Data Loss Prevention (DLP) policies with the Global Secure Access and Netskope integration
Microsoft Entra Internet Access with Global Secure Access integration with Netskope provides comprehensive Data Loss Prevention (DLP) capabilities to help protect your organization's sensitive data from leaks and unauthorized access. By leveraging Netskope's advanced DLP features, you can create and enforce policies that monitor, control, and protect data across your network.    

This guide provides step-by-step instructions to set up full DLP policies using the Global Secure Access and Netskope integration.

## Prerequisites
To complete these steps, make sure you have the following prerequisites:
- A Global Secure Access Administrator role in Microsoft Entra ID to configure Global Secure Access settings.
- An App Administrator role in Microsoft Entra ID to set up DLP integrations.
- Assign Global Secure Access admins to the app **Netskope GSA SAML SSO**.
 <!--What does the above step mean? What is this app? Can we change its name (we shouldn't abbreviate Global Secure Access)?  -->
- A tenant configured with a Transport Layer Security (TLS) inspection policy as described in [Configure Transport Layer Security Inspection](how-to-transport-layer-security.md).
- Devices or virtual machines running Windows 10 or Windows 11 that are joined or hybrid joined to a Microsoft Entra ID.
- Devices with the Global Secure Access client installed. See [Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md) for requirements and installation instructions.
- A Conditional Access Administrator role to configure Conditional Access policies.
- Trial Microsoft Entra Internet Access licenses. For licensing details, see the Global Secure Access [Licensing overview](overview-what-is-global-secure-access.md#licensing-overview). You can purchase licenses or get trial licenses. To activate an Internet Access trial, browse to [aka.ms/InternetAccessTrial](https://aka.ms/InternetAccessTrial).

## Set up full DLP integration
To set up full DLP integration between Global Secure Access and Netskope, follow these steps:

### Configure SAML SSO using Microsoft Graph API
To enable Single Sign-On (SSO) authentication between Global Secure Access and Netskope, you need to configure SAML SSO by running the following commands using Microsoft Graph API. Follow these steps:

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
    Replace `insert app id` and `insert claims mapping policy id` with the respective values obtained from previous steps. 
 
    ```json
    POST https://graph.microsoft.com/v1.0/servicePrincipals(appId='<insert app id>')/claimsMappingPolicies/$ref 

    { 
    
      "@odata.id": "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/<insert claims mapping policy id>" 

    } 
    ```

### Configure the full DLP integration
To configure the full DLP integration between Global Secure Access and Netskope, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **Data Loss Prevention policies**. 
1. Select **+ Create policy** and select a DLP profile. <!-- Which DLP profiles should be visible? Which one should we select for this example? -->
1. Select the link to open the Netskope admin center. <!-- Where is this link to the Netskope admin center? Should it be visible in the Entra admin center? -->
1. In the Netskope admin center, [create a custom DLP profile](https://docs.netskope.com/en/create-a-custom-dlp-profile).
1. After creating the profile, return to the Entra admin center.
1. The custom DLP profile automatically syncs and appears in the DLP profiles list. <!-- What is the name of the custom DLP profile? Is it always the same? If so, we should call it out specifically. -->
1. Select the custom DLP profile and complete the policy creation workflow.

## Activate a Netskope offer
Netskope’s DLP offering is a value-added enhancement to Microsoft Entra Internet Access. For instructions on how to start a free trial or contact Netskope for a private offer, see [Activate a Netskope offer through the Global Secure Access marketplace](concept-netskope-integration.md#activate-a-netskope-offer-through-the-global-secure-access-marketplace).

## Related content
- [Global Secure Access integration with Netskope's Advanced Threat Protection and Data Loss Prevention](concept-netskope-integration.md)
