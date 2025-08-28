---
title: Restore or permanently remove recently deleted user
description: How to view restorable users, restore a deleted user, or permanently delete a user with Microsoft Entra ID.
author: barclayn
ms.author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: how-to
ms.date: 03/05/2025
ms.reviewer: jeffsta
ms.custom: ge-structured-content-pilot, sfi-image-nochange
---

# Restore or remove a recently deleted user


After you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored, along with all its properties. 

After that 30-day window passes, the permanent deletion process is automatically started and can't be stopped. During this time, the management of soft-deleted users is blocked. This limitation also applies to restoring a soft-deleted user via a match during Tenant sync cycle for on-premises hybrid scenarios.

You can view your restorable users, restore a deleted user, or permanently delete a user using the Microsoft Entra admin center.

> [!IMPORTANT]
> Neither you nor Microsoft customer support can restore a permanently deleted user.

## Prerequisites

You must have at least the following role to restore and permanently delete users.

## View your restorable users

You can see all the users that were deleted less than 30 days ago. These users can be restored.

### To view your restorable users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

2. Browse to **Entra ID** > **Users** > **Deleted users**.

3. Review the list of users that are available to restore.

  :::image type="content" source="media/users-restore/users-deleted-users-view-restorable.png" alt-text="Screenshot of the Users - Deleted users page, with users that can still be restored." lightbox="media/users-restore/users-deleted-users-view-restorable.png":::

## Restore a recently deleted user

When a user account is deleted from the organization, the account is in a suspended state. All of the account's organization information is preserved. When you restore a user, this organization information is also restored.

> [!NOTE]
> Once a user is restored, licenses that were assigned to the user at the time of deletion are also restored even if there are none available. If you're consuming more licenses than you purchased, your organization could be temporarily out of compliance for license usage.

### To restore a user

1. On the **Deleted users** page, search for and select one of the available users. For example, *Mary Parker*.

2. Select **Restore user**.

  :::image type="content" source="media/users-restore/users-deleted-users-restore-user.png" alt-text="Screenshot of the Users - Deleted users page, with Restore user option highlighted." lightbox="media/users-restore/users-deleted-users-restore-user.png":::

## Permanently delete a user

You can permanently delete a user from your organization without waiting the 30 days for automatic deletion. A permanently deleted user can't be restored by anyone, including Microsoft customer support.

>[!Note]
>If you permanently delete a user by mistake, you have to create a new user and manually enter all the previous information. For more information about creating a new user, see [Add or delete users](./add-users.md).

### To permanently delete a user

1. On the **Deleted users** page, search for and select one of the available users. For example, *Rae Huff*.

2. Select **Delete permanently**.

  :::image type="content" source="media/users-restore/users-deleted-users-permanent-delete-user.png" alt-text="Screenshot of the Users - Deleted users page, with Delete user option highlighted." lightbox="media/users-restore/users-deleted-users-permanent-delete-user.png":::

## Related content

- [Add or delete users](./add-users.md)
- [Assign roles to users](./how-subscriptions-associated-directory.md)
- [Add or change profile information](./how-to-manage-user-profile-info.md)
