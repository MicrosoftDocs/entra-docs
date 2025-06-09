---
title: Enable per-user multifactor authentication
description: Learn how to enable per-user Microsoft Entra multifactor authentication by changing the user state
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: lvandenende
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-image-nochange
---
# Enable per-user Microsoft Entra multifactor authentication to secure sign-in events

To secure user sign-in events in Microsoft Entra ID, you can require Microsoft Entra multifactor authentication (MFA). The best way to protect users with Microsoft Entra MFA is to create a Conditional Access policy. Conditional Access is a Microsoft Entra ID P1 or P2 feature that lets you apply rules to require MFA as needed in certain scenarios. To get started using Conditional Access, see [Tutorial: Secure user sign-in events with Microsoft Entra multifactor authentication](tutorial-enable-azure-mfa.md).

For Microsoft Entra ID Free tenants without Conditional Access, you can [use security defaults to protect users](~/fundamentals/security-defaults.md). Users are prompted for MFA as needed, but you can't define your own rules to control the behavior.

If needed, you can instead enable each account for per-user Microsoft Entra MFA. When you enable users individually, they perform MFA each time they sign in. You can enable exceptions, such as when they sign in from trusted IP addresses, or when the **remember MFA on trusted devices** feature is turned on.

Changing [user states](#azure-ad-multi-factor-authentication-user-states) isn't recommended unless your Microsoft Entra ID licenses don't include Conditional Access and you don't want to use security defaults. For more information on the different ways to enable MFA, see [Features and licenses for Microsoft Entra multifactor authentication](concept-mfa-licensing.md).

> [!IMPORTANT]
>
> This article details how to view and change the status for per-user Microsoft Entra multifactor authentication. If you use Conditional Access or security defaults, you don't review or enable user accounts using these steps.
>
> Enabling Microsoft Entra multifactor authentication through a Conditional Access policy doesn't change the state of the user. Don't be alarmed if users appear disabled. Conditional Access doesn't change the state.
>
> **Don't enable or enforce per-user Microsoft Entra multifactor authentication if you use Conditional Access policies.**

<a name='azure-ad-multi-factor-authentication-user-states'></a>

## Microsoft Entra multifactor authentication user states

A user's state reflects whether an Authentication Administrator enrolled them in per-user Microsoft Entra multifactor authentication. User accounts in Microsoft Entra multifactor authentication have the following three distinct states:

| State | Description | Legacy authentication affected | Browser apps affected | Modern authentication affected |
|:---:| --- |:---:|:--:|:--:|
| Disabled | The default state for a user not enrolled in per-user Microsoft Entra multifactor authentication. | No | No | No |
| Enabled | The user is enrolled in per-user Microsoft Entra multifactor authentication, but can still use their password for legacy authentication. If the user has no registered MFA authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser). | No. Legacy authentication continues to work until the registration process is completed. | Yes. After the session expires, Microsoft Entra multifactor authentication registration is required.| Yes. After the access token expires, Microsoft Entra multifactor authentication registration is required. |
| Enforced | The user is enrolled per-user in Microsoft Entra multifactor authentication. If the user has no registered authentication methods, they receive a prompt to register the next time they sign in using modern authentication (such as when they sign in on a web browser). Users who complete registration while they're *Enabled* are automatically moved to the *Enforced* state. | Yes. Apps require app passwords. | Yes. Microsoft Entra multifactor authentication is required at sign-in. | Yes. Microsoft Entra multifactor authentication is required at sign-in. |

All users start out *Disabled*. When you enroll users in per-user Microsoft Entra multifactor authentication, their state changes to *Enabled*. When enabled users sign in and complete the registration process, their state changes to *Enforced*. Administrators may move users between states, including from *Enforced* to *Enabled* or *Disabled*.

> [!NOTE]
> If per-user MFA is re-enabled on a user and the user doesn't re-register, their MFA state doesn't transition from *Enabled* to *Enforced* in MFA management UI. The administrator must move the user directly to *Enforced*.

## View the status for a user

The per-user MFA administration experience in the Microsoft Entra admin center is recently improved. To view and manage user states, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select a user account, and select **User MFA settings**.
1. After you make any changes, select **Save**.

   :::image type="content" border="true" source="./media/howto-mfa-userstates/user-states.png" alt-text="Screenshot that shows an example of MFA settings for a user.":::

   If you try to sort thousands of users, the result might gracefully return **There are no users to display**.
   Try to enter more specific search criteria to narrow the search, or apply specific **Status** or **View** filters.

   :::image type="content" border="true" source="./media/howto-mfa-userstates/sort.png" alt-text="Screenshot that shows an example of how to filter a large user sort.":::


## Change the status for a user

To change the per-user Microsoft Entra multifactor authentication state for a user, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select a user account, and select **Enable MFA**. 
   :::image type="content" border="true" source="./media/howto-mfa-userstates/new-enable.png" alt-text="Screenshot that shows how to enable a user for Microsoft Entra multifactor authentication.":::

   > [!TIP]
   > *Enabled* users are automatically switched to *Enforced* when they register for Microsoft Entra multifactor authentication. Don't manually change the user state to *Enforced* unless the user is already registered or if it is acceptable for the user to experience interruption in connections to legacy authentication protocols.

1. Confirm your selection in the pop-up window that opens.

After you enable users, notify them by email. Tell the users that a prompt is displayed to ask them to register the next time they sign in. If your organization uses applications that don't run in a browser or support modern authentication, you can create application passwords. For more information, see [Enforce Microsoft Entra multifactor authentication with legacy applications using app passwords](howto-mfa-app-passwords.md).

## Use Microsoft Graph to manage per-user MFA

You can manage per-user MFA settings by using the Microsoft Graph REST API Beta. You can use the [authentication resource type](/graph/api/resources/authentication) to expose authentication method states for users. 

To manage per-user MFA, use the perUserMfaState property within users/id/authentication/requirements. For more information, see [strongAuthenticationRequirements resource type](/graph/api/resources/strongauthenticationrequirements).

### View per-user MFA state 

To retrieve the per-user multifactor authentication state for a user:

``` http
GET /users/{id | userPrincipalName}/authentication/requirements
```

For example:

``` http
GET https://graph.microsoft.com/beta/users/071cc716-8147-4397-a5ba-b2105951cc0b/authentication/requirements
```

If the user is enabled for per-user MFA, the response is:

``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "perUserMfaState": "enforced"
}
```

For more information, see [Get authentication method states](/graph/api/authentication-get).

### Change MFA state for a user

To change multifactor authentication state for a user, use the user's strongAuthenticationRequirements. For example:

``` http
PATCH https://graph.microsoft.com/beta/users/071cc716-8147-4397-a5ba-b2105951cc0b/authentication/requirements
Content-Type: application/json

{
  "perUserMfaState": "disabled"
}
```

If successful, the response is:

```http
HTTP/1.1 204 No Content
```

For more information, see [Update authentication method states](/graph/api/authentication-update).

## Next steps

To configure Microsoft Entra multifactor authentication settings, see  [Configure Microsoft Entra multifactor authentication settings](howto-mfa-mfasettings.md).

To manage user settings for Microsoft Entra multifactor authentication, see [Manage user settings with Microsoft Entra multifactor authentication](howto-mfa-userdevicesettings.yml).

To understand why a user was prompted or not prompted to perform MFA, see [Microsoft Entra multifactor authentication reports](howto-mfa-reporting.md).
