---
title: Show suggested access packages for MyAccess in entitlement management (preview)
description: Learn how to show suggested access packages to users in MyAccess so they can quickly find the most relevant access packages
author: owinfreyatl
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 12/23/2024
ms.author: owinfrey
ms.reviewer: myra-ramdenbourg
#Customer intent: As an administrator, I want to allow my users to see the access packages that are most relevant to them.
---

# Suggested access packages in MyAccess (Preview)

In MyAccess, Microsoft Entra ID Governance users can see a curated list of suggested access packages in MyAccess. This capability allows users to quickly view the most relevant access packages for them based off their peers' access packages and previous requests without scrolling through all their available access packages.

The suggested access packages list is created by finding people related to the user (manager, direct reports, organization, team members) and recommending access packages based on what the users’ peers have. The user is also suggested access packages that they previously owned.

## Enable users to see their suggested access packages in MyAccess

Follow these steps to enable suggested access packages in MyAccess.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Identity governance** > **Entitlement management** > **Settings**.

1. Select **Edit**.
    :::image type="content" source="media/entitlement-management-suggested-access-packages/edit-identity-governance-settings.png" alt-text="Screenshot of edit identity governance settings.":::
1. On the edit page under Opt-in Preview Features, select **Show suggested access packages in My Access**. 
    :::image type="content" source="media/entitlement-management-suggested-access-packages/opt-in-features-selection.png" alt-text="Screenshot of the opt in to suggested access package feature.":::
1. On the feature pane, check the "**I understand the implications of this setting**" box.
    :::image type="content" source="media/entitlement-management-suggested-access-packages/suggested-access-package-settings.png" alt-text="Screenshot of the suggested access package setting option.":::
1. Select **Save**.

## Next steps

- [Create and manage a catalog of resources](entitlement-management-catalog-create.md)
- [Delegate access governance to access package managers](entitlement-management-delegate-managers.md)
- [Delegate access governance to resource owners](entitlement-management-delegate.md)