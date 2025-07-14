---
title: Group naming policy quickstart
description: Explains how to add new users or delete existing users in Microsoft Entra ID

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: quickstart
ms.date: 12/16/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, mode-other
ms.collection: M365-identity-device-management
#Customer intent: As a Microsoft Entra identity administrator, I want to enforce naming policy on self-service groups, to help me sort and search in my Microsoft Entra organization’s user-created groups.
---

# Quickstart: Naming policy for groups in Microsoft Entra ID

In this quickstart, in Microsoft Entra ID, part of Microsoft Entra, you set up naming policy in your Microsoft Entra organization for user-created Microsoft 365 groups, to help you sort and search your groups. For example, you could use the naming policy to:

* Communicate the function of a group, membership, geographic region, or who created the group.
* Help categorize groups in the address book.
* Block specific words from being used in group names and aliases.

If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Configure the group naming policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select Microsoft Entra ID.
1. Select **Groups** > **All groups**  then select **Naming policy** to open the Naming policy page.

    :::image type="content" source="./media/groups-quickstart-naming-policy/policy.png" alt-text="Screenshot of the Naming policy page in the admin center.":::

### View or edit the Prefix-suffix naming policy

1. On the **Naming policy** page, select **Group naming policy**.
1. You can view or edit the current prefix or suffix naming policies individually by selecting the attributes or strings you want to enforce as part of the naming policy.
1. To remove a prefix or suffix from the list, select the prefix or suffix, then select **Delete**. Multiple items can be deleted at the same time.
1. Select **Save** for your changes to the policy to go into effect.

### View or edit the custom blocked words

1. On the **Naming policy** page, select **Blocked words**.

   :::image type="content" source="./media/groups-quickstart-naming-policy/blockedwords.png" alt-text="Screenshot of editing and uploading blocked words list for naming policy.":::

1. View or edit the current list of custom blocked words by selecting **Download**.
1. Upload the new list of custom blocked words by selecting the file icon.
1. Select **Save** for your changes to the policy to go into effect.

That's it. You finished setting up your naming policy and added your custom blocked words.

## Clean up resources

### Remove the naming policy

1. On the **Naming policy** page, select **Delete policy**.
1. After you confirm the deletion, the naming policy is removed, including all prefix-suffix naming policy and any custom blocked words.

## Next steps

Advance to the next article for more information including the PowerShell cmdlets for naming policy, technical constraints, adding a list of custom blocked words, and the end user experiences across Microsoft 365 apps.
> [!div class="nextstepaction"]
> [Naming policy PowerShell](groups-naming-policy.md)
