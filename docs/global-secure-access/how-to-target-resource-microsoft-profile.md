---
title: Microsoft traffic Conditional Access policies
description: Learn how to apply Conditional Access policies to the Global Secure Access traffic.
ms.service: global-secure-access
ms.subservice: entra-internet-access
ms.topic: how-to
ms.date: 02/21/2025
ms.author: kenwith
author: kenwith
manager: femila
ms.reviewer: alexpav
ai-usage: ai-assisted
---
# Apply Conditional Access policies to Global Secure Access traffic

You apply Conditional Access policies to Global Secure Access traffic. With Conditional Access, you can require multifactor authentication and device compliance for accessing Microsoft resources. 

This article describes how to apply Conditional Access policies to your Global Secure Access internet traffic.

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   * The [Global Secure Access Administrator role](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role to manage the Global Secure Access features.
   * The [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role to create and interact with Conditional Access policies.
* The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Create a Conditional Access policy targeting Global Secure Access internet traffic

The following example policy targets all users except for your break-glass accounts and guest/external users, requiring multifactor authentication, device compliance, or a Microsoft Entra hybrid joined device for Global Secure Access internet traffic.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select the **Users and groups** link.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**:
      1. Select **Users and groups** and choose your organization's [emergency access or break-glass accounts](#user-exclusions).
      1. Select **Guest or external users** and select all checkboxes.
1. Under **Target resources** > **Resources (formerly cloud apps)**.
   1. Choose **All internet resources with Global Secure Access**.

   :::image type="content" source="media/how-to-target-resource-microsoft-profile/target-resource-traffic-profile.png" alt-text="Screenshot showing a Conditional Access policy targeting a traffic profile.":::

   > [!NOTE]
   > To only enforce the *Internet Access traffic forwarding profile* and **not** the *Microsoft traffic forwarding profile* then choose **Select resources** and select **Internet resources** from the app picker and configure a security profile. 

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
