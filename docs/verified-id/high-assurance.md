---
title: Microsoft Entra High Assurance
description: Plan Microsoft Entra high assurance scenarios for identity-verified onboarding, resource access, risk remediation, and account recovery.
author: tilarso
ms.author: tilarso
contributors: rogulati
ms.topic: concept-article
ms.date: 11/10/2026
ms.custom: msecd-doc-authoring-108
ai-usage: ai-generated
#customer intent: As an identity architect, I want to understand high assurance scenarios so that I can choose the supported Microsoft Entra capabilities for onboarding, access, and recovery.
---

# Microsoft Entra high assurance overview

Microsoft Entra high assurance is a scenario across Microsoft Entra products that connects identity verification with supported onboarding, credential registration, protected access, risk remediation, and account recovery. It helps you ensure the right person is accessing the intended account across the lifecycle of the user, including capabilities to record and review verification history along with details on how a credential was registered.

This overview describes the preview scope and connects you to the product-owned configuration guides. Identity verification supports these journeys; it isn't itself an authentication method or a replacement for sign-in, MFA, or self-service password reset.

## Supported journeys

Use the journey to choose its configuration and policy owner.

| Journey | Purpose | Product-owned guidance |
| --- | --- | --- |
| Identity-verified onboarding | Verify the new hire before credential bootstrap, with Lifecycle Workflows orchestration. | [Onboard users with identity verification](../id-governance/how-to-onboard-users-with-identity-verification.md). |
| Verification for resource access | Require identity verification after initial authentication for a protected resource or action. | [Conditional Access identity verification policy](../identity/conditional-access/policy-require-identity-verification.md#configure-a-resource-access-policy). |
| Risk remediation | Require verification when a supported user-risk or sign-in-risk condition applies. | [Identity verification for risk](../id-protection/concept-identity-protection-policies.md#identity-verification-for-risk). |
| Account recovery | Verify account ownership when existing authentication methods are unavailable, then register replacement credentials. | [Account recovery overview](../identity/authentication/concept-account-recovery-overview.md). |

Onboarding and recovery establish or restore credentials. They aren't substitutes for ordinary resource-access policies. Conditional Access can add security to those flows through the onboarding and recovery action.

## Shared verification profiles

An identity verification profile connects the scenario to its provider, accepted credential, account-validation configuration, and user scope. Configure shared profiles before the workflow or policy that uses them.

The [identity verification profile overview](../identity/authentication/concept-authentication-verified-id.md) is the authoritative home for profile setup and the [credential/scenario matrix](../identity/authentication/concept-authentication-verified-id.md#credential-support-by-scenario). Link to that matrix when planning a journey rather than maintaining separate eligibility tables.

Creating a profile automatically enables tenant-wide collection of users' identity verification history. Review the profile article's [collection prerequisites](../identity/authentication/concept-authentication-verified-id.md#prerequisites) before reviewing status and history.

## Verification and credential registration

To establish a high-assurance passkey, complete identity verification as part of a supported credential-registration journey. The passkey's recorded provenance connects the new registration to the verified identity and records its credential assurance classification.

Use [credential provenance and assurance classification](../identity/authentication/concept-authentication-passkeys-fido2.md#credential-assurance-classification-preview) to understand the individual passkey's **Low**, **Medium**, or **High** assurance. Use [identity verification status and history](../identity/authentication/concept-authentication-methods-manage.md#identity-verification-status-and-history) to review the account-level verification evidence. During preview, credential assurance classification and provenance are available only for passkeys.

New passkeys registered through supported identity-verified onboarding, recovery, or other registration journeys have **High** assurance when their chain of trust is intact. An existing passkey used with identity verification has **Medium** assurance. Expiration or invalidation of supporting identity verification lowers affected **High** and **Medium** passkeys to **Low**. Successful reverification restores their previous level without requiring new registration for a previously **High** passkey. These changes affect only passkeys whose provenance relies on that verification. See the [credential assurance lifecycle](../identity/authentication/concept-authentication-passkeys-fido2.md#credential-assurance-lifecycle) for the differences between these journeys and changes to trust.

Credential issuance gives a user a credential. Presentation uses an existing credential to satisfy a verification request. Successful issuance alone doesn't establish that the user completed the originating challenge or gained access.

For protected resource access, verification follows initial authentication and precedes additional MFA or authentication-strength requirements. A user who needs a credential uses the supported inline issuance path from the verification challenge.

Successful recovery records verification history on the user's account. When a user registers a passkey during recovery, provenance is recorded on that credential. Administrators use verification status and history to understand how a passkey was established and should be trusted.

During preview, credential provenance is recorded only for passkey credentials. Reporting doesn't provide credential-provenance policy enforcement or establish that every credential on a verified account has the same provenance. See [user verification status and history](../identity/authentication/concept-authentication-methods-manage.md#identity-verification-status-and-history), [passkey credential provenance](../identity/authentication/concept-authentication-passkeys-fido2.md#credential-provenance), and [identity verification reporting](../identity/authentication/howto-authentication-methods-activity.md#identity-verification-reporting) for the product-owned evidence guidance.

## Preview limitations

Plan each scenario against its supported configuration:

- **Cloud availability:** During preview, high assurance scenarios are available only in the Microsoft public cloud. National and sovereign clouds aren't supported.
- **Credential eligibility:** Use the shared profile matrix. Employee ID presentation support doesn't establish support for Employee ID inline issuance or risk remediation.
- **Authenticator and Android work profiles:** Review [Authenticator preview prerequisites](../identity/authentication/how-to-enable-authenticator-passkey.md#identity-verified-onboarding-and-recovery-during-preview) before onboarding or recovery. Android Management API (AM API) users should complete those journeys with TAP issuance rather than being required to set up a passkey. For identity verification step-up with a device-compliance requirement, review the [Android Management API (AM API) and Enterprise Mobility Management API (EMM API) compatibility guidance](../identity/conditional-access/policy-require-identity-verification.md#android-work-profile-compatibility-during-preview).
- **Onboarding and recovery policies:** Terms of use, authentication strength, and most other Microsoft Entra-specific controls aren't supported for this user action. There's no current plan or timeline to add support. These limitations don't remove support in ordinary resource-access policies. See [control limitations](../identity/conditional-access/policy-require-identity-verification.md#review-control-limitations).
- **Recovery registration:** When passkey attestation is required, TAP-free registration is supported only on Android. iOS continues to receive a Temporary Access Pass (TAP), even with issuance turned off. Review [account recovery setup](../identity/authentication/how-to-account-recovery-enable.md); don't assume recovery platform behavior also applies to onboarding.
- **Risk outcomes:** Successful identity verification remediates user risk or sign-in risk, depending on the risk condition in the triggering policy. Failed verification doesn't remediate risk. Risk-based Conditional Access policies currently don't apply to onboarding actions. Review verification completion, the access decision, and the risk record separately. **Require risk remediation** is a distinct adaptive control.
- **Evaluation:** Report-only mode evaluates which policies could apply without triggering identity verification. Identity-verified onboarding and account recovery still require identity verification independently of Conditional Access policy requirements. Use the [CA walkthrough](../identity/conditional-access/policy-require-identity-verification.md) to plan testing.

<!-- TODO: Confirm tenant rollout, supported clients, final roles, portal labels, and released telemetry before publication. This overview doesn't establish GA or universal tenant availability. -->

## Deployment sequence

Build the shared foundation before enabling individual journeys:

- **Profiles and eligibility:** Configure the provider or issuer, account-validation rules, profile purpose, and user scope using the profile guide.
- **Product configuration:** Prepare Lifecycle Workflows, recovery settings, or risk policy configuration for the selected journey.
- **Policy boundaries:** Configure the applicable Conditional Access policy. Review bootstrap conflicts, exclusions, emergency access, and control limitations together.
- **Pilot validation:** Test successful and unsuccessful verification, issuance, registration, access, and remediation outcomes as applicable. Record support and rollback paths before expanding scope.
- **Operations:** Review product-owned workflow history, sign-in records, [Verified ID audit activities](../identity/monitoring-health/reference-audit-activities.md#verified-id), and user verification evidence. Keep identity documents and biometric material out of troubleshooting tickets.

## Licensing

Requirements vary by capability. Use [identity verification licensing](../fundamentals/licensing.md#identity-verification) and the licensing prerequisites in each product guide rather than assuming one scenario's entitlement covers every journey.

## Related content

- [Identity verification profiles](../identity/authentication/concept-authentication-verified-id.md).
- [Conditional Access identity verification policy](../identity/conditional-access/policy-require-identity-verification.md).
- [Lifecycle Workflows onboarding](../id-governance/tutorial-onboard-custom-workflow-portal.md).
- [Account recovery setup](../identity/authentication/how-to-account-recovery-enable.md).
- [Risk remediation](../id-protection/howto-identity-protection-remediate-unblock.md).
- [Microsoft Entra audit activities](../identity/monitoring-health/reference-audit-activities.md).
