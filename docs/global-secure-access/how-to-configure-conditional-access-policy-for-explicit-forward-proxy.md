---
title: Learn How to Configure Conditional Access Policy for Explicit Forward Proxy
description: Learn How to Configure Conditional Access Policy for Explicit Forward Proxy
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Configure Microsoft Entra Conditional Access Policy for Explicit Forward Proxy (preview)

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Overview

Explicit Forward Proxy (EFP) for Microsoft Entra Internet Access relies on IP affinity, among other mechanisms, for session management. While not required, we recommend that you configure a Conditional Access policy that restricts the use of EFP on networks your organization trusts. Additionally, you use Conditional Access policies to assign the Microsoft Entra Internet Access security profiles to users. 

## Prerequisites

- Administrators who configure and manage the Conditional Access policy for EFP must have at least the Conditional Access Administrator role.
 - EFP is enabled in Global Secure Access > Session Management section of the Microsoft Entra admin center. Enabling EFP creates the workload identity in your tenant. This workload identity is the target for the Conditional Access policy.
- Security Profile is configured in Global Secure Access > Secure > Security Profiles
- A Named Location that represents known company networks is defined in Microsoft Entra Conditional Access

## Scoping EFP to Known Networks

1. Navigate to the Microsoft Entra admin center. Under **Entra ID**, select  **Conditional Access**. Then, select **+Create new policy**.
1. Give the policy a name that aligns with your organization’s policy naming standards. For example, **GSA – Explicit Forward Proxy Known Locations Policy**.
1. Under Assignments, select **Users and Groups**. Typically, you would scope this policy to All Users, and make exceptions (for example, your break-glass accounts) as necessary on the Exclude tab.
1. Under Target Resources, select **Select resources** radio button, and then **Select specific resources**. Search for **GSA-ExplicitForwardProxy** workload identity and select it.
1. On the **Network** tab of the new policy, select **Configure** and leave the defaults under **Include** – **Any network or location**. Under Exclude, select a named location that represents known networks from which you allow the use of EFP.
1. Under the Grant tab, select **Block**. 
1. Toggle the **Enable policy control** to **On** and select the **Create** button.

> [!Note]
> Explicit Forward Proxy (EFP) preview is not currently included in the **All internet resources with Global Secure Access** group. If your users use Explicit Forward Proxy (preview), please follow [How to configure EFP Conditional Access Policies](how-to-configure-conditional-access-policy-for-explicit-forward-proxy.md)


## Assigning Security Profiles to EFP

Security profiles are assigned using Microsoft Entra Conditional Access policies. You can assign policies to EFP using either the ‘All internet resources with Global Secure Access’ resource assignment (if your security profiles are the same for EFP as they are for the Global Secure Access client), or by explicitly targeting the GSA-ExplicitForwardProxy workload identity (if your security profiles for EFP and GSA Client scenarios are different).
To configure the policy, follow https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-configure-web-content-filtering?tabs=microsoft-entra-admin-center#create-and-link-conditional-access-policy 

