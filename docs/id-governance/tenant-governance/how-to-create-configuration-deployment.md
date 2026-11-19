---
title: Create a configuration deployment (Preview)
description: Learn how to deploy baseline configuration to home and governed tenants and handle partial or failed deployments in Microsoft Entra Tenant Governance.
ms.topic: how-to
ms.date: 11/12/2026
ai-usage: ai-assisted
# Customer intent: As a tenant administrator, I want to deploy an approved baseline so that I can standardize settings in a target tenant.
---

# Create a configuration deployment (Preview)

Use Configuration deployments to apply baseline-defined configuration to the home tenant or governed tenants. You can create a deployment from baseline JSON, a snapshot, or a configuration baseline template.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- The tenant has licenses for **Tenant Governance Basic** or **Tenant Governance Premium**. See [Microsoft Entra Tenant Governance licensing](licensing.md).
- A reviewed baseline containing only [resources supported for configuration deployments](configuration-deployments.md#supported-resources) and the settings you want to apply. Currently, only the listed 15 Microsoft Entra and 8 Exchange resource types are supported.
- Delegated write permissions granted to the Tenant Configuration Management service and administrator roles for the selected workload resources. Deployments run on behalf of the signed-in administrator. Application permissions, service principal role assignments, or monitoring read permissions alone aren't sufficient.
- For another tenant, an active [governance relationship](governance-relationships.md), required delegated permissions, and workload access in the target tenant.

Review [Tenant Governance licensing](licensing.md) and [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md) before starting.

## Start a deployment

To start creating a deployment, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Tenant Governance**. Under **Tenant management**, select **Configuration deployments** for the home tenant. Under **Other tenants**, select **Configuration deployments** for a governed tenant.
1. Select **Deploy configuration**.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-deployments.png" alt-text="Screenshot of the deployment list with the Deploy configuration command and target tenants." lightbox="../media/tenant-governance-configuration-management/configuration-deployments.png":::

## Complete the deployment wizard

Configure the baseline and target tenant:

1. For a governed-tenant deployment, select the target tenant on **Tenants**. This step isn't shown for home-tenant deployments, which use your current tenant.
1. On **Settings**, enter the deployment name and an optional description.
1. On **Configuration baseline**, upload baseline JSON, import a snapshot, or select a configuration baseline template.
1. Review tenant-specific resource references, dependencies, and the settings that the deployment will change.
1. On **Permissions**, review delegated write permission readiness for the selected workload and tenant. Application permissions and roles assigned to the service principal don't satisfy this check. Separately verify the signed-in administrator's workload roles, which aren't evaluated on this step.
1. On **Ongoing monitoring**, choose whether to monitor for configuration drift after provisioning. Select **Yes** to create a separate monitor from the same configuration, or **No** to deploy without creating a monitor.
1. On **Review**, confirm the target tenant, baseline, and ongoing monitoring choice, and select **Deploy configuration**.

Repeat the process for additional governed tenants, reviewing tenant-specific values and permissions for each target.

> [!IMPORTANT]
> A deployment changes resource settings in the selected tenant. Review the baseline and impact before confirming, particularly when deploying settings captured from a different tenant.

## Track deployment status

Open the deployment details and refresh to track progress. The deployment list shows **Running** or **Completed** for the deployment lifecycle. **Completed** doesn't establish that every resource was deployed successfully. Open **Deployment results** to review execution outcomes and **Resource deployment failures** to investigate failed resources.

| Status | What to do |
| --- | --- |
| **In progress** | Track progress until the deployment completes. |
| **Successful** | Validate the resulting configuration with a monitor. |
| **Partially successful** | Identify successful changes and review errors for failed resources. |
| **Failed** | Review error details and actual resource state before another attempt. |

A failed or partially successful deployment doesn't prove that no changes were applied. Don't assume successful changes were rolled back.

The details view shows the baseline version, target tenant, and deployment outcome.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-deployment-details.png" alt-text="Screenshot of deployment details showing the target tenant, baseline version, and execution status." lightbox="../media/tenant-governance-configuration-management/configuration-deployment-details.png":::

## Handle failed or partially successful deployments

To address deployment errors, follow these steps:

1. Open the deployment details and identify failed resources and their errors.
1. Review which resources succeeded and confirm their current state in the target tenant.
1. Resolve the reported permission, dependency, or baseline issues. For another tenant, also verify the governance relationship and delegated access.
1. Review the baseline against the current tenant state before attempting changes again.
1. For a completed home-tenant deployment, use **Redeploy** to apply its stored configuration again. For a governed-tenant deployment, use the configuration update flow or create a new deployment; a standalone **Redeploy** action isn't available.
1. Review the new outcome, then use a monitor to verify baseline alignment.

An accepted configuration update isn't proof that another deployment execution completed. Refresh the deployment and check **Deployment results** before submitting the same change again.

## Verify the deployed configuration

Create or update a [configuration monitor](how-to-create-monitor.md) for the deployment baseline and target tenant. Review a completed monitor run and any remaining drift.

If you selected **Yes** on **Ongoing monitoring**, verify that the separate monitor was created. A warning that ongoing monitoring couldn't be created doesn't undo the deployment. Resolve the monitor error and create a monitor separately if needed.

## Related content

- [Configuration deployments](configuration-deployments.md).
- [Use configuration baseline templates](how-to-use-configuration-baseline-templates.md).
- [Create configuration snapshots](how-to-create-snapshots.md).
- [View monitor results and manage monitors](how-to-see-monitor-results.md).
