---
title: Passkeys by default and retirement of Microsoft-provided SMS and voice authentication
description: Learn how to prepare for the retirement of Microsoft provided SMS and Voice authentication in Microsoft Entra ID and migrate users to passkeys.
ms.topic: how-to
ms.date: 07/29/2026
author: marinasanchezz1
ms.author: marisanchez
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to understand the SMS and Voice retirement timeline so that I can migrate my users to passkeys before the deadline.
---

# Passkeys by default and retirement of Microsoft-provided SMS and voice authentication

To help enterprises adopt AI at scale, it is imperative for users to use secure authentication and move from phishable authentication methods to phishing-resistant authentication methods like [passkeys](concept-authentication-passkeys-fido2.md). Therefore, Microsoft Entra ID is making passkeys the default sign-in experience, so every organization gets phishing-resistant security by default. SMS and voice are no longer positioned as secure authentication methods and will no longer be provided natively in Entra ID.

Starting September 1, 2026, passkeys become the default authentication experience and will be automatically enabled for users enabled for SMS or voice. From February 1, 2027, Microsoft-provided telecom delivery for SMS and voice will be retired; customers who still require these methods should configure customer-managed providers through the Microsoft Security Store. More information on customer-managed telecoms coming September 18th, 2026.

Users who already sign in with passkeys, Windows Hello for Business, or another phishing-resistant method can continue using those methods. However, users who remain enabled for SMS or voice may still receive prompts to register passkeys on eligible devices. To check who in your tenant still uses SMS or Voice, see [Find active SMS or Voice users in your tenant](#1-find-users-enabled-for-sms-or-voice).

## Retirement timeline

| Date | Milestone | What you should do |
|------|-----------|--------------------|
| September 1, 2026 | Tenants with users enabled for SMS or voice, those users are auto-enabled and nudged for Passkey registration upon MFA sign-in. | Notify end users of the changes happening. Use the [passkey deployment guide](how-to-deploy-phishing-resistant-passwordless-authentication.md) to prepare your environment for passkey use. |
| February 1, 2027 | Microsoft provided SMS and Voice fully retired in Microsoft Entra ID| Make sure every user is on a phishing-resistant method (passkeys, Windows Hello, or FIDO2) before this date, or users may experience sign in disturbances. |
| After February 1, 2027 | Users whose **only available MFA method is SMS or voice** will be required to register a passkey during sign-in to continue accessing their account. This prompt will be **blocking**. Users must **register a passkey before they can continue to sign in** to their account.<br>**There is no opt out from this February 1 behavior. It will be enforced for all tenants.** | Migrate users to a phishing-resistant method or choose a telecom provider to continue using SMS or voice. |

## Prepare for transition to passkeys

### 1. Find users enabled for SMS or Voice

Microsoft recommends that you identify which users are enabled for SMS or Voice, before you plan your migration. Use the following steps to find each group.

To find users enabled for SMS or Voice, run this [PowerShell script](https://github.com/microsoft/entra-sms-voice-usage-analyzer). Ensure you have one of global reader, Authentication policy administrator, or Security reader roles enabled.

### 2. Move users to passkeys

Passkeys are the default phishing-resistant credential for Microsoft Entra ID. They're tied to a device or a synced credential store, use cryptographic keys instead of shared secrets, and are resistant to phishing, SIM-swap, and replay attacks.

Microsoft Entra ID supports two types of [passkeys](concept-authentication-passkeys-fido2.md):

- [Synced passkeys](concept-authentication-passkeys-fido2.md#types-of-passkeys) — passkeys saved to a platform credential manager (such as iCloud Keychain, or Google Password Manager) and synced across the user's devices. Best for users who already use a platform credential manager.
- [Device bound passkey](howto-authentication-passwordless-security-key-windows.md) — the passkey is created and stored on a user's device, such as Passkey in Microsoft Authenticator, Entra Passkey on Windows, FIDO2 hardware security key, and so on.

To enable passkeys for your tenant and plan your rollout, see [Plan a passkey deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md) and [Enable passkeys (FIDO2) for your organization](how-to-authentication-passkeys-fido2.md).

To view the full list of passwordless authentication methods that Entra ID supports, see [Microsoft authentication overview](overview-authentication.md).

> [!IMPORTANT]
> On September 1, 2026, users enabled for SMS or Voice in the Entra Authentication Methods Policy (AMP), or in legacy MFA settings, will be auto-enabled for passkeys in AMP. These in scope users will be put into a passkey profile allowing all types of passkeys. Your Registration Campaign settings will be set to Microsoft Managed state targeting passkeys, and will automatically bring these users into scope.
>
> When these users next sign-in and complete MFA, the registration campaign will nudge them to register a passkey. By default, users will have unlimited snoozes of the nudge prompt. If you do not want this to occur, move users out of SMS or Voice in AMP before September 1st.

#### Proactively drive adoption with a registration campaign

You can enable a passkey registration campaign before it is automatically enabled for your SMS and Voice enabled users on September 1, 2026. A registration campaign prompts users to set up a passkey the next time they sign in and complete MFA. It's the most effective way to move users off SMS and Voice at scale without adding help-desk load.

Before configuring the registration campaign, ensure Passkey (FIDO2) is enabled as an authentication method and that your SMS/Voice users are included in a passkey-enabled authentication methods policy.

To configure a registration campaign for passkeys:

1. Sign in to the Microsoft Entra admin center as an Authentication Policy Administrator.
1. Go to **Entra ID > Authentication methods > Registration campaign**.
1. Set **State** to **Microsoft Managed** and target the security group of SMS and Voice users you created in step 1.

### 3. Evaluate a telecommunications provider in the Security Store for operational needs

Microsoft recommends passkeys as the primary migration path for all users where possible. If you operate in a regulated industry or have an operational need for a telecoms channel — for example, specific compliance regimes that require an out-of-band SMS, or scenarios where no other method is workable — you can use a telecom provider available through the Microsoft Security Store for those user segments.

1. Identify the specific user segments where you have a genuine regulatory or operational need for a telecoms channel. Document the requirement (which regulation, which scenario).
1. Beginning September 18th, 2026, review the telecom providers and related information available through the Microsoft Security Store to evaluate which option best meets your regional and compliance requirements.
1. Beginning October 30, 2026, customers who need to continue using SMS or voice will be able to select and configure a telecom provider from the Microsoft Security Store.
1. Stand up the carrier contract through the marketplace flow and test with a pilot group before broad rollout.
1. For every other user segment in your tenant, default to passkeys.


### 4. Communicate the change to your users

With passkeys enabled in your tenant, give your users clear notice of what's changing, when, and what they need to do before you start driving registration. Coordinated communications are the single biggest predictor of a smooth passkey rollout.

Microsoft recommends a phased communication plan aligned with the retirement timeline:

1. **Awareness** — announce that SMS and Voice are retiring, explain why, and tell users which method they'll move to.
1. **Action** — direct users to register a passkey, with step-by-step guidance for their device type (Windows Hello, iOS, Android).
1. **Reminder** — remind users who haven't yet registered a phishing-resistant method on the actions they should take.

Use [end-user communication templates](https://aka.ms/mfatemplates) for email, Teams, and employee communications portals. Microsoft recommends that you scope your messaging to the security group of SMS and Voice users you created in step 1, so the right people hear from you at the right time.

### 5. After retirement

Beginning February 1, 2027, Microsoft-provided SMS and voice delivery will be retired in Microsoft Entra ID.

If your tenant still has users enabled for SMS or voice and you have not configured a customer-managed telecom provider through the Microsoft Security Store, those users will no longer be able to use SMS or voice to complete MFA and sign in as usual.

After this date, users whose only available MFA method is SMS or voice will be required to register a passkey during sign-in to continue accessing their account. This prompt will be blocking. Users must register a passkey before they can continue signing into their account.

**There is no opt out from this February 1 behavior. It will be enforced for all tenants.**

To avoid sign-in disruption, make sure users register a passkey or move to another phishing-resistant authentication method before February 1, 2027. If your organization has a valid business, regulatory, or operational need to keep using SMS or voice, configure a customer-managed telecom provider before this date.

## Temporarily opt out of the automatic passkey enablement

A temporary opt-out is available for the September 1, 2026 through February 1, 2027 changes. This lets you delay passkey and Registration Campaign enablement while you complete transition activities, such as configuring customer-managed telecom providers or migrating to other authentication methods.

To opt out, update your authentication methods policy using Microsoft Graph and set the `passkeyDynamicMigration` property to `true`.

**Request**

```http
PATCH https://graph.microsoft.com/beta/policies/authenticationmethodspolicy
Content-Type: application/json

{
   "optOutSettings": {
     "passkeyDynamicMigration": true
   }
}
```

After this setting is applied, your tenant is excluded from the automatic passkey enablement and Registration Campaign rollout during the opt-out period. Beginning February 1, 2027, standard passkey migration and enforcement timelines apply regardless of this setting.

If your tenant still has users enabled for Microsoft-managed SMS or voice on February 1, 2027, and you haven't configured a customer-managed telecom provider through the Security Store, those users can no longer use SMS or voice to satisfy MFA requirements and continue signing in.

**There is no opt out for the February 1, 2027 enforcement. This requirement applies to all tenants.**

## Frequently asked questions

For answers to common questions about the SMS and voice retirement, telecom providers, opt-out options, and passkey migration, see [Frequently asked questions about SMS and voice retirement](concept-sms-voice-retirement-faq.yml).

## Related links

- [What are authentication methods?](overview-authentication.md)
- [Plan a passkey deployment](how-to-deploy-phishing-resistant-passwordless-authentication.md)
- [Authentication methods activity report](howto-authentication-methods-activity.md)
