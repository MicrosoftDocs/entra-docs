---
title: System-preferred multifactor authentication (MFA)
description: Learn how system-preferred multifactor authentication evaluates methods to prompt users with the most secure sign-in option.
ms.topic: how-to
ms.date: 04/15/2026
ms.reviewer: msft-poulomi
ms.custom: msecd-doc-authoring-106
author: Justinha
ms.author: Justinha
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to encourage users to sign in with the most secure authentication method so that I can improve my organization's sign-in security.
---

# System-preferred multifactor authentication

System-preferred multifactor authentication (MFA) prompts users to sign in by using the most secure method they registered. 
It's an important security enhancement for users who authenticate by using phone-based methods.
Administrators can enable system-preferred MFA to improve sign-in security and discourage less secure sign-in methods like Short Message Service (SMS).

For example, if a user registered both SMS and Microsoft Authenticator push notifications as methods for MFA, system-preferred MFA prompts the user to sign in by using the more secure push notification method. The user can still choose to sign in by using another method, but they're first prompted to try the most secure method they registered. 

System-preferred MFA is a Microsoft managed setting, which is a [tristate policy](#authentication-method-feature-configuration-properties). The **Microsoft managed** value of system-preferred MFA is **Enabled**. If you don't want to enable system-preferred MFA, change the state from **Microsoft managed** to **Disabled**, or exclude users and groups from the policy.

After system-preferred MFA is enabled, the authentication system does all the work. Users don't need to set any authentication method as their default because the system always determines and presents the most secure method they registered. 

### Known limitations

- When you change the policy for a target group, the change might not take effect on the user's very next sign-in. It applies to all subsequent sign-ins after that.
- Conditional Access policy is validated only for MFA and doesn't apply to first-factor authentication.

## Enable system-preferred MFA in the Microsoft Entra admin center

By default, system-preferred MFA is Microsoft managed and enabled for all users. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Microsoft Entra ID** > **Authentication methods** > **Settings**.
1. For **System-preferred multifactor authentication**, choose whether to explicitly enable or disable the feature, and include or exclude any users. Excluded groups take precedence over include groups.

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

| Rank | Credential| Category | Meets requirement for |
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

<sup>1</sup>Includes security keys, passkeys in Authenticator app, synced passkeys, Windows Hello for Business, and macOS Platform SSO.

<sup>2</sup>Includes hardware or software TOTP from Microsoft Authenticator, Authenticator Lite, or third-party applications.

<sup>3</sup>Includes SMS and voice calls.

>[!IMPORTANT]
>Certificate-based authentication (CBA) was previously placed last in the system-preferred MFA order due to known issues with CBA and system-preferred MFA. Now that those issues are resolved, starting March 18th, 2026, certificate-based authentication moved to the third position in the authentication order.

### How does system-preferred MFA affect the NPS extension?

System-preferred MFA doesn't affect users who sign in by using the Network Policy Server (NPS) extension. Those users don't see any change to their sign-in experience.

### What happens for users who aren't specified in the Authentication methods policy but enabled in the legacy MFA tenant-wide policy?

The system-preferred MFA also applies for users who are enabled for MFA in the legacy MFA policy.

:::image type="content" border="true" source="./media/how-to-mfa-number-match/legacy-settings.png" alt-text="Screenshot of legacy MFA settings.":::

### Can users still choose a different sign-in method?

Yes. System-preferred MFA prompts users with the most secure registered credential, but users can still choose other allowed methods during sign-in.

## Next steps

* [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
* [How to run a registration campaign to set up Microsoft Authenticator](how-to-mfa-registration-campaign.md)
