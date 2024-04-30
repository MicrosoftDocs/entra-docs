---
title: Block authentication flows with Conditional Access policy 
description: Use Conditional Access policy to restrict how device code flow and authentication transfer are used within your organization.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 03/05/2024
ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: anjusingh, ludwignick
---
# Block authentication flows with Conditional Access policy 

The following steps help create Conditional Access policies to restrict how device code flow and authentication transfer are used within your organization.  

## Device code flow policies 

> [!NOTE]
> To bolster security posture, Microsoft recommends blocking or restricting device code flow wherever possible.  

You should always start by configuring a policy in [report-only mode](howto-conditional-access-insights-reporting.md) to determine the potential effect on your organization. 

We recommend organizations get as close as possible to a unilateral block on device code flow. Organizations should consider creating a policy to audit the existing use of device code flow and determine if it is still necessary.

For organizations that have no established use of device code flow, blocking can be done with the following Conditional Access policy: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Browse to **Protection** > **Conditional Access**. 
1. Select **Create new policy**. 
1. Under **Assignments**, select **Users or workload identities**. 
   1. Under **Include**, select the users you want to be in-scope for the policy (**all users** recommended).
   1. Under **Exclude**, select **Users and groups**. You should only exclude necessary users and this exclusion list should be audited regularly.  
1. Under **Target resources** > **Cloud apps** > **Include**, select the apps you want to be in-scope for the policy (**all cloud apps** recommended).
1. Under **Conditions** > **Authentication Flows**, set **Configure** to **Yes**.
   1. Select **Device code flow**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**. 
   1. Select **Select**.  
1. Confirm your settings and set **Enable policy** to **Report-only**. 
1. Select **Create** to create to enable your policy. 

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**. 

## Authentication transfer policies 

The ability to control [authentication transfer](concept-authentication-transfer.md) is in preview, use the **Authentication flows** condition in Conditional Access to manage the feature. You might want to block authentication transfer if you don’t want users to transfer authentication from their PC to a mobile device. For example, if you don’t allow Outlook to be used on personal devices by certain groups. Blocking authentication transfer can be done with the following Conditional Access policy:   

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Browse to **Protection** > **Conditional Access**. 
1. Select **Create new policy**. 
1. Under **Assignments**, select **Users or workload identities**. 
   1. Under **Include**, select **All users** or user groups you would like to block for authentication transfer.
   1. Under **Exclude**, select **Users and groups**. You should only exclude necessary users and this exclusion list should be audited regularly.
1. Under **Target resources** > **Cloud apps** > **Include**, select **All cloud apps** or apps you would like to block for authentication transfer.
1. Under **Conditions** > **Authentication Flows**, set **Configure** to **Yes**  
   1. Select **Authentication transfer**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**. 
   1. Select **Select**.  
1. Confirm your settings and set **Enable policy** to **Enabled**.
1. Select **Create** to create to enable your policy. 

## Related content

- [Conditional Access: Authentication flows](concept-authentication-flows.md)
- [Conditional Access: Authentication transfer](concept-authentication-transfer.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
