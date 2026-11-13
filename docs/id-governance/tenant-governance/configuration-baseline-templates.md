---
title: Configuration baseline templates (Preview)
description: Learn how configuration baseline templates standardize configuration definitions across monitors and deployments in Microsoft Entra Tenant Governance.
ms.topic: concept-article
ms.date: 11/12/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to reuse approved baselines so that I can standardize configuration across tenants.
---

# Configuration baseline templates (Preview)

A configuration baseline template is a reusable baseline definition in Microsoft Entra Tenant Governance. Use Configuration baseline templates to standardize baseline definitions across monitors and deployments.

Configuration management supports operations in the home tenant and in other tenants that are connected through governance relationships. A shared template helps you use the same approved configuration standard for those targets.

The **Templates** page separates configuration baseline templates from governance policy templates and shows each baseline template's version.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-baseline-templates.png" alt-text="Screenshot of configuration baseline templates with descriptions and version numbers." lightbox="../media/tenant-governance-configuration-management/configuration-baseline-templates.png":::

## Templates, baselines, and snapshots

A baseline is the JSON definition of resources and their expected property values. A snapshot captures actual resource settings at a point in time. A template lets you reuse a reviewed baseline when you create monitors or deployments.

Use the following workflow:

1. Capture current settings in a snapshot or author baseline JSON.
1. Review the settings and remove or adjust values that shouldn't become part of your standard.
1. Save the approved baseline as a template.
1. Use the template to create a monitor or deployment for a selected tenant.

A template doesn't grant permissions or apply settings by itself. A monitor evaluates the baseline; a deployment applies it.

> [!NOTE]
> Configuration baseline templates are different from [governance policy templates](governance-policy-templates.md). Governance policy templates define access through governance relationships, not the desired configuration of workload resources.

## Reuse across tenants

Before using a template in another tenant, review tenant-specific resource identifiers, dependencies, and workload availability. A baseline captured in one tenant isn't automatically suitable for every target tenant.

The operation that uses the template must have the required permissions in its target tenant. Monitoring requires read access. Deployments require permissions to change the affected settings.

## Manage versions and approvals

Treat approved template revisions as controlled configuration changes:

- Include a version or revision in your naming convention.
- Record the owner, approval date, and intended environments.
- Store reviewed baseline JSON in version control.
- Validate a revision with a limited target scope before broader use.
- Review existing monitors and deployments explicitly when adopting a revised template; don't rely on editing a template to update existing operations.

The service creates a new version when you save a template edit. Existing monitors continue using their selected version until you explicitly update them. For a template-linked monitor, use **Apply latest**, when available, to adopt the latest version and review its parameter values.

The service limits the number of versions retained for a template. When the limit prevents a save, the editor attempts to delete the oldest version that no monitor references and retry. If all earlier versions are still referenced, update or delete those monitors before trying again. Keep reviewed baseline JSON in version control for durable change history.

## Related content

- [Use configuration baseline templates](how-to-use-configuration-baseline-templates.md).
- [Create configuration snapshots](how-to-create-snapshots.md).
- [Create a configuration deployment](how-to-create-configuration-deployment.md).
- [Create a configuration monitor](how-to-create-monitor.md).
