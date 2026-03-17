---
title: Frequently asked questions for Microsoft Entra Tenant Governance (preview)
description: Find answers to common questions about Microsoft Entra Tenant Governance, including related tenants, governance relationships, configuration management, and secure tenant creation.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: faq
ms.date: 03/17/2026
---

# Frequently asked questions for Microsoft Entra Tenant Governance (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article answers frequently asked questions about Microsoft Entra Tenant Governance.

## Can I manage Tenant Governance with Microsoft Graph APIs?

Yes, a set of Microsoft Graph APIs is available to manage Tenant Governance. For more information, see the [Microsoft Graph API documentation](https://aka.ms/TenantGovernance/MSGraphAPI).

## Are licenses required to use Tenant Governance?

Tenant Governance offers free, basic, and premium capabilities. For a comprehensive list of license requirements per capability, see [Microsoft Entra licensing](~/fundamentals/licensing.md#microsoft-entra-tenant-governance-preview).

## How does Microsoft Entra Tenant Governance compare to the multitenant organization feature?

Microsoft Entra Tenant Governance and the multitenant organization feature are complementary. Tenant Governance enables tenant discovery, administrative access across tenants, and configuration monitoring within a tenant. The multitenant organization feature enables end-user collaboration across Microsoft Entra tenants within Microsoft 365 services. Within an organization, the list of tenants related by governance relationships remains independent of the list of tenants within a multitenant organization.

## Do I own all my related tenants?

No. Related tenants don't imply ownership of a discovered tenant. Related tenants represent tenants that have historical or active relationships with your tenant based on discovery signals. The feature provides situational awareness by surfacing tenant connections based on evidence already present across identity, application, and billing systems. This awareness enables organizations to make informed governance decisions.

## What do I do if Tenant Governance shows me a related tenant that I don't recognize?

Start by checking whether the tenant shares your Commerce billing account. A shared billing account often indicates a tenant you might need to govern. Users in that tenant might have permissions to access or modify the billing account, or might have subscriptions paid for under your billing account.

You can also review B2B collaboration signals and multitenant application usage between your tenant and the related tenant. B2B registration and sign-in patterns might reveal interactions you recognize. You might also use email scanning capabilities to detect administration emails about those other tenants. When needed, reach out to the users involved using your organization's communication tools, such as Exchange Online or Teams, to understand why the relationship exists.

## How can I protect my organization if an administrator of another tenant doesn't approve my governance request?

If administrators of another tenant reject or don't respond to your governance request, run a quarantine workflow to protect your organization from actions of the related tenant. Follow the steps in [Quarantine unsanctioned tenants](/entra/fundamentals/quarantine-unsanctioned-tenants) to block users or applications in the other tenant from accessing your resources. This approach protects the security and privacy of data in your tenant.

Consider cutting off outbound B2B user access or Commerce service provisioning as a test. This action could prompt the other tenant to reconsider your request.

## How does Tenant Governance relate to B2B capabilities?

Some customers use B2B accounts for multi-tenant administration. This approach requires roles to be assigned per B2B user in every tenant. Granular delegated admin privileges (GDAP) don't replace B2B collaboration features. However, for multi-tenant administration needs, assigning and maintaining least-privileged permissions is often easier with GDAP accounts in governance relationships.

## I'm a Microsoft partner in the Partner Center program. Can I use these capabilities to manage customer tenants?

Tenant Governance relationships aren't currently supported for Microsoft partners with existing [GDAP relationships configured through Partner Center](/partner-center/customers/gdap-introduction).

## Can governed tenants independently terminate the relationship?

Yes. A governed tenant can always terminate the governance relationship. Administrators in the governing tenant see that the governed tenant terminated the relationship and receive an email notification.

## Does Tenant Governance support multi-tier relationships?

No. Multi-tier relationships aren't currently supported. For example, you can't set up a governance relationship where Tenant A governs Tenant B and Tenant B governs Tenant C. A tenant can't be both a governing and a governed tenant. If the system detects that a relationship setup would break this rule, API calls fail.

## Do governance relationships support PIM?

Yes. Use [PIM for Groups](/entra/id-governance/privileged-identity-management/concept-pim-for-groups) so that admins activate group membership in the governing tenant before using GDAP access configured in the relationship to manage other tenants. PIM policies configured in the governed tenant and applied to a governing tenant administrator aren't supported.

## Does Tenant Governance support multiple relationships between tenants?

Multiple tenants can govern a single tenant, and a single tenant can govern multiple tenants. Multiple active relationships between the same two tenants aren't supported.

## What Microsoft services and resources can I monitor?

Monitor any of over 200 resource types supported by Microsoft tenant configuration APIs. These resources span Microsoft Entra, Intune, Exchange Online, Teams, and Security & Compliance (Defender and Purview). For the full list of supported resource types, see the tenant configuration management documentation: [Entra](/graph/utcm-entra-resources), [Exchange](/graph/utcm-exchange-resources), [Intune](/graph/utcm-intune-resources), [Security and Compliance](/graph/utcm-securityandcompliance-resources), and [Teams](/graph/utcm-teams-resources).

## What does a configuration baseline look like, and how do you create one?

A configuration baseline is a declarative JSON representation of the desired tenant configuration state. Author it manually, or generate a starting baseline by using Snapshot APIs to extract the tenant's current configuration and then editing it into the desired state.

## How often do monitors run, and can you control the monitoring frequency?

After you create a monitor, it runs automatically on a periodic basis. The default run interval is every six hours.

## Are there any limits on how large a configuration baseline can be?

A monitor baseline can include up to 200 resource instances. The overall daily limit is 800 resource instances across all monitors in a tenant.

## What happens if I try to monitor or snapshot more resources than allowed?

The new monitor or snapshot job fails during creation. For example, if an existing monitor already uses the full daily quota of 800 resource instances, any attempt to create another monitor fails because it would exceed the limit.

## If the monitoring service detects a configuration drift, how do I fix it?

Use the tool of your choice to update the resource configuration, such as the admin center, PowerShell, or Graph API. The next time the monitor runs, it detects that the resource matches the configuration baseline and automatically marks the drift as no longer active.

## Can I monitor configuration across multiple tenants using the same baseline?

Reuse the same configuration baseline file to create monitors in different tenants. To create a monitor in multiple tenants, or to detect configuration drifts in multiple tenants, sign in to each tenant individually and perform the task in that tenant.

## What happens if multiple monitors define different required states for the same resource?

Both monitors run successfully, but each independently evaluates drift against its own baseline. For example, if monitor 1 expects property A to be `true` and monitor 2 expects property A to be `false`, the monitors report different results. If the actual state is `true`, only monitor 2 reports a drift. Define a single desired state per resource to avoid conflicting baselines.

## Why do I need to choose a subscription when creating a tenant?

To use the secure add-on tenant creation feature, you need owner or contributor permissions on a Microsoft Customer Agreement (MCA) subscription. The subscription you select is where the system stores the Microsoft Entra ID Free billing asset for the new tenant.

## What is the Microsoft Entra ID Free billing asset?

Microsoft Entra ID Free is a free billing asset that represents your Microsoft Entra tenants within your billing account. This asset demonstrates commercial and legal ownership of the tenant. The Microsoft support team can use it to restore access or securely process sensitive requests. Each billing asset is tied directly to one Microsoft Entra tenant and doesn't expire or get removed unless the tenant is deleted by a Global Administrator. For more information, see [Microsoft Entra ID Free](/azure/cost-management-billing/manage/microsoft-entra-id-free).

## How are add-on tenants governed?

When a user in your organization creates a new tenant through the secure add-on tenant creation flow in the Microsoft Entra admin center (or through APIs), the system automatically creates a governance relationship. This relationship connects the home (governing) tenant and the add-on (governed) tenant. This relationship uses the default governance policy template. If no default template is defined, no relationship is established.

## Can add-on tenants be created from governed tenants?

Yes. Although multi-tier governance relationships aren't supported, an exception exists for new tenant creation. If your tenant is governed by another tenant, you can still create add-on tenants. Those add-on tenants are then governed by your tenant.

## Related content

- [What is Microsoft Entra Tenant Governance?](overview.md)
- [Related tenants](related-tenants.md)
- [Governance relationships](governance-relationships.md)
- [Configuration management](configuration-management.md)
- [Microsoft Entra licensing](~/fundamentals/licensing.md#microsoft-entra-tenant-governance-preview)
- [Deploy Microsoft Entra Tenant Governance end to end](deployment-guide.md)
