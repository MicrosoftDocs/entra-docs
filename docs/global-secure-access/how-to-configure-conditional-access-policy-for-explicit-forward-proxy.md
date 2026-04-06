---
title: Learn How to Configure Conditional Access Policy for Explicit Forward Proxy
description: Learn How to Configure Conditional Access Policy for Explicit Forward Proxy
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Configure Entra ID Conditional Access Policy for EFP

## Overview

EFP for Internet Access relies on IP affinity, among other mechanisms, for session management. While not required, we recommend that you configure a Conditional Access policy that restricts the use of EFP to networks your organization trusts. Additionally, you use Conditional Access policies to assign the Entra Internet Access security profiles to users. 

## Prerequisites

- Administrators who configure and manage the Conditional Access policy for EFP must have at least the Conditional Access Administrator Entra ID role.
 - EFP is enabled in Global Secure Access > Session Management section of the Entra Portal. Enabling EFP creates the workload identity in the Entra ID tenant. This workload identity is the target for the Conditional Access policy.
- Security Profile is configured in Global Secure Access > Secure > Security Profiles
- A Named Location representing known company networks is defined in Entra ID Conditional Access

## Scoping EFP to Known Networks

1. Navigate to the Entra Portal. Under Entra ID, click on Conditional Access blade. Then, click on +Create new policy.
1. Give the policy a name that aligns with your organization’s policy naming standards. For example, ‘GSA – Explicit Forward Proxy Known Locations Policy’.
1. Under Assignments, select ‘Users and Groups’. Typically, you would scope this policy to All Users, and make exceptions as necessary on the Exclude tab.
1. Under Target Resources, click on ‘Select resources’ radio button, and then click on ‘Select specific resources’. Search for ‘GSA-ExplicitForwardProxy’ workload identity and select it.
1. On the Network blade of the new policy, select ‘Configure’ and leave the defaults under ‘Include’ – ‘Any network or location’. Under Exclude, select a named location that represents known networks from which you allow the use of EFP.
1. Under the Grant tab, select ‘Block’. 
1. Toggle the Enable policy control to ‘On’ and click the Create button.

With this configuration, EFP authorization and use will only be possible from networks that are known to your organization.

## Assigning Security Profiles to EFP

Security profiles are assigned using Entra ID Conditional Access policies. You can assign policies to EFP using either the ‘All internet resources with Global Secure Access’ resource assignment (if your security profiles are the same for EFP as they are for the GSA client), or by explicitly targeting the GSA-ExplicitForwardProxy workload identity (if your security profiles for EFP and GSA Client scenarios are different).
To configure the policy, please follow https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-configure-web-content-filtering?tabs=microsoft-entra-admin-center#create-and-link-conditional-access-policy 

