---
title: Join a Mac device with Microsoft Entra ID during the out of box experience
description: How users can set up a Microsoft Entra with a new Mac device with macOS Platform Single Sign On

ms.service: active-directory
ms.subservice: devices
ms.topic: tutorial
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
---

# Join a Mac device with Microsoft Entra ID during the out of box experience (preview)

Mac users can join their new device to Microsoft Entra ID during the first-run out-of-box experience (OOBE). MacOS Platform Single Sign-On (PSSO) is a capability on macOS that is enabled using the [Microsoft Enterprise Single Sign-on Extension](../../identity-platform/apple-sso-plugin.md). PSSO allows users to sign in to a Mac device using a hardware-bound key, smart card or their Microsoft Entra ID password. This tutorial shows you how to set up a Mac device during the OOBE to use PSSO using Automated Device Enrollment or Web Enrollment.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- [Microsoft Intune Company Portal](/mem/intune/apps/apps-company-portal-macos) <!--TODO: version-->
- A Mac device enrolled in mobile device management (MDM) with Microsoft Intune
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended): The user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) on their mobile device to complete device registration.

## Set up your macOS device

1. Upon seeing the "Hello" screen when opening your Mac for the first time, follow the steps to select your country or region, and configure network settings as required.
1. You're prompted to download a **Remote Management** profile, which allows the configuration setup in Microsoft Intune to be applied to your device. Select **Continue**, and enter your Microsoft Entra ID credentials when prompted to approve the management profile download.
1. Enter the code sent to your **Authenticator app** (recommended) or use another MFA method.
1. To create a user account, fill in your full name, account name, and create a local account password. Select **Continue** and your home screen appears.

## Registration with Automated Device Enrollment

There are three authentication methods for PSSO registration, **Secure Enclave**, **Smartcard** and **Password**. It's recommended for your system administrator to have the Mac enrolled using secure enclave or smartcard. This new password-less feature is supported only by PSSO. Check which authentication method has been set up by your administrator before continuing.

### [Secure Enclave](#tab/secure-enclave)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. {***Insert recording vid 50sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-0-50-registration-required-popup.png" alt-text="Screenshot of registration required popup on home screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**. Wait for a moment for the system to log you in. {***Insert recording vid 53sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-0-53-register-with-microsoft-entra.png" alt-text="Screenshot of Microsoft Entra credentials window.":::

1. MFA is required as part of this sign in flow. Open your **Authenticator app** (recommended) or use your other MFA methods you have registered, and enter the number displayed on the screen to finish registration.
1. Upon completing the MFA flow, your device should be registered with PSSO. To check that registration has completed successfully, open the **Terminal** app and run the following command:

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

1. Now that the Mac is correctly set up, you can now use PSSO to access Microsoft app resources.

>[NOTE!]
> On macOS 14 Somona, you can check the PSSO registration status by navigating to **Settings** > **Users and Groups** > **Select user**. To see your device registration status, navigate to **Settings** > **Users and Groups** > **Network account server**. Select **Edit** to see your device status.

### [Smartcard](#tab/smartcard)

TODO: Add steps

### [Password](#tab/password)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. {***Insert recording vid 50sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-0-50-registration-required-popup.png" alt-text="Screenshot of registration required popup on home screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**. {***Insert recording vid 53sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-0-53-register-with-microsoft-entra.png" alt-text="Screenshot of Microsoft Entra credentials window.":::

    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.
    
1. When a **Single Sign-On** window appears, enter your local account password and select **OK**. {***Insert recording vid 1m09sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-1-09-sso-window.png" alt-text="Screenshot of Microsoft Entra credentials window.":::

1. If your local password differs to your Microsoft Entra ID password, an **Authentication Required** popup appears on the top right of the screen. Hover over the banner and select **Sign-in**.
1. When a **Microsoft Entra** window appears, enter your Microsoft Entra ID password and select **Sign In**. {***Insert recording vid 1m21sec screenshot***}

:::image type="content" source="media/device-join-macos-pssoe-oobe/password-sync-1-21-mac-microsoft-entra-window.png" alt-text="Screenshot of Microsoft Entra credentials window.":::

1. After unlocking the Mac, you can now use PSSO to access Microsoft app resources. From this point on, your old password doesn't work because PSSO is enabled for your device.

---

## Enable macOS Platform Credentials for use as a passkey (secure enclave only)

If you've set up your device using the secure enclave method, you can use the resulting credential saved to the Mac as a passkey in the browser. To enable it;

1. Open the **Settings** app, and navigate to **Passwords** > **Password options**.
1. Under **Password options**, find **Use passwords and passkeys from** and enable **Company Portal** through the toggle switch.
<!--TODO: New screenshot-->

## See also

- [Register a Mac device with macOS Platform Single Sign-On using Company Portal](./device-registration-macos-pssoe.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)