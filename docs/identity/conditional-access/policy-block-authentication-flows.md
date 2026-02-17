---
title: Block authentication flows with Conditional Access policy
description: Secure your organization by blocking device code flow and authentication transfer. Learn how to configure Conditional Access policies effectively.
ms.topic: how-to
ms.date: 12/04/2025
manager: dougeby
ms.reviewer: anjusingh, ludwignick
---
# Block authentication flows with Conditional Access policy 

The following steps help you create Conditional Access policies to restrict how [device code flow](concept-authentication-flows.md#device-code-flow) and [authentication transfer](concept-authentication-flows.md#authentication-transfer) are used within your organization.  

## Device code flow policies 

We recommend organizations get as close as possible to a unilateral block on device code flow. Consider creating a policy to audit the existing use of device code flow and determine if it's still necessary. Only allow device code flow in well documented and secured use cases, like legacy tooling that can't be updated.

For organizations that don't use device code flow, block it with the following Conditional Access policy: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Under **Assignments**, select **Users or workload identities**. 
   1. Under **Include**, select the users you want to be in-scope for the policy (**all users** recommended).
   1. Under **Exclude**: 
      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts and any other necessary users. Audit this exclusion list regularly.  
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select the apps you want to be in-scope for the policy (**All resources (formerly 'All cloud apps')** recommended).
1. Under **Conditions** > **Authentication Flows**, set **Configure** to **Yes**.
   1. Select **Device code flow**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**. 
   1. Select **Select**.  
1. Confirm your settings and set **Enable policy** to **Report-only**. 
1. Select **Create** to enable your policy. 

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)] 

## Authentication transfer policies 

Use the **Authentication flows** condition in Conditional Access to manage the feature. Block [authentication transfer](concept-authentication-transfer.md) if you don't want users to transfer authentication from their PC to a mobile device. For example, block authentication transfer if you don't allow Outlook to be used on personal devices by certain groups. Use the following Conditional Access policy to block authentication transfer:   

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Under **Assignments**, select **Users or workload identities**. 
   1. Under **Include**, select **All users** or user groups you want to block for authentication transfer.
   1. Under **Exclude**: 
      1. Select **Users and groups** and choose your organization's emergency access or break-glass accounts and any other necessary users. Audit this exclusion list regularly.  
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')** or apps you want to block for authentication transfer.
1. Under **Conditions** > **Authentication Flows**, set **Configure** to **Yes**  
   1. Select **Authentication transfer**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**. 
   1. Select **Select**.  
1. Confirm your settings and set **Enable policy** to **Enabled**.
1. Select **Create** to enable your policy. 

## Related content

- [Conditional Access: Authentication flows](concept-authentication-flows.md)
- [Conditional Access: Authentication transfer](concept-authentication-transfer.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
