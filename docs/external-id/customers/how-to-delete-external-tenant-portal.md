---
title: Delete an external tenant
description: Learn how to delete an external tenant in the  Microsoft Entra admin center.
author: csmulligan
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 02/06/2025
ms.author: cmulligan
ms.custom: it-pro, sfi-ga-nochange, sfi-image-nochange
#Customer intent: As an it admin, I want to learn how to delete an external tenant in the  Microsoft Entra admin center. 
---
# Delete an external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can't delete an external tenant until it passes several checks. These checks reduce the risk that deleting an external tenant negatively affects user access. For example, if the tenant associated with a subscription is unintentionally deleted, users can't access the Azure resources for that subscription. 

## Prerequisites

- A Microsoft Entra External ID external tenant that you want to delete.
- There are no users in the external tenant, except one [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) who will delete the tenant. You must delete any other users before you can delete the tenant.
- There are no applications in the tenant. Make sure that you remove all applications including the **b2c-extensions-app**. You must delete all apps listed under **App registrations** in the **All applications** section before proceeding with the deletion. 

## Delete the external tenant

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **Overview** > **Manage tenants**.
1. Select the tenant you want to delete, and then select **Delete**.

    :::image type="content" source="media/how-to-create-external-tenant-portal/delete-tenant.png" alt-text="Screenshot that shows how to delete the tenant.":::

1. You might need to complete required actions before you can delete the tenant. For example, you might need to delete all user flows in the tenant. If you're ready to delete the tenant, select **Delete**.

The tenant and its associated information are deleted.


