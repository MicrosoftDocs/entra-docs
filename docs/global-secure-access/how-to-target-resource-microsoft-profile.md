---
title: Microsoft traffic Conditional Access policies
description: Learn how to apply Conditional Access policies to the Microsoft traffic profile with Global Secure Access.
ms.service: global-secure-access
ms.subservice: entra-internet-access
ms.topic: how-to
ms.date: 05/20/2024
ms.author: kenwith
author: kenwith
manager: amycolannino
ms.reviewer: alexpav
---
# Apply Conditional Access policies to the Microsoft traffic profile

With a dedicated traffic forwarding profile for your Microsoft traffic, you can apply Conditional Access policies to Microsoft traffic. With Conditional Access, you can require multifactor authentication and device compliance for accessing Microsoft resources. 

This article describes how to apply Conditional Access policies to your Microsoft traffic forwarding profile.

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   * The [Global Secure Access Administrator role](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role to manage the Global Secure Access features.
   * The [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role to create and interact with Conditional Access policies.
* The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
* To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

## Create a Conditional Access policy targeting the Microsoft traffic profile

The following example policy targets all users except for your break-glass accounts and guest/external users, requiring multifactor authentication, device compliance, or a Microsoft Entra hybrid joined device when accessing Microsoft traffic.

:::image type="content" source="media/how-to-target-resource-microsoft-profile/target-resource-traffic-profile.png" alt-text="Screenshot showing a Conditional Access policy targeting a traffic profile.":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Identity** > **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**:
      1. Select **Users and groups** and choose your organization's [emergency access or break-glass accounts](#user-exclusions).
      1. Select **Guest or external users** and select all checkboxes.
1. Under **Target resources** > **Global Secure Access***.
   1. Choose **Microsoft traffic**.
1. Under **Access controls** > **Grant**.
   1. Select **Require multifactor authentication**, **Require device to be marked as compliant**, and **Require Microsoft Entra hybrid joined device**
   1. **For multiple controls** select **Require one of the selected controls**.
   1. Select **Select**.

After administrators confirm the policy settings using [report-only mode](../identity/conditional-access/concept-conditional-access-report-only.md), an administrator can move the **Enable policy** toggle from **Report-only** to **On**.

### User exclusions

[!INCLUDE [entra-policy-exclude-user](../includes/entra-policy-exclude-user.md)]

## Next steps

The next step for getting started with Microsoft Entra Internet Access is to [review the Global Secure Access logs](concept-global-secure-access-logs-monitoring.md).

For more information about traffic forwarding, see the following articles:

- [Learn about traffic forwarding profiles](concept-traffic-forwarding.md)
- [Manage the Microsoft traffic profile](how-to-manage-microsoft-profile.md)
