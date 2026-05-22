Did y---
title: Sign in with passkeys in Microsoft Entra External ID
description: Learn how to enable passkeys (FIDO2) for phishing-resistant, passwordless sign-in in your consumer and business customer apps using Microsoft Entra External ID.
ms.service: entra-external-id
ms.topic: how-to
ms.date: 05/21/2026
ms.author: godonnell
author: garrodonnell
ai-usage: ai-assisted
ms.custom: it-pro
#Customer intent: As a developer or IT admin, I want to enable passkey (FIDO2) sign-in for my external tenant so that customers can use phishing-resistant, passwordless authentication.
---

# Sign in with passkeys

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article explains how to enable passkeys (FIDO2) as a sign-in method for your consumer applications built on Microsoft Entra External ID. Passkeys let your customers sign in with face, fingerprint, PIN, or a security key, instead of remembering passwords or entering one-time codes. They provide phishing-resistant authentication.

In an external tenant, you can use passkeys in two ways:

- **Passwordless sign-in.** The user enters their email or username. If a passkey is available, they're prompted to sign in with face, fingerprint, PIN, or a security key. The passkey completes first-factor authentication and also satisfies multifactor authentication (MFA) requirements.
- **Passkey for MFA.** The user signs in with their email or username and password. If a passkey is registered, they complete MFA with the passkey — a phishing-resistant alternative to traditional verification methods.

For more about MFA options, see [MFA in external tenants](concept-multifactor-authentication-customers.md).

## Prerequisites

- A Microsoft Entra external tenant. [Create a free trial](https://aka.ms/ciam-free-trial) or use an existing external tenant.
- An account with at least the [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator) role to configure passkey policies.
- A [custom URL domain](how-to-custom-url-domain.md) configured for your tenant. Passkeys are registered against the custom URL as the relying party.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) associated with your application.
- An app that's [registered](how-to-register-ciam-app.md) in your external tenant and added to the sign-up and sign-in user flow.

### End-user requirements

- Only email + password and username + password local accounts can register a passkey.
- Users must complete MFA before they register a passkey. To set up MFA, see [Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md).
- Customers need a WebAuthn-capable browser and device. For details, see [What platforms and browsers are supported?](#what-platforms-and-browsers-are-supported).

## Step 1: Enable the passkey (FIDO2) authentication method

Turn on the passkey (FIDO2) authentication method for your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).

1. Browse to **Entra ID** > **Security** > **Authentication methods** > **Policies**.

1. In the **Method** list, select **Passkey (FIDO2)**.

1. Under **Enable and Target**, turn the **Enable** toggle on.

1. Under **Include**, next to **Target**, select **All users** or choose specific groups.

1. Select **Save**.

## Step 2: Configure passkey profiles

Passkey profiles let you define different policies for different user groups. For full reference, see [Enable passkeys (FIDO2) in Microsoft Entra ID](/entra/identity/authentication/how-to-enable-passkey-fido2).

To configure a profile:

1. On the **Passkey (FIDO2)** policy page, select the **Configure** tab.

1. Set **Allow self-service set up** to **Yes**.

1. Select the **Default passkey profile**, or select **+ Add passkey profile** to create a new one.

1. Configure the profile:

    - **Passkey types** — Select both **Synced** and **Device-bound** for maximum flexibility.
    - **Enforce attestation** — Set to **No** for consumer scenarios (allows synced passkeys). Set to **Yes** only for regulated environments.
    - **Key restrictions** — Leave disabled unless you need to allow or block specific authenticators by AAGUID.

1. Under **Target**, assign the profile to the appropriate user groups.

1. Select **Save**.

## Step 3: Build a passkey management experience for your application

Your application needs a credential management experience so customers can register and manage their passkeys. Use the [FIDO2 provisioning APIs](/graph/api/resources/fido2authenticationmethod?view=graph-rest-beta&preserve-view=true) to build this into your app.

The credential management experience should enable customers to:

- Register a passkey on the same device (Windows Hello, platform authenticator, security key).
- Register a passkey via cross-device QR code flow (phone or tablet).
- View their registered passkeys.
- Delete a passkey.

For a complete reference implementation, see the [passkey management sample app on GitHub](https://github.com/Azure-Samples/ms-eeid-passkey-sample-app). The sample is a React single-page application (SPA) that demonstrates how to sign in users with Microsoft Entra External ID and manage passkey credentials by using the Microsoft Graph API.

## User experience

The following sections describe what your customers see when they register, sign in with, or manage a passkey.

### Register a passkey

The user registers a passkey from your credential management experience:

1. The user signs in to your application with their email or username and password.
1. The user goes to the settings page to manage their credentials and selects the option to add a passkey.
1. The user completes MFA. They must have completed MFA within the last five minutes.
1. The browser presents the native passkey creation dialog. The user chooses one of the following options:
    - **Same device** — Windows Hello, iCloud Keychain, Google Password Manager, or a third-party provider such as 1Password or Bitwarden.
    - **Cross-device** — scan a QR code to register from a phone or tablet.
    - **Security key** — insert or tap a FIDO2 hardware key.
1. The user completes verification with face, fingerprint, or PIN.
1. The passkey is registered and ready for sign-in.

### Sign in with a passkey

A registered user signs in with their passkey instead of a password:

1. The user goes to your application and starts the sign-in process.
1. The user enters their email address or username.
1. If a passkey is registered, the sign-in experience depends on whether the user has signed in before:
    - **First time.** The user selects **Use your face, fingerprint, PIN or security key instead**.
    - **Subsequent sign-ins.** The user is immediately prompted to authenticate with a passkey. The browser or platform might also surface the passkey automatically through autofill or a password manager.
    - **Cross-device sign-in.** The user selects the option to use a passkey from another device and scans a QR code with their phone or tablet.
1. After successful authentication, the user is signed in to your application.

### Use a passkey for MFA

When a Conditional Access policy requires MFA and the user has a registered passkey, the user can satisfy MFA with the passkey:

1. The user goes to your application and starts the sign-in process.
1. The user enters their email address or username and password.
1. At the MFA prompt, the user selects the passkey option.
1. The user completes verification with face, fingerprint, PIN, or security key.

After successful verification, the user is signed in to your application.

### Manage passkeys

Through your credential management experience, customers can:

- **View** their registered passkeys (name, type, creation date).
- **Delete** a passkey they no longer need.
- **Register** more passkeys for backup.

## Frequently asked questions

### What platforms and browsers are supported?

| Platform | Minimum version | Supported browsers |
|----------|-----------------|-------------------|
| Windows | Windows 10 version 1903 or later (Windows 11 recommended) | Edge, Chrome, Firefox |
| macOS | macOS 13 (Ventura) or later | Safari, Chrome, Edge |
| iOS | iOS 16 or later | Safari, Chrome |
| Android | Android 9 or later | Chrome, Edge |
| Linux | - | Chrome, Edge (with external security key) |

### What passkey providers and types are supported?

| Type | Supported providers |
|------|-------------------------------|
| **Device-bound** | Windows Hello, FIDO2 security keys (for example, YubiKey, Feitian) |
| **Synced** | Apple iCloud Keychain, Google Password Manager, 1Password, Bitwarden |

Device-bound passkeys stay on a single physical device and never leave it. Synced passkeys are encrypted and available across all devices linked to a cloud provider.

### Is Microsoft Authenticator supported for passkeys?

No. Registering passkeys through the Microsoft Authenticator app isn't currently supported. Use Windows Hello, FIDO2 security keys, iCloud Keychain, Google Password Manager, 1Password, or Bitwarden instead. Authenticator support is planned for a future release.

### What is a passkey?

A passkey is a FIDO2-based credential that uses public-key cryptography. A private key stays on the customer's device; a public key is stored with Microsoft Entra ID. Sign-in requires a local biometric or PIN, making passkeys phishing-resistant. No shared secret is ever transmitted.

### What's the difference between synced and device-bound passkeys?

Synced passkeys are encrypted and available across all devices linked to a cloud provider (iCloud Keychain, Google Password Manager, 1Password, Bitwarden). Device-bound passkeys live on a single physical device (Windows Hello, FIDO2 security key) and never leave it. Device-bound passkeys support attestation; synced passkeys don't.

### Does a passkey satisfy MFA?

Yes. A passkey combines device possession (something you have) with biometric or PIN (something you are or know), satisfying MFA in a single gesture.

### Can a customer use a passkey as their only sign-in method?

Yes, once registered. However, customers currently need an email + password account to register the passkey initially.

### What happens if a customer loses their device?

For synced passkeys, the credential is available on the customer's other linked devices. For device-bound passkeys, the customer signs in with email + password (fallback) and registers a new passkey. Admins can delete the lost passkey via the admin center or Graph API.

### Can customers use a passkey on a different device from where they registered it?

Yes — synced passkeys are automatically available on all linked devices. For any passkey type, cross-device sign-in is possible by scanning a QR code (requires Bluetooth on both devices).

### Can I enforce passkeys using Conditional Access authentication strengths?

No. External ID tenants don't currently support authentication strengths in Conditional Access. You can't enforce phishing-resistant MFA through a Conditional Access policy. Passkeys are offered as an available sign-in method, but can't be required via policy at this time.

### Can I use passkeys with email one-time passcode or social IdP users?

Not yet. Only email + password local account users can use passkeys currently. Support for email one-time passcode, federated, and social IdP users is on the roadmap.

### Is there a cost for passkey authentication?

No. Passkeys are included in all Microsoft Entra External ID pricing tiers at no additional cost, unlike SMS-based MFA which requires a linked subscription.

### Are passkeys supported in Azure AD B2C?

No. Passkeys for customer-facing apps are available only in Microsoft Entra External ID (external tenants). If you're on B2C, consider [planning your migration to External ID](plan-your-migration-from-b2c-to-external-id.md).

### Is passkey sign-in supported in embedded webviews?

No. Embedded webviews (WebView, WKWebView) have limited or no WebAuthn support. Use system browsers or the device's default browser.

### Can admins register passkeys on behalf of customers?

No. Registration requires the customer's physical presence and local biometric or PIN gesture. Admins can delete passkeys and prompt re-registration.

### Are there low-privilege APIs for building a credential management experience?

Not yet. Low-privilege credential management APIs for passkeys are on the roadmap. Currently, use the [FIDO2 provisioning APIs](/graph/api/resources/fido2authenticationmethod?view=graph-rest-beta&preserve-view=true) to build your credential management experience.

### Can I use the same passkey across multiple domains (related origins)?

No. Related origins support isn't currently available. A passkey is registered against a single domain (relying party) and can't be used across multiple domains. Support for related origins is on the roadmap.

### Are passkeys supported in mobile native authentication flows?

No. Passkeys aren't currently supported through native authentication APIs. Support for mobile native authentication flows is on the roadmap.

### Is there an out-of-box passkey registration experience?

No. There isn't a built-in passkey registration experience provided by Microsoft at this time. You need to build your own credential management experience using the [FIDO2 provisioning APIs](/graph/api/resources/fido2authenticationmethod?view=graph-rest-beta&preserve-view=true). An out-of-box registration experience is coming soon.

## Related content

- [Passkey management sample app on GitHub](https://github.com/Azure-Samples/ms-eeid-passkey-sample-app)
- [Create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md)
- [Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md)
- [Authentication methods in external tenants](concept-authentication-methods-customers.md)
- [Passkeys (FIDO2) in Microsoft Entra ID](/entra/identity/authentication/concept-authentication-passwordless#fido2-security-keys)
- [Enable passkeys in Microsoft Entra ID](/entra/identity/authentication/how-to-enable-passkey-fido2)
