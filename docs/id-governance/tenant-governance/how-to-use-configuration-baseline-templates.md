---
title: Use configuration baseline templates (Preview)
description: Learn how to create, edit, version, and apply configuration baseline templates to monitors and deployments in Microsoft Entra Tenant Governance.
ms.topic: how-to
ms.date: 11/12/2026
ai-usage: ai-assisted
# Customer intent: As a tenant administrator, I want to manage reusable baseline templates so that I can use approved settings in monitors and deployments.
---

# Use configuration baseline templates (Preview)

Use Configuration baseline templates to standardize baseline definitions across monitors and deployments. A template contains reusable baseline JSON; selecting it doesn't apply configuration until you create a deployment.

Configuration management supports operations in the home tenant and in other tenants that are connected through governance relationships.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- The tenant has licenses for **Tenant Governance Basic** or **Tenant Governance Premium**. Basic includes templates for home-tenant and cross-tenant configuration management. See [Microsoft Entra Tenant Governance licensing](licensing.md).
- Baseline JSON or a completed snapshot that contains the resource settings you want to reuse.
- Required workload permissions for operations that use the template. For deployments or monitors in another tenant, an active governance relationship and required delegated access.

For permission setup, see [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md).

## Create a template

To create a reusable baseline template, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Tenant Governance** > **Templates** > **Configuration Baseline Template**.
1. Select **New configuration template**.
1. In the **Configuration JSON** editor, provide the template metadata and baseline by uploading a JSON file, importing a completed snapshot, or composing JSON.
1. Review resource properties and tenant-specific references. If you imported a snapshot, verify that the captured settings represent your intended standard.
1. Select **Validate + Save**.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-baseline-templates.png" alt-text="Screenshot of the Templates page with configuration baseline templates and the creation command." lightbox="../media/tenant-governance-configuration-management/configuration-baseline-templates.png":::

## Edit a template

To update template metadata or its baseline, follow these steps:

1. Open the template from **Configuration Baseline Template**.
1. Update the template metadata or baseline in the **Configuration JSON** editor.
1. Select **Save changes**.

Saving an edit publishes a new template version. Review the monitors and deployments that should use the revised definition. Changing a template doesn't automatically update existing monitors or reapply configuration to tenants.

## Apply a template to a monitor

To monitor a tenant against the template baseline, follow these steps:

1. Browse to **Tenant Governance**. Under **Tenant management**, select **Monitors** for the home tenant, or under **Other tenants**, select **Monitors (Preview)** for a governed tenant. Select **New monitor**.
1. For a governed-tenant monitor, select the target on **Tenants**.
1. On **Configuration baseline**, choose the template option and select the approved template.
1. Review the baseline and target tenant, then complete permission checks and the remaining steps in [Create a configuration monitor](how-to-create-monitor.md).

## Apply a template to a deployment

To apply the template baseline to a tenant, follow these steps:

1. Browse to **Tenant Governance**. Under **Tenant management** or **Other tenants**, select **Configuration deployments** for the required scope, and select **Deploy configuration**.
1. For a governed-tenant deployment, select the target on **Tenants**.
1. On **Configuration baseline**, choose the template option and select the approved template.
1. Review the settings, tenant-specific references, and write permissions before completing [Create a configuration deployment](how-to-create-configuration-deployment.md).

## Manage template versions

Template edits create service-managed versions. Keep reviewed baseline JSON in version control, and record an owner, approval date, and intended environments for each approved revision.

Test a revision with a limited tenant scope before broader deployment. When replacing an existing baseline, explicitly review and update affected monitors or create deployments from the approved revision. Preserve a copy of the previous baseline for comparison and change review.

For a template-linked monitor, the baseline is read-only in the monitor details. Edit the source template, then use **Apply latest**, when available, to adopt the latest version. Review and supply any required parameter values before confirming.

If the service's template version limit is reached, the editor attempts to delete the oldest version that no monitor references and retries the save. If every earlier version is still referenced, update or delete the monitors using those versions before saving again. Keep your own approved baseline history rather than relying on every service version being retained.

## Related content

- [Configuration baseline templates](configuration-baseline-templates.md).
- [Create configuration snapshots](how-to-create-snapshots.md).
- [Create a configuration monitor](how-to-create-monitor.md).
- [Create a configuration deployment](how-to-create-configuration-deployment.md).
