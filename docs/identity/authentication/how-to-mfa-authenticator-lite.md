---
title: Enable Authenticator Lite for Outlook mobile
description: Learn about how you can set up Authenticator Lite for Outlook mobile to help users validate their identity.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: justinha
ms.reviewer: guptashi
manager: dougeby
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to encourage users to understand how default protection can improve our security posture.
---
# Enable Authenticator Lite for Outlook mobile

Authenticator Lite is another surface for Microsoft Entra users to complete multifactor authentication (MFA) by using push notifications or time-based one-time passcodes (TOTP) on your Android or iOS device. With Authenticator Lite, users can satisfy an MFA requirement from the convenience of a familiar app. Authenticator Lite is currently enabled in [Outlook mobile](https://www.microsoft.com/microsoft-365/outlook-mobile-for-android-and-ios).

Users receive a notification in Outlook mobile to approve or deny sign-in, or you can copy a TOTP to use during sign-in.

> [!NOTE]
> Use these important security enhancements if you're authenticating via telecom transports:
>
> - The Microsoft-managed value of this feature is enabled in the Authentication methods policy. If you don't want to enable this feature, move the state from **Default** to **Disabled**, or scope it to only a group of users.
> - Authenticator Lite is enabled as part of the Notification through mobile app verification option in the per-user MFA policy. If you don't want this feature enabled, you can disable it in the Authentication methods policy by following the steps in this article.

## Prerequisites

- Your organization needs to enable Authenticator (second factor) push notifications for all users or select groups. We recommend that you enable Authenticator by using the modern [Authentication methods policy](concept-authentication-methods-manage.md#authentication-methods-policy). You can edit the Authentication methods policy by using the Microsoft Entra admin center or Microsoft Graph API. Authenticator Lite isn't eligible for on-premises user accounts or organizations with an active MFA server.

  > [!TIP]
  > We recommend that you also enable [system-preferred MFA](concept-system-preferred-multifactor-authentication.md) when you enable Authenticator Lite. With system-preferred MFA enabled, users try to sign in with Authenticator Lite before they try less secure telephony methods like SMS or voice call.

- If your organization is using the Active Directory Federation Services (AD FS) adapter or Network Policy Server (NPS) extensions, upgrade to the latest versions for a consistent experience.
- Users enabled for shared device mode on Outlook mobile aren't eligible for Authenticator Lite.
- Users must run a minimum Outlook mobile version.

  | Operating system | Outlook version |
  |:----------------:|:---------------:|
  |Android           | 4.2310.1        |
  |iOS               | 4.2312.1        |

## Enable Authenticator Lite

By default, Authenticator Lite is [Microsoft managed](concept-authentication-default-enablement.md#microsoft-managed-settings) in the Authentication methods policy. On June 26, the Microsoft-managed value of this feature changed from `disabled` to `enabled`. Authenticator Lite is also included as part of the **Notification through mobile app** verification option in the per-user MFA policy.

### Disable Authenticator Lite in the Microsoft Entra admin center

To disable Authenticator Lite in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Microsoft Authenticator**.

1. On the **Enable and Target** tab, select **Enable** and **All users** to enable the Authenticator policy for everyone, or add select groups. Set the Authentication mode for these users or groups to **Any** or **Push**.

   Users who aren't enabled for Authenticator can't see the feature. Users who have Authenticator downloaded on the same device on which Outlook is downloaded aren't prompted to register for Authenticator Lite in Outlook. Android users who use a personal and work profile on their device might be prompted to register if Authenticator is present on a different profile from the Outlook application.

   <img width="1112" alt="Microsoft Entra admin center Authenticator settings" src="https://user-images.githubusercontent.com/108090297/228603771-52c5933c-f95e-4f19-82db-eda2ba640b94.png">

1. On the **Configure** tab, for **Microsoft Authenticator on companion applications**, change **Status** to **Disabled**, and then select **Save**.

   <img width="664" alt="Authenticator Lite configuration settings" src="https://user-images.githubusercontent.com/108090297/228603364-53f2581f-a4e0-42ee-8016-79b23e5eff6c.png">

If your organization still manages authentication methods in the per-user MFA policy, you need to disable **Notification through mobile app** as a verification option there in addition to the preceding steps. We recommend that you do this step only after you enable Authenticator in the Authentication methods policy.

You can continue to manage the remainder of your authentication methods in the per-user MFA policy while Authenticator is managed in the modern Authentication methods policy. However, we recommend that you [migrate](how-to-authentication-methods-manage.md) management of all authentication methods to the modern Authentication methods policy. The ability to manage authentication methods in the per-user MFA policy retires on September 30, 2025.

### Enable Authenticator Lite via Graph APIs

| Property | Type | Description |
|----------|------|-------------|
| `excludeTarget` | `featureTarget` | A single entity that's excluded from this feature. <br>You can exclude only one group from Authenticator Lite, which can be a dynamic or nested group.|
| `includeTarget` | `featureTarget` | A single entity that's included in this feature. <br>You can include only one group for Authenticator Lite, which can be a dynamic or nested group.|
| `State` | `advancedConfigState` | Possible values:<br>**Enabled** explicitly enables the feature for the selected group.<br>**Disabled** explicitly disables the feature for the selected group.<br>**Default** allows Microsoft Entra ID to manage whether the feature is enabled or not for the selected group. |

After you identify the single target group, use the following API endpoint to change the `CompanionAppsAllowedState` property under `featureSettings`.

```http
https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/MicrosoftAuthenticator
```

In Graph Explorer, you need to consent to the `Policy.ReadWrite.AuthenticationMethod` permission.

### Request

```JSON
//Retrieve your existing policy via a GET. 
//Leverage the Response body to create the Request body section. Then update the Request body similar to the Request body as shown below.
//Change the query to PATCH and run the query.

{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration",
    "id": "MicrosoftAuthenticator",
    "state": "enabled",
    "isSoftwareOathEnabled": false,
    "excludeTargets": [],
    "featureSettings": {
        "companionAppAllowedState": {
            "state": "enabled",
            "includeTarget": {
                "targetType": "group",
                "id": "s4432809-3bql-5m2l-0p42-8rq4707rq36m"
            },
            "excludeTarget": {
                "targetType": "group",
                "id": "00000000-0000-0000-0000-000000000000"
            }
        }
    },
    "includeTargets@odata.context": "https://graph.microsoft.com/beta/$metadata#authenticationMethodsPolicy/authenticationMethodConfigurations('MicrosoftAuthenticator')/microsoft.graph.microsoftAuthenticatorAuthenticationMethodConfiguration/includeTargets",
    "includeTargets": [
        {
            "targetType": "group",
            "id": "all_users",
            "isRegistrationRequired": false,
            "authenticationMode": "any"
        }
    ]
}
```

## User registration

If users are enabled for Authenticator Lite, they're prompted to register your account directly from Outlook mobile. Authenticator Lite registration isn't available by using [My Sign-Ins](https://aka.ms/mysignins). Users can also enable or disable Authenticator Lite from within Outlook mobile. For more information about the user experience, see [Authenticator Lite support](https://aka.ms/authappliteuserdocs).

:::image type="content" border="true" source="./media/how-to-mfa-authenticator-lite/registration.png" alt-text="Screenshot that shows how to register Authenticator Lite.":::

If users don't have any MFA methods registered, they're prompted to download Authenticator when they begin the registration flow. For the most seamless experience, provision users with a [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md) during Authenticator Lite registration.

## Monitor Authenticator Lite usage

[Sign-in logs](/graph/api/signin-list) can show which app was used to complete user authentication. To view the latest sign-ins, use the following call on the beta API endpoint:

```http
GET auditLogs/signIns
```

If the sign-in was done by phone app notification, under `authenticationAppDeviceDetails` the **clientApp** field returns `microsoftAuthenticator` or **Outlook**.

If a user has registered Authenticator Lite, the user's registered authentication methods include **Microsoft Authenticator (in Outlook)**.

## Push notifications in Authenticator Lite

Push notifications sent by Authenticator Lite aren't configurable and don't depend on the Authenticator feature settings. Authenticator Lite doesn't support passwordless authentication mode. The following table lists the settings for features included in the Authenticator Lite experience. Every authentication includes a number matching prompt and doesn't include app and location context, regardless of Authenticator feature settings.

| Authenticator feature    | Authenticator Lite experience|
|:------------------------:|:----------------------------:|
| Number matching          | Enabled                      |
| Location context         | Disabled                     |
| Application context      | Disabled                     |

The following screenshots show what users see when Authenticator Lite sends a push notification.

:::image type="content" border="true" source="./media/how-to-mfa-authenticator-lite/notification.png" alt-text="Screenshot that shows push notification in Outlook mobile.":::

## AD FS adapter and NPS extension

Authenticator Lite enforces number matching in every authentication. If your tenant is using an AD FS adapter or an NPS extension, your users might not be able to complete Authenticator Lite notifications. For more information, see [AD FS adapter](how-to-mfa-number-match.md#ad-fs-adapter) and [NPS extension](how-to-mfa-number-match.md#nps-extension).

To learn more about verification notifications, see [Microsoft Authenticator authentication method](concept-authentication-authenticator-app.md).

## Common questions

The following sections list common questions.

### Does Authenticator Lite work as a broker app?

No, Authenticator Lite is available only for push notifications and TOTP.

### Can Authenticator Lite be used for SSPR?

No, Authenticator Lite is available only for push notifications and TOTP.

### Is Authenticator Lite available in the Outlook desktop app?

No, Authenticator Lite is available only on Outlook mobile.

### Where can users register for Authenticator Lite?

Users can register for Authenticator Lite only from mobile Outlook. Authenticator Lite registration is managed from [My Sign-Ins](https://aka.ms/mysignins).

### Can users register Authenticator and Authenticator Lite?

Users who have Authenticator on their device can't register Authenticator Lite on that same device. If a user has an Authenticator Lite registration and then later downloads Authenticator, they can register both. If a user has two devices, they can register Authenticator Lite on one and Authenticator on the other.

## Known issues

The following issues are known.

### SSPR notifications

TOTP codes from Outlook work for SSPR, but the push notification won't work and returns an error.

### Logs are showing added Conditional Access evaluations

The Conditional Access policies are evaluated each time a user opens their Outlook app to determine whether they're eligible to register for Authenticator Lite. These checks might appear in logs.

## Related content

- [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
