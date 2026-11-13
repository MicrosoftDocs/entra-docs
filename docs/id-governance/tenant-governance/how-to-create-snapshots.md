---
title: Create configuration snapshots
titleSuffix: Microsoft Entra ID Governance
description: Learn how to capture tenant configuration in Microsoft Entra Tenant Governance and use snapshots for baseline templates, deployments, and monitors.
ms.topic: how-to
ms.date: 11/10/2026
ai-usage: ai-assisted
---

<!-- source: Tenant Governance - Create configuration snapshots how-to.docx -->

# Create configuration snapshots

Configuration snapshots capture the current state of selected tenant configuration resources. Create a snapshot when you want to establish a configuration baseline for monitoring configuration drift of a tenant in a known-good configuration, or to collect configuration data for audit evidence.

Use a snapshot as the starting point for a configuration baseline template, deployment, or monitor: **snapshot > template or baseline > deployment or monitor**. A snapshot captures actual settings, not necessarily approved settings. Review and edit the captured baseline before reusing it.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- The tenant has licenses for **Tenant Governance Basic** or **Tenant Governance Premium**. For current licensing requirements, see [Microsoft Entra Tenant Governance licensing](licensing.md).
- Tenant Governance Basic includes a quota for the number of resources that you can snapshot. A tenant gets additional quota for snapshotted resources for each Tenant Governance Premium license it has. If your tenant exceeds its monthly quota, you can't create new snapshots.
- You have read permissions for every resource type included in the snapshot.
- The Tenant Configuration Management service has service authorization for every workload and resource type included in the snapshot. To assign or remove permissions for the service, see [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md).

## Create a snapshot

To create a configuration snapshot, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Tenant Governance** > **Snapshots**.
1. Select **New snapshot**.
1. On the service and resource selection step, select the resource types to include in the snapshot.
1. On **Settings**, enter a display name of 8 to 32 characters using only letters, numbers, and spaces, and an optional description.
1. On **Permissions**, review whether the service has permission to:

    - Read the required Microsoft Graph resources, to snapshot Microsoft Entra or Intune resources.
    - Authenticate to Exchange, to snapshot Exchange, Defender, or Purview resources.
    - Use the **Teams Reader** role, to snapshot Teams resources.

    > [!NOTE]
    > This step doesn't evaluate whether the user is authorized to create a snapshot with the selected resources. It also doesn't show or validate whether the permissions assigned to the configuration management service locally within Exchange Online, Defender, or Purview are sufficient to create a snapshot with resources in those services.

1. On **Review and create**, review the summary and create the snapshot.

## Check snapshot status

Snapshot creation is asynchronous. A snapshot progresses from **Not started** to **In progress**. Select **Refresh** in the command bar to check progress until the snapshot succeeds, fails, or is partially successful. The time it takes to complete a snapshot is roughly proportional to the number of resources being snapshotted.

The snapshot list shows creation and expiration times alongside each snapshot's status.

:::image type="content" source="../media/tenant-governance-configuration-management/snapshots.png" alt-text="Screenshot of snapshots with the New snapshot command, status, creation time, and expiration time." lightbox="../media/tenant-governance-configuration-management/snapshots.png":::

## View snapshot details

To view the details of a completed snapshot, follow these steps:

1. Open a completed snapshot from the snapshots list.
1. On the **Overview** tab, review the name, description, creation time, completion time, expiration time, status, and included resource counts. Errors, if any, appear on this page. You can expand an error to see details.
1. On the **Configuration baseline** tab, view or download the generated configuration baseline JSON.

> [!IMPORTANT]
> Snapshot jobs and their generated snapshots are retained for 7 days. Download and store the baseline JSON before expiration if you need to reuse it.

## Use a snapshot as a baseline template (Preview)

To turn captured settings into a reusable standard, follow these steps:

1. Open a completed snapshot and review its status and errors. If it's partially successful, identify any missing resources before using it as a baseline.
1. On **Configuration baseline**, download the generated JSON.
1. Review the resource settings and update them to reflect your approved configuration.
1. [Create a configuration baseline template](how-to-use-configuration-baseline-templates.md#create-a-template) by uploading the reviewed JSON or importing the snapshot.

Store approved baseline versions separately from the snapshot so that snapshot expiration doesn't remove your source configuration.

## Create a monitor from a snapshot

To create a configuration monitor from a completed snapshot, follow these steps:

1. Open a completed snapshot.
1. Select **Create as monitor**.
1. The monitor creation wizard opens with the snapshot baseline imported. Snapshot-only fields, such as `@odata` metadata and object ID, are removed from the baseline. Continue with the remaining steps in the monitor creation experience, such as setting a name for the monitor and reviewing permissions, as described in [Create a configuration monitor](how-to-create-monitor.md).

## Create a deployment from a snapshot baseline (Preview)

To apply captured configuration to a target tenant, follow these steps:

1. Open a completed snapshot and review or download its baseline JSON.
1. Start a [configuration deployment](how-to-create-configuration-deployment.md).
1. Select the home tenant or another tenant connected through a governance relationship.
1. Import the snapshot, upload the reviewed JSON, or use a template created from it.
1. Review tenant-specific resource references, proposed settings, and permission readiness before creating the deployment.

Creating a snapshot doesn't change the target tenant. A deployment applies the baseline settings and requires the corresponding write permissions.

## Related content

- [Configuration management](configuration-management.md)
- [configurationSnapshotJob](/graph/api/resources/configurationsnapshotjob?view=graph-rest-1.0&preserve-view=true)
- [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md)
- [Create a configuration monitor](how-to-create-monitor.md)
- [Use configuration baseline templates](how-to-use-configuration-baseline-templates.md).
- [Create a configuration deployment](how-to-create-configuration-deployment.md).
