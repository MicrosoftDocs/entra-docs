---
title: View update and sign-in activities for Managed identities
description: Step-by-step instructions for viewing the activities made to managed identities, and authentications carried out by managed identities
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 06/05/2024
ms.author: shermanouko
ms.custom: sfi-image-nochange
---

# View update and sign-in activities for Managed identities

This article explains how to view updates carried out to managed identities, and sign-in attempts made by managed identities.

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/).

## View updates made to user-assigned managed identities

This procedure demonstrates how to view updates carried out to user-assigned managed identities.

1. In the Azure portal, browse to **Activity Log**.

    :::image type="content" source="./media/how-to-view-managed-identity-activity/browse-to-activity-log.png" alt-text="Screenshot showing how to browse to the activity log in the Azure portal":::

1. Select the **Add Filter** search pill and select **Operation** from the list.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/start-adding-search-filter.png" alt-text="Screenshot showing how to start building the search filter":::

1. In the **Operation** dropdown list, enter these operation names: "Delete User Assigned Identity" and "Write UserAssignedIdentities".

   :::image type="content" source="./media/how-to-view-managed-identity-activity/add-operations-to-search-filter.png" alt-text="Screenshot showing how to add operations to the search filter":::

1. When matching operations are displayed, select one to view the summary.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/view-summary-of-operation.png" alt-text="Screenshot showing the summary of the operation":::

1. Select the **JSON** tab to view more detailed information about the operation, and scroll to the **properties** node to view information about the identity that was modified.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/view-json-of-operation.png" alt-text="Screenshot showing operation details":::

## View role assignments added and removed for managed identities

 > [!NOTE] 
 > You'll need to search by the object (principal) ID of the managed identity that you want to view role assignment changes for.

1. Locate the managed identity you wish to view the role assignment changes for. If you're looking for a system-assigned managed identity, the object ID is displayed in the **Identity** screen under the resource. If you're looking for a user-assigned identity, the object ID is displayed in the **Overview** page of the managed identity.

User-assigned identity:

:::image type="content" source="./media/how-to-view-managed-identity-activity/get-object-id-of-user-assigned-identity.png" alt-text="Screenshot showing how to get the object ID of user-assigned identity":::

System-assigned identity:

:::image type="content" source="./media/how-to-view-managed-identity-activity/get-object-id-of-system-assigned-identity.png" alt-text="Screenshot showing how to get the object ID of system-assigned identity":::

1. Copy the object ID.
1. Browse to the **Activity log**.

    :::image type="content" source="./media/how-to-view-managed-identity-activity/browse-to-activity-log.png" alt-text="Screenshot showing how to browse to the activity log in the Azure portal":::

1. Select the **Add Filter** search pill and select **Operation** from the list.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/start-adding-search-filter.png" alt-text="Screenshot showing how to start building the search filter":::

1. In the **Operation** dropdown list, enter these operation names: **Create role assignment** and **Delete role assignment**.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/add-role-assignment-operations-to-search-filter.png" alt-text="Screenshot showing how to add role assignment operations to the search filter":::

1. Paste the object ID in the search box; the results are filtered automatically.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/search-by-object-id.png" alt-text="Screenshot showing how to search by object ID":::
 
1. When matching operations are displayed, select one to view the summary.
 
   :::image type="content" source="./media/how-to-view-managed-identity-activity/summary-of-role-assignment-for-msi.png" alt-text="Screenshot showing the summary of role assignment for managed identity":::

## View authentication attempts by managed identities

1. Browse to **Microsoft Entra ID**.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/browse-to-entra.png" alt-text="Screenshot showing how to browse to active directory":::

1. Select **Sign-in logs** from the **Monitoring** section.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/sign-in-logs-menu-item.png" alt-text="Screenshot showing sign-in logs selection":::

1. Select the **Managed identity sign-ins** tab.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/sign-in-logs.png" alt-text="Screenshot of the managed identities activity section showing all columns "::: 

1. To view the identity's Enterprise application in Microsoft Entra ID, select the "Managed Identity ID" column.
1. To view the Azure resource or user-assigned managed identity, search by name in the search bar of the Azure portal.

   :::image type="content" source="./media/how-to-view-managed-identity-activity/msi-sign-in-events.png" alt-text="Screenshot showing managed identity sign-in events"::: 

 > [!NOTE] 
 > Since managed identity authentication requests originate within the Azure infrastructure, the IP Address value is excluded here.

## Next steps

* [Managed identities for Azure resources](./overview.md)
* [Azure Activity log](/azure/azure-monitor/essentials/activity-log)
* [Microsoft Entra sign-in log](~/identity/monitoring-health/concept-sign-ins.md)
