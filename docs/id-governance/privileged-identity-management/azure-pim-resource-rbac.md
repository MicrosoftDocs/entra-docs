---
title: View audit report for Azure resource roles in Privileged Identity Management (PIM)
description: View activity and audit history for Azure resource roles in Privileged Identity Management (PIM).

author: barclayn
manager: amycolannino

ms.service: entra-id-governance
ms.subservice: privileged-identity-management
ms.topic: how-to
ms.date: 09/12/2023
ms.author: barclayn
ms.reviewer: shaunliu

---
# View activity and audit history for Azure resource roles in Privileged Identity Management

Privileged Identity Management (PIM) in Microsoft Entra ID, enables you to view activity, activations, and audit history for Azure resources roles within your organization. This includes subscriptions, resource groups, and even virtual machines. Any resource within the Microsoft Entra admin center that leverages the Azure role-based access control functionality can take advantage of the security and lifecycle management capabilities in Privileged Identity Management. If you want to retain audit data for longer than the default retention period, you can use Azure Monitor to route it to an Azure storage account. For more information, see [Archive Microsoft Entra logs to an Azure storage account](~/identity/monitoring-health/howto-archive-logs-to-storage-account.md).

> [!NOTE]
> If your organization has outsourced management functions to a service provider who uses [Azure Lighthouse](/azure/lighthouse/overview), role assignments authorized by that service provider won't be shown here.

## View activity and activations

To see what actions a specific user took in various resources, you can view the Azure resource activity that's associated with a given activation period.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to view activity and activations for.

1. Select **Roles** or **Members**.

1. Select a user.

    You see a summary of the user's actions in Azure resources by date. It also shows the recent role activations over that same time period.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-user-details.png" alt-text="Screenshot of user details with resource activity summary and role activations.":::

1. Select a specific role activation to see details and corresponding Azure resource activity that occurred while that user was active.

    :::image type="content" source="media/azure-pim-resource-rbac/export-membership.png" alt-text="Screenshot of role activation selected and activity details.":::

## Export role assignments with children

You may have a compliance requirement where you must provide a complete list of role assignments to auditors. Privileged Identity Management enables you to query role assignments at a specific resource, which includes role assignments for all child resources. Previously, it was difficult for administrators to get a complete list of role assignments for a subscription and they had to export role assignments for each specific resource. Using Privileged Identity Management, you can query for all active and eligible role assignments in a subscription including role assignments for all resource groups and resources.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to export role assignments for, such as a subscription.

1. Select **Assignments**.

1. Select **Export** to open the Export membership pane.

    :::image type="content" source="media/azure-pim-resource-rbac/export-membership.png" alt-text="Screenshot showing the export membership pane to export all members.":::

1. Select **Export all members** to export all role assignments in a CSV file.

    :::image type="content" source="media/azure-pim-resource-rbac/export-csv.png" alt-text="Screenshot showing exported role assignments in CSV file as displayed in Excel.":::

## View resource audit history

Resource audit gives you a view of all role activity for a resource.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to view audit history for.

1. Select **Resource audit**.

1. Filter the history using a predefined date or custom range.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-resource-audit.png" alt-text="Screenshot showing resource audit list with filters.":::

1. For **Audit type**, select **Activate (Assigned + Activated)**.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-audit-activity.png" alt-text="Screenshot showing the resource audit list filtered by Activate audit type.":::

1. Under **Action**, select **(activity)** for a user to see that user's activity detail in Azure resources.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-audit-activity-details.png" alt-text="Screenshot showing user activity details for a particular action.":::

## View my audit

My audit enables you to view your personal role activity.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to view audit history for.

1. Select **My audit**.

1. Filter the history using a predefined date or custom range.

    :::image type="content" source="media/azure-pim-resource-rbac/my-audit-time.png" alt-text="Screenshot showing an audit list for the current user.":::

> [!NOTE]
> Access to audit history requires at least the Privileged Role Administrator role.

## Get reason, approver, and ticket number for approval events

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity** > **Monitoring & health** > **Audit logs**.

1. Use the **Service** filter to display only audit events for the Privileged identity Management service. On the **Audit logs** page, you can:

    - See the reason for an audit event in the **Status reason** column.
    - See the approver in the **Initiated by (actor)** column for the "add member to role request approved" event.

    :::image type="content" source="media/azure-pim-resource-rbac/filter-audit-logs.png" alt-text="Screenshot showing filtering the audit log for the PIM service.":::

1. Select an audit log event to see the ticket number on the **Activity** tab of the **Details** pane.
  
    :::image type="content" source="media/azure-pim-resource-rbac/audit-event-ticket-number.png " alt-text="Screenshot showing the ticket number for the audit event.":::

1. You can view the requester (person activating the role) on the **Targets** tab of the **Details** pane for an audit event. There are three target types for Azure resource roles:

    - The role (**Type** = Role)
    - The requester (**Type** = Other)
    - The approver (**Type** = User)

    :::image type="content" source="media/azure-pim-resource-rbac/audit-event-target-type.png" alt-text="Screenshot showing how to check the target type.":::

Typically, the log event immediately above the approval event is an event for "Add member to role completed" where the **Initiated by (actor)** is the requester. In most cases, you won't need to find the requester in the approval request from an auditing perspective.

## Next steps

- [View audit history for Microsoft Entra roles in Privileged Identity Management](pim-how-to-use-audit-log.md)
