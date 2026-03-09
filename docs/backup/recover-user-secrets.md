---
title: Recover user authentication methods using Microsoft Entra Backup
description: Learn how to recover user authentication methods after accidental or malicious changes using Microsoft Entra Backup and Recovery
ms.topic: how-to
ms.date: 03/09/2026
---

# Recover user authentication methods using Microsoft Entra Backup (Preview)

This article outlines Microsoft's recommended approach for recovering user authentication methods ("user secrets") in Microsoft Entra ID when they were accidentally or maliciously edited or deleted.

## Overview

Authentication methods are a critical component of user identity security. Disruption or compromise can result in account lockouts or unauthorized access.

Using Entra Backup and Recovery, administrators can restore user objects and associated authentication data to a previous state. In cases where authentication methods can't or shouldn't be restored, administrators should remove untrusted entries and have users securely re-register new authentication methods.

The following sections provide step-by-step guidance for two common recovery scenarios:

- **Accidental changes or deletion** - Cases where a user's authentication methods or account were unintentionally modified or removed, such as through admin error or automation.
- **Malicious changes or deletion** - Cases where authentication methods or the user object itself might have been intentionally altered or deleted by a bad actor, requiring a Zero Trust recovery approach.

Across all scenarios, the goal is to restore secure user access, ensure authentication methods can be trusted, and reinforce long-term prevention through appropriate administrative controls.

## Preparation and prevention

Before recovery is needed, organizations should establish clear controls and redundancy for managing user authentication methods. Doing so minimizes disruption and simplifies recovery when issues occur.

**Recommended practices:**

- **Require MFA for all users.** Use [Conditional Access](/entra/identity/conditional-access/overview), [authentication strengths](/entra/identity/authentication/concept-authentication-strengths), or [Identity Protection policies](/entra/id-protection/overview-identity-protection) to ensure users authenticate with strong methods rather than relying solely on passwords.
- **Require multiple authentication methods per user.** While Microsoft Entra ID doesn't currently enforce a strict "two-method minimum," organizations should encourage users to register at least two strong methods to prevent lockouts if one method is lost or deleted. This can be reinforced through authentication strengths, [SSPR policies that require multiple methods](/entra/identity/authentication/tutorial-enable-sspr#select-authentication-methods-and-registration-options), and operational checks (for example, periodic reporting using [Microsoft Graph reporting APIs](/graph/api/resources/userregistrationdetails?view=graph-rest-1.0&preserve-view=true)).
- **Favor phishing-resistant methods.** Encourage users to register FIDO2 security keys, passkeys, or Windows Hello for Business to strengthen resilience against account compromise. Microsoft's [guidance](/entra/identity/authentication/how-to-deploy-phishing-resistant-passwordless-authentication) is to use synced passkeys for most end users and device-bound passkeys for higher-assurance roles.
- **Restrict authentication method management via Entra RBAC.** Limit management of authentication methods to [Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-administrator) or [Privileged Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-authentication-administrator), assigned only to trusted, least-privileged users and elevated through [Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure) (PIM). For helpdesk scenarios, use Authentication Administrator, which allows support staff to reset or remove authentication methods for standard users while preventing changes to privileged accounts.
- **Protect user authentication-method registration with Conditional Access.** [Require](/entra/identity/conditional-access/policy-all-users-security-info-registration) strong sign-in (for example, compliant devices or trusted networks) when users access the Security info registration portal.
- **Use protected actions for destructive operations.** Limit the ability to permanently delete users to highly privileged administrators via [protected actions](/entra/identity/role-based-access-control/protected-actions-overview).

## Determine the nature of the change

Before restoring, determine whether the activity was accidental or malicious:

| Scenario | Common causes | Recommended posture |
|---|---|---|
| **Accidental** | Admin error, automation, error in directory sync | Validate and selectively restore |
| **Malicious** | Insider threat, compromised account, external breach | Treat as a compromise and rebuild from trusted state |

If the cause is unclear, **default to treating the incident as malicious** in line with Zero Trust recovery practices.

## Recovery guidance

### Accidental changes or deletions

If a user's authentication methods or account were unintentionally changed or deleted, Entra Backup and Recovery can be used to restore them to a prior state.

**Step 1 - Review audit logs**

Begin by confirming what was changed and when.

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Monitoring** > **Audit logs** and filter for the impacted user.
1. Look for activities such as *Update user authentication methods*, *Delete user authentication method*, or *Delete user*.
1. Use this information to determine whether the issue affected the user's authentication methods only, or if the user object itself was deleted.

**Step 2 - Recover the user to a previous state**

Use Entra Backup and Recovery to restore the user to a point in time before the accidental change occurred.

If the user was **soft-deleted**, restoring them reinstates their attributes, group memberships, licenses, and assignments. This helps ensure that MFA, SSPR, and authentication method policies continue to apply as before.

If the user was **hard-deleted** and is no longer available in Backup and Recovery, the user must be recreated manually, and all authentication methods must be newly registered.

> [!NOTE]
> Even if the user was *not* deleted, restoring the user object is required to recover prior authentication methods. Individual authentication methods can't be restored independently.

**Step 3 - Validate recovered authentication methods**

After restoration, review the specific methods identified in Step 1 as changed or deleted using the **Microsoft Entra admin center** > **Users** > **{Select user}** > **Authentication methods** page or Microsoft Graph (`GET /users/{id}/authentication/methods`).

Most authentication methods in Microsoft Entra ID continue to function normally after being restored. The following table summarizes which methods are usable after recovery.

| Authentication method | Usable after restoration? |
|---|---|
| Phone (SMS or Voice) | ✅ Yes |
| Email | ✅ Yes |
| Password | ❌ No - Not recovered for security |
| Microsoft Authenticator Push | ✅ Yes |
| Microsoft Authenticator Passkey | ✅ Yes |
| Synced passkey | ✅ Yes |
| FIDO2 Security Key | ✅ Yes |
| Windows Hello for Business | ✅ Yes |
| Platform SSO for macOS | ✅ Yes |
| Certificate-based authentication | ✅ Yes |
| External authentication methods | ✅ Yes |
| Temporary Access Pass | ❌ No - Time-bound; typically expired |
| OATH Hardware Token | ✅ Yes |
| OATH Software Token | ✅ Yes |

**Step 4 - Set a new password or issue a TAP (as needed)**

Because most authentication methods are fully usable after being restored, only two credentials typically require action:

1. **Set a new password for the user.** Backup and Recovery doesn't restore passwords, so [setting a new password](/entra/fundamentals/users-reset-password-azure-portal) might be needed to allow the user to sign in normally after recovery.

   > [!NOTE]
   > If your organization enforces passwordless authentication through authentication strengths, this step might not be required.

1. **Issue a new Temporary Access Pass (TAP), if needed.** TAPs are time-bound and typically expired after restore. [Generate a new TAP](/entra/identity/authentication/howto-authentication-temporary-access-pass#create-a-temporary-access-pass) if the user requires it to complete sign-in or reconfigure methods.

In most cases, no additional re-registration is required unless specific methods were intentionally removed during recovery.

### Malicious changes or deletion

If you suspect a user's authentication methods were maliciously altered or the user account itself was deleted, treat the event as a potential account compromise. In a Zero Trust recovery model, assume that all existing methods tied to the user might be untrustworthy.

The goal in this scenario is to restore the user object if needed, remove all potentially compromised methods, and have the user re-register new, trusted ones.

**Step 1 - Confirm malicious activity**

Review **Audit logs** for unexpected authentication-method changes or user-deletion events. If the origin of the change is unknown or suspicious, proceed as if the activity was malicious.

Look for activities such as:

- Add user authentication method / Admin adds user authentication method
- Update user authentication methods
- Delete user authentication method
- Delete user

**Step 2 - Remove all existing authentication methods**

Before removing authentication methods, ensure the user object exists:

- **If the user account was maliciously deleted but is still recoverable**, use Entra Backup and Recovery to restore the user to a point in time before the deletion occurred.
- **If the user was hard-deleted and is no longer available in Backup and Recovery**, recreate the user manually. In this case, no authentication methods exist to delete, and all methods need to be newly registered as part of recovery.

Once restored, proceed with removing all authentication methods. Use the **Microsoft Entra admin center** > **Users** > **{Select user}** > **Authentication methods** page or Microsoft Graph (`/users/{id}/authentication/methods`) to delete all existing authentication methods for the user. Microsoft's guidance is not to reuse authentication methods that might have been involved in malicious activity, even if Backup and Recovery can revert them.

**Step 3 - Set a new password for the user**

Before enrolling any new authentication methods, [set a new password for the user](/entra/fundamentals/users-reset-password-azure-portal) to establish a clean, trusted credential for the recovered account. Backup and Recovery doesn't restore passwords, so issuing a new one ensures the user begins from a known, administrator-issued baseline.

Reset the password in the **Microsoft Entra admin center** or via Microsoft Graph (`POST /users/{id}/changePassword`). Require the user to set a new, strong password at their next sign-in, unless your tenant enforces passwordless-only authentication through authentication strengths.

**Step 4 - Re-register new authentication methods**

1. **Require the user to register new methods** using your organization's standard enrollment flow.
1. **Encourage phishing-resistant authentication** options wherever possible, such as:
   - FIDO2 security keys
   - Passkeys (device-bound or cross-device)
   - Windows Hello for Business (for managed devices)
1. **Use identity verification (recommended).** When available, organizations should consider using the Identity Verification capability released as part of [account recovery](/entra/identity/authentication/concept-account-recovery-overview). Identity verification provides a higher-assurance and more secure alternative to Temporary Access Pass for re-establishing user trust before new authentication methods are enrolled.
1. **If identity verification isn't available, provide a Temporary Access Pass (TAP)** to allow secure initial sign-in and method setup.
1. **Confirm new methods appear correctly** under the user's authentication-methods list.

## Post-recovery validation

After completing recovery under any scenario:

- Have the user perform a test sign-in to confirm that restored or re-registered methods function correctly.
- Verify that MFA, SSPR, and Conditional Access policies apply as expected.
- Review the prevention and readiness recommendations outlined earlier in this article, such as limiting admin access via Entra RBAC and protecting registration through Conditional Access, to ensure those controls are implemented where possible.
- Document the recovery outcome and any lessons learned to improve future response.
