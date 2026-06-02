---
title: Account Recovery Overview in Microsoft Entra ID
description: Account recovery in Microsoft Entra ID enables users to regain access through identity verification when all authentication methods are lost. Learn how it works.
author: tilarso
ms.author: tilarso
ms.service: entra-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-108, msecd-doc-authoring-1012
ms.date: 04/29/2026

#customer intent: As an identity administrator, I want to understand how account recovery works in Microsoft Entra ID so that I can evaluate whether to deploy it for users who lose all their authentication methods.

---

# Account recovery overview

Account recovery is a Microsoft Entra ID capability that enables users to regain access to their organizational accounts when they lose all registered authentication methods — such as when a primary device is lost, stolen, or compromised. Unlike self-service password reset (SSPR), which requires users to retain at least one authentication method, account recovery re-establishes trust in a user's identity through third-party identity verification before restoring access.

Account recovery replaces manual helpdesk-led recovery with automated identity proofing. Traditional helpdesk recovery is vulnerable to social engineering attacks where bad actors manipulate support staff into illegitimately granting access. Account recovery eliminates this attack vector by using government-issued identification and biometric verification through certified identity verification providers.

## Account recovery fundamentals

Account recovery is an authentication recovery mechanism for scenarios where users face complete authentication lockout — all registered methods are unavailable, and traditional self-service options can't help.

### Key characteristics

- **Identity-centric** — Shifts recovery from _what you know_ (passwords) and _what you have_ (devices, security keys) to _who you are_ through comprehensive identity verification using government-issued ID and biometrics.
- **Trust re-establishment** — Treats recovery as a re-onboarding scenario. The organization verifies and re-establishes trust in the user's identity before granting access to register new authentication methods.
- **Built on Verified ID** — Uses Microsoft Entra Verified ID and Face Check alongside third-party identity verification providers available through the Microsoft Security Store.
- **Profile-based configuration** — Admins create identity verification profiles that define recovery behavior per user population — including which provider performs verification, what recovery mode applies, and how account validation works.

### When to use account recovery

- **Device loss or theft** — A user loses the phone or security key that contains their authenticator app, passkey, or other authentication methods.
- **Complete authentication lockout** — All registered authentication methods become unavailable simultaneously.
- **Account compromise response** — A security incident requires a complete authentication method reset as part of incident response.

### Account recovery compared to self-service password reset

Although account recovery and SSPR both restore user access, they address different scenarios:

| Aspect | Self-service password reset (SSPR) | Account recovery |
|---|---|---|
| **Primary use case** | User forgot password but retains access to authentication methods | User lost access to all authentication methods |
| **Authentication requirement** | At least one registered method (policy can require up to two) | Identity verification through a certified provider |
| **Trust assumption** | User's identity is verified through existing methods | User's identity must be re-established |
| **Recovery scope** | Password only | Complete authentication method reset |
| **Technology dependency** | Existing MFA methods | Identity verification services, Verified ID |
| **Security level** | Medium — relies on pre-registered methods | High — requires comprehensive identity proofing |

### Business benefits

- **Reduced helpdesk burden** — Secure self-service recovery for total lockout scenarios reduces high-priority support tickets that require manual intervention.
- **Improved user experience** — Users recover accounts independently without waiting for helpdesk availability, reducing downtime during critical situations.
- **Stronger security posture** — Identity verification provides stronger assurance than traditional recovery methods that rely on social engineering-vulnerable information.
- **Scalable for remote work** — Organizations support distributed workforces without requiring physical presence or complex manual verification.

> [!TIP]
> The Account Recovery overview page in the Microsoft Entra admin center includes a **cost savings estimator** that helps organizations project potential savings by comparing traditional helpdesk recovery costs against self-service account recovery.

## How account recovery works

Account recovery operates through a structured identity verification and trust re-establishment process that starts at sign-in.

### Core components

- **Identity verification providers (IDV)** — Trusted third-party services that validate user identity using government-issued documents, biometric verification, and other high-assurance methods. These providers issue verifiable credentials that attest to the user's verified identity. Providers are available through the [Microsoft Security Store](https://securitystore.microsoft.com/).

- **Microsoft Entra Verified ID** — The decentralized identity service that enables users to present cryptographically secure identity credentials during recovery. These credentials provide tamper-evident proof of identity verification without exposing sensitive personal information. For more information, see [Introduction to Microsoft Entra Verified ID](/entra/verified-id/decentralized-identifier-overview).

- **Identity verification profiles** — Configuration objects in the Microsoft Entra admin center that define how account recovery works for a specific group of users. Each profile specifies the recovery mode, target user groups, identity verification provider, and account validation rules. Organizations can create multiple profiles to support different user populations with different requirements.

- **Custom authentication extensions** — Optional Azure Function, Logic App, or REST API endpoints that add organization-specific account validation logic during recovery. Verified claims from the identity verification provider are passed to the extension, which validates them against organizational data such as HRIS systems or employee directories. Extensions should use managed identities or other secretless authentication for service-to-service communication. All data processed by the extension stays within the organization's trust boundary — no organizational data is shared with Microsoft.

### Recovery flow

The account recovery process combines multiple verification layers to ensure that only legitimate account owners regain access.

### Account discovery

The user provides their account identifier at sign-in and indicates they can't access their account. The system checks whether the account is eligible for recovery based on the identity verification profiles configured by the tenant administrator, then directs the user to the appropriate identity verification provider.

### Identity verification

The user is redirected to the identity verification provider specified in their applicable profile. The provider verifies government-issued identification documents using advanced fraud detection. Liveness checks and facial recognition confirm the person is physically present. Upon successful verification, the user receives a verifiable credential (Verified ID) stored in Microsoft Authenticator.

### Credential validation

The user presents their newly acquired Verified ID to Microsoft Entra ID. The system validates the credential's authenticity and matches identity attributes from the credential against stored user profile information — first name and last name by default. If a custom authentication extension is configured in the profile, additional claim validation runs against organizational data.

### Access restoration

The user receives a Temporary Access Pass with limited validity and is guided through registering new authentication methods, such as passkeys.

## Identity verification profiles

Identity verification profiles are the central configuration object for account recovery. Each profile defines:

- **Profile name and description** — A friendly name to identify the profile's purpose.
- **Recovery mode** — Whether the profile operates in Evaluation mode (testing only — accounts are not recovered) or Production mode (full recovery enabled).
- **User group scope** — Which users the profile applies to, defined by included and excluded groups.
- **Identity verification provider** — The third-party provider that performs identity proofing for users in this profile.
- **Account validation rules** — How identity claims are matched against Entra user properties, including match confidence (exact or relaxed) and optional custom authentication extension validation.

Organizations create multiple profiles to address different requirements across their user populations. For example, a profile for corporate employees might use a different identity verification provider or stricter validation rules than a profile for frontline workers.

### Evaluation and production modes

Each identity verification profile operates in one of two modes:

- **Evaluation** — Users can test the identity verification flow to confirm it works correctly. Accounts are **not** recovered in this mode. Use Evaluation mode to validate the experience with a small group before enabling full recovery.
- **Production** — Users who complete identity verification can fully recover their accounts, receive a Temporary Access Pass, and re-enroll authentication methods.

Start with Evaluation mode for new profiles to confirm the identity verification flow works for your users and policies before switching to Production.

> [!NOTE]
> Identity verification involves processing government-issued documents and biometric data through third-party providers. Review your organization's privacy, data retention, and regional compliance requirements before deploying account recovery.

### Account validation and custom authentication extensions

By default, account recovery matches identity claims from the verification provider against the user's **First name** and **Last name** properties in Microsoft Entra ID. Admins can configure the match confidence level:

- **Exact** — Claims must match exactly.
- **Relaxed** — Allows minor variations in name matching.

> [!TIP]
> For sensitive user populations, consider enabling a custom authentication extension to validate additional claims beyond first and last name. Default name-only matching may not provide sufficient assurance for high-risk accounts.

For organizations that need stronger validation, custom authentication extensions add a second layer of account matching. During recovery, verified claims from the identity verification provider are passed to an organization-owned endpoint — an Azure Function, Logic App, or REST API — which validates them against authoritative data sources such as:

- HRIS systems (employee records)
- Employee directories
- Badge management systems
- Other organization-owned data stores

> [!IMPORTANT]
> Data processed by the custom authentication extension stays within the organization's trust boundary. No organizational data is shared with Microsoft — only the match result is returned to the account recovery flow.

## Next steps

Account recovery takes about 5–10 minutes to set up. Start in Evaluation mode so you can validate the experience before enabling production recovery. To get started, see [Enable and configure account recovery in Microsoft Entra ID](how-to-account-recovery-enable.md).

## Related content

- [Enable and configure account recovery in Microsoft Entra ID](how-to-account-recovery-enable.md)
- [How end users can perform account recovery in Microsoft Entra ID](how-to-account-recovery-for-users.md)
- [Frequently asked questions about Microsoft Entra ID account recovery](self-service-account-recovery.yml)
- [What is Microsoft Entra Verified ID?](/entra/verified-id/decentralized-identifier-overview)
- [Enable the Temporary Access Pass policy](howto-authentication-temporary-access-pass.md)
- [How it works: Microsoft Entra self-service password reset](concept-sspr-howitworks.md)
