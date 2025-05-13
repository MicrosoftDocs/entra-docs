---
title: Add or remove a user in Microsoft Entra Permissions Management through the Microsoft Entra admin center
description: How to add or remove a user in Microsoft Entra Permissions Management through the Microsoft Enter admin center.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 05/02/2025
ms.author: jfields
---

# Add or remove a user in Microsoft Entra Permissions Management

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how you can add or remove a new user for a group in Permissions Management. 

> [!NOTE] 
> Permissions Management entitlements work through group-based access. To add a new user, you must add a user to a group through Microsoft Entra ID.

## Add a user

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#home) as at least a [Billing Administrator](https://go.microsoft.com/fwlink/?linkid=2254515).
1. Browse to **Entra ID**, then select **Go to Microsoft Entra ID**. 
1. From the navigation pane, go to **Entra ID** > **Groups** > **All groups**.
1. Select the group name for the group you want to add the user to.
1. From the group's **Manage** menu, click **Members**.
1. Click **+ Add members**, then search for the user you want to add from the list.
    > [!NOTE]
    > In order to add a user to a group, you must be the group owner. If you're not the owner of the selected group, please reach out to the group owner. If you don't know who the owner of the group is, select **Owners** under the group's **Manage** menu.
1. Click **Select**. Your user has been added. 
1. Click the **Refresh** button to refresh your screen and view the user you've added.

## Remove a user

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#home) as at least a [Billing Administrator](https://go.microsoft.com/fwlink/?linkid=2254515).
1. Browse to **Entra ID**, then select **Go to Microsoft Entra ID**. 
1. From the navigation pane, go to **Entra ID** > **Groups** > **All groups**.
1. Select the group name for the group you want to remove the user from.
1. From the groups **Manage** menu, click **Members**.
1. Search for the user you want to remove from the list, then check the box next to their name.
    > [!NOTE]
    > In order to remove a user from a group, you must be the group owner. If you're not the owner of the selected group, please reach out to the group owner. If you don't know who the owner of the group is, select **Owners** under the group's **Manage** menu.
1. Click **X Remove**, then click **Yes**. The user is removed from the group.

## Next steps

- For more information on managing users and groups, see [Manage users and groups with the User management dashboard](ui-user-management.md).
