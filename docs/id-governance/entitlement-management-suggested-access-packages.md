---
title: Show suggested access packages for My Access in entitlement management (preview)
description: Learn how to show suggested access packages to users in My Access so they can quickly find the most relevant access packages.
author: owinfreyatl
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 1/09/2025
ms.author: owinfrey
ms.reviewer: myra-ramdenbourg
#Customer intent: As an administrator, I want to allow my users to see the access packages that are most relevant to them.
---

# Suggested access packages in My Access (Preview)

In My Access, Microsoft Entra ID Governance users can see a curated list of suggested access packages in My Access. This capability allows users to quickly view the most relevant access packages for them based off their peers' access packages and previous requests without scrolling through all their available access packages.

The suggested access packages list is created by finding people related to the user (manager, direct reports, organization, team members) and recommending access packages based on what the users’ peers have. The user is also suggested access packages that they previously owned.

## Enable users to see their suggested access packages in My Access

Follow these steps to enable suggested access packages in My Access.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Identity governance** > **Entitlement management** > **Settings**.

1. Select **Edit**.

1. On the edit page under Opt-in Preview Features, select **Show suggested access packages in My Access**. 
    :::image type="content" source="media/entitlement-management-suggested-access-packages/opt-in-features-selection.png" alt-text="Screenshot of the opt in to suggested access package feature." lightbox="media/entitlement-management-suggested-access-packages/opt-in-features-selection.png":::
1. Select **Save**.

1. Sign in to the My Access portal at https://myaccess.microsoft.com. Select **Access packages** to see your suggested access packages.  
     :::image type="content" source="media/entitlement-management-suggested-access-packages/suggested-access-packages.png" alt-text="Screenshot of suggested access packages.":::

## Next steps

- [Create and manage a catalog of resources](entitlement-management-catalog-create.md)
- [Delegate access governance to access package managers](entitlement-management-delegate-managers.md)
- [Delegate access governance to resource owners](entitlement-management-delegate.md)