---
title: "Troubleshoot the Global Secure Access Client: Disabled by Your Organization"
description: Troubleshoot the Global Secure Access client using the health check tab in the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 02/19/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: I want to troubleshoot the Global Secure Access client when I see the "disabled by your organization" error message.
---
# Troubleshoot the Global Secure Access client: disabled by your organization
This document provides troubleshooting guidance for the Global Secure Access client. It explores how to troubleshoot the error message, "disabled by your organization."
:::image type="content" source="media/troubleshoot-global-secure-access-client-disabled/warning-message.png" alt-text="Screenshot of the warning message, Global Secure Access - disabled by your organization.":::

The **Global Secure Access client - disabled by your organization** error message can appear right after installing the Global Secure Access client if the Global Secure Access client is unable to get the Global Secure Access policy either because the Global Secure Access Traffic profiles weren't enabled in the tenant the device and user belong to or if user isn't authorized to get any of the Global Secure Access traffic profiles or lastly due to any reason because of which the Global Secure Access client is unable to query the Global Secure Access Traffic profile configuration. 

Global Secure Access Traffic profiles configuration can be found in the Microsoft Entra Admin portal > Global Secure Access section > Connect > Traffic forwarding 

## Troubleshooting steps    
1. Check if all the forwarding profiles are disabled (Entra Portal > Global Secure Access > Connect > Traffic Forwarding). At least one traffic profile needs to be enabled, and the users signed into the device getting the error should be assigned to the Global Secure Access traffic profile that is enabled. 

1. Ensure the user authentication is successful and the Global Secure Access Client can't get an authentication token on-behalf of the user. 

1. Check if the user is blocked by a conditional access policy either from a network blocked by CA or unmanaged or noncompliant device or ToU (Terms of Usage) can't be fulfilled. Note: the Global Secure Access client uses silent authorization (non-interactive). 

1. You might also face an issue if the user has NO PRT (Primary Refresh Token) and ALL user assignment is turned off on the enabled forwarding profiles ("Assign to all users" is set to NO) and the user is assigned directly (or part of the assigned group). Note: run "Dsregcmd /status cmd on the client device and validate the `AzureAdPrt` value is `Yes`. 

1. Direct assignment is configured on the enabled forwarding profiles, but the user logged into the device isn't assigned (or not part of the assigned group). Note: Traffic profiles are fetched on behalf of the Microsoft Entra user logged into the device, not the user logged into the client. Multiple users logging into the same device simultaneously isn't supported. Nested group memberships aren't supported. Each user must be a direct member of the group assigned to the profile. 

1. It might also be worth checking if  the user facing the issue has the necessary Global Secure Access license (Global Secure Access - licensing) assigned. 

1. Lastly, check if there's a network communication issue when the client tries to communicate with the policy endpoint. 




|Icon    |Message    |Description    |
|---------|---------|---------|
|:::image type="icon" source="media/troubleshoot-global-secure-access-client-disabled/global-secure-access-client-icon-warning.png":::	|Global Secure Access - Disabled by your organization	|Your organization disabled the client (that is, all traffic forwarding profiles are disabled).    |



## Related content
- [How to assign users and groups to traffic forwarding profiles](how-to-manage-users-groups-assignment.md)   
- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)   
- [Troubleshoot the Global Secure Access client: Advanced diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)   
