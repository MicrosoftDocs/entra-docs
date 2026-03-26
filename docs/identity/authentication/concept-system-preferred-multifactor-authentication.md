---
title: System-preferred multifactor authentication (MFA)
description: Learn how system-preferred multifactor authentication and device-preferred credential evaluate methods to prompt users with the most secure sign-in option.
ms.topic: how-to
ms.date: 03/18/2026
ms.reviewer: msft-poulomi
ms.custom: msecd-doc-authoring-106
author: Justinha
ms.author: Justinha

# Customer intent: As an identity administrator, I want to encourage users to sign in with the most secure authentication method so that I can improve my organization's sign-in security.
---

# System-preferred multifactor authentication

System-preferred multifactor authentication (MFA) prompts users to sign in by using the most secure method they registered. 
It's an important security enhancement for users who authenticate by using phone-based methods.
Administrators can enable system-preferred MFA to improve sign-in security and discourage less secure sign-in methods like Short Message Service (SMS).

For example, if a user registered both SMS and Microsoft Authenticator push notifications as methods for MFA, system-preferred MFA prompts the user to sign in by using the more secure push notification method. The user can still choose to sign in by using another method, but they're first prompted to try the most secure method they registered. 

System-preferred MFA is a Microsoft managed setting, which is a [tristate policy](#authentication-method-feature-configuration-properties). The **Microsoft managed** value of system-preferred MFA is **Enabled**. If you don't want to enable system-preferred MFA, change the state from **Microsoft managed** to **Disabled**, or exclude users and groups from the policy.

After system-preferred MFA is enabled, the authentication system does all the work. Users don't need to set any authentication method as their default because the system always determines and presents the most secure method they registered. 

With device-preferred credential (preview), system-preferred authentication evaluates which credentials are available on the user's device at sign-in time, and prompts the user with the strongest option.

## Device-preferred credential (preview)

Device-preferred credential is a sign-in enhancement that replaces the existing most-recently-used (MRU) credential logic. Instead of defaulting users to the credential they last used at an account level, device-preferred credential evaluates the best available credential on the user's device at sign-in time.

For example, if a user previously signed in with SMS but also has a passkey available on their device, device-preferred credential prompts the user with the passkey instead.

### Device-preferred credential modes

Device-preferred credential has three modes:

- **Disabled** - No change to sign-in logic. The existing MRU logic continues to apply.
- **Enabled** - Device-preferred credential logic applies to second-factor (MFA) only for scoped users.
- **Microsoft managed** - Device-preferred credential uses Microsoft-managed defaults for second-factor (MFA) only. A toggle for **Apply to both primary and multifactor authentication (preview)** controls whether the feature also applies to primary authentication:
  - **Off** (default) - Device-preferred credential applies to second-factor only.
  - **On** - Device-preferred credential applies to both primary and secondary authentication.

Both **Enabled** and **Microsoft managed** modes allow administrators to include or exclude specific users or groups.

> [!NOTE]
> Device-preferred credential is scoped to users, not devices. Administrators include or exclude users or groups but can't assign device-preferred credential to specific devices or device groups. The device context is evaluated dynamically during sign-in.

### Known limitations

- When you change the policy for a target group, the change might not take effect on the user's very next sign-in. It applies to all subsequent sign-ins after that.
- Conditional Access policy is validated only for MFA and doesn't apply to first-factor authentication.

## Enable system-preferred MFA in the Microsoft Entra admin center

By default, system-preferred MFA is Microsoft managed and enabled for all users. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Microsoft Entra ID** > **Authentication methods** > **Settings**.
1. For **System-preferred multifactor authentication**, choose whether to explicitly enable or disable the feature, and include or exclude any users. Excluded groups take precedence over include groups.

   When you set the state to **Microsoft managed**, a toggle for **Apply to both primary and multifactor authentication (preview)** appears. Turn on the toggle to apply device-preferred credential logic to both primary and secondary authentication. When the toggle is off (default), device-preferred credential applies to second-factor only.

   For example, the following screenshot shows how to make system-preferred MFA explicitly enabled for only the Engineering group.

   :::image type="content" border="true" source="./media/concept-system-preferred-multifactor-authentication/enable.png" alt-text="Screenshot of the system-preferred multifactor authentication settings in the Microsoft Entra admin center, showing the feature enabled for the Engineering group.":::

1. After you finish making any changes, select **Save**. 

## Enable system-preferred MFA by using Graph APIs

To enable system-preferred MFA in advance, you need to choose a single target group for the schema configuration, as shown in the [Request](#request) example. 

### Authentication method feature configuration properties

By default, system-preferred MFA is [Microsoft managed](concept-authentication-default-enablement.md#microsoft-managed-settings) and enabled. 

| Property | Type | Description |
|----------|------|-------------|
| excludeTarget | featureTarget | A single entity that is excluded from this feature. <br>You can only exclude one group from system-preferred MFA, which can be a dynamic or nested group.|
| includeTarget | featureTarget | A single entity that is included in this feature. <br>You can only include one group for system-preferred MFA, which can be a dynamic or nested group.|
| State | advancedConfigState | Possible values are:<br>**enabled** explicitly enables the feature for the selected group.<br>**disabled** explicitly disables the feature for the selected group.<br>**default** allows Microsoft Entra ID to manage whether the feature is enabled or not for the selected group. |

### Feature target properties

System-preferred MFA can be enabled only for a single group, which can be a dynamic or nested group. 

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

### How does system-preferred MFA determine the most secure method?

When a user signs in, the authentication process checks which authentication methods are registered for the user. The user is prompted to sign in with the most secure method according to the following order. The order of authentication methods is dynamic, and updated as the security landscape changes and as better authentication methods emerge. Users can always cancel and choose a different available sign-in method. If your organization has Conditional Access policies that require specific authentication methods, those policies continue to take priority over the system-preferred MFA order.

When device-preferred credential is enabled, the system evaluates which credentials are available on the user's device and selects the highest-ranked method from this list.

| Rank | Credential | Category | Meets requirement for |
|------|-----------|----------|----------------------|
| 1 | [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md) | Recovery | 1FA + MFA |
| 2 | [Passkey](concept-authentication-passwordless.md#passkeys-fido2)<sup>1</sup> | Phishing-resistant | 1FA + MFA |
| 3 | [Certificate-based authentication (CBA)](concept-certificate-based-authentication.md) | Phishing-resistant | 1FA or 1FA + MFA |
| 4 | [Microsoft Authenticator notifications](concept-authentication-authenticator-app.md) | Passwordless | 1FA + MFA |
| 5 | [External multifactor authentication (MFA)](how-to-authentication-external-method-manage.md) | — | MFA |
| 6 | [Time-based one-time password (TOTP)](concept-authentication-oath-tokens.md)<sup>2</sup> | — | MFA |
| 7 | [Telephony](concept-authentication-phone-options.md)<sup>3</sup> | — | MFA |
| 8 | QR code | Frontline worker | 1FA |
| 9 | Password | — | 1FA |

<sup>1</sup>Includes security keys, passkeys in Authenticator app, synced passkeys, Windows Hello for Business, and macOS Platform SSO.

<sup>2</sup>Includes hardware or software TOTP from Microsoft Authenticator, Authenticator Lite, or third-party applications.

<sup>3</sup>Includes SMS and voice calls.

### How does system-preferred MFA affect the NPS extension?

System-preferred MFA doesn't affect users who sign in by using the Network Policy Server (NPS) extension. Those users don't see any change to their sign-in experience.

### What happens for users who aren't specified in the Authentication methods policy but enabled in the legacy MFA tenant-wide policy?

The system-preferred MFA also applies for users who are enabled for MFA in the legacy MFA policy.

:::image type="content" border="true" source="./media/how-to-mfa-number-match/legacy-settings.png" alt-text="Screenshot of legacy MFA settings.":::

### How is device-preferred credential different from the previous sign-in behavior?

The previous most-recently-used (MRU) logic selected the credential last used by the user at an account level. Device-preferred credential replaces this logic by evaluating device context and available credentials at sign-in time, then selecting the strongest applicable method.

### Do administrators need to configure credentials for each device?

No. The credential sort order is system-defined. Administrators don't need to configure credential priority per user or per device. Device-preferred credential automatically evaluates which credentials are available and supported on the device at sign-in time.

### Can users still choose a different sign-in method with device-preferred credential?

Yes. Device-preferred credential prompts users with the best available credential, but users can still choose other allowed methods during sign-in. The system doesn't change the default based on the user's choice.

## Next steps

* [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
* [How to run a registration campaign to set up Microsoft Authenticator](how-to-mfa-registration-campaign.md)
