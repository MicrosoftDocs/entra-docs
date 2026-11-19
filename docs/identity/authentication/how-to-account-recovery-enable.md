---
title: Configure account recovery settings in Microsoft Entra ID
description: Enable the Account recovery policy in Microsoft Entra ID and configure actions after recovery, including Temporary Access Pass issuance and stale credential cleanup.
ms.reviewer: tilarso
ms.service: entra-id
ms.topic: how-to
ms.custom: sfi-ga-nochange, sfi-image-nochange, msecd-doc-authoring-108, msecd-doc-authoring-1012, msecd-doc-authoring-1026
ms.date: 11/13/2026
author: rogulati
ms.author: rogulati
ai-usage: ai-assisted
#customer intent: As an identity administrator, I want to enable account recovery and configure actions after recovery so that users can register replacement authentication methods after identity verification.
---

# Configure account recovery settings in Microsoft Entra ID

Account recovery settings control whether users can recover their accounts and how they register replacement authentication methods after identity verification. Use this article to enable the tenant's Account recovery policy, choose Temporary Access Pass (TAP) issuance and stale-credential cleanup settings, and test the recovery experience.

ID verification profiles are created and managed in Microsoft Entra Verified ID, separately from Account recovery settings.

Before you begin, prepare a recovery profile and confirm licensing, Face Check setup, and administrative permissions. See [Prerequisites](#prerequisites).

## Prerequisites

Before configuring recovery settings, prepare:

- A Microsoft Entra ID P1 license and the applicable [identity verification licenses](../../fundamentals/licensing.md#identity-verification).
- [Verified ID](../../verified-id/verifiable-credentials-configure-tenant-quick.md) enabled and [Face Check](../../verified-id/using-facecheck.md) configured in your tenant.
- The [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role to manage Account recovery settings.
- An ID verification profile for recovery, configured in Microsoft Entra Verified ID, and a dedicated test group.
- Microsoft Authenticator version 6.2610.7075 or later for Android, or version 6.8.58 or later for iOS, installed on users' devices.
- Supported replacement authentication methods enabled for the users in scope. For the TAP-based path, confirm that users are enabled for the Temporary Access Pass method.

<a id="open-account-recovery"></a>

## Open Account recovery settings

To open the settings blade:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with permission to manage recovery settings.
1. Go to **Entra ID** > **Account recovery**.
1. Open **Settings (preview)**.

<a id="subscribe-to-an-identity-verification-provider"></a>
<a id="create-an-identity-verification-profile"></a>
<a id="add-profile-details"></a>
<a id="choose-a-recovery-mode"></a>
<a id="select-user-groups"></a>
<a id="select-an-identity-verification-provider"></a>
<a id="configure-account-validation"></a>
<a id="review-and-finalize"></a>
<a id="manage-identity-verification-profiles"></a>
<a id="verify-user-profiles-are-ready-for-account-recovery"></a>
<a id="move-a-profile-from-evaluation-to-production"></a>
<a id="evaluate-proposed-shared-profile-management"></a>
<a id="manage-shared-identity-verification-profiles"></a>

## Configure an ID verification profile

Create and manage profiles in **Verified ID** > **ID verification profiles** > **Profiles**. For provider selection, user groups, profile mode, and account-validation steps, follow [Create an ID verification profile](../../verified-id/how-to-create-id-verification-profile.md). Select **Recovery** as the profile purpose.

Profile configuration isn't part of the Account recovery settings blade. Creating a profile doesn't enable the tenant's Account recovery policy or choose actions after recovery.

## Enable the Account recovery policy

In the new Account recovery policy experience, the policy is disabled by default for both new and existing tenants. Enable the policy before users can use account recovery.

If your tenant already uses account recovery from an earlier preview, you also need to enable the new policy to continue using the feature. Existing identity verification profiles alone don't enable the new policy.

To prepare tenant-level recovery:

1. In Account recovery settings, enable the tenant's Account recovery policy.
1. Confirm that the policy is enabled before testing recovery with users in scope.

Enabling the policy is separate from configuring actions after recovery, such as issuing a TAP or removing stale credentials. The default TAP issuance setting doesn't enable account recovery for your tenant.

<a id="evaluate-proposed-recovery-settings"></a>

## Configure recovery settings

Use **Actions after recovery** in Account recovery settings to choose how users register replacement methods. These settings are separate from tenant-level enablement and ID verification profile management.

First, [enable the Account recovery policy](#enable-the-account-recovery-policy). Confirm that the preview controls are available in your tenant before changing them.

| Setting | Behavior |
| --- | --- |
| **Issue Temporary Access Pass** on | Default for new and existing tenants. Successful account validation issues a TAP for the established registration flow. Stale-credential cleanup isn't available. |
| **Issue Temporary Access Pass** off | Explicit preview opt-in. Successful account validation grants access to registration in the same recovery session without a TAP on supported devices. When passkey attestation is required, this path is supported only on Android; iOS continues to receive a TAP. Stale-credential cleanup becomes available. |
| **Stale credential cleanup** | Off by default; explicitly opt in during preview with TAP issuance off. After successful recovery and replacement-passkey registration, deletes all previously registered authentication methods while preserving the new passkey. If deletion fails, recovery remains successful. Turning TAP issuance on turns cleanup off before saving. |

To choose the actions after recovery:

1. Review whether users should receive a TAP or continue to registration without a TAP on supported devices.
1. Choose the TAP issuance setting for the intended registration path.
1. If TAP issuance is off, review the scope and timing of stale-credential cleanup before explicitly enabling it.
1. If you turn TAP issuance back on, confirm that cleanup is off before saving the settings.
1. Apply your settings and test recovery through registration of a replacement method, not just successful identity verification.

> [!NOTE]
> When passkey attestation is required, turning off TAP issuance is supported only on Android. iOS continues to receive a TAP, even when TAP issuance is turned off, because the TAP-free registration path doesn't support attestation on iOS.

## Test recovery settings

Use a small test group to validate the selected registration path:

1. Confirm the recovery profile's mode and user scope in Microsoft Entra Verified ID. **Evaluation** tests verification without recovering the account; use **Production** only for a deliberate end-to-end recovery test.
1. Confirm that the tenant's Account recovery policy is enabled.
1. Complete identity verification and account validation with a test user.
1. With TAP issuance on, confirm that the user receives a TAP and can register a replacement authentication method.
1. With TAP issuance off, validate the required device and registration-method combination. If passkey attestation is required, use Android for the TAP-free path; iOS continues to receive a TAP.
1. Confirm that replacement-method registration completes. Successful identity verification alone doesn't establish that recovery is complete.

> [!CAUTION]
> Review which users are in scope before using a recovery profile in Production mode. Confirm that only the intended test users can participate before expanding the deployment.

For the user journey, see [Perform account recovery](how-to-account-recovery-for-users.md).

<a id="review-proposed-policy-and-extension-integration"></a>

## Review policy and extension integration

Use Conditional Access to protect the **Account onboarding and recovery** user action. Review targeting and exclusions with your policy owner so that unrelated access requirements don't block the recovery journey. See [Protect onboarding and recovery with Conditional Access](../conditional-access/policy-require-identity-verification.md#configure-an-onboarding-and-recovery-policy) for configuration guidance.

Review the [global onboarding and recovery exclusion](../conditional-access/policy-require-identity-verification.md#enable-the-global-onboarding-and-recovery-exclusion-preview) with your Conditional Access policy owner. This tenant-wide setting excludes the combined onboarding and recovery user action from **All resources** policies. Policies targeting the user action still apply, and ordinary application access remains subject to resource-access policies. Configure and test the intended user-action policy rather than using the exclusion as a replacement for protecting recovery.

Conditional Access policies can block account recovery if they require controls that aren't supported for the onboarding and recovery user action.

> [!NOTE]
> **Terms of use**, **Require authentication strength**, and most other Microsoft Entra-specific controls aren't supported for the onboarding and recovery user action. Unsupported recovery policy requirements can block recovery or leave intended requirements unenforced. Review the [control limitations](../conditional-access/policy-require-identity-verification.md#review-control-limitations) and test policy enforcement before rollout.

Before enabling account recovery, review your Conditional Access policies and test the recovery experience with a small group of users. Successful identity verification alone doesn't confirm that recovery can complete.

If recovery is blocked, review the Conditional Access results in the sign-in logs to identify the blocking policy.

If you can't save the Conditional Access policy, review [Policy configuration errors](../conditional-access/policy-require-identity-verification.md#troubleshoot-onboarding-and-recovery-policy-configuration-errors) for client-app and named-location validation guidance. Policy-save errors are separate from a saved policy blocking recovery.

Configure custom claim validation in the [ID verification profile](../../verified-id/how-to-create-id-verification-profile.md#configure-an-optional-custom-extension), not in recovery settings.

Recovery currently supports one custom authentication extension. You can link the same extension to multiple identity verification profiles.

## Related content

- [Create an ID verification profile](../../verified-id/how-to-create-id-verification-profile.md).
- [How end users can perform account recovery](how-to-account-recovery-for-users.md).
- [Create a custom authentication extension for account recovery claim validation](../../identity-platform/tutorial-custom-authentication-extension-account-recovery.md).
- [FAQ for account recovery](self-service-account-recovery.yml).
