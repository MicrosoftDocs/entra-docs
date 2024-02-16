---
title: Join a Mac device with Microsoft Entra ID during the out of box experience with macOS PSSO
description: How users can set up a Microsoft Entra with a new Mac device with macOS Platform Single Sign-on

ms.service: active-directory
ms.subservice: devices
ms.topic: tutorial
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
#Customer intent: As a user I want to understand how to set up a Mac device with macOS Platform Single Sign-on (PSSO) during the out of box experience. I want to know the difference betwwen setting up with secure enclave, smart card or password based authentication methods.
---

# Join a Mac device with Microsoft Entra ID during the out of box experience with macOS PSSO (preview)

Mac users can join their new device to Microsoft Entra ID during the first-run out-of-box experience (OOBE). The macOS Platform single sign-on (PSSO) is a capability on macOS that is enabled using the [Microsoft Enterprise Single Sign-on Extension](../../identity-platform/apple-sso-plugin.md). PSSO allows users to sign in to a Mac device using a hardware-bound key, smart card or their Microsoft Entra ID password. This tutorial shows you how to set up a Mac device during the OOBE to use PSSO using Automated Device Enrollment.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- [Automated Device Enrollment (ADE)](https://support.apple.com/HT204142) enrolled device. Check with your administrator if you're unsure if your device is enrolled with this requirement.
- [Microsoft Intune Company Portal](/mem/intune/apps/apps-company-portal-macos)
- A Mac device enrolled in mobile device management (MDM) with Microsoft Intune.
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended): The user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) on their mobile device to complete device registration.
- A smart card loaded with a certificate for authentication with Microsoft Entra (smart card setup only).

## Set up your macOS device

1. Upon seeing the "Hello" screen when opening your Mac for the first time, follow the steps to select your country or region, and configure network settings as required.
1. You're prompted to download a **Remote Management** profile, which allows the configuration setup in Microsoft Intune to be applied to your device. Select **Continue**, and enter your Microsoft Entra ID credentials when prompted to approve the management profile download.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-remote-management.png" alt-text="Screenshot of remote management window.":::

1. Enter the code sent to your **Authenticator app** (recommended) or use another MFA method.
1. To create a user account, fill in your full name, account name, and create a local account password. Select **Continue** and your home screen appears.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-local-account.png" alt-text="Screenshot of the window used to create a computer account, where the user enters their name, account name and local password.":::

## Registration with Automated Device Enrollment

There are three authentication methods for PSSO registration:

- **Secure Enclave**: User logs on to their device which has a secure enclave backed cryptographic key used for SSO across apps that use Microsoft Entra ID for authentication
- **Smart card**: User logs into the machine using an external smart card or smart card compatible hard token
- **Password**: User logs on to their local device with a local account, updated to use their Microsoft Entra ID password

It's recommended for your system administrator to have the Mac enrolled using secure enclave or smart card. These new password-less features are supported only by PSSO. Check which authentication method has been set up by your administrator before continuing.

### [Secure Enclave](#tab/secure-enclave)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png" alt-text="Screenshot of a desktop screen with a registration required popup in the top right of the screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**. Wait for a moment for the system to log you in.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. MFA is required as part of this sign in flow. Open your **Authenticator app** (recommended) or use your other MFA methods you have registered, and enter the number displayed on the screen to finish registration.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-2fa-challenge.png" alt-text="Screenshot of a two-factor authentication window, prompting the user to open the Authenticator app.":::

1. When the MFA flow completes and the loading screen disappears, your device should be registered with PSSO. You can now use PSSO to access Microsoft app resources.

### Enable macOS Platform Credentials for use as a passkey

Setting up your device using secure enclave method enables you to use the resulting credential saved to the Mac as a passkey in the browser. To enable it;

1. Open the **Settings** app, and navigate to **Passwords** > **Password options**.
1. Under **Password Options**, find **Use passwords and passkeys from** and enable **Company Portal** through the toggle switch.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/password-options-enable-passkeys.png" alt-text="Screenshot of the Password Options window indicating that the use of passwords and passkeys from Company Portal has been enabled by a switch.":::

### [Smart Card](#tab/smart-card)

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. If the certificate is not already paired with the local account, the user will see a prompt to use the smart card. Select **Smart card**.
1. You're prompted to enter the pin for your smart card. Enter your pin and select **Enter pin for the smart card**. When the correct pin is entered, PSSO registration with smart card authentication is complete.
1. You can now use PSSO to access Microsoft app resources, and unlock the device with the smart card pin. You'll need to use the local password to log in after a reboot to unlock the keychain access.

### [Password](#tab/password)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png" alt-text="Screenshot of a desktop screen with a registration required popup in the top right of the screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. When a **Single Sign-On** window appears, enter your local account password and select **OK**.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-enter-local-password.png" alt-text="Screenshot of a single sign-on window prompting the user to enter their local account password.":::

1. If your local password differs to your Microsoft Entra ID password, an **Authentication Required** popup appears on the top right of the screen. Hover over the banner and select **Sign-in**.
1. When a **Microsoft Entra** window appears, enter your Microsoft Entra ID password and select **Sign In**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-entra-account-password-prompt.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. After unlocking the Mac, you can now use PSSO to access Microsoft app resources. From this point on, your old password doesn't work because PSSO is enabled for your device.

---

## Check your device registration status

Once you've completed the steps above, it's a good idea to check your device registration status.

### [macOS 14 Somona](#tab/macos-14-somona)

1. To check that registration has completed successfully, navigate to **Settings** and select **Users & Groups**. 
1. Select **Edit** next to **Network Account Server** and check that **Platform SSO** is listed as **Registered**.
1. To verify the method used for authentication, navigate to your username in the **Users & Groups** window and select the **Information** icon. Check the method listed, which should be **Secure enclave**, **Smart Card**, or **Password**.

    > [!NOTE]
    >
    > You can also use the **Terminal** app to check the registration status. Run the following command to check the status of your device registration. You should see in the bottom of the output that SSO tokens are retrieved.
    >
    > ```console
    > app-sso platform -s
    > ```


### [macOS 13 Ventura](#tab/macos-13-ventura)

1. To check that registration has completed successfully, open the **Terminal** app and run the following command:

    ```console
    app-sso platform -s
    ```
1. Check the bottom of the output, and confirm that information similar to the following snippet is shown, which signifies that SSO tokens are retrieved.

    ```console
    SSO Tokens:
    Received:
    YYYY-MM-DD T HH:MM:SS
    Expiration:
    YYYY-MM-DD T HH:MM:SS (Not Expired)
    ```
---

## See also

- [Register a Mac device with macOS Platform single sign-in using Company Portal](./device-registration-macos-platform-single-sign-on.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
