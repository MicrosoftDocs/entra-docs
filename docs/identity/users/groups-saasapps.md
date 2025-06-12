---
title: Use a group to manage access to SaaS apps
description: Learn how to use groups in Microsoft Entra ID to assign access to SaaS applications that are integrated with Microsoft Entra ID.
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 12/13/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, sfi-image-nochange
---
# Use a group to manage access to SaaS applications

When you use Microsoft Entra ID with a Microsoft Entra ID P1 or P2 license plan, you can use groups to assign access to software as a service (SaaS) applications integrated with Microsoft Entra ID.

For example, if you want to assign access for a marketing department to use five different SaaS applications, you can create an Office 365 or security group that contains the users in the marketing department. Then you can assign that group to the five SaaS applications that the marketing department needs.

With Microsoft Entra ID, you can save time by managing the membership of the marketing department in one place. Users then are assigned to the application when they're added as members of the marketing group. They have their assignments removed from the application when they're removed from the marketing group. You can use this capability with hundreds of applications that you can add from within the Microsoft Entra Application Gallery.

> [!IMPORTANT]
> You can use this feature only after you start a Microsoft Entra ID P1 or P2 trial or purchase a Microsoft Entra ID P1 or P2 license plan.
> Group-based assignment is supported only for security groups.
> Nested group memberships aren't supported for group-based assignment to applications at this time.

<a name='assign-access-for-a-user-or-group-to-an-saas-application'></a>

## Assign access for a user or group to a SaaS application


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Go to **Applications** > **Enterprise applications** to open **All applications** in the Application Gallery.

   :::image type="content" source="./media/domains-manage/enterprise-apps.png" alt-text="Screenshot that shows the Application Gallery.":::

1. Select an application that you added from the Application Gallery to open it.
1. On the left pane, select **Users and groups**, and then select **Add user/group**.
1. On **Add Assignment**, select **Users and groups** to open the **Users and groups** selection list.
1. Select as many groups or users as you want, and then select or tap **Select** to add them to the **Add Assignment** list. You can also assign a role to a user at this stage.
1. Select **Assign** to assign the users or groups to the selected enterprise application.

## Next steps

For more information on Microsoft Entra ID, see:

* [Managing access to resources with Microsoft Entra groups](~/fundamentals/concept-learn-about-groups.md)
* [Application management in Microsoft Entra ID](~/identity/enterprise-apps/what-is-application-management.md)
* [Microsoft Entra cmdlets for configuring group settings](~/identity/users/groups-settings-cmdlets.md)
* [What is Microsoft Entra ID?](~/fundamentals/whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](~/identity/hybrid/whatis-hybrid-identity.md)
