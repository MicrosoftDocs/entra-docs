---
title: View audit report for Azure resource roles in Privileged Identity Management (PIM)
description: View activity and audit history for Azure resource roles in Privileged Identity Management (PIM).
ms.topic: how-to
ms.date: 11/17/2026
ms.reviewer: ilyal
ms.custom: sfi-image-nochange, msecd-doc-authoring-1032
#Customer Intent: As an administrator, I want to view activity and audit history for Azure resource roles to monitor privileged access and maintain compliance.
ms.author: tamimsangrar
ai-usage: ai-assisted
---
# View activity and audit history for Azure resource roles in Privileged Identity Management

## Overview

Privileged Identity Management (PIM) in Microsoft Entra ID enables you to view activity, activations, and audit history for Azure resource roles within your organization. This includes subscriptions, resource groups, and even virtual machines. Any resource within the Microsoft Entra admin center that uses the Azure role-based access control functionality can take advantage of the security and lifecycle management capabilities in Privileged Identity Management. If you want to keep audit data for longer than the default retention period, you can use Azure Monitor to route it to an Azure storage account. For more information, see [Archive Microsoft Entra logs to an Azure storage account](~/identity/monitoring-health/howto-archive-logs-to-storage-account.md).

> [!NOTE]
> If your organization has outsourced management functions to a service provider who uses [Azure Lighthouse](/azure/lighthouse/overview), role assignments authorized by that service provider won't be shown here.

## View activity and activations

To see the actions a specific user took in various resources, view the Azure resource activity associated with their activation period.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to view activity and activations for.

1. Select **Roles** or **Members**.

1. Select a user.

    You see a summary of the user's actions in Azure resources by date. It also shows the recent role activations over that same time period.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-user-details.png" alt-text="Screenshot of user details with resource activity summary and role activations.":::

1. Select a specific role activation to see details and corresponding Azure resource activity that occurred while that user was active.

    :::image type="content" source="media/azure-pim-resource-rbac/export-membership.png" alt-text="Screenshot of role activation selected and activity details.":::

## Export role assignments with children

You might have a compliance requirement where you must provide a complete list of role assignments to auditors. Privileged Identity Management enables you to query role assignments at a specific resource, which includes role assignments for all child resources. Previously, it was difficult for administrators to get a complete list of role assignments for a subscription and they had to export role assignments for each specific resource. Using Privileged Identity Management, you can query for all active and eligible role assignments in a subscription including role assignments for all resource groups and resources.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to export role assignments for, such as a subscription.

1. Select **Assignments**.

1. Select **Export** to open the Export membership pane.

    :::image type="content" source="media/azure-pim-resource-rbac/export-membership.png" alt-text="Screenshot showing the export membership pane to export all members.":::

1. Select **Export all members** to export all role assignments in a CSV file.

    :::image type="content" source="media/azure-pim-resource-rbac/export-csv.png" alt-text="Screenshot showing exported role assignments in CSV file as displayed in Excel.":::

## View resource audit history

Resource audit gives you a view of all role activity for a resource.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Azure resources**. 

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

1. Browse to **ID Governance** > **Privileged Identity Management** > **Azure resources**. 

1. Select the resource you want to view audit history for.

1. Select **My audit**.

1. Filter the history using a predefined date or custom range.

    :::image type="content" source="media/azure-pim-resource-rbac/my-audit-time.png" alt-text="Screenshot showing an audit list for the current user.":::

> [!NOTE]
> Access to audit history requires at least the Privileged Role Administrator role.

## Get reason, approver, and ticket number for approval events


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Monitoring & health** > **Audit logs**.

1. Use the **Service** filter to display only audit events for the Privileged Identity Management service. On the **Audit logs** page, you can:

    - See the reason for an audit event in the **Status reason** column.
    - See the approver in the **Initiated by (actor)** column for the "add member to role request approved" event.

    :::image type="content" source="media/azure-pim-resource-rbac/filter-audit-logs.png" alt-text="Screenshot showing filtering the audit log for the PIM service.":::

1. Select an audit log event to see the ticket number on the **Activity** tab of the **Details** pane.
  
    :::image type="content" source="media/azure-pim-resource-rbac/audit-event-ticket-number.png" alt-text="Screenshot showing the ticket number for the audit event.":::

1. You can view the requester (person activating the role) on the **Targets** tab of the **Details** pane for an audit event. There are three target types for Azure resource roles:

    - The role (**Type** = Role)
    - The requester (**Type** = Other)
    - The approver (**Type** = User)

    :::image type="content" source="media/azure-pim-resource-rbac/audit-event-target-type.png" alt-text="Screenshot showing how to check the target type.":::

Typically, the log event immediately above the approval event is an event for **Add member to role completed** where the **Initiated by (actor)** is the requester. In most cases, you won't need to find the requester in the approval request from an auditing perspective.

<a name="review-session-activity"></a>

<a name="review-session-activity-preview"></a>

## View session activity (preview)

Use Session Analytics to view an identity's PIM role lifecycle and Azure Bastion connection activity for a selected Azure subscription or resource group. The view covers role activation, Bastion access to an Azure Virtual Machine, and role deactivation or expiration. It doesn't show Azure resource operations, such as creating a resource group, or commands run inside a virtual machine.

For graphical recordings, use [Session Recordings](#review-azure-bastion-session-recordings). Recordings have separate setup and viewing requirements.

### Session Analytics prerequisites

Microsoft Entra ID Governance licensing is required for Session Analytics in preview. See [Microsoft Entra ID Governance licensing fundamentals](../licensing-fundamentals.md).

Configure diagnostic settings on each Azure Bastion host you want to monitor to send `BastionAuditLogs` to a Log Analytics workspace. Use a workspace in the same tenant. Only Azure Bastion audit logs need this routing for Session Analytics. You don't need to route additional PIM log sources to the workspace.

Complete [Set up Azure Bastion audit-log collection](#set-up-azure-bastion-audit-log-collection) with the setup roles, then [verify Bastion log collection](#verify-bastion-log-collection). Use the separate roles listed in [View Session Analytics](#view-session-analytics) to view the results.

### Set up Azure Bastion audit-log collection

Configure the destination for each host before viewing its Bastion connection activity. If log collection is already configured, continue to [Verify Bastion log collection](#verify-bastion-log-collection).

For setup with an existing Log Analytics workspace, use these recommended roles:

| Resource | Recommended role | Role assignment scope |
| --- | --- | --- |
| Azure Bastion host | **Monitoring Contributor** | The Azure Bastion resource. |
| Existing Log Analytics workspace | **Monitoring Contributor** | The Log Analytics workspace. |

These are sufficient built-in setup recommendations, not minimum permissions. Custom roles can grant narrower permissions. See [Monitoring Contributor permissions](/azure/azure-monitor/fundamentals/roles-permissions-security#monitoring-contributor) and [Log Analytics workspace permissions](/azure/azure-monitor/logs/manage-access#azure-rbac).

1. Create or reuse a Log Analytics workspace in the same tenant. Follow [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace) for creation steps and permissions.
1. For each Azure Bastion host you want to monitor, follow [Diagnostic settings in Azure Monitor](/azure/azure-monitor/data-collection/diagnostic-settings) to configure a setting, for example, `SendToLogAnalytics`, that sends `BastionAuditLogs` to the workspace. For the log category and `MicrosoftAzureBastionAuditLogs` table, see [Azure Bastion resource logs](/azure/bastion/monitor-bastion-reference#resource-logs).
1. Before viewing Bastion activity in PIM, [verify the host's connection records](#verify-bastion-log-collection) in the destination workspace.

### Verify Bastion log collection

Use the **Log Analytics Reader** role on the destination Log Analytics workspace to check for Bastion connection records before viewing Bastion activity in PIM.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. After a user connects through a monitored Bastion host, check for that connection's records in the workspace's `MicrosoftAzureBastionAuditLogs` table. Use `_ResourceId` to identify the Bastion host, `TargetResourceId` to identify the virtual machine, and `SessionStartTime` to check the connection time. For column details, see [MicrosoftAzureBastionAuditLogs](/azure/azure-monitor/reference/tables/microsoftazurebastionauditlogs).

    If the expected record isn't present, verify the host's [diagnostic settings](#set-up-azure-bastion-audit-log-collection), the destination workspace, and the time range you're checking before viewing Bastion activity in PIM.

After verifying log collection, continue to [View Session Analytics](#view-session-analytics).

### View Session Analytics

To view Session Analytics, you need both of the following:

- At least the **Reports Reader** role in Microsoft Entra ID.
- The **Azure resource and Log Analytics workspace viewing roles**.

If your directory role assignment is eligible, activate it before viewing Session Analytics. See [Microsoft Entra activity-log prerequisites](~/identity/monitoring-health/howto-access-activity-logs.md#prerequisites).

The following Azure resource and workspace viewing roles apply at the listed resource scopes. These are separate from the [setup roles](#set-up-azure-bastion-audit-log-collection).

| Resource | Role | Role assignment scope |
| --- | --- | --- |
| Log Analytics workspace | **Log Analytics Reader** | The Log Analytics workspace. |
| Azure Bastion host | **Reader** | The Azure Bastion resource. |
| Azure Virtual Machine | **Reader** | The Azure Virtual Machine resource. |
| Network interface | **Reader** | The Azure Virtual Machine's network interface. |
| Virtual network | **Reader** | The relevant virtual network, including a peered virtual network where applicable. |

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Open **Privileged Identity Management**, select **Azure resources**, and select the Azure subscription or resource group whose activity you want to view.
1. Under **Activity**, select **Session Analytics (Preview)**.
1. Use **Date range** or search by identity, role, or scope to find the activity you want to view.

    :::image type="content" source="media/azure-pim-resource-rbac/session-analytics-activity.png" alt-text="Screenshot of Session Analytics showing a role activation with its scope, start and end times, and filtering controls." lightbox="media/azure-pim-resource-rbac/session-analytics-activity.png":::

1. View the identity, activated role, scope, scope type, and start and end times. Select **Refresh** to reload the results.

<a name="review-azure-bastion-session-recordings"></a>

<a name="review-azure-bastion-session-recordings-preview"></a>

## View Azure Bastion session recordings (preview)

Use Session Recordings to find recording-enabled Azure Bastion hosts in the selected scope and open their graphical recordings.

### Session Recordings prerequisites

- Microsoft Entra ID Governance licensing is required for the PIM Session Recordings view in preview. See [Microsoft Entra ID Governance licensing fundamentals](../licensing-fundamentals.md).
- Azure Bastion must use the **Premium** SKU with session recording and storage configured. Follow [Record Bastion sessions](/azure/bastion/session-recording) for setup and storage requirements.
- To view or list recordings in Azure Bastion, you need the **Storage Blob Data Reader** role. Follow the [Bastion recording guide](/azure/bastion/session-recording#prerequisites) for the viewing requirements.

### Azure Bastion recording support

A recording-enabled Azure Bastion Premium host records RDP and SSH connections through that host. It records all connections through the host, not just connections initiated from My Access. The following table summarizes supported and unsupported connection combinations for graphical recording:

| Protocol | Authentication | Client | Graphical recording |
| --- | --- | --- | --- |
| **SSH** | Microsoft Entra ID or other supported SSH authentication. | Azure portal (browser). | Supported. |
| **RDP** | Supported authentication other than Microsoft Entra ID. | Azure portal (browser). | Supported. |
| **RDP** | Microsoft Entra ID. | Azure portal (browser). | Not supported concurrently with Microsoft Entra ID RDP. |
| **RDP or SSH** | Any authentication method. | Native client. | Not supported. |

Use this table when selecting a connection method for a recording requirement. For recording setup and considerations, see [Record Bastion sessions](/azure/bastion/session-recording). For Microsoft Entra connection requirements, see [Configure Microsoft Entra ID authentication for Azure Bastion](/azure/bastion/bastion-entra-id-authentication).

<a name="open-session-recordings"></a>

### Session Recordings (Preview)

After recording setup is complete, use the PIM view to locate the host and open its recordings.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Open **Privileged Identity Management** and select **Azure resources**. Use the scope selector to select the **subscription or resource group that contains the Azure Bastion host** whose recordings you want to view.
1. Under **Activity**, select **Session Recordings (Preview)**.

    :::image type="content" source="media/azure-pim-resource-rbac/session-recordings-hosts.png" alt-text="Screenshot of Session Recordings listing Azure Bastion hosts with recording enabled." lightbox="media/azure-pim-resource-rbac/session-recordings-hosts.png":::

1. Select a Bastion host to open its recordings in the Bastion experience.

## Next steps

- [View audit history for Microsoft Entra roles in Privileged Identity Management](pim-how-to-use-audit-log.md)
