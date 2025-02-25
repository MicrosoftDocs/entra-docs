---
title: "Troubleshoot the Global Secure Access Client: Disabled by Your Organization"
description: Troubleshoot the Global Secure Access client using the health check tab in the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 02/24/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: I want to troubleshoot the Global Secure Access client when I see the "disabled by your organization" error message.
---
# Troubleshoot the Global Secure Access client: disabled by your organization
This document provides troubleshooting guidance for the Global Secure Access client. It explores how to troubleshoot the error message, **Global Secure Access client - disabled by your organization**.   

|Icon    |Message    |Description    |
|---------|---------|---------|
|:::image type="icon" source="media/troubleshoot-global-secure-access-client-disabled/global-secure-access-client-icon-warning.png":::	|Global Secure Access - disabled by your organization	|Your organization disabled the client (that is, all traffic forwarding profiles are disabled).    |

The **Global Secure Access client - disabled by your organization** error message appears when the Global Secure Access client is deliberately deactivated by your organization's administrator.   
:::image type="content" source="media/troubleshoot-global-secure-access-client-disabled/warning-message.png" alt-text="Screenshot of the warning message, Global Secure Access - disabled by your organization.":::

The message can also appear right after installing the client if the Global Secure Access client is unable to acquire the Global Secure Access policy. This policy failure can happen for several reasons, including:   
- The Global Secure Access traffic profiles aren't enabled for the tenant the device is using.   
- The user isn't authorized to use any of the Global Secure Access traffic profiles.   
- The Global Secure Access client, for any reason, is unable to query the traffic profile configuration.    

To view the Global Secure Access traffic profile configuration:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Navigate to **Global Secure Access** > **Connect** > **Traffic forwarding**.   
:::image type="content" source="media/troubleshoot-global-secure-access-client-disabled/traffic-forwarding.png" alt-text="Screenshot of the Traffic forwarding profiles screen." lightbox="media/troubleshoot-global-secure-access-client-disabled/traffic-forwarding-expanded.png":::

## Troubleshooting steps    
1. View the available traffic forwarding profiles. At least one traffic forwarding profile must be enabled. Verify that the user is assigned to the enabled traffic forwarding profile. 

1. Ensure the user authentication is successful and the Global Secure Access Client can't get an authentication token on behalf of the user. 

1. Check if a conditional access policy is blocking the user. Network blocks can arise from conditional access settings, an unmanaged or noncompliant device, or unfulfilled terms of use (ToU) policies. 
> [!NOTE]
> The Global Secure Access client uses non-interactive, silent authorization. 

4. Check if the user has no Primary Refresh Token (NO PRT).

1. Check if **Assign to all users** is set to `NO` on the enabled forwarding profiles.

1. Check if the user (or part of the assigned group) is assigned directly. Run the command `Dsregcmd /status` on the client device and validate the **AzureAdPrt** value is `Yes`. 

1. Check if **Direct assignment** is configured on the enabled forwarding profiles, but the user logged into the device isn't assigned (or isn't part of the assigned group). 
> [!NOTE]
> Traffic profiles are fetched on behalf of the Microsoft Entra user logged into the device, not the user logged into the client. Multiple users logging into the same device simultaneously isn't supported. Nested group memberships aren't supported. Each user must be a direct member of the group assigned to the profile. 

8. Check if the user is assigned all necessary Global Secure Access licenses: navigate to **Global Secure Access** > **Licensing**.

1. Check if there's a network communication issue when the Global Secure Access client attempts to communicate with the policy endpoint.  

## Related content
- [How to assign users and groups to traffic forwarding profiles](how-to-manage-users-groups-assignment.md)   
- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)   
- [Troubleshoot the Global Secure Access client: Advanced diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)   
