---
title: Verified ID identity verification overview in Microsoft Entra ID
description: Learn how centralized identity verification profiles, profile purposes, and modes support onboarding, recovery, and access verification in Microsoft Entra ID.
ms.reviewer: tilarso
ms.service: entra-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-108
ms.date: 11/03/2026
author: tilarso
ms.author: tilarso
ai-usage: ai-assisted

#customer intent: As an identity administrator, I want to understand how Verified ID identity verification works in Microsoft Entra ID so that I can evaluate how identity verification profiles apply to users in my organization.

---

# Verified ID identity verification overview

Verified ID is an identity verification capability in Microsoft Entra ID —  it provides a cryptographic proof of a user's verified identity but can't be used to satisfy authentication requirements like sign-in, MFA, or SSPR. Instead, Verified ID serves as the identity proofing layer for scenarios where a user's identity must be re-established — such as account recovery when all authentication methods are lost.

Identity verification profiles control which users can participate in these flows, which verification method is used, and how identity claims are validated. Profiles support account recovery, onboarding, and verification for access.

## Prerequisites

During preview, identity verification profiles and their integrated journeys are available only in the Microsoft public cloud, not in national or sovereign clouds.

To view users' identity verification status and history, enable tenant-wide **Collect identity verification history** in the authentication methods policy under **Authentication methods** > **Verified ID** > **Configure** > **Data collection**.

:::image type="content" source="media/concept-authentication-verified-id/collect-identity-verification-history.png" alt-text="Screenshot of the Verified ID Configure tab with Collect identity verification history enabled under Data collection." lightbox="media/concept-authentication-verified-id/collect-identity-verification-history.png":::

> [!NOTE]
> Creating an identity verification profile automatically enables **Collect identity verification history** across your tenant. You don't need to enable collection separately when you create a profile.

Identity verification history collection becomes available when the setting is enabled. For the user-level views, see [Identity verification status and history](concept-authentication-methods-manage.md#identity-verification-status-and-history).

To view a user's identity verification status and history, use at least the [Security Reader](../role-based-access-control/permissions-reference.md#security-reader) role.

Before creating a profile:

- Identify whether you need recovery, onboarding, or verification for access.
- For recovery, complete the Verified ID, Face Check, provider subscription, and account-matching preparation in [Enable and test account recovery](how-to-account-recovery-enable.md).
- Identify the users to include in your evaluation.
- Confirm that your tenant has access to shared profiles and that you have at least the [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role to manage them.
- Microsoft Entra ID P1 or an eligible higher license for identity verification profiles. Review the [identity verification licensing requirements](../../fundamentals/licensing.md#identity-verification) for your scenario.

<!-- TODO: Confirm minimum permissions to change collection settings or access reporting beyond user-level status/history, collection latency, backfill, retention, and the effect of turning collection off. Don't infer these behaviors from enabling collection. -->

## Identity verification profiles

An identity verification profile is a configuration object that defines identity verification behavior for a group of users. Profiles specify:

- **Name and description** — A display name and description that identify the profile.
- **Profile purpose** — The scenario the profile supports: **All**, **Verification**, **Onboarding**, or **Recovery**. See [Credential support by scenario](#credential-support-by-scenario).
- **Profile mode** — Whether the profile operates in **Evaluation** or **Production** mode.
- **User group scope** — Which users the profile applies to, defined through group-based assignment.
- **Verification method** — The identity verification provider or supported tenant-issued credential used for the selected purpose.
- **Face Check configuration** — Settings for Microsoft Entra Verified ID Face Check behavior during verification.
- **Profile configuration** — The accepted credential issuer, how identity claims map to user properties, and the credential type for the exchange.
- **Priority** — The processing order when a user matches multiple profiles.

### Profile mode

Use **Profile mode** to test identity verification or make it operational for the selected **Profile purpose**.

| Mode | Behavior |
| --- | --- |
| **Evaluation** | The scenario can invoke identity verification, but verification doesn't complete the handoff to onboarding, account recovery, or resource access. |
| **Production** | Identity verification is fully operational for the selected profile purpose, enabling the handoff to the corresponding onboarding, account recovery, or resource-access journey. |

Successful verification in **Evaluation** mode doesn't mean onboarding or recovery completed or access was granted.

### Credential support by scenario

Choose the purpose before selecting a verification method: **All**, **Verification**, **Onboarding**, or **Recovery**. Use this matrix to choose a credential for your scenario. Confirm release availability in your tenant before deployment.

| Credential | All-purpose profile | Verification for access | Recovery | Onboarding |
| --- | --- | --- | --- | --- |
| Employee ID | Not supported. | Supported. | Not supported. | Not supported. |
| Custom-issued Verified ID | Not supported. | Supported. | Not supported. | Not supported. |
| Third-party Verified ID from Security Marketplace | Supported. | Supported. | Required. | Required. |

For recovery, keep the third-party provider and account-matching requirements. Don't substitute an employee credential or a custom-issued credential based only on the existence of a shared profile.

For resource-access verification, including risk-based policies, set **Profile purpose** to **All** or **Verification**. **All** supports identity verification providers only. To use tenant-issued credentials, select **Verification**. **Onboarding** and **Recovery** purposes are for their respective bootstrap journeys.

<a id="automatic-creation-through-account-recovery"></a>
<a id="profile-creation-in-microsoft-entra-verified-id"></a>
<a id="profile-management-in-authentication-method-policy"></a>
<a id="shared-identity-verification-profiles"></a>

## Create and manage identity verification profiles

Create and manage profiles in the Microsoft Entra admin center under **Verified ID** > **ID verification profiles** > **Profiles**. On **Getting started**, review the setup checklist and select **Create your first identity verification profile**. If profiles already exist, select **Profiles** > **Create profile** instead.

Enter a **Name** and **Description**, select **Profile purpose**, and choose **Profile mode**. The shared wizard also includes user groups, the verification method, account validation, optional custom claim validation, and self-service issuance settings. Review those settings before completing profile creation.

For recovery, use your subscribed identity verification provider and check the user's **First name** and **Last name** against the claims returned by that provider. Review any custom claim-validation extension with its owner before using it.

<a id="confirm-user-scope-and-profile-priority"></a>
<a id="multiple-profiles"></a>

### User scope and profile selection

Configure user scope in the shared-profile wizard. Use **Include** > **Select targets** > **Select groups** to start with an evaluation group.

> [!IMPORTANT]
> Exclusions apply globally across all identity verification profiles, not just the profile you're creating or editing. Groups excluded here are also reflected in the Verified ID authentication methods policy's **Exclude** settings. Don't use **Exclude** to remove a group from only one profile; use that profile's **Include** assignments to define its scope.

These profile exclusions are separate from the [Conditional Access onboarding and recovery exclusion](../conditional-access/policy-require-identity-verification.md#enable-the-global-onboarding-and-recovery-exclusion-preview).

Use multiple profiles for different user populations, verification providers, or pilot groups. When a user belongs to groups that match multiple profiles, the system evaluates profiles in priority order and applies the first matching profile.

Lower priority numbers are evaluated first: priority 1 precedes priority 5. Priority numbers are unique, so ties aren't possible.

### Review self-service issuance

Review whether to enable self-service issuance, the approved user scope, and the custom credential issuance destination before enabling the experience. My Account self-service issuance is separate from inline issuance during a protected journey. Don't assume that provider issuance destinations follow the same rules as custom credential destinations.

### Keep recovery settings separate

Profile creation is separate from enabling the tenant's Account recovery policy and choosing actions after recovery. Configure those settings under **Account recovery**, not in the shared profiles blade. Temporary Access Pass (TAP) issuance is on by default. TAP-free registration and stale-credential cleanup are preview choices.

For account recovery setup, see [Enable and configure account recovery](how-to-account-recovery-enable.md). Creating a profile alone doesn't establish that the TAP-free path is supported for your users.

### Test and manage the profile

> [!NOTE]
> Changes to identity verification profiles can take 5-10 minutes to apply. After saving changes, allow time for them to take effect before testing the affected journey.

Validate the profile before expanding your deployment:

- Confirm that the intended profile appears with the expected purpose and verification method.
- Test with a user in the intended scope and confirm that the expected provider handles verification.
- For recovery, test account matching and confirm that evaluation doesn't restore account access.
- Check that an out-of-scope user doesn't receive the intended recovery offer, using the eligibility guidance in [the recovery user article](how-to-account-recovery-for-users.md).
- Review the Conditional Access scope for your scenario with the policy owner.
- Before enabling the profile for production users, set **Profile mode** to **Production** and test the complete journey for the selected **Profile purpose**.

### Troubleshoot an unavailable identity verification profile

During onboarding, account recovery, or identity verification step-up, a user can receive the following sign-in error when no valid identity verification profile is available to them:

`AADSTS10020005: No valid VidProfile data found for the tenant.`

The message doesn't necessarily mean that the tenant has no profiles. Check whether a valid profile is available for the affected user and scenario:

- Confirm that the intended profile exists and supports the scenario and credential type. See [Credential support by scenario](#credential-support-by-scenario).
- Review the user's group assignments and applicable exclusions in the profile and Verified ID authentication method policy.
- Confirm that Verified ID is enabled for the intended users and review the saved profile configuration.

After correcting the configuration, test the affected journey again with the user. The [global Conditional Access exclusion](../conditional-access/policy-require-identity-verification.md#enable-the-global-onboarding-and-recovery-exclusion-preview) doesn't supply a missing profile and isn't a workaround for this error.

If you're an end user, contact your organization's support team with the error code, request ID, correlation ID, and timestamp from **Troubleshooting details**. Don't send identity documents, biometric images, or Temporary Access Pass values. Administrators can use those diagnostic details when escalating an unresolved error.

## Usage scenarios

A profile supplies identity verification. Each scenario also needs its own configuration.

### Account recovery

Account recovery helps users who lose all registered authentication methods regain access through identity verification. For scenario setup, see [Enable and configure account recovery in Microsoft Entra ID](how-to-account-recovery-enable.md).

> [!NOTE]
> Identity verification providers are external services available through the Microsoft Security Store. Review your provider's privacy, data retention, and compliance policies before deploying a profile to production users.

### Onboarding and verification for access

| Scenario | Purpose | Where to start |
| --- | --- | --- |
| Integrated onboarding | Complete required identity verification before access and passkey bootstrap, with Lifecycle Workflows orchestration. | [Onboard users with identity verification](../../id-governance/how-to-onboard-users-with-identity-verification.md). |
| Verification for access | Require identity verification after initial authentication for a protected resource or action. | [High assurance overview](../../verified-id/high-assurance.md). |

> [!IMPORTANT]
> When you use this profile for identity verification during resource access, configure the associated Conditional Access policy's **Conditions** > **Client apps** to select **Browser** and **Mobile apps and desktop clients**. The default configuration includes legacy client types that aren't supported for identity verification step-up and can cause the verification flow to fail. See [Configure a resource-access policy](../conditional-access/policy-require-identity-verification.md#configure-a-resource-access-policy).

During preview, credential provenance is recorded only for passkey credentials. For more information, see [Passkey credential provenance](concept-authentication-passkeys-fido2.md#credential-provenance).

## Profile properties

For Microsoft Graph API properties and values, see [verifiedIdProfile resource type (beta)](/graph/api/resources/verifiedidprofile?view=graph-rest-beta&preserve-view=true). API property names, including `state`, aren't the profile creation controls described in this article.

## Face Check

Verified ID profiles include Face Check configuration to verify proof of presence during identity verification. Face Check compares the photo on the user's government-issued ID to a real-time biometric check, confirming the person presenting the credential is physically present.

Face Check requires a [Face Check license](/entra/verified-id/using-facecheck), available through Entra Suite or as a standalone license.

## Common questions

Review profile deletion behavior and supported user-level overwrites.

### How do I stop use of previously issued Verified IDs through a profile?

Delete the associated identity verification profile to stop use through that profile. Review the profile's dependencies before deleting it. Don't delete and recreate profiles merely to change navigation.

Deleting a profile doesn't mean deleting a credential from a user's wallet or revoking it with its issuer. Don't infer effects on unrelated verifiers, retained history, credential provenance, or existing sessions.

### Can administrators overwrite identity verification events and credential provenance?

Administrators can overwrite identity verification events and credential provenance. These operations are separate from the user completing identity verification and from deleting a shared profile. See [Manage identity verification for a user](concept-authentication-methods-manage.md#manage-identity-verification-for-a-user) and the [identity verification licensing requirements](../../fundamentals/licensing.md#identity-verification).

## Related content

- [Account recovery overview](concept-account-recovery-overview.md)
- [Enable and configure account recovery in Microsoft Entra ID](how-to-account-recovery-enable.md)
- [Frequently asked questions about account recovery](self-service-account-recovery.yml)
- [What is Microsoft Entra Verified ID?](/entra/verified-id/decentralized-identifier-overview)
- [verifiedIdProfile resource type (beta)](/graph/api/resources/verifiedidprofile?view=graph-rest-beta&preserve-view=true)
- [Identity verification status and history](concept-authentication-methods-manage.md#identity-verification-status-and-history).
