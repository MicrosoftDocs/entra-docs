---
title: Plan your SSO integration with Microsoft Entra (ISVs)
description: High-level planning and decision guide for Independent Software Vendors (ISVs) preparing to integrate single sign-on (SSO) with Microsoft Entra ID.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: concept-article
ms.date: 06/04/2026
ms.author: jomondi
ms.reviewer: hkinyunyu
ms.custom: enterprise-apps-article, msecd-doc-authoring-1013
ai-usage: ai-assisted

# Customer intent: As an ISV application developer or architect, I want to understand the key planning decisions for SSO integration with Microsoft Entra ID so I can design my application for successful enterprise deployment.
---

# Plan your SSO integration with Microsoft Entra ID (ISVs)

Single sign-on (SSO) with Microsoft Entra ID takes planning. Your early decisions affect your app's architecture, customer onboarding, and long-term upkeep. This guide helps independent software vendors (ISVs) make those decisions before they build.

SSO planning for independent software vendors (ISVs) differs from organizational SSO. As an ISV, you design your app once, then deploy it to many customer tenants. Each tenant can have different requirements, protocols, and configuration.

This deployment approach is the "design once, configure per tenant" model. Decisions you make early shape how well you support diverse customers. Weak planning leads to onboarding friction, more support work, and lost enterprise sales.

To plan well, first understand the basics. For background, see [What is single sign-on (SSO)](what-is-single-sign-on.md) and [Understand Microsoft's SSO model](understand-microsoft-sso-model.md).

## Start here: Recommended defaults for most SaaS ISVs

For most modern SaaS ISVs, use these defaults:

- **Multitenant architecture**: the default for scalable SaaS distribution.
- **OpenID Connect (OIDC)**: the recommended protocol for new development.
- **Single-page applications (SPAs) and mobile apps**: must use OIDC.
- **SAML**: choose it only for specific legacy enterprise customer requirements.
- **Single-tenant apps**: fail Microsoft Entra app gallery validation.

These recommended defaults match modern development practices and Microsoft Entra validation requirements. If you deviate from them, you often face rework during validation.

> [!IMPORTANT]
> Design decisions directly affect whether your app passes Microsoft Entra validation and receives a Test ID. The wrong tenancy model or protocol often causes rework.

## Understand the ISV SSO context in Microsoft Entra ID

Microsoft Entra ID uses a structured model. Your app has one global definition called the application object, which represents the app registration shared across all tenants. In each tenant, your app also has a tenant-specific instance called a service principal. When a customer adds your app to their tenant, they create its service principal. The service principal holds that tenant's SSO configuration, user assignments, and protocol settings.

The separation between the application object and service principals lets your app support different SSO protocols and configurations across tenants, while your core design stays the same. Each tenant configures its SSO settings on its own, without affecting other deployments.

**Critical implication for ISVs:** Protocol configuration lives in the service principal. So your app must tolerate different SSO protocols and claim mappings across tenants. One customer might use SAML with specific attribute mappings. Another might use OIDC with different claims. Your app architecture must handle this variation gracefully.

For detailed explanation of this model, see [Application objects and service principals](~/identity-platform/app-objects-and-service-principals.md) and [Single-tenant vs multitenant apps](~/identity-platform/single-and-multi-tenant-apps.md).

## Decide your tenancy model

**For most SaaS ISVs, multitenant architecture is the recommended default.** You can design your app as single-tenant (one organization) or multitenant (many organizations). This choice strongly affects your SSO design, onboarding complexity, and how well your business model scales.

**Multitenant applications** (recommended) serve many customer organizations from one app registration. A single registration simplifies deployment and scales well. Multitenant apps do require careful design for tenant isolation and per-customer configuration.

**Single-tenant applications** need a separate deployment per customer. They give stronger isolation but add operational work. Choose this approach only for specialized enterprise or compliance needs.

**Impact on validation and publishing:**
- Single-tenant apps fail validation for Microsoft Entra app gallery publishing.
- Multitenancy is required for scalable enterprise distribution and gallery inclusion.
- Gallery publishing requires multitenant architecture to serve diverse customers.

The choice between single-tenant and multitenant architecture is hard to change after customers start using your app. For full guidance, see [Single-tenant vs multitenant apps](~/identity-platform/single-and-multi-tenant-apps.md).

## Define your application architecture and sign-in patterns

Your app's architecture determines which authentication flows and SSO patterns you can support. Choose your architecture and protocol together, and choose carefully. A poor match causes rework during validation.

**Recommended architecture-protocol alignment:**
- **Single-page applications (SPAs)** → OIDC required (client-side token management)
- **Mobile applications** → OIDC required (native authentication flows)
- **Modern web applications** → OIDC recommended default (server-side token handling)
- **Legacy enterprise applications** → SAML acceptable (XML-based federation)

**Web apps** can use either SAML or OpenID Connect, but OIDC is the recommended default for new development. Single-page applications and mobile apps work best with OIDC because they run on the client and use modern authentication patterns.

> [!NOTE]
> If you choose incorrectly: Misaligned architecture and protocol choices often require significant rework during validation and can delay gallery publishing.

For detailed guidance on application types and authentication patterns, see [Microsoft identity platform app types](~/identity-platform/v2-app-types.md) and [OAuth 2.0 authorization code flow](~/identity-platform/v2-oauth2-auth-code-flow.md).

## Review protocol-specific planning considerations

**ISVs must choose between SAML 2.0 and OpenID Connect (OIDC) for SSO.** For most modern SaaS ISVs, OIDC is the recommended default. It matches modern development practices, supports modern app architectures, and integrates more simply.

**Choose SAML only for specific enterprise customer requirements or legacy integration needs.** SAML is still widely supported and fits some scenarios, but it usually takes more work to implement and configure.

**Your protocol choice directly affects validation success and Test ID generation.** Apps that use recommended patterns and protocols usually pass Microsoft Entra validation faster. Nonstandard choices might need extra validation cycles.

For a detailed comparison and decision framework, see [SAML vs OpenID Connect: Choose the right SSO protocol](saml-vs-oidc-decision-guide.md).

## Plan customer configuration and onboarding experience

**Keep configuration simple, but allow the customization customers need.** Some values are the same for every customer, such as redirect URIs and application identifiers. Others differ per customer, such as claims mapping and user attributes.

**Design for automation first:**
- Automate standard configurations wherever possible
- Provide clear guidance for customer-specific settings
- Plan how customers will obtain and validate configuration values
- Test the onboarding process with multiple customer scenarios

Poor onboarding design directly impacts customer adoption and support overhead. For configuration concepts, see [App registration concepts](~/identity-platform/quickstart-register-app.md), [SAML metadata documentation](~/identity-platform/single-sign-on-saml-protocol.md), and [Redirect URI guidance](~/identity-platform/reply-url.md).

## Plan claims, identity data, and authorization mapping

**Define required and optional claims early.** Some claims, such as the user identifier, are usually required. Others, such as group memberships and custom attributes, might be optional or customer-specific.

**Plan for customer variability:**
- Different customers have different identity data available
- Claims format and delivery preferences vary across tenants
- Test your application with minimal and rich claim scenarios
- Document fallback behavior for missing optional claims

For claims and token concepts, see [Tokens and claims overview](~/identity-platform/security-tokens.md), [ID tokens](~/identity-platform/id-tokens.md), and [Security tokens](~/identity-platform/access-tokens.md).

## Plan sign-out, lifecycle, and long-term operations

**SSO goes beyond the first sign-in.** Plan early for sign-out, session management, and account lifecycle. These needs often come up as customer requirements during enterprise sales.

**Key scenarios to address:**
- Single sign-out across applications
- Session timeout alignment with organizational policies
- Account deactivation and cleanup
- Token refresh and expiration handling

For implementation guidance, see [OpenID Connect logout documentation](~/identity-platform/v2-protocols-oidc.md#send-a-sign-out-request) and SAML sign-out references in the [SAML protocol documentation](~/identity-platform/single-sign-on-saml-protocol.md).

## Prepare for validation and gallery publishing

**Plan for gallery requirements from the start.** To publish to the Microsoft Entra app gallery, you must meet specific integration standards and pass validation tests to get a Test ID.

**Validation success factors:**
- Multitenant architecture (required)
- Protocol compliance (OIDC recommended for faster validation)
- Standard authentication flows and error handling
- Proper claims and token management

**Apps that follow established patterns usually pass validation faster.** Poor planning decisions often show up as validation failures that need significant rework.

For publishing guidance and validation requirements, see the [Microsoft Entra application gallery documentation](v2-howto-app-gallery-listing.md).

## SSO planning readiness checklist

Use the following tables to confirm you're ready for validation and gallery publishing. Each item maps to a key SSO planning decision: tenancy model, application architecture, protocol choice, customer configuration, claims, and sign-out.

### Application design checklist

Confirm these application design choices before validation.

| Readiness item | Why it matters |
|---|---|
| Multitenant model confirmed | The Microsoft Entra app gallery only accepts multitenant applications. |
| Application architecture defined (web, SPA, mobile, or API) | Architecture determines which authentication flows apply. |
| Authentication flows identified and aligned with architecture | Misaligned flows cause validation failures. |

### Protocol selection checklist

Confirm your protocol choice and its implications.

| Readiness item | Why it matters |
|---|---|
| OIDC default confirmed *or* business reason documented for SAML | OIDC is the recommended default; deviations need justification. |
| Protocol choice aligns with application architecture | SPAs and mobile apps require OIDC. |
| Protocol-specific implications understood for your application type | Avoids late-stage redesign during validation. |

### Customer experience checklist

Review the onboarding and configuration experience for customers.

| Readiness item | Why it matters |
|---|---|
| Configuration values categorized as fixed or customer-specific | Drives onboarding instructions and tenant model. |
| Onboarding process designed to minimize customer complexity | Lower friction improves tenant admin adoption. |
| Claims and identity data requirements defined and tested | Prevents authorization mismatches at runtime. |

### Validation and publishing checklist

Confirm validation and publishing readiness.

| Readiness item | Why it matters |
|---|---|
| Gallery publishing requirements reviewed early in development | Avoids rework before submission. |
| Validation impact of design decisions considered | Some decisions block validation entirely. |
| Sign-out and session management approach planned | Required for compliance and a clean user experience. |
| Account lifecycle scenarios tested | Catches deprovisioning edge cases. |

### Pre-validation checklist

Complete this final check before you start validation.

| Readiness item | Why it matters |
|---|---|
| All critical decisions documented and justified | Speeds support handoffs and reduces rework. |
| Test ID validation pathway confirmed | Required before entering the publishing flow. |
| Rework risk assessed and minimized | Final go / no-go gate before validation. |

## Related content

Use these resources to register, validate, and publish your app.

**For ISV application developers:**
- [Register your application](~/identity-platform/quickstart-register-app.md) - Create your application registration
- [Publish to the Microsoft Entra app gallery](v2-howto-app-gallery-listing.md) - Gallery submission process
- [Configure SSO using SAML](~/identity/enterprise-apps/add-application-portal-setup-sso.md) - SAML implementation guidance (if required)
- [Configure SSO using OpenID Connect](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) - OIDC implementation guidance (recommended)

**For IT administrators:**
- [Plan a single sign-on deployment](plan-sso-deployment.md) - Organizational SSO planning guidance
