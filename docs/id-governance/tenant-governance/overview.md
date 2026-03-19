---
title: What is Microsoft Entra Tenant Governance? (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn about Microsoft Entra Tenant Governance and how it helps organizations discover, manage, and govern tenants across their environment
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: overview
ms.date: 03/05/2026
---

# What is Microsoft Entra Tenant Governance? (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

[!INCLUDE [entra-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

Most large organizations operate Microsoft services in multiple tenants because of mergers and acquisitions, requirements for partitioning security or privacy-sensitive workloads, test environments, and other reasons. Most organizations also have user-created "shadow IT" tenants that central IT doesn't administer and often doesn't know about. In many environments, it's not easy to verify that each of these tenants is configured properly, especially if you don't know that some tenants even exist. This creates risk for your organization's security and compliance objectives.

Microsoft Entra Tenant Governance enables you to get visibility across all your tenants and ensure they are configured to meet your security and compliance requirements. This includes the tenants you administer today, "shadow IT" tenants that you don't administer but that create risks for your organization, and new tenants that your users create.

## Related tenants

Related tenants capabilities help you identify tenants that you need to govern, or that have security or privacy exposure to tenants that you administer.

Key features:

- Automatically detect tenants that are related to your tenant based on one or more discovery signals.
- The B2B discovery signal identifies and measures inbound and outbound B2B access, B2B registration, and B2B administrative access between your tenant and other tenants.
- The multitenant application discovery signal identifies tenants with registered multitenant applications that have permissions in your tenant, or tenants to which your registered multitenant applications have access.
- The billing discovery signal identifies tenants that share billing accounts with you, where either your tenant or the related tenant is an associated billing tenant for the billing account.
- View initial and recent metrics about the volume of relationships between your tenant and related tenants.
- Filter and sort the list of related tenants based on discovery signal findings to focus on tenants with particular types of risk that your organization prioritizes.

Learn more about [related tenants](related-tenants.md).

## Governance relationships

Governance relationship capabilities help you set up and manage cross-tenant administrative access across the tenants that you need to govern.

Key features:

- Invitation, request, and approval workflows to define a governance relationship and set up cross-tenant administrative access between existing tenants.
- Integration with the commerce discovery signal to streamline the workflow for setting up relationships between tenants that share a commerce billing account.
- Least-privilege cross-tenant administrative access that enables users in your governing tenant to perform administrative tasks in governed tenants, including configuration management tasks.
- Streamlined app injection experience to provision and maintain permissions for your custom application in a governed tenant.
- Governance policy templates to easily request the same permissions in different tenants where you need the same administrative permissions.

Learn more about [governance relationships](governance-relationships.md).

## Configuration management

Configuration management capabilities help you monitor the configuration of tenant resources in any tenant that you govern. Over 200 types of resources are supported across six Microsoft services: Entra, Intune, Exchange Online, Teams, Purview, and Defender.

Key features:

- Author a configuration baseline that expresses the desired state of tenant resources by using a standard JSON format.
- Create a configuration snapshot to document the current state of tenant resources. You can use a snapshot from a "known good" tenant to jumpstart the authoring of a configuration baseline. Snapshots can also help satisfy certain audit requirements.
- Create a monitor that automatically compares the actual state of tenant resources to the desired state defined in your JSON configuration baseline.
- View monitor results that show summary statistics each time the monitor runs. Currently, each monitor runs at six-hour intervals.
- View a list of configuration drifts in one monitor or across all monitors running in the tenant. Each configuration drift shows which properties of the resource differ from what the configuration baseline defines.

Learn more about [configuration management](configuration-management.md).

## Secure tenant creation

Secure tenant creation capabilities help you control which users can create new add-on tenants, automatically set up governance relationships with those tenants, and ensure that your organization can recover administrative access to those tenants if necessary.

Key features:

- Define a governance policy template to automatically create a governance relationship between your tenant and new tenants created by your users.
- Control which users can create new add-on tenants by assigning or limiting access to commerce billing accounts in your tenant.
- Use the Microsoft Entra asset in your commerce billing account to streamline recovery of administrative access to an add-on tenant, such as when the last administrator of that tenant leaves your organization, or when a threat actor compromises the add-on tenant.
- Use the commerce API or the Microsoft Entra admin center to create a new add-on tenant.

Learn more about [creating a governed tenant](how-to-create-tenant.md).

## Getting started

To begin using Tenant Governance features, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an administrator whose roles have permission to perform Tenant Governance tasks. Navigate to the **Tenant governance** page.

## Licensing and support

Tenant Governance is available at two service levels: Tenant Governance Basic and Tenant Governance Premium. To see which Tenant Governance features are available at each service level, see [Microsoft Entra licensing](~/fundamentals/licensing.md).

Tenant configuration management APIs are generally available. Other Tenant Governance experiences are in preview. All Tenant Governance capabilities are supported by Microsoft Customer Support for use in production environments.

## Next steps

- [Related tenants](related-tenants.md)
- [Enable tenant discovery](how-to-enable-tenant-discovery.md)
- [Set up a governance relationship](how-to-set-up-governance-relationship.md)
- [Deploy Tenant Governance](deployment-guide.md)
