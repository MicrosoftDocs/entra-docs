---
title: Quickstart - Create a group with members and view all groups and members
description: Instructions about how to search for and view your organization's groups and their assigned members.
author: barclayn
manager: amycolannino
ms.service: entra
ms.subservice: fundamentals
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: quickstart
ms.date: 03/23/2024
ms.author: barclayn
ms.reviewer: krbain
---

# Quickstart: Create a group with members and view all groups and members

In this quickstart, you'll set up a new group and assign members to the group. Then you'll view your organization's group and assigned members. Throughout this guide, you'll create a user and group that you can use in other quickstarts and tutorials.

You can view your organization's existing groups and group members using the Microsoft Entra admin center. Groups are used to manage users that all need the same access and permissions for potentially restricted apps and services.

## Prerequisites

Before you begin, you'll need to:

- Have an Azure subscription. If you don't have one, create a [free account](https://azure.microsoft.com/free/).
- Create a Microsoft Entra tenant. For more information, see [Access the portal and create a new tenant](./create-new-tenant.md).

## Create a new group

Create a new group, named *MDM policy - West*. For more information about creating a group, see [How to create a basic group and add members](./how-to-manage-groups.yml).

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Groups** > **All groups**.

   :::image type="content" source="media/groups-view-azure-portal/create-new-group.png" alt-text="Screenshot of the All Groups page." lightbox="media/groups-view-azure-portal/create-new-group.png":::

1. Select **New group**.
1. Complete the options in the **Group** page:
   - **Group name:** Type *MDM policy - West*
   - **Membership type:** Select *Assigned*.

   :::image type="content" source="media/groups-view-azure-portal/new-group-page.png" alt-text="Screenshot of the New group page.":::

1. Select **Create**.

## Create a new user

A user must exist before being added as a group member, so you'll need to create a new user. For this quickstart, we've added a user named *Alain Charon*. Check the "Custom domain names" tab first to get the verified domain name in which to create users. For more information about creating a user, see [How to add or delete users](./add-users.md).

1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**.

   :::image type="content" source="media/groups-view-azure-portal/create-new-user-menu.png" alt-text="Screenshot of the New user page.":::

1. Complete the **User** page:

   - **User principal name:** Type *alain\@contoso.com*.
   - **Display name:** Type *Alain Charon*.

1. Copy the auto-generated password provided in the **Password** box and select **Create**.

## Add a group member

Now that you have a group and a user, you can add *Alain Charon* as a member to the *MDM policy - West* group. For more information about adding group members, see the [Manage groups](how-to-manage-groups.yml) article.

1. Browse to **Identity** > **Groups** > **All groups**.
1. Select the **MDM policy - West** group created earlier.
1. From the **MDM policy - West Overview** page, select **Members**.
1. Select **Add members**, and then search and select **Alain Charon**.
1. Choose **Select**.

## View all groups

You can see all the groups for your organization in the **Groups - All groups** page.

- Browse to **Identity** > **Groups** > **All groups**.

    The **All groups** page appears, showing all your active groups.

    :::image type="content" source="media/groups-view-azure-portal/groups-search.png" alt-text="Screenshot of the 'Groups-All groups' page, showing all existing groups.":::

## Search for a group

Search the **All groups** page to find the **MDM policy – West** group.

1. Browse to **Identity** > **Groups** > **All groups**.
1. From the **All groups** page, type *MDM* into the **Search** box.

    The search results appear under the **Search** box, including the *MDM policy - West* group.

   :::image type="content" source="media/groups-view-azure-portal/groups-search-group-name.png" alt-text="Screenshot of the 'Groups' search page showing matching search results.":::

1. Select the group **MDM policy – West**.
1. View the group info on the **MDM policy - West Overview** page, including the number of members of that group.

   :::image type="content" source="media/groups-view-azure-portal/groups-overview.png" alt-text="Screenshot of MDM policy – West Overview page with member info.":::

## View group members

Now that you've found the group, you can view all the assigned members.

Select **Members** from the **Manage** area, and then review the complete list of member names assigned to that specific group, including *Alain Charon*.

:::image type="content" source="media/groups-view-azure-portal/groups-all-members.png" alt-text="Screenshot of the list of members assigned to the MDM policy – West group.":::

## Clean up resources

The group you just created is used in other articles in this documentation. If you'd rather not use this group, you can delete it and its assigned members using the following steps:

1. Browse to **Identity** > **Groups** > **All groups**.
1. On the **All groups** page, search for the **MDM policy - West** group.
1. Select the **MDM policy - West** group.

   The **MDM policy - West Overview** page appears.

1. Select **Delete**.

   The group and its associated members are deleted.

   :::image type="content" source="media/groups-view-azure-portal/groups-delete.png" alt-text="Screenshot of the MDM policy – West Overview page with Delete link highlighted.":::

   > [!IMPORTANT]
   > This doesn't delete the user Alain Charon, just his membership in the deleted group.
   >
   > To delete your test user: Browse to **Identity** > **Users** > **All users** select your test user and choose **Delete**.

## Next steps

Advance to the next article to learn how to associate a subscription to your directory.

> [!div class="nextstepaction"]
> [Associate an Azure subscription](./how-subscriptions-associated-directory.yml)
