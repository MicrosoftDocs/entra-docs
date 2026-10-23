---
title: System-preferred authentication in Microsoft Entra ID
description: Learn how system-preferred authentication evaluates methods to prompt users with the most secure sign-in option for both first-factor and second-factor authentication.
ms.topic: overview
ms.date: 10/23/2026
ms.reviewer: msft-poulomi
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to encourage users to sign in with the most secure authentication method so that I can improve my organization's sign-in security.
---

# System-preferred authentication

System-preferred authentication prompts users to sign in by using their most secure registered authentication method. For passkeys, it also considers the device and browser the user is signing in from to prioritize a passkey they can use locally. It's an important security enhancement for users who authenticate by using less secure methods like passwords or SMS.

For example, when system-preferred authentication applies to first-factor sign-in, a user with both a password and a passkey available on their current device is prompted to use the passkey instead of the password. Registering a passkey on one device doesn't mean the user is prompted to use it on every device. The user can still choose another allowed sign-in method.

System-preferred authentication is a Microsoft managed setting, which is a [three-state policy](#authentication-method-feature-configuration-properties) (enabled, disabled, or Microsoft managed). If you don't want to enable system-preferred authentication, change the state from **Microsoft managed** to **Disabled**, or exclude users and groups from the policy.

After system-preferred authentication is enabled, users don't need to set a default authentication method. The system selects the preferred method for the applicable authentication step. For passkeys, the initial experience can differ between devices and browsers.

## How system-preferred authentication applies to sign-in

System-preferred authentication has three modes:

- **Disabled** - No change to sign-in logic.
- **Enabled** - System-preferred authentication applies to second-factor only. The existing sign-in behavior continues to apply for first-factor authentication.
- **Microsoft managed** - System-preferred authentication applies to both first-factor and second-factor authentication. The system evaluates which credentials are registered for the user and selects the highest-ranked method for each authentication step.

Both **Enabled** and **Microsoft managed** modes allow administrators to include or exclude specific users or groups.

> [!TIP]
> If you don't want system-preferred authentication to apply to first-factor authentication, switch from **Microsoft managed** to **Enabled**. The **Enabled** state applies system-preferred logic to second-factor only.

> [!NOTE]
> System-preferred authentication is scoped to users, not devices. Administrators include or exclude users or groups but can't assign the feature to specific devices or device groups.
>
> This policy scope doesn't mean users see the same passkey prompt on every device. Passkey selection also considers the device and browser used for sign-in.

### Known limitations

- When you change the policy for a target group, the change might not take effect on the user's very next sign-in. It applies to all subsequent sign-ins after that.
- Conditional Access policy is validated only for second-factor authentication and doesn't apply to first-factor authentication. Authentication happens first, and then Conditional Access evaluates authorization. System-preferred authentication doesn't override Conditional Access policies or authentication strength requirements.

### How passkeys are selected for the current device

When a passkey is the preferred authentication method, **system-preferred authentication prioritizes a local passkey when one is available**. A local passkey is one the user can access through the current device's built-in authenticator or a passkey provider available on that device or in that browser. The user doesn't need to switch to another device to use it.

> [!IMPORTANT]
> **The first passkey prompt is a starting point, not a restriction.** Regardless of which passkey experience is shown first, users can navigate the browser or operating system's passkey options to use any of their registered local or portable passkeys that is accessible, supported, and allowed by your organization's policies. They don't need to use the suggested passkey or wait for an attempt to fail. See [Choose another passkey or sign-in method](#choose-another-passkey-or-sign-in-method).

For example, if a user has a passkey available on their Windows PC and another passkey on their phone, the local passkey experience is prioritized over asking them to use the phone.

**Local doesn't mean the same provider on every device or browser.** In Chrome, a passkey saved in Google Password Manager can be the local option. On Windows, Windows Hello for Business can be the local option. The browser and operating system determine which available local provider is displayed, so a user with multiple local passkeys isn't necessarily prompted for Windows Hello first.

The exact experience also depends on browser and operating system support. If the device or browser can't be identified reliably, the browser or operating system presents its default passkey experience.

> [!NOTE]
> A registered passkey isn't necessarily accessible on the device being used. For example, a synced passkey must be available in the user's passkey provider, and the user might need to sign in to that provider or browser profile. A passkey prompt doesn't guarantee that a matching passkey is present.

#### Device-bound, nonportable passkeys

System-preferred authentication includes logic for device-bound, nonportable platform credentials: **Windows Hello for Business**, **Microsoft Entra passkey on Windows**, and **macOS Platform SSO**. These credentials stay on the device where they're created. They aren't synced to other devices and can't be used from another device through cross-device QR code sign-in.

System-preferred authentication uses the operating system to decide whether to offer one of these platform experiences. Using the credential still requires its private key on the original device:

| Registered credential | Prompt can appear on | Credential works on |
| --- | --- | --- |
| Windows Hello for Business | Windows. | Only the Windows PC where the credential was created. |
| [Microsoft Entra passkey on Windows](how-to-authentication-entra-passkeys-on-windows.md) | Windows. | Only the Windows PC where the passkey was created. |
| macOS Platform SSO | macOS. | Only the Mac where the credential was created. |

**These credentials aren't offered on incompatible platforms:**

- Windows Hello for Business and Microsoft Entra passkey on Windows aren't offered on non-Windows devices, including a Mac, iPhone, iPad, Android device, or Linux device.
- macOS Platform SSO isn't offered on non-macOS devices.

If no other applicable passkey is registered, system-preferred authentication continues with the next applicable registered authentication method.

> [!NOTE]
> Microsoft Entra ID can identify the operating system, but it can't confirm before the prompt that the current device holds the credential's private key. A user might therefore receive a prompt on a compatible operating system even when the credential isn't available on that device. If no matching credential is available, the user needs to choose another allowed sign-in method.

These credential types also differ in where they apply during authentication:

- **Windows Hello for Business and macOS Platform SSO:** First-factor only. In the **Microsoft managed** state, their platform experiences can be offered before the password on a compatible operating system. Completing sign-in requires the credential on the current device.
- **Microsoft Entra passkey on Windows:** A separate FIDO2 passkey type that isn't subject to this first-factor-only limitation.

> [!NOTE]
> This nonportable behavior is different from a passkey on a phone that supports cross-device sign-in, or a security key that the user can connect to another supported device. Selecting **Sign in another way** lets the user choose another allowed method; it doesn't make a nonportable credential usable on another device.

#### Examples of passkey selection

The table answers one question: **Which local passkey experience is prioritized on this device and browser?** Each first-factor example assumes:

- System-preferred authentication is **Microsoft managed**.
- The user has only the passkeys listed in that row.
- The local passkey is accessible and allowed by the user's authentication policies.

Other registered passkey providers can change which local experience appears first. These examples don't change the overall [authentication method ranking](#how-does-system-preferred-authentication-determine-the-most-secure-method).

| Where the user signs in | Passkeys registered for the account | Local experience prioritized |
| --- | --- | --- |
| Windows PC, Microsoft Edge | Windows Hello for Business on this PC, and a passkey in Microsoft Authenticator on a phone | **Windows Hello for Business on this PC**, rather than switching to the phone to use the Authenticator passkey. |
| Windows PC, Google Chrome | A passkey in Google Password Manager accessible in Chrome, and Windows Hello for Business on this PC | **Google Password Manager in Chrome.** Being on Windows doesn't mean Windows Hello is always shown first. |
| Mac, Google Chrome | A passkey in Google Password Manager accessible in Chrome, and Windows Hello for Business on a Windows PC | **Google Password Manager in Chrome.** The Windows Hello credential from the Windows PC isn't used on the Mac. |
| Mac, Google Chrome | macOS Platform SSO on this Mac, with no passkey saved in Google Password Manager for this account | **macOS Platform SSO on this Mac.** Chrome can use the local platform experience when there's no matching Google Password Manager passkey. |
| iPhone running iOS 17 or later, Safari | A passkey in Microsoft Authenticator on this iPhone, with Authenticator enabled as an iOS passkey provider, and Windows Hello for Business on a Windows PC | **The Authenticator passkey on this iPhone.** The user selects it through the iOS passkey options and verifies with Face ID, Touch ID, or the device PIN. The Windows Hello credential isn't offered on the iPhone. |

#### Other passkey experiences

When the registered passkey types and current platform don't lead to a local passkey experience, the user isn't necessarily prompted for a password. Other possible experiences include:

- **A passkey on a phone that supports cross-device sign-in:** The user might see a QR code to scan with that phone.
- **A FIDO2 security key as their only passkey:** The user is prompted to insert or tap the key on a supported device and browser.
- **Only nonportable passkeys for a different operating system:** For example, the user has Windows Hello for Business or Microsoft Entra passkey on Windows but is signing in on an iPhone, Android device, or Mac. Those Windows credentials aren't offered. The user is prompted for the next applicable registered authentication method instead.

These are separate cases, not a fallback sequence. If the user has both a phone passkey and a security key, which experience is offered first depends on their device, browser, and passkey types.

##### Example: Sign in on Windows with an Authenticator passkey on an iPhone

In this example, system-preferred authentication is **Microsoft managed**, and passkey is the preferred method. The user's only passkey is in Microsoft Authenticator on their iPhone. Both the Windows PC and iPhone need Bluetooth and an internet connection.

1. The user starts sign-in in Microsoft Edge on the Windows PC.
1. Because the passkey is on the phone, the PC offers a cross-device passkey experience with a QR code.
1. The user scans the QR code with the iPhone's **Camera** app.
1. The user verifies with Face ID, Touch ID, or the device PIN on the iPhone.
1. Sign-in completes on the Windows PC.

This is **passkey authentication**, not an Authenticator push notification.

If the same user signs in directly on the iPhone, they can use that Authenticator passkey on the iPhone without scanning a QR code from another device, as shown in the table. For detailed steps, see [Sign in with passkeys in Authenticator](how-to-sign-in-passkey-authenticator.md).

#### Choose another passkey or sign-in method

Users can choose a different passkey even when the suggested one is available. They don't have to cancel sign-in or first try the suggested passkey. Through the browser or operating system's passkey options, they can choose:

- **Another local passkey:** Use a different passkey provider available on the current device.
- **A security key:** Connect or tap a supported key containing their registered passkey.
- **A passkey on another device:** Use a supported cross-device experience, such as scanning a QR code with a phone.

The option names and available choices vary by browser and operating system. Choosing another passkey doesn't make a nonportable credential usable away from its original device.

If the user cancels the passkey prompt or the attempt fails, they're returned to the sign-in method picker. They can select passkey sign-in again to reopen the passkey options, or select **Sign in another way** when shown to choose another allowed registered method.

All choices remain subject to your organization's authentication policies and Conditional Access requirements.

## Enable system-preferred authentication in the Microsoft Entra admin center

By default, system-preferred authentication is Microsoft managed for all users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Microsoft Entra ID** > **Authentication methods** > **Settings**.
1. For **System-preferred authentication**, choose **Microsoft-managed**, **Enabled**, or **Disabled**, and include or exclude any users. Excluded groups take precedence over include groups.
1. After you finish making any changes, select **Save**.

## Enable system-preferred authentication by using Graph APIs

To enable system-preferred authentication in advance, choose a single target group for the schema configuration, as shown in the [Request](#request) example.

### Authentication method feature configuration properties

By default, system-preferred authentication is [Microsoft managed](concept-authentication-default-enablement.md#microsoft-managed-settings).

| Property | Type | Description |
|----------|------|-------------|
| excludeTarget | featureTarget | A single entity that is excluded from this feature. <br>You can only exclude one group from system-preferred authentication, which can be a dynamic or nested group.|
| includeTarget | featureTarget | A single entity that is included in this feature. <br>You can only include one group for system-preferred authentication, which can be a dynamic or nested group.|
| State | advancedConfigState | Possible values are:<br>**enabled** explicitly enables the feature for the selected group.<br>**disabled** explicitly disables the feature for the selected group.<br>**default** allows Microsoft Entra ID to manage whether the feature is enabled or not for the selected group. |

### Feature target properties

System-preferred authentication can be enabled only for a single group, which can be a dynamic or nested group.

| Property | Type | Description |
|----------|------|-------------|
| ID | String | ID of the entity targeted. |
| targetType | featureTargetType | The kind of entity targeted, such as group, role, or administrative unit. The possible values are: 'group', 'administrativeUnit', 'role', 'unknownFutureValue'. |

Use the following API endpoint to enable **systemCredentialPreferences** and include or exclude groups:

```text
https://graph.microsoft.com/v1.0/policies/authenticationMethodsPolicy
```

> [!NOTE]
> In Graph Explorer, you need to consent to the **Policy.ReadWrite.AuthenticationMethod** permission.

### Request

The following example excludes a sample target group and includes all users. For more information, see [Update authenticationMethodsPolicy](/graph/api/authenticationmethodspolicy-update).

```http
PATCH https://graph.microsoft.com/v1.0/policies/authenticationMethodsPolicy
Content-Type: application/json

{
    "systemCredentialPreferences": {
        "state": "enabled",
        "excludeTargets": [
            {
                "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
                "targetType": "group"
            }
        ],
        "includeTargets": [
            {
                "id": "all_users",
                "targetType": "group"
            }
        ]
    }
}
```

## FAQ

### How does system-preferred authentication determine the most secure method?

When a user signs in, the authentication process checks which methods are registered. The user is prompted to sign in with the most secure applicable method according to the following order. For passkeys, the system also considers the device and browser, as described in [How passkeys are selected for the current device](#how-passkeys-are-selected-for-the-current-device). The method order is dynamic and updates as the security landscape changes. Users can always cancel and choose a different available sign-in method. If your organization has Conditional Access policies that require specific authentication methods, those policies continue to take priority over the system-preferred authentication order.

When in the **Microsoft managed** state, the system evaluates available credentials and selects the highest-ranked method for both first-factor and second-factor authentication.

| Rank | Credential | Category | Meets requirement for |
|------|-----------|----------|----------------------|
| 1 | [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md) | Recovery | 1FA + MFA |
| 2 | [Passkey](concept-authentication-passkeys-fido2.md)<sup>1</sup> | Phishing-resistant | 1FA + MFA |
| 3 | [Certificate-based authentication (CBA)](concept-certificate-based-authentication.md) | Phishing-resistant | 1FA or 1FA + MFA |
| 4 | [Microsoft Authenticator notifications](concept-authentication-authenticator-app.md) | Passwordless | 1FA + MFA |
| 5 | [External multifactor authentication (MFA)](how-to-authentication-external-method-manage.md) | — | MFA |
| 6 | [Time-based one-time password (TOTP)](concept-authentication-oath-tokens.md)<sup>2</sup> | — | MFA |
| 7 | [Telephony](concept-authentication-phone-options.md)<sup>3</sup> | — | MFA |
| 8 | QR code | Frontline worker | 1FA |
| 9 | Password | — | 1FA |

<sup>1</sup>Includes security keys, passkeys in Authenticator app, synced passkeys, Windows Hello for Business, Microsoft Entra passkey on Windows, and macOS Platform SSO. This row ranks passkeys relative to other authentication methods; it doesn't mean every registered passkey is usable on every device. See [Device-bound, nonportable passkeys](#device-bound-nonportable-passkeys) for platform restrictions. Windows Hello for Business and macOS Platform SSO apply only to first-factor sign-in.

<sup>2</sup>Includes hardware or software TOTP from Microsoft Authenticator, Authenticator Lite, or third-party applications.

<sup>3</sup>Includes SMS and voice calls.

> [!IMPORTANT]
> Certificate-based authentication (CBA) was previously placed last in the system-preferred authentication order due to known issues with CBA and system-preferred authentication. Now that those issues are resolved, starting March 18th, 2026, certificate-based authentication moved to the third position in the authentication order.
>
> With the current Microsoft managed behavior, users are directed to the best available authentication methods for both first and second factors based on the system-preferred MFA ordering. While this avoids presenting the password page by default, users on devices without certificates will fail immediately during CBA and must manually select **Sign in another way** to continue with an alternate method.

### How does system-preferred authentication affect the NPS extension?

System-preferred authentication doesn't affect users who sign in by using the Network Policy Server (NPS) extension. Those users don't see any change to their sign-in experience.

### How does system-preferred authentication work for federated users?

For federated users, first-factor sign-in is unchanged. System-preferred authentication doesn't apply at the first factor, so federated users continue to be routed to their external identity provider to sign in. System-preferred authentication applies only to second-factor authentication for these users.

### How does system-preferred authentication affect first-factor sign-in?

When set to **Microsoft managed**, the system applies the credential ranking to both first-factor and second-factor authentication. For example, if a user has both a password and a passkey available on their current device, they're prompted with the passkey at first-factor sign-in instead of the password. Nonportable platform credentials aren't offered on incompatible operating systems: Windows Hello for Business and Microsoft Entra passkey on Windows aren't offered on non-Windows devices, and macOS Platform SSO isn't offered on non-macOS devices. For more examples, see [Examples of passkey selection](#examples-of-passkey-selection). The user can still select other allowed sign-in options.

When set to **Enabled**, the credential ranking applies only to second-factor authentication. First-factor sign-in behavior remains unchanged.

### Can users still choose a different sign-in method?

Yes. System-preferred authentication prompts users with the highest-ranked credential, but users can still choose other allowed methods during sign-in.

## Related content

* [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
* [How to run a registration campaign to set up Microsoft Authenticator](how-to-mfa-registration-campaign.md)
