---
title: Passwordless sign-in with Authenticator
description: Learn how to enable passwordless sign-in to Microsoft Entra ID by using Microsoft Authenticator.
ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, sfi-image-nochange
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: femila
ms.reviewer: jogro
---

# Enable passwordless sign-in with Authenticator

Authenticator is used to sign in to any Microsoft Entra account without using a password. Authenticator uses key-based authentication to enable a user credential that's tied to a device, where the device uses a PIN or biometric. [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification) uses a similar technology.

Authentication technology can be used on any device platform, including mobile. Authenticator can run on either iOS or Android.

:::image type="content" border="false" source="./media/howto-authentication-passwordless-phone/phone-sign-in-microsoft-authenticator-app-next.png" alt-text="Screenshot that shows an example of a browser sign-in asking the user to approve the sign-in.":::

Phone sign-in from Authenticator shows a message that asks the user to tap a number in the app. It doesn't ask for a username or password. To complete the sign-in process in the app, follow these steps:

1. In the Authenticator dialog, enter the number shown on the sign-in screen.
1. Select **Approve**.
1. Provide your PIN or biometric.

## Multiple accounts

You can enable passwordless phone sign-in for multiple accounts in Authenticator on any supported Android or iOS device. Consultants, students, and other users with multiple accounts in Microsoft Entra ID can add each account to Authenticator and use passwordless phone sign-in for all of them from the same device.

The Microsoft Entra accounts can be in the same tenant or different tenants. Guest accounts aren't supported for multiple account sign-ins from one device.

## Prerequisites

To use passwordless phone sign-in with Authenticator, you must meet the following prerequisites:

- Recommended: Microsoft Entra multifactor authentication (MFA), with push notifications allowed as a verification method. Push notifications to a user smartphone or tablet help the Authenticator app to prevent unauthorized access to accounts and stop fraudulent transactions. The Authenticator app automatically generates codes when set up to do push notifications. A user has a backup sign-in method even if their device doesn't have connectivity.
- The device must be registered with each tenant where it's used to sign in. For example, the following device must be registered with Contoso and Wingtip Toys to allow all accounts to sign in:

  - balas@contoso.com
  - balas@wingtiptoys.com and bsandhu@wingtiptoys

To use passwordless authentication in Microsoft Entra ID, first enable the combined registration experience, and then enable users for the passwordless method.

## Enable passwordless phone sign-in authentication methods


Microsoft Entra ID lets [Authentication Policy Administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) choose which authentication methods can be used to sign in. You can enable **Microsoft Authenticator** in the Authentication methods policy to manage both the traditional push MFA method and the passwordless authentication method.

After **Microsoft Authenticator** is enabled as an authentication method, users can go to [Security info](https://aka.ms/mysecurityinfo) to register Authenticator as a way to sign in. **Microsoft Authenticator** is listed as a method on **Security info**. For example, **Microsoft Authenticator-Passwordless** or **Microsoft Authenticator-MFA Push** appears, depending on what's enabled and registered.

To enable the authentication method for passwordless phone sign-in, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Policies**.

Each group is enabled by default to use **Any** mode. **Any** mode allows group members to sign in with either a push notification or passwordless phone sign-in.

   > [!NOTE]
   > If you see an error when you try to save, it might be because of the number of users or groups being added. As a workaround, replace the users and groups that you're trying to add with a single group in the same operation. Then select **Save** again.

## User registration

Users register for the passwordless authentication method of Microsoft Entra ID. Users who already registered the Authenticator app for [MFA](./concept-mfa-howitworks.md) can skip to the next section and [enable phone sign-in](#enable-phone-sign-in).

### Direct phone sign-in registration

Users can register for passwordless phone sign-in directly within the Authenticator app without the need to first register Authenticator with their account, all while never accruing a password. Here's how:

1. Acquire a [Temporary Access Pass](~/identity/authentication/howto-authentication-temporary-access-pass.md) from your admin or organization.
1. Download and install the Authenticator app on your mobile device.
1. Open Authenticator and select **Add account**, and then select **Work or school account**.
1. Select **Sign in**.
1. Follow the instructions to sign in with your account by using the Temporary Access Pass provided by your admin or organization.
1. After sign-in, continue following the extra steps to set up phone sign-in.

### Guided registration with My Sign-Ins

> [!NOTE]
> Users can register Authenticator via combined registration only if the Authenticator authentication mode is set to **Any** or **Push**.

To register the Authenticator app, follow these steps:

1. Browse to [Security info](https://aka.ms/mysecurityinfo).
1. Sign in, and then select **Add method** > **Authenticator app** > **Add** to add Authenticator.
1. Follow the instructions to install and configure the Authenticator app on your device.
1. Select **Done** to finish the Authenticator configuration.

#### Enable phone sign-in

After users register for the Authenticator app, they need to enable phone sign-in:

1. In **Microsoft Authenticator**, select the account registered.
1. Select **Set up Passwordless sign-in requests**.
1. Follow the instructions in the app to finish registering the account for passwordless phone sign-in.

An organization can direct its users to sign in with their phones, without using a password. For further assistance configuring Authenticator and enabling phone sign-in, see [Sign in to your accounts by using the Authenticator app](https://support.microsoft.com/account-billing/sign-in-to-your-accounts-using-the-microsoft-authenticator-app-582bdc07-4566-4c97-a7aa-56058122714c).

> [!NOTE]
> If a policy restricts the user from using phone sign-in, the user can't enable it within Authenticator.

## Sign in with a passwordless credential

A user can start using passwordless sign-in after all the following actions are completed:

- An admin enabled the user's tenant.
- The user added Authenticator as a sign-in method.

To start the phone sign-in process for the first time, follow these steps:

1. Enter your name on the **Sign-in** pane.
1. Select **Next**.
1. If necessary, select **Other ways to sign in**.
1. Select **Approve a request on my Authenticator app**.

A number then appears. The app prompts the user to authenticate by entering the appropriate number instead of by entering a password.

After the user uses passwordless phone sign-in, the app continues to guide the user through this method. The user also sees the option to choose another method.

:::image type="content" border="true" source="./media/howto-authentication-passwordless-phone/number.png" alt-text="Screenshot that shows an example of a browser sign-in by using the Authenticator app.":::

#### Temporary Access Pass

If the tenant administrator enabled self-service password reset for users to set up passwordless sign-in with the Authenticator app for the first time by using a Temporary Access Pass, follow these steps:

1. Open a browser on a mobile device or desktop, and go to [Security info](https://aka.ms/mysecurityinfo).
1. Register the Authenticator app as your sign-in method. This action links your account to the app.
1. Return to your mobile device and activate passwordless sign-in through the Authenticator app.

## Management

We recommend the Authentication methods policy as the best way to manage Authenticator. [Authentication Policy Administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) can edit this policy to enable or disable Authenticator. Admins can include or exclude specific users and groups from using it.

Admins can also configure parameters to better control how Authenticator is used. For example, they can add a location or the app name to the sign-in request so that users have greater context before they approve.

## Known issues

The following known issues exist.

### Not seeing the option for passwordless phone sign-in

In one scenario, a user might have an unanswered passwordless phone sign-in verification that's pending. If the user attempts to sign in again, the user sees only the option to enter a password.

To resolve this scenario, follow these steps:

1. Open Authenticator.
1. Respond to any notification prompts.

Then continue to use passwordless phone sign-in.

### AuthenticatorAppSignInPolicy not supported

The legacy policy `AuthenticatorAppSignInPolicy` isn't supported with Authenticator. To enable users for push notifications or passwordless phone sign-in with the Authenticator app, use the [Authentication Methods policy](concept-authentication-methods-manage.md).

### Federated accounts

After a user enables any passwordless credential, the Microsoft Entra sign-in process stops using `login\_hint`. The process no longer accelerates the user toward a federated sign-in location.

This logic generally prevents a user in a hybrid tenant from being directed to Active Directory Federation Services for sign-in verification. The option to select **Use your password instead** is still available.

### On-premises users

Admins can enable users for MFA through an on-premises identity provider. Users can still create and use a single passwordless phone sign-in credential.

If a user attempts to upgrade multiple installations (5+) of Authenticator with the passwordless phone sign-in credential, this change might result in an error.

## Related content

To learn about Microsoft Entra authentication and passwordless methods, see the following articles:

- [Learn how passwordless authentication works](concept-authentication-passwordless.md)
- [Learn about device registration](~/identity/devices/overview.md)
- [Learn about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
