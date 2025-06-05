---
title: Convert guest user lifecycle in entitlement management - Microsoft Entra
description: Learn how to convert guest user access package assignments for an access package in entitlement management.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 07/15/2024
ms.author: owinfrey
ms.custom: sfi-image-nochange
#Customer intent: As an administrator, I want detailed information about how I can convert an ungoverned guest user access package assignment so that requestors have the resources they need to perform their job.
---

# Manage guest user lifecycle

Entitlement management allows you to gain visibility into the state of a guest user's lifecycle through the following viewpoints:

- **Governed** - The guest user is set to be governed.  
- **Ungoverned** - The guest user is set to not be governed.
- **Blank** - The lifecycle for the guest user isn't determined. This happens when the guest user had an access package assigned before managing user lifecycle was possible.

> [!NOTE]
> When a guest user is set as **Governed**, based on entitlement management tenant-wide settings their account will be deleted or disabled in specified days after their last access package assignment expires.  Learn more about entitlement management settings here: [Manage external access with Microsoft Entra entitlement management](../architecture/6-secure-access-entitlement-managment.md).

Guest users that already existed in your tenant by being invited are ungoverned. After an ungoverned guest that requests access packages lose their last access package assignment, they'll remain in the tenant indefinitely. If there are guests that have an access package assignment, and only need access from that access package, and there's no other need for them to remain in the tenant, you can convert them to be governed during the time they have that access package assignment. You can directly convert those ungoverned users to be governed by using the **Mark Guests as Governed** functionality in the top menu bar of an access package.

## Manage guest user lifecycle in the Microsoft Entra admin center


To manage user lifecycle, you'd follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!TIP]
    > Other least privilege roles that can complete this task include the Catalog owner, the Access package manager, and the Access package assignment manager.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. On the **Access packages** page, open the access package you want to manage guest user lifecycle of.

1. In the left menu, select **Assignments**.

1. On the assignments screen, select the user you want to manage the lifecycle for, and then select **Mark guest as governed**. Only users who requested access for themselves, and not those users who were assigned to the access package, can be changed.
    :::image type="content" source="media/entitlement-management-access-package-assignments/govern-user-lifecycle.png" alt-text="Screenshot of the governed user lifecycle selection." lightbox="media/entitlement-management-access-package-assignments/govern-user-lifecycle.png":::
1. Select save.

## Manage guest user lifecycle programmatically

To manage user lifecycle programmatically using Microsoft Graph, see: [`accessPackageSubject` resource type](/graph/api/resources/accesspackagesubject).

## Next steps

- [What is entitlement management?](entitlement-management-overview.md)
