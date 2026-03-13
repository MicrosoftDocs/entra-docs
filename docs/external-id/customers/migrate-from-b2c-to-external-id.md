---
title: Migrate from Azure AD B2C to Microsoft Entra External ID
description: Migrate users, credentials, and applications from Azure AD B2C to Microsoft Entra External ID using the standard migration approach.
author: garrodonnell
ms.author: godonnell
ms.topic: how-to-guide
ms.date: 03/13/2026
ai-usage: ai-assisted
---

# Migrate from Azure AD B2C to Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Migrate your users, credentials, and applications from Azure AD B2C to Microsoft Entra External ID using the standard migration approach. This article focuses on migration scenarios where identities already exist in Azure AD B2C and must be transitioned with minimal disruption. New customers evaluating Microsoft Entra External ID at scale should refer to [Planning your solution](concept-planning-your-solution.md).

If you're an Azure AD B2C customer and haven't yet reviewed the available options for migration, refer to [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md).

In this article, you’ll learn how to:
- Prepare your destination External ID tenant and baseline security
- Register applications and configure user flows
- Choose a user and password migration strategy (bulk, JIT, or hybrid)
- Migrate users and handle password preservation requirements
- Validate, monitor, and plan application cutover

## Prerequisites

This article assumes you’ve already chosen the **standard migration approach**. If you still need to decide between approaches (standard vs HSC), start with [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md).

- An inventory of your Azure AD B2C applications, user flows, identity providers, and token/claim requirements
- Admin access to the destination External ID tenant and the ability to call Microsoft Graph for bulk operations
- A test plan and non-production environment to validate sign-in flows and application cutover

## Implementation decisions (standard migration)

At this stage, the remaining decisions are closely tied to configuration and cutover planning. The choices you make here affect user experience, operational complexity, and how quickly you can retire Azure AD B2C.

- **Password preservation:** Do users need to keep their current passwords, or can you move to password reset, passwordless, or social sign-in?
- **Migration mechanics:** Will you use bulk migration only, just-in-time (JIT) password migration, or a hybrid approach?
- **Coexistence window:** If you use JIT, how long will coexistence run, and how will you handle users who never sign in during that period?
- **Application cutover order:** Which apps move first (lowest risk/highest value), and how will you validate tokens/claims before moving the next app?

The following stages walk through the implementation end to end.

## Stage 1: Assess your current Azure AD B2C implementation

Inventory what you have today so you can recreate equivalent behavior in External ID: applications, user flows, identity providers, token/claim requirements, and any custom business logic.

Use the following feature mapping table as a starting point when translating your Azure AD B2C implementation into External ID configuration.

### Feature mapping table

| Feature | Azure AD B2C | External ID equivalent |
|---|---|---|
| Custom business logic | Custom policies (XML/IEF) | Custom authentication extensions |
| Authentication UI | Hosted pages with HTML/CSS | User flows with branding + native authentication |
| User management | Microsoft Graph API | Microsoft Graph API |
| Access policies | Custom policies, user flow conditions | Microsoft Entra conditional access |
| Mobile authentication | Browser-based flows, web redirects | Native authentication SDKs (local accounts only) |
| Token customization | Custom claims in policies | Custom authentication extensions |

For a full feature overview, see [Supported features](concept-supported-features-customers.md).

## Stage 2: Prepare your destination External ID tenant

Set up your destination External ID tenant and baseline security, compliance, and monitoring before migrating production users or cutting over applications. For step-by-step deployment guidance for new External ID tenants, see [Planning your solution](concept-planning-your-solution.md).

This stage typically includes:
- [Creating your external tenant](how-to-create-external-tenant-portal.md)
- [Registering applications and configuring user flows](how-to-user-flow-sign-up-sign-in-customers.md)
- [Setting up federation with social identity providers](concept-authentication-methods-customers.md) (optional)
- [Configuring security, compliance, and monitoring](concept-security-customers.md)

Complete these steps before you migrate any production user data.

## Stage 3: Configure user and password migration

In this stage, you migrate users from Azure AD B2C to External ID and decide how credentials are handled during the transition (bulk, JIT, or hybrid).

These decisions determine whether you run a short coexistence period and how you sequence application cutover.

### User migration

Regardless of whether you preserve passwords, bulk user migration is always the first step. Migrate user accounts from Azure AD B2C to External ID using Microsoft Graph before you cut over applications or begin password migration. This establishes user identities in the destination tenant and is a prerequisite for every credential strategy.

For step-by-step instructions, see [Migrate users](/entra/external-id/customers/how-to-migrate-users).

> [!NOTE]
> When migrating large numbers of objects, you might encounter throttling limits for Microsoft Graph. See [Service-specific throttling limits](/graph/throttling-limits-msgraph-service) and [Throttling guidance](/graph/throttling) for best practices to handle or avoid throttling.

### Password preservation

Decide whether you need to preserve existing passwords. Not every migration requires password preservation — if you don’t need it, users can reset their password after migration using [self-service password reset (SSPR)](how-to-enable-password-reset-customers.md), or you can move to passwordless or social sign-in options.

You typically **don’t** need password preservation if:
- Users authenticate using **social identity providers** (for example, Google or Facebook).
- You plan to use **passwordless authentication** (such as email one-time passcodes).
- You are comfortable requiring users to **reset their password** after migration.
- Regulatory requirements mandate renewing user consent. In this case, you can obtain consent through outbound email communications followed by a user-initiated password reset.
- You have access to **plain-text passwords** and can set them directly via Microsoft Graph during bulk user migration.

If you don’t need password preservation, you can skip directly to [Stage 4: Validate, monitor, and plan cutover](#stage-4-validate-monitor-and-plan-cutover).

If you **do** need to preserve passwords, choose one of the following approaches based on where applications authenticate during the migration.

Use the following decision tree to determine the remaining password-preservation and cutover steps.

![][image_RNyoKyplygrDdlbgnUOH6A==]

#### Just-in-Time (JIT) password migration (External ID-initiated)

In JIT password migration, applications have already moved to External ID endpoints. When a user signs in, External ID uses the `OnPasswordSubmit` custom authentication extension to validate the user's credentials against the legacy IdP, writes the password to the External ID account, and flags the account as migrated. For step-by-step implementation instructions, see [Just-in-time password migration](how-to-migrate-passwords-just-in-time.md).

This diagram provides a deeper view of the standard migration path, combining bulk migration, JIT password migration, and application cutover.

- **1:** User accounts are pre-provisioned in External ID while applications continue to authenticate through your legacy IdP.
- **2:** Applications transition to External ID while passwords are migrated via JIT, with the legacy IdP validating credentials for migration.
- **3:** The legacy IdP is shut down once all users and credentials have been fully moved, leaving External ID as the sole authentication system.

![][image_4YSchXbQ0v9zeAJHZEEsSA==]

**Considerations when using JIT password migration**

Just-in-time (JIT) password migration introduces a coexistence period between Azure AD B2C and Microsoft Entra External ID. Customers should plan for the following considerations:

**Bulk user migration is required upfront**  
Even when using JIT, user accounts must exist in External ID before sign-in:
- Establishes immutable user identifiers.
- Enables consistent attribute mapping.
- Prevents authentication failures during application cutover.

This step is often underestimated and should be completed early.

**Identity state synchronization complexity increases over time**  
Long-running coexistence requires a clear strategy to keep identity state consistent:
- Profile updates, password changes, and new sign-ups must remain aligned.
- One-way or event-driven approaches help reduce conflicts.
- Periodic reconciliation is typically required.

Operational overhead grows the longer JIT runs.

**Higher operational and support impact**  
During extended coexistence:
- Two identity systems must be monitored and supported.
- Migration issues surface during real user sign-ins.
- Support teams need visibility into each user's migration state.

This increases support cost compared to shorter migration windows.

**Incomplete migration risk**  
Users who never sign in during the coexistence period won’t migrate automatically. Plan for:
- Forced password reset scenarios.
- Final bulk migration for remaining users.
- Clear cutover criteria and timelines.

Without this, Azure AD B2C can’t be fully retired.

JIT works best **when coexistence is time-boxed, not open-ended**. Bulk user migration is always a prerequisite, and identity state synchronization becomes the dominant risk as JIT runs longer.

#### Azure AD B2C initiated migration

In the B2C-initiated pattern, applications remain on Azure AD B2C endpoints while credentials are harvested in the background. A B2C custom policy calls a REST API to validate credentials against the legacy IdP and write them to the corresponding External ID accounts. Once enough credentials have been migrated, applications cut over to External ID.

This is the approach referred to as "seamless migration" in [Migrate users](/entra/external-id/customers/how-to-migrate-users).

- **1:** Applications keep authenticating with the legacy IdP while users are progressively migrated into External ID using Azure Functions for credential validation and background migration.
- **2:** Applications cut over to External ID once most users have been migrated, and External ID becomes the primary authentication service for all core user flows.

![][image_BSJj0l8mn9e0/DDbzyaTug==]

## Stage 4: Validate, monitor, and plan cutover

### Validate migration success

Before you move to production and decommission Azure AD B2C apps, validate end-to-end user journeys and integrations:
- Test all authentication flows (sign-up, sign-in, password reset, MFA).
- Validate token issuance and custom claims (<https://jwt.ms/>).
- Test application and API integrations.
- Verify custom authentication extensions.
- Test JIT provisioning and native authentication.
- Conduct performance and load tests.
- Ensure security policies and user data integrity.

See [Test user flows](how-to-test-user-flows.md), [Samples](samples-ciam-all.md), and [Custom extension attribute collection](~/identity-platform/custom-extension-attribute-collection.md) for guidance.

### Monitor and optimize

After you go to production, implement monitoring and analytics to maintain system health and optimize user experience:
- Set up logging and monitoring with Azure Monitor and Microsoft Sentinel. For more information, see [Azure Monitor integration](how-to-azure-monitor.md).
- Use built-in dashboards for user activity, authentication, and engagement insights. For more information, see [User insights](how-to-user-insights.md).

Ongoing monitoring enables proactive issue resolution, data-driven optimization, and continuous improvement of your CIAM solution.

## Related content

- [Microsoft Entra External ID](/entra/external-id/)
- [Just-in-time password migration](how-to-migrate-passwords-just-in-time.md)
- [Migrate users](how-to-migrate-users.md)
- [MSAL overview](/azure/active-directory/develop/msal-overview)
- [Microsoft Entra External ID Q&A](/answers/tags/438/entra-external-id)
- [External authentication and access control](/entra/architecture/deployment-external-authentication-access-control)
- [Service limits](/entra/external-id/customers/reference-service-limits)
