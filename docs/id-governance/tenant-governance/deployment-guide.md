---
title: Deploy Microsoft Entra Tenant Governance end to end (preview)
description: Learn how to deploy Microsoft Entra Tenant Governance from initial setup through tenant discovery, governance relationships, delegated administration, and configuration monitoring.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/17/2026
---

# Deploy Microsoft Entra Tenant Governance end to end (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article describes how to deploy Microsoft Entra Tenant Governance across your organization. The deployment follows five phases: verifying prerequisites, discovering related tenants, establishing governance relationships, implementing delegated administration, and setting up configuration monitoring.

Each phase builds on the previous one. Complete the phases in order, but skip optional phases if they don't apply to your environment.

## Prerequisites

Before you begin, confirm that your environment meets these requirements:

- A Microsoft Entra tenant with the appropriate license for Tenant Governance. For details, see [Microsoft Entra licensing](~/fundamentals/licensing.md#microsoft-entra-tenant-governance-preview).
- An account with the Tenant Governance Administrator or Global Administrator role.
- For configuration management: an account with the Global Administrator or Privileged Role Administrator role.
- For secure tenant creation: at least Tenant Contributor permissions on a Microsoft Customer Agreement (MCA) subscription. Enterprise Agreement (EA) subscriptions aren't supported.

## Phase 1: Enable tenant discovery

Tenant discovery identifies other Microsoft Entra tenants that have observable relationships with your tenant. These relationships are based on signals such as B2B collaboration, multitenant application usage, and shared billing accounts. For more information about what related tenants represent, see [Related tenants](related-tenants.md).

### Enable discovery

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Tenant Governance Administrator.
1. Browse to **Tenant governance** > **Related tenants**.
1. Review the description of the tenant discovery feature.
1. Select **Discover related tenants**.

> [!IMPORTANT]
> Enabling tenant discovery is permanent. After you enable it, the setting can't be reversed.

Discovery signals begin aggregating after you enable the feature. It might take several days for data to populate. For more information about the signals and metrics that tenant discovery uses, see [Signals and metrics for tenant discovery](signals-metrics.md).

### Review and classify discovered tenants

After signals aggregate, review the related tenants inventory and classify each tenant:

1. Browse to **Tenant governance** > **Related tenants** to see the full list.
1. Examine the discovery signals for each tenant: B2B collaboration, multitenant applications, and shared billing accounts.
1. Compare initial and recent metrics to determine whether activity is ongoing, growing, or dormant.
1. Classify each tenant into one of these categories:

   - **Known and acceptable**: Clearly identifiable tenants (partners, vendors, customers) with expected activity. Document as a known relationship. No immediate governance action is needed.
   - **Requires governance**: Internal-looking tenants with moderate or growing activity and unclear ownership. Investigate and consider establishing a governance relationship.
   - **Potentially risky**: Unknown tenants with unexpected activity and no clear business justification. Consider quarantining. For more information, see [Quarantine unsanctioned tenants](/entra/fundamentals/quarantine-unsanctioned-tenants).

For detailed guidance on interpreting discovery data, see [Interpret tenant discovery data](how-to-interpret-discovery-data.md).

## Phase 2: Create governance policy templates

Before you establish governance relationships, create one or more governance policy templates. A policy template defines the permissions and applications that are provisioned when a governance relationship is created.

### Create a policy template

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Tenant Governance Administrator.
1. Browse to **Tenant governance** > **Templates**.
1. Select **Create template**.
1. Configure the template:

   - **Cross-tenant delegated administration**: Select the Microsoft Entra built-in roles to assign, and specify the security groups in the governing tenant that receive those roles.
   - **Multi-tenant applications** (optional): Select custom applications to provision in governed tenants.

1. Save the template.

Policy template updates don't automatically apply to existing governance relationships. To apply changes, send a new governance request and have the governed tenant accept it. For more information, see [Governance policy templates](governance-policy-templates.md).

### Configure a default policy template (optional)

If you plan to use the secure add-on tenant creation feature, configure a default policy template. The default template is applied automatically when a new governed tenant is created through that flow.

1. Create or update a policy template with the ID `default`.
1. Configure the delegated administration roles and applications for new tenants.

If no default template exists, new tenants created through the secure add-on flow don't automatically get a governance relationship. For more information, see [Secure add-on tenant creation settings](tenant-creation-settings.md).

## Phase 3: Set up governance relationships

Governance relationships connect a governing tenant to one or more governed tenants. The process depends on whether the tenants share a billing account. For background on governance relationships, see [Governance relationships](governance-relationships.md).

### Two-step handshake (tenants with shared billing)

Use the two-step process when a billing signal exists between the tenants:

**Step 1: Send a governance request (governing tenant)**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Tenant Governance Administrator.
1. Browse to **Tenant governance** > **Governed tenants**.
1. Select **Send governance request**.
1. Select the target tenant and the policy template to apply.
1. Send the request. The request is valid for 14 days.

**Step 2: Accept the request (governed tenant)**

1. Sign in to the governed tenant as a Tenant Governance Administrator.
1. Browse to **Tenant governance** > **Governing tenants** > **Received requests**.
1. Review the request details, including the roles and applications defined in the policy template.
1. Select **Accept**.

### Three-step handshake (tenants without shared billing)

Use the three-step process when no billing signal exists between the tenants:

**Step 1: Send an invitation (governed tenant)**

1. Sign in to the governed tenant as a Tenant Governance Administrator.
1. Browse to **Tenant governance** > **Governing tenants** > **Sent invitations**.
1. Send an invitation to the future governing tenant. The invitation is valid for 30 days.

**Step 2: Send a governance request (governing tenant)**

1. Enable governance invitations in **Tenant governance** > **Settings** (if not already enabled).
1. Browse to **Tenant governance** > **Governed tenants** > **Received invitations**.
1. Review the invitation and send a governance request with the selected policy template. The request is valid for 14 days.

**Step 3: Accept the request (governed tenant)**

1. Browse to **Tenant governance** > **Governing tenants** > **Received requests**.
1. Review and accept the request.

### Verify the relationship

After the governed tenant accepts the request, verify that these resources are provisioned:

- A governance relationship object in both tenants
- Cross-tenant access settings updates
- GDAP role assignments (if delegated administration is configured)
- Service principals for multi-tenant applications (if application management is configured)

For complete setup instructions, see [Set up a governance relationship](how-to-setup-governance-relationship.md).

## Phase 4: Implement cross-tenant delegated administration

After you establish governance relationships with delegated administration configured, administrators in the governing tenant can manage governed tenants without local or B2B accounts. For background, see [Cross-tenant delegated administration](cross-tenant-delegated-administration.md).

### Add users to security groups

Add the administrators who need cross-tenant access to the security groups specified in the governance policy template.

### Sign in to governed tenants

Administrators sign in to governed tenants by accessing a supported admin portal with the governed tenant's domain or ID:

1. Open the admin portal URL with the governed tenant identifier appended, for example:
   `https://entra.microsoft.com/{governed-tenant-domain-or-id}`
1. Sign in with governing tenant credentials.
1. Perform administrative tasks based on the assigned roles.

Supported admin portals include the Azure portal, Microsoft Entra admin center, Microsoft Intune, Exchange, SharePoint, Teams, and Microsoft 365 admin centers.

### Update delegated administration roles

To change the roles assigned through a governance relationship:

1. Update the governance policy template in the governing tenant.
1. Send a new governance request to the governed tenant with the updated template.
1. The governed tenant reviews and accepts the request to apply the updated roles.

For more information, see [Use cross-tenant delegated administration](how-to-delegated-administration.md) and [Monitor governing tenant admin activity](how-to-monitor-governing-activity.md).

## Phase 5: Set up configuration management

Configuration management lets you define a desired configuration state and monitor tenants for drift. Set up monitoring in each tenant where you want to detect configuration changes. For background, see [Configuration management](configuration-management.md).

### Set up permissions

The configuration management service requires explicit permissions to read tenant configuration.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Global Administrator or Privileged Role Administrator.
1. Browse to **Tenant governance** > **Configuration management permissions**.
1. On the **Application permissions** tab, add the required Microsoft Graph application permissions for the resource types you want to monitor (for example, `Policy.Read.All` for conditional access policies).
1. On the **Entra roles** tab, assign any required roles (for example, Teams Reader for Teams resources).
1. For Exchange, Security, and Compliance resources, assign permissions in the respective service admin centers.

For detailed instructions, see [Set up permissions for tenant monitoring](how-to-setup-permissions-tenant-monitoring.md).

### Author a configuration baseline

A configuration baseline is a JSON representation of the desired tenant configuration state.

1. Decide which resources and properties to monitor.
1. Author a JSON baseline manually, or generate a starting baseline by using Snapshot APIs to extract the current configuration.
1. Edit the baseline to define the desired state you want to enforce.

Each baseline can include up to 200 resource instances. The overall daily limit is 800 resource instances across all monitors.

For more information, see [Author a configuration baseline](how-to-author-configuration-baseline.md).

### Create a monitor

1. Browse to **Tenant governance** > **Configuration management** > **Monitors**.
1. Select **Create monitor**.
1. On the **Permissions** step, review and grant the required permissions for the resources in your baseline.
1. On the **Configuration baseline** step, paste or upload your JSON baseline. Validate the baseline before you proceed.
1. On the **Review** step, confirm the monitor name, description, and resource count.
1. Select **Create monitor**.

The monitor runs automatically every six hours. Results and drift data are available after the first run, which might take up to six hours.

For more information, see [Create a configuration monitor](how-to-create-monitor.md).

### Review results and address drift

1. Browse to **Tenant governance** > **Configuration management** > **Monitors**.
1. Select the **Monitor results** tab to view execution summaries.
1. Select the **Configuration drifts** tab to view detected drifts.
1. For each drift, select the **Drifted properties** value to see a comparison of actual and expected values.

To address a drift, either update the resource to match the baseline or update the baseline to reflect the acceptable current state. The next monitor run automatically marks the drift as resolved.

For more information, see [See monitor results and configuration drifts](how-to-see-monitor-results.md).

## Create governed tenants (optional)

Use the secure add-on tenant creation feature to create new tenants that are immediately governed.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with at least Tenant Contributor permissions on a Microsoft Customer Agreement subscription.
1. Create a new tenant using the **Governed Workforce** option.
1. Select the Azure subscription and resource group for the Microsoft Entra ID Free billing asset.

The system creates the tenant, establishes a governance relationship using the default policy template, provisions a billing asset, and adds the tenant to your related tenants inventory.

> [!NOTE]
> A default governance policy template must be configured before you use this feature. If no default template exists, the tenant is created but no governance relationship is established.

For more information, see [Create a governed workforce tenant](how-to-create-tenant.md).

## Related content

- [What is Microsoft Entra Tenant Governance?](overview.md)
- [Related tenants](related-tenants.md)
- [Governance relationships](governance-relationships.md)
- [Governance policy templates](governance-policy-templates.md)
- [Cross-tenant delegated administration](cross-tenant-delegated-administration.md)
- [Configuration management](configuration-management.md)
- [Microsoft Entra licensing](~/fundamentals/licensing.md#microsoft-entra-tenant-governance-preview)
- [Frequently asked questions](faq.yml)
