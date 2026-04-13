---
title: Plan your migration from Azure AD B2C to External ID
description: Choose between the standard migration approach and High Scale Compatibility (HSC) mode when moving from Azure AD B2C to Microsoft Entra External ID.
author: garrodonnell
ms.author: godonnell
ms.topic: concept-article
ms.date: 03/13/2026
ai-usage: ai-assisted
---

# Plan your migration from Azure AD B2C to External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Decide which migration approach is right for your Azure AD B2C tenant before you begin implementation. This article helps you choose between the standard migration and High Scale Compatibility (HSC) mode, understand the key decision points, and find the right next step. This article is for existing customers of Azure AD B2C who are planning to migrate. New customers evaluating Microsoft Entra External ID should refer to [Planning your solution](concept-planning-your-solution.md).

In this article, you’ll learn how to:
- Compare the available migration approaches (standard and High Scale Compatibility)
- Understand the key decision points and eligibility criteria
- Review HSC mode limitations and feature availability
- Review a stage-by-stage view of how coexistence works
- Find links to configuration instructions for your chosen approach

## Choose a migration approach

Your first decision is which migration approach to use. Most customers should use the standard approach. High Scale Compatibility (HSC) mode is only relevant if your tenant exceeds specific scale thresholds and you can accept its functional limitations.

- **Standard migration.** Recommended for most customers. You migrate users and credentials to a new External ID tenant and cut over applications.
- **High Scale Compatibility (HSC) mode.** For very large Azure AD B2C tenants with over 5 million directory objects. You keep existing users and credentials in place and migrate applications in phases.

### Determine whether High Scale Compatibility (HSC) mode migration applies

Use the following decision tree to check whether your tenant is eligible for HSC mode.

:::image type="content" source="media/plan-your-migration-from-b2c-to-external-id/b2c-migration-decision-process-large-tenant.png" alt-text="Diagram of a migration decision tree for Azure AD B2C showing steps for HSC and standard migration approaches." lightbox="media/plan-your-migration-from-b2c-to-external-id/b2c-migration-decision-process-large-tenant.png":::

HSC mode migration might be a good choice if **all** the following are true:

- You are an existing Azure AD B2C customer.
- Your tenant contains approximately 5 million or more directory objects (users, groups, and applications).
- You have reviewed and accepted the [functional limitations](#review-limitations-and-roadmap-alignment) of HSC mode.

### Decision summary

| Standard migration | High Scale Compatibility (HSC) mode migration |
|---|---|
| **Best for**: Most tenants<br>**Typical trigger**: Below high-scale thresholds<br>**Identity approach**: Plan to migrate users (and, where required, credentials) as part of moving to External ID<br>**Coexistence**: Not designed for long-running side-by-side operation at very large scale<br>**Feature coverage**: Broadest compatibility | **Best for**: Very large Azure AD B2C tenants<br>**Typical trigger**: ~5 million+ directory objects and scale-driven constraints<br>**Identity approach**: Keep existing users and credentials in place while migrating applications in phases<br>**Coexistence**: Azure AD B2C and External ID run side by side in the same tenant and might require schema updates<br>**Feature coverage**: Some External ID features aren’t available yet in HSC mode. Review limitations carefully |

If your tenant meets the HSC mode eligibility criteria, review both approaches below before deciding. The standard approach might still be the better fit depending on your feature requirements.

If your tenant doesn't meet the HSC mode eligibility criteria, use the **standard migration approach**. HSC mode provides no added benefit below the high-scale thresholds.

## Standard migration approach

The standard migration approach is recommended for most Azure AD B2C customers. It’s intended for tenants that can migrate users (and, where required, credentials) and move applications to Microsoft Entra External ID without needing high-scale coexistence behavior.

### What you migrate in the standard approach

In the standard approach, you migrate identities and applications to a new Microsoft Entra External ID tenant. This typically includes:

1. Creating the destination tenant and configuring security, compliance, and monitoring
1. Registering applications and configuring user flows
1. Migrating users data from your existing tenant
1. Preserving passwords (if needed)
1. Cutting over applications to External ID

### Common migration patterns

- **Bulk user migration, then app cutover**: Users are migrated to External ID in advance, and applications are updated to authenticate against External ID.
- **Bulk user migration with just-in-time (JIT) password migration**: Users are migrated to External ID first, then password validation/migration happens during sign-in or password reset over a time-boxed coexistence period.
- **Azure AD B2C-initiated migration**: Applications initially continue authenticating through your legacy B2C tenant while passwords are progressively migrated in the background, then applications cut over to External ID.

### Common considerations

Before you start implementation, review the following areas at a high level:
- **Custom business logic**: Identify custom policy logic, token/claim shaping, and downstream dependencies you need to recreate.
- **User experience**: Inventory sign-in UX customizations and decide which External ID experience to use.
- **Identity providers**: List social and enterprise identity providers and any federation requirements.
- **Access controls**: Note Conditional Access policies and conditions that must be equivalent post-migration.
- **Age gating**: Azure AD B2C tenants that use custom policies to derive or store age-based attributes (such as minor or major classification) need to plan for alternate approaches. Age gating isn't currently supported in Microsoft Entra External ID.
- **Application-level changes**: Migration requires changes at the application level, not just the tenant level. Each application must be updated to use External ID endpoints and validate tokens accordingly. If your tenant contains applications owned by third parties (for example, ISV tenants where customers register their own apps), coordinate with those app owners early. You can't complete migration until every application is updated.
- **Automation and operations**: Plan Microsoft Graph-based lifecycle operations, monitoring, and runbooks.

### When to choose standard migration

- You don't require long-running side-by-side operation of Azure AD B2C and External ID.
- You want the broadest feature compatibility while you move identities and applications to External ID.

### Configuration instructions

If you’ve decided to use the standard migration approach, continue to [Migrate from Azure AD B2C to Microsoft Entra External ID](migrate-from-b2c-to-external-id.md) for guidance on configuring a new tenant and migrating your users and credentials from Azure AD B2C to your new environment.

## High Scale Compatibility (HSC) mode migration approach

High Scale Compatibility (HSC) mode is a specialized approach for very large Azure AD B2C tenants. It lets you adopt Microsoft Entra External ID endpoints and features while keeping your existing users and credentials in place, so you can migrate applications in phases.

### How HSC mode works

In HSC mode, Azure AD B2C and Microsoft Entra External ID run side by side in the same tenant. Existing apps can continue to use Azure AD B2C endpoints while you move new or migrated apps to External ID endpoints.

### Why choose HSC mode

HSC mode is intended for tenants where a full user and credential migration would be high risk or difficult to complete in a single operation. It helps you:
- Preserve existing B2C users and credentials without disruption.
- Continue supporting legacy B2C applications alongside new or migrated apps using External ID.
- Control the pace and scope of migration, enabling a phased transition across applications according to business needs.

Before you enable HSC mode, confirm eligibility, review limitations, and validate key sign-in and token issuance scenarios with a small set of applications. The following sections summarize each prerequisite.

### Confirm tenant eligibility

Your tenant is eligible for HSC mode if it exceeds the required object quota (approximately 5 million directory objects). You can check your current usage through the Graph API `directoryObject` resource type. For more information, see [directoryObject resource type](/graph/api/resources/directoryobject?view=graph-rest-1.0&preserve-view=true).

If your tenant doesn't exceed this object quota, HSC mode provides no additional benefit and the standard migration approach is recommended.

### Review limitations and roadmap alignment

> [!IMPORTANT]
> HSC mode is appropriate only if you can accept limitations that apply at large scale. Review the limitations before enabling HSC mode or migrating additional applications.

Some limitations are fundamental to operating at high scale and exist today in Azure AD B2C. These same constraints apply when running External ID in HSC mode. For a comprehensive list, see [Capability support by scale and deployment mode](/entra/external-id/customers/reference-service-limits#capability-support-by-scale-and-deployment-mode).

#### External ID features not yet supported in HSC mode

Some capabilities available in External ID aren't available in HSC mode today. If you're considering HSC mode, review these features carefully before making a decision.

> [!NOTE]
> Feature availability timelines might differ between External ID HSC mode and standard deployment modes. Always refer to the official roadmap for the latest status and rollout expectations.

**Authentication and access control**

- Advanced Conditional Access scenarios, including:
  - Authentication context or step-up authentication
  - Session-based controls
- Application assignment via groups
- Phone-based MFA (SMS and voice call). Plan to transition affected users to a supported MFA method such as email one-time passcode before migrating applications.

**Federation and ecosystem integrations**

- Social identity providers (Google, Facebook, Apple, and any other social identity providers configured in Azure AD B2C). Only enterprise identity providers (SAML/WS-Fed and OIDC) are supported for federated sign-in in External ID.
- Custom OIDC federation

**Admin portal UI support**

Full Microsoft Entra admin center UI support isn't yet available for External ID scenarios in HSC mode tenants. Administrative configuration and management are currently performed programmatically using Microsoft Graph and automation.

### Understand how coexistence works

In HSC mode, Azure AD B2C and Microsoft Entra External ID run side by side within the same tenant. Existing applications continue to use Azure AD B2C endpoints, while new or migrated applications use External ID endpoints. Users and credentials are shared across both experiences.

Stage 1: All apps running on B2C services as they are now.
Stage 2: Your tenant is enabled for HSC mode on your existing Azure AD B2C tenant. This is performed without impacting any apps. You can now migrate apps to run on External ID services while others remain on B2C.

:::image type="content" source="media/plan-your-migration-from-b2c-to-external-id/azure-b2c-external-id-coexistence-migration-flow.png" alt-text="Diagram of HSC mode workflow showing app migration from B2C to External ID with endpoints and artifacts listed." lightbox="media/plan-your-migration-from-b2c-to-external-id/azure-b2c-external-id-coexistence-migration-flow.png":::

Stage 3: All apps completely moved over to External ID and your tenant is ready for Azure AD B2C retirement.

> [!IMPORTANT]
> Application migration is always performed by you. HSC mode doesn't automatically move applications.

### Configuration instructions

If you've decided to use High Scale Compatibility (HSC) mode, continue to [Enable External ID High Scale Compatibility (HSC) mode](enable-external-id-high-scale-compatibility-mode.md) for step-by-step instructions on enabling HSC mode for your tenant and guidance on how to configure your environment for coexistence.

If after reviewing the HSC mode limitations you'd prefer the standard approach instead, see [Migrate from Azure AD B2C to Microsoft Entra External ID](migrate-from-b2c-to-external-id.md).

## Related content

- [Microsoft Entra External ID overview](/entra/external-id/external-identities-overview)
- [Supported features in External ID](concept-supported-features-customers.md)
- [Planning your solution](concept-planning-your-solution.md)
- [Service limits and restrictions](reference-service-limits.md)
