---
title: Passwordless sign-in with Authenticator
description: Enable passwordless sign-in to Microsoft Entra ID by using Microsoft Authenticator.


ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref
ms.topic: how-to
ms.date: 10/04/2024


ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: jogro
---

# Enable passwordless sign-in with Authenticator

You can use Authenticator to sign in to any Microsoft Entra account without using a password. Authenticator uses key-based authentication to enable a user credential that's tied to a device, where the device uses a PIN or biometric. [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification) uses a similar technology.

Authentication technology can be used on any device platform, including mobile. You can also use this technology with any app or website that integrates with Authentication Libraries.

:::image type="content" border="false" source="./media/howto-authentication-passwordless-phone/phone-sign-in-microsoft-authenticator-app-next.png" alt-text="Screenshot that shows an example of a browser sign-in asking for the user to approve the sign-in.":::

Phone sign-in from Authenticator shows a message that asks you to tap a number in the app. No username or password is asked for. To complete the sign-in process in the app, follow these steps:

1. Enter the number you see on the sign-in screen in to the Authenticator dialog.
1. Select **Approve**.
1. Provide your PIN or biometric.

## Multiple accounts

You can enable passwordless phone sign-in for multiple accounts in Authenticator on any supported Android or iOS device. Consultants, students, and other users with multiple accounts in Microsoft Entra ID can add each account to Authenticator and use passwordless phone sign-in for all of them from the same device.

Previously, admins might not require passwordless sign-in for users with multiple accounts because it requires them to carry more devices for sign-in. By removing the limitation of one user sign-in from a device, admins can more confidently encourage users to register passwordless phone sign-in and use it as their default sign-in method.

The Microsoft Entra accounts can be in the same tenant or different tenants. Guest accounts aren't supported for multiple account sign-ins from one device.

## Prerequisites

To use passwordless phone sign-in with Authenticator, the following prerequisites must be met:

- Recommended: Microsoft Entra multifactor authentication (MFA), with push notifications allowed as a verification method. Push notifications to your smartphone or tablet help the Authenticator app to prevent unauthorized access to accounts and stop fraudulent transactions. The Authenticator app automatically generates codes when set up to do push notifications. A user has a backup sign-in method even if their device doesn't have connectivity.
- Latest version of Authenticator installed on devices running iOS or Android.
- The device must be registered with each tenant where it's used to sign in. For example, the following device must be registered with Contoso and Wingtiptoys to allow all accounts to sign in:
  - balas@contoso.com
  - balas@wingtiptoys.com and bsandhu@wingtiptoys

To use passwordless authentication in Microsoft Entra ID, first enable the combined registration experience, and then enable users for the passwordless method.

## Enable passwordless phone sign-in authentication methods

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Microsoft Entra ID lets [Authentication Policy administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) choose which authentication methods can be used to sign in. They can enable **Microsoft Authenticator** in the Authentication methods policy to manage both the traditional push MFA method and the passwordless authentication method.

After **Microsoft Authenticator** is enabled as an authentication method, users can go to their [Security info](https://aka.ms/mysecurityinfo) to register Microsoft Authenticator as a way to sign in. They see Microsoft Authenticator listed as a method on the **Security info** pane. For example, **Microsoft Authenticator-Passwordless** or **Microsoft Authenticator-MFA Push** appears depending on what's enabled and registered.

To enable the authentication method for passwordless phone sign-in, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Policies**.
1. Under **Microsoft Authenticator**, select the following options:
   1. **Enable**: Select **Yes** or **No**.
   1. **Target**: Select **All users** or **Select users**.
1. Each added group or user is enabled by default to use Authenticator in both passwordless and push notification modes (**Any** mode). To change the mode, for each row for **Authentication mode**, select **Any** or **Passwordless**. Selecting **Push** prevents the use of the passwordless phone sign-in credential.
1. To apply the new policy, select **Save**.

   > [!NOTE]
   > If you see an error when you try to save, the cause might be because of the number of users or groups being added. As a workaround, replace the users and groups you're trying to add with a single group in the same operation. Then select **Save** again.

## User registration

Users register themselves for the passwordless authentication method of Microsoft Entra ID. For users who already registered the Authenticator app for [multifactor authentication](./concept-mfa-howitworks.md), skip to the next section, and [enable phone sign-in](#enable-phone-sign-in).

### Direct phone sign-in registration

Users can register for passwordless phone sign-in directly within the Authenticator app without the need to first registering Authenticator with their account, all while never accruing a password. Here's how:

1. Acquire a [Temporary Access Pass](~/identity/authentication/howto-authentication-temporary-access-pass.md) from your admin or organization.
1. Download and install the Authenticator app on your mobile device.
1. Open Authenticator and select **Add account** and then choose **Work or school account.**
1. Select **Sign in**.
1. Follow the instructions to sign in with your account by using the Temporary Access Pass provided by your admin or organization.
1. After sign-in, continue following the extra steps to set up phone sign-in.

### Guided registration with My Sign-ins

> [!NOTE]
> Users will only be able to register Authenticator via combined registration if the Authenticator authentication mode is to Any or Push.

To register the Authenticator app, follow these steps:

1. Browse to [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo).
1. Sign in, then select **Add method** > **Authenticator app** > **Add** to add Authenticator.
1. Follow the instructions to install and configure the Authenticator app on your device.
1. Select **Done** to complete Authenticator configuration.

#### Enable phone sign-in

After users registered themselves for the Authenticator app, they need to enable phone sign-in:

1. In **Microsoft Authenticator**, select the account registered.
1. Select **Enable phone sign-in**.
1. Follow the instructions in the app to finish registering the account for passwordless phone sign-in.

An organization can direct its users to sign in with their phones, without using a password. For further assistance configuring Authenticator and enabling phone sign-in, see [Sign in to your accounts using the Authenticator app](https://support.microsoft.com/account-billing/sign-in-to-your-accounts-using-the-microsoft-authenticator-app-582bdc07-4566-4c97-a7aa-56058122714c).

> [!NOTE]
> Users who aren't allowed by policy to use phone sign-in are no longer able to enable it within Authenticator.

## Sign in with passwordless credential

A user can start using passwordless sign-in after all the following actions are completed:

- An admin has enabled the user's tenant.
- The user has added Authenticator as a sign-in method.

The first time a user starts the phone sign-in process, the user follows these steps:

1. Enter your name at the sign-in page.
1. Select **Next**.
1. If necessary, select **Other ways to sign in**.
1. Select **Approve a request on my Authenticator app**.

The user is then presented with a number. The app prompts the user to authenticate by typing the appropriate number, instead of by entering a password.

After the user has used passwordless phone sign-in, the app continues to guide the user through this method. However, the user sees the option to choose another method.

:::image type="content" border="true" source="./media/howto-authentication-passwordless-phone/number.png" alt-text="Screenshot that shows an example of a browser sign-in by using the Authenticator app.":::

#### Temporary Access Pass

If the tenant administrator has enabled Self-Service Password Reset (SSPR) and a user is setting up passwordless sign-in with the Authenticator app for the first time by using a Temporary Access Password, the following steps should be followed:

1. The user should open a browser on a mobile device or desktop and navigate to the [mySecurity](https://aka.ms/mysecurityinfo) info page.
1. The user must register the Authenticator App as their sign-in method. This action links the user's account to the app.
1. The user should then return to their mobile device and activate passwordless sign-in through the Authenticator App.

## Management

We recommend the Authentication methods policy as the best way to manage Authenticator. [Authentication Policy administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) can edit this policy to enable or disable Authenticator. Admins can include or exclude specific users and groups from using it.

Admins can also configure parameters to better control how Authenticator can be used. For example, they can add location or app name to the sign-in request so users have greater context before they approve.

## Known issues

The following known issues exist.

### Not seeing option for passwordless phone sign-in

In one scenario, a user can have an unanswered passwordless phone sign-in verification that's pending. If the user attempts to sign in again, they might only see the option to enter a password.

To resolve this scenario, follow these steps:

1. Open Authenticator.
1. Respond to any notification prompts.

Then the user can continue to use passwordless phone sign-in.

### AuthenticatorAppSignInPolicy not supported

The `AuthenticatorAppSignInPolicy` is a legacy policy that is not supported with Authenticator. In order to enable your users for push notifications or passwordless phone sign-in with the Authenticator app, use the [Authentication Methods policy](concept-authentication-methods-manage.md).

### Federated accounts

When a user has enabled any passwordless credential, the Microsoft Entra sign-in process stops using the `login\_hint`. The process no longer accelerates the user toward a federated sign-in location.

This logic generally prevents a user in a hybrid tenant from being directed to Active Directory Federated Services (AD FS) for sign-in verification. However, the user retains the option of selecting **Use your password instead**.

### On-premises users

A user can be enabled for MFA through an on-premises identity provider. The user can still create and use a single passwordless phone sign-in credential.

If the user attempts to upgrade multiple installations (5+) of Authenticator with the passwordless phone sign-in credential, this change might result in an error.

## Related content

To learn about Microsoft Entra authentication and passwordless methods, see the following articles:

- [Learn how passwordless authentication works](concept-authentication-passwordless.md)
- [Learn about device registration](~/identity/devices/overview.md)
- [Learn about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
