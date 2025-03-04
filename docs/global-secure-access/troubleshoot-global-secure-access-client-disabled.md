---
title: "Troubleshoot the Global Secure Access Client: Disabled by Your Organization"
description: Troubleshoot the Global Secure Access client using the health check tab in the advanced diagnostics utility.
ms.service: global-secure-access
ms.topic: troubleshooting
ms.date: 03/03/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: femila
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
> To get the policy, the Global Secure Access client uses a non-interactive, silent authentication. 

1. If the traffic forwarding profile is assigned to specific users and groups, ensure that the user who is signed in to Windows is either assigned to the profile or is a direct member of a group assigned to the profile.   
:::image type="content" source="media/troubleshoot-global-secure-access-client-disabled/user-group-assignments.png" alt-text="Screenshot of the User and group assignments screen.":::

> [!NOTE]
> Traffic profiles are fetched on behalf of the Microsoft Entra user logged into Windows, not the user logged into the client. Multiple users logging into the same device simultaneously isn't supported. Nested group memberships aren't supported. Each user must be a direct member of the group assigned to the profile. 

8. Ensure the Global Secure Access client can reach the policy service in the cloud by checking that the **Policy service hostname resolved by DNS** and the **Policy server is reachable** health check tests pass.
:::image type="content" source="media/troubleshoot-global-secure-access-client-disabled/hostname-resolved.png" alt-text="Screenshot of the Advanced diagnotics Health check tab, with Policy service hostname resolved and Policy server is reachable tests highlighted.":::  

## Related content
- [How to assign users and groups to traffic forwarding profiles](how-to-manage-users-groups-assignment.md)   
- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)   
- [Troubleshoot the Global Secure Access client: Advanced diagnostics](troubleshoot-global-secure-access-client-advanced-diagnostics.md)   
