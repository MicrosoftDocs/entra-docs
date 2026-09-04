---
title: Analyze Azure AD B2C custom policies for Microsoft Entra External ID migration
description: Use the Migration Policy Analyzer to scan Azure AD B2C custom policies and generate a detailed migration assessment for Microsoft Entra External ID. Start your migration today.
#customer intent: As an IT admin managing Azure AD B2C custom policies, I want to run the Migration Policy Analyzer against my policies so that I can scope the work required to migrate to Microsoft Entra External ID.
author: garrodonnell
ms.author: godonnell
ms.reviewer: godonnell
ms.date: 07/02/2026
ms.topic: how-to
ai-usage: ai-assisted
---

# Analyze Azure AD B2C custom policies for migration to Microsoft Entra External ID

The Migration Policy Analyzer is available directly in your Azure AD B2C tenant. It scans your custom policies and produces a migration assessment for Microsoft Entra External ID, mapping each detected feature to a migration path so you can scope the work required to move from Azure AD B2C to External ID.

In this article, you learn how to:

- Run the analyzer against your Azure AD B2C tenant.
- Interpret the feature detection results and migration statuses.
- Choose the right migration path for each detected feature.
- Account for analyzer limitations and known issues.

## Prerequisites

- A valid Azure AD B2C tenant with custom policies uploaded.
- Azure portal access with the B2C IEF Policy Administrator or Global Administrator role.

> [!NOTE]
> The analyzer works with custom policies only. User flows don't require analysis because they map directly to External ID user flows.

## Run the analyzer

To analyze your custom policies, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com) and go to your Azure AD B2C tenant.
1. Select **Identity Experience Framework** from the left menu.
1. Select **Migration Policy Analyzer** from the toolbar.
1. Select the policies to analyze. Your selection must include a relying party (RP) policy for the analysis to complete successfully.
1. Select **Analyze Policies** to start the assessment.

When the analysis completes, the report shows:

- The total number of features detected in your policies.
- Each feature's migration status and recommended path.

## What the analyzer detects

The analyzer scans your custom policies and groups detected features into categories such as Sign-Up, Sign-In, Session & Access Control, Password Management, Token & Claims, UX & Branding, and others. Categories might evolve as the tool adds new detections.

What matters is what you take away from the report:

| What you learn | Why it matters |
|----|----|
| **Which features your policies use** | Understand the full scope of what needs to migrate. |
| **Migration status for each feature** | Know immediately what works in External ID today vs. what needs custom development or isn't yet supported. |
| **Recommended migration path** | Each feature maps to a specific action: configure natively, build with custom authentication extensions, use the Native Authentication SDK, or call the Microsoft Graph API. |
| **Documentation links** | Every migration path links directly to the relevant Microsoft Learn guide so you can start implementing. |

When you're ready to act on the results, see [Plan your migration from Azure AD B2C to External ID](https://aka.ms/b2c-migration-guide) for end-to-end tooling, user migration patterns, and step-by-step cutover guidance.

## Understand the analysis report

The report contains two sections:

| Section | What it shows |
|----|----|
| Migration Summary | Total features detected and how many are available natively in External ID. |
| Feature Details | Each detected feature with its migration status, recommended path, and relevant documentation. |

Example summary output:

```text
Migration Summary
---
Features detected: 42
Available (External ID built-in): 28
Custom Development Required: 12
Not Currently Supported: 2
Architecture Incompatible: 0
```

> [!NOTE]
> The numbers shown are illustrative. Your results vary based on the complexity of your custom policies.

> [!IMPORTANT]
> Analyzer output is a best-effort assessment. Review each detected feature and its recommended migration path manually before you act on it, and validate the results against your own policies and business requirements before making migration decisions.

You can download the results as JSON from the API response or copy the formatted report from the portal UI.

## Interpret migration statuses

Each detected feature is assigned one of four migration statuses:

| Status | Meaning | Action required |
|----|----|----|
| Available | Works natively in External ID today&mdash;GA, documented, production-ready. | Configure in External ID; no custom development needed. |
| Custom Development Required | Achievable via custom authentication extensions, Native Authentication SDK, or Microsoft Graph API. | Follow the recommended migration path; you own the implementation. |
| Not Currently Supported | No current equivalent, or only in preview&mdash;no committed timeline. | Monitor the Microsoft Entra roadmap for updates. |
| Architecture Incompatible | Fundamental pattern mismatch&mdash;the Azure AD B2C approach doesn't translate directly. | Review the alternative architecture documentation; plan a different design. |

## Choose a migration path

### Built-in External ID features

These features work out of the box in Microsoft Entra External ID with no custom code. Configure them through the Microsoft Entra admin center or the Microsoft Graph API. Examples: email/password sign-up, social identity provider federation (Google, Facebook, Apple), enterprise SAML/OIDC, email OTP, custom attributes, branding, custom domain, Conditional Access, and Keep Me Signed In (KMSI).

### Native Authentication SDK or custom UI

Use this path when you need full UX control beyond the built-in hosted experience&mdash;for example, custom HTML/CSS/JS pages, multi-step registration wizards, or embedded authentication flows.

| Platform | Solution | Documentation |
|----|----|----|
| Mobile (iOS/Android) | Native Authentication SDK | [Native authentication concept](/entra/external-id/customers/concept-native-authentication) |
| Single-page apps | MSAL.js with custom UI | [Configure SPA authentication](/entra/external-id/customers/tutorial-single-page-app-vanillajs-configure-authentication) |

### Custom authentication extensions

Use [custom authentication extensions](concept-custom-extensions.md) to replace server-side logic that ran in B2C REST API technical profiles or complex claims transformations. They call external APIs during token issuance events and support claims enrichment, custom MFA providers, validation logic, orchestration branching, conditional claim issuance, and forced password reset.

### Microsoft Graph API or app-side logic

Move user management and application-level logic from B2C policies into your application by using the [Microsoft Graph API](/graph/api/resources/identityuserflowattribute). Typical scenarios: profile editing, progressive profiling, account linking, username changes, attribute management, account lockout, and impersonation.

### Platform roadmap

Some features don't yet have an equivalent in External ID&mdash;typically newer authentication methods or niche protocols such as QR code authentication, WS-Federation, SAML artifact binding, inbound SAML encryption, and CAPTCHA on sign-in. Passkeys (FIDO2) are now available for sign-in and MFA. Track updates on the [Microsoft Entra roadmap](https://aka.ms/entra-roadmap).

## Limitations and known issues

| Limitation | Details | Workaround |
|----|----|----|
| Custom policies only | Built-in user flows aren't analyzed. | User flows map directly to External ID, so no analysis is needed. |
| Single tenant at a time | The analyzer can't process policies across multiple B2C tenants in one session. | Run the analyzer separately for each tenant. |
| No runtime behavior analysis | The analyzer reads XML structure, not runtime execution. | Test critical flows in External ID after migration. |
| English output only | Results are in English regardless of policy language. | Localization is planned. |
| Extension properties | Custom extension attributes are detected, but schema compatibility isn't validated. | Verify extension attribute mapping manually in External ID. |

## Troubleshooting

### Analysis returns a CallerError

**Symptom**: The API returns a `CallerError` result type.

**Cause**: The selected policies contain invalid XML or reference missing base policies that aren't uploaded to the tenant.

**Resolution**:

- Verify that all policies compile successfully in the Identity Experience Framework before you analyze them.
- Ensure that the base policies (`TrustFrameworkBase`, `TrustFrameworkExtensions`) are uploaded.
- Check for XML encoding issues in your policy files.

### Features aren't detected that should be

**Symptom**: You know a feature exists in your policies, but the analyzer doesn't report it.

**Cause**: The feature might use a nonstandard implementation pattern, or detection relies on a base policy that wasn't included in the analysis.

**Resolution**:

- Include all policy files in the analysis (base, extensions, and relying parties).
- Verify that the feature uses standard B2C XML patterns rather than inline JavaScript or custom handlers.

### Report shows features you don't use

**Symptom**: The report lists features such as *Orchestration Branching* or *Claims Transformation* that seem generic.

**Cause**: These features are structural patterns present in most custom policies. The analyzer reports what it detects in the XML, which includes foundational patterns used by all custom policies.

**Resolution**:

- Focus on features with *Custom Development Required* or *Not Currently Supported* status.
- Use the migration path column to prioritize your planning.

### Insufficient permissions error

**Symptom**: Access is denied when you try to run the analyzer.

**Resolution**:

- Ensure you have the B2C IEF Policy Administrator or Global Administrator role.
- Verify that your account is in the correct B2C tenant directory.
- Check that Conditional Access policies aren't blocking portal access.

## Frequently asked questions

### Is the analyzer free?

Yes. The Migration Policy Analyzer is included with your Azure AD B2C tenant at no additional cost. There's no separate sign-up, install, or license required.

### Does the analyzer modify my policies or tenant?

No. The analyzer operates in read-only mode. It reads your policy XML files, processes them in memory, and returns results. It doesn't change your tenant, policies, or user data.

### How often should I run the analyzer?

Run the analyzer at the start of migration planning for your baseline, after you change B2C policies in ways that affect migration scope, and periodically after External ID product updates to check whether new capabilities have become available.

### Can I export the analysis report?

Yes. You can download the analysis results as JSON from the API response, or copy the formatted report from the portal UI.

### What if a feature shows *Not Currently Supported*?

Features in this status don't have a current migration path. You can:

- Monitor the [Microsoft Entra roadmap](https://aka.ms/entra-roadmap) for updates.
- Evaluate whether the feature is critical for your launch or can be deferred.
- Contact your Microsoft account team for timeline guidance on specific features.

### Does the analyzer support multi-tenant analysis?

No. The analyzer runs against one B2C tenant at a time. If you manage multiple tenants, run the analysis separately for each.

## Ready to begin your migration?

Once you review your analyzer results and understand the migration paths for your detected features, these resources help you take the next step:

| What you need | Resource |
|----|----|
| End-to-end migration planning (standard and HSC mode) | [Plan your migration from Azure AD B2C to External ID](https://aka.ms/b2c-migration-guide) |
| Create your External ID tenant | [Create an external tenant](how-to-create-external-tenant-portal.md) |
| Choose browser-delegated vs. native authentication | [Choose an authentication approach](/entra/external-id/customers/concept-choose-authentication-approach) |
| Build custom authentication extensions for custom logic | [Custom authentication extensions overview](/entra/identity-platform/custom-extension-overview) |
| Migrate users and credentials | [Plan your migration from Azure AD B2C to External ID](https://aka.ms/b2c-migration-guide) |
| Understand service limits and rate constraints | [Service limits and restrictions](reference-service-limits.md) |

## Related content

- [Plan your migration from Azure AD B2C to External ID](https://aka.ms/b2c-migration-guide)
- [Microsoft Entra External ID overview](overview-customers-ciam.md)
- [Native authentication](/entra/external-id/customers/concept-native-authentication)
- [Custom authentication extensions](concept-custom-extensions.md)
- [Microsoft Entra roadmap](https://aka.ms/entra-roadmap)
