---
title: Hide or delete access package in entitlement management
description: Learn how to hide or delete an access package in Microsoft Entra entitlement management.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 07/15/2024
ms.author: owinfrey
#Customer intent: As an administrator, I want detailed information about how I can edit an access package so that requestors have the resources they need to perform their job.
---
# Hide or delete an access package in entitlement management

When you create access packages, they're discoverable by default. This means that if a policy allows a user to request the access package, they'll automatically see the access package listed in their My Access portal. However, you can change the **Hidden** setting so that the access package isn't listed in the user's My Access portal. A user will only see the access packages from a given tenant in their My Access portal. Users can either use the organization/tenant switcher which is located on the top right of the My Access portal or a My Access portal link which includes a tenant hint. For more information, see [Share link to request an access package](entitlement-management-access-package-settings.md).

This article describes how to hide or delete an access package.

## Change the Hidden setting

Follow these steps to change the **Hidden** setting for an access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!TIP]
    > Other least privilege roles that can complete this task include the Catalog owner and Access Package manager.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. On the Access packages page, open an access package.

1. On the Overview page, select **Edit**.

1. Set the **Hidden** setting.

    If set to **No**, the access package is listed in the user's My Access portal.

    If set to **Yes**, the access package won't be listed in the user's My Access portal. The only way a user can view the access package is if they have the direct **My Access portal link** to the access package. For more information, see [Share link to request an access package](entitlement-management-access-package-settings.md).

## Delete an access package

An access package can only be deleted if it has no active user assignments. Follow these steps to delete an access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
     > [!TIP]
     > Other least privilege roles that can complete this task include the Catalog owner and Access Package manager.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. On the Access packages page, open the access package.

1. In the left menu, select **Assignments** and remove access for all users.

1. In the left menu, select **Overview** and then select **Delete**.

1. In the delete message that appears, select **Yes**.

## Next steps

- [View, add, and remove assignments for an access package](entitlement-management-access-package-assignments.md)
- [View reports and logs](entitlement-management-reports.md)
