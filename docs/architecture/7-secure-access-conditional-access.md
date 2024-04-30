---
title: Manage external access to resources with Conditional Access
description: Learn to use Conditional Access policies to secure external access to resources.
author: janicericketts
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 02/23/2023
ms.author: jricketts
ms.reviewer: ajburnle
---

# Manage external access to resources with Conditional Access policies

Conditional Access interprets signals, enforces policies, and determines if a user is granted access to resources. In this article, learn about applying Conditional Access policies to external users. The article assumes you might not have access to entitlement management, a feature you can use with Conditional Access.

Learn more:

- [What is Conditional Access?](~/identity/conditional-access/overview.md)
- [Plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md)
- [What is entitlement management?](~/id-governance/entitlement-management-overview.md)

The following diagram illustrates signals to Conditional Access that trigger access processes.

   ![Diagram of Conditional Access signal input and resulting access processes.](media/secure-external-access//7-conditional-access-signals.png)

## Before you begin

This article is number 7 in a series of 10 articles. We recommend you review the articles in order. Go to the **Next steps** section to see the entire series.

## Align a security plan with Conditional Access policies

In the third article, in the set of 10 articles, there's guidance on creating a security plan. Use that plan to help create Conditional Access policies for external access. Part of the security plan includes:

- Grouped applications and resources for simplified access
- Sign-in requirements for external users

> [!IMPORTANT]
> Create internal and external user test accounts to test policies before applying them.

See article three, [Create a security plan for external access to resources](3-secure-access-plan.md)

## Conditional Access policies for external access

The following sections are best practices for governing external access with Conditional Access policies.

### Entitlement management or groups

If you can't use connected organizations in entitlement management, create a Microsoft Entra security group, or Microsoft 365 Group for partner organizations. Assign users from that partner to the group. You can use the groups in Conditional Access policies.

Learn more:

* [What is entitlement management?](~/id-governance/entitlement-management-overview.md)
* [Manage Microsoft Entra groups and group membership](~/fundamentals/how-to-manage-groups.yml)
* [Overview of Microsoft 365 Groups for administrators](/microsoft-365/admin/create-groups/office-365-groups?view=o365-worldwide&preserve-view=true)

### Conditional Access policy creation

Create as few Conditional Access policies as possible. For applications that have the same access requirements, add them to the same policy.

Conditional Access policies apply to a maximum of 250 applications. If more than 250 applications have the same access requirement, create duplicate policies. For instance, Policy A applies to apps 1-250, Policy B applies to apps 251-500, and so on.

### Naming convention

Use a naming convention that clarifies policy purpose. External access examples are:

- ExternalAccess_actiontaken_AppGroup
- ExternalAccess_Block_FinanceApps

## Allow external access to specific external users

There are scenarios when it's necessary to allow access for a small, specific group.

Before you begin, we recommend you create a security group, which contains external users who access resources. See, [Quickstart: Create a group with members and view all groups and members in Microsoft Entra ID](~/fundamentals/groups-view-azure-portal.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All guests and external users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts and the external users security group.
1. Under **Target resources** > **Cloud apps**, select the following options:
   1. Under **Include**, select **All cloud apps**
   1. Under **Exclude**, select applications you want to exclude.
1. Under **Access controls** > **Grant**, select **Block access**, then select **Select**.
1. Select **Create** to create to enable your policy.

> [!NOTE]
> After administrators confirm the settings using [report-only mode](~/identity/conditional-access/howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

Learn more: [Manage emergency access accounts in Microsoft Entra ID](~/identity/role-based-access-control/security-emergency-access.md)

## Service provider access

Conditional Access policies for external users might interfere with service provider access, for example granular delegated administrate privileges.

Learn more: [Introduction to granular delegated admin privileges (GDAP)](/partner-center/gdap-introduction)

## Conditional Access templates

Conditional Access templates are a convenient method to deploy new policies aligned with Microsoft recommendations. These templates provide protection aligned with commonly used policies across various customer types and locations.

Learn more: [Conditional Access templates (Preview)](~/identity/conditional-access/concept-conditional-access-policy-common.md)

## Next steps

Use the following series of articles to learn about securing external access to resources. We recommend you follow the listed order.

1. [Determine your security posture for external access with Microsoft Entra ID](1-secure-access-posture.md)

2. [Discover the current state of external collaboration in your organization](2-secure-access-current-state.md)

3. [Create a security plan for external access to resources](3-secure-access-plan.md)

4. [Secure external access with groups in Microsoft Entra ID and Microsoft 365](4-secure-access-groups.md)

5. [Transition to governed collaboration with Microsoft Entra B2B collaboration](5-secure-access-b2b.md)

6. [Manage external access with Microsoft Entra entitlement management](6-secure-access-entitlement-managment.md)

7. [Manage external access to resources with Conditional Access policies](7-secure-access-conditional-access.md) (You're here)

8. [Control external access to resources in Microsoft Entra ID with sensitivity labels](8-secure-access-sensitivity-labels.md)

9. [Secure external access to Microsoft Teams, SharePoint, and OneDrive for Business with Microsoft Entra ID](9-secure-access-teams-sharepoint.md)

10. [Convert local guest accounts to Microsoft Entra B2B guest accounts](10-secure-local-guest.md)
