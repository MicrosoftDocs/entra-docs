---
title: Update or delete a monitor
titleSuffix: Microsoft Entra ID Governance
description: Learn how to update or delete home-tenant and governed-tenant monitors, including the impact on results and drift records.
ms.topic: how-to
ms.date: 11/12/2026
ai-usage: ai-assisted
---

# Update or delete a monitor

This article describes how to update or delete a configuration monitor in the [Microsoft Entra admin center](https://entra.microsoft.com). You might update a monitor when your configuration baseline changes. Delete a monitor when the monitored resources are no longer important for your organization's security or compliance requirements.

These actions apply to monitors targeting the home tenant or other tenants connected through governance relationships. Check the monitor's target tenant before updating or deleting it.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- The tenant has licenses for **Tenant Governance Basic** or **Tenant Governance Premium**. Basic includes monitors targeting the home tenant and governed tenants. See [Microsoft Entra Tenant Governance licensing](licensing.md).
- At least one configuration monitor must exist in your tenant.
- For a monitor targeting another tenant, verify the governance relationship and required delegated permissions. Workload permissions must remain valid for subsequent runs.

## Update a monitor

To update an existing configuration monitor:

1. Browse to **Tenant Governance**. Under **Tenant management**, select **Monitors** for the home tenant. Under **Other tenants**, select **Monitors (Preview)** for a governed tenant.
1. Open the monitor and confirm the target tenant.
1. Use **Settings** to update its name or description, or **Baseline** to update its configuration.

Review the monitor settings, target tenant, baseline, and permission readiness in the update wizard. You can update the baseline by using JSON, a snapshot, or a configuration baseline template, as available in the wizard. For details about baseline selection and tenant scope, see [Create a configuration monitor](how-to-create-monitor.md).

Changing the tenant filter in the monitor list doesn't retarget an existing monitor. The governed tenant is read-only when you edit a monitor. Create a new monitor to target a different tenant.

When you update an existing configuration monitor, the updated settings replace the existing monitor definition.

> [!IMPORTANT]
> A baseline update hides previous monitor results and drift records. A name or description update is a metadata-only change; it doesn't replace the baseline. Preserve required evidence before changing the baseline.

These update types also apply to monitors targeting governed tenants. New results and drifts are produced on later runs. Updating a monitor changes its definition, not the configuration of the resources it monitors. Use a deployment to change resource settings.

For a template-linked monitor, the baseline is read-only. Edit the source template and use **Apply latest**, when available, to apply a new version after reviewing parameter values.

## Delete a monitor

Deleting a monitor can't be undone and stops future runs for that monitor. Preserve any associated monitor results and drift records you need before deletion. Don't rely on a deleted monitor as your history archive.

To delete a configuration monitor:

1. Browse to **Tenant Governance**. Under **Tenant management**, select **Monitors** for the home tenant. Under **Other tenants**, select **Monitors (Preview)** for a governed tenant.
1. Confirm the target tenant.
1. Find the monitor you want to delete.
1. Select the checkbox next to the monitor's name, then select **Delete** in the command bar. Alternatively, hover over the monitor name and select the delete icon that appears.
1. In the confirmation dialog, select **Delete**.
1. Select a monitor to enable **Delete** in the command bar.

:::image type="content" source="../media/tenant-governance-configuration-management/selected-monitor.png" alt-text="Screenshot of a selected monitor with the Delete command enabled in the command bar." lightbox="../media/tenant-governance-configuration-management/selected-monitor.png":::

Deleting an other-tenant monitor removes the selected monitor from its target tenant. It doesn't delete resources in the governed tenant, revert previously applied configuration, or terminate the governance relationship. Other monitors aren't affected.

Permission or relationship changes can prevent later runs of a governed-tenant monitor. Review those dependencies when you update the monitor; don't interpret a failed run as confirmation that no drift exists.

## Related content

- [Create a monitor](how-to-create-monitor.md)
- [See monitor results and configuration drifts](how-to-see-monitor-results.md)
- [Set up permissions for tenant monitoring](how-to-set-up-permissions-tenant-monitoring.md)
- [Configuration management](configuration-management.md)
