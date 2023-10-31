---
title: Set up a macOS device using macOS Platform Single Sign-On
description: How users can set up a new macOS with the macOS Platform Single Sign-On Extension, and sign in to their device using their Microsoft Entra ID credentials.

services: active-directory
ms.service: active-directory
ms.subservice: devices
ms.topic: tutorial
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
---

# Setup a Mac device using macOS Platform Single Sign-On

MacOS Platform Single Sign-On (SSO) is a capability on macOS that is enabled using the [Microsoft Enterprise Single Sign-on Extension](../../identity-platform/apple-sso-plugin.md) (SSOe). MacOS Platform SSO allows users to sign in to a Mac device using a hardware-bound key or their Microsoft Entra ID password. This tutorial shows you how to set up a Mac device to use macOS Platform SSO.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- [Microsoft Intune Company Portal](/mem/intune/apps/apps-company-portal-macos) (version 5.2307.99.2235 only)
- A Mac device enrolled in MDM with Microsoft Intune
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration.

## Set up your macOS device

1. Upon seeing the "Hello" screen when opening your Mac for the first time, follow the steps to select your country or region, and configure network settings as required.
1. You're prompted to download a **Remote Management** profile, which allows the configuration setup in Microsoft Intune to be applied to your device. Select **Continue**, and enter your Microsoft Entra ID credentials when prompted to approve the management profile download.
1. If your device is configured with multifactor authentication (MFA), you're prompted to enter the code sent to your **Authenticator app** (recommended) or use your other MFA methods you have registered.
1. To create a user account, fill in your full name, account name, and create a local account password. Select **Continue** and your home screen appears.

## Registration with Automated Device Enrollment

There are two authentication methods for macOS Platform SSO registration, **Secure Enclave** and **Password**. It's recommended for your system administrator to have the Mac enrolled using the secure enclave method. This new password-less feature is supported only by macOS Platform SSO. Choose the method that your company admin has configured for you.

### [Secure Enclave](#tab/secure-enclave)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. <!--TODO: Insert recording vid 50sec screenshot-->
1. You're prompted to register your device with Microsoft Entra. Enter your sign-in credentials and select **Next**. Wait for a moment for the system to log you in. <!--TODO: Insert recording vid 53sec screenshot-->
1. MFA is required as part of this sign in flow. Open your **Authenticator app** (recommended) or use your other MFA methods you have registered, and enter the number displayed on the screen to finish registration.
1. To check that the macOS Platform SSO registration has completed successfully, open the **Terminal** app and run the following command:

    ```console
    app-sso platform -s
    ```

1. Check the bottom of the output, and confirm that information similar to the following snippet is shown, which signifies that SSO tokens have been retrieved.

    ```console
    SSO Tokens:
    Received:
    YYYY-MM-DD T HH:MM:SS
    Expiration:
    YYYY-MM-DD T HH:MM:SS (Not Expired)
    ```

1. Now that the Mac has been correctly set up, you can now use macOS Platform SSO to access Microsoft app resources.

### [Password](#tab/password)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. <!--TODO: Insert recording vid 50sec screenshot-->
1. You're prompted to register your device with Microsoft Entra. Enter your sign-in credentials and select **Next**. <!--TODO: Insert recording vid 53sec screenshot-->
1. Multifactor authentication (MFA) is required as part of this sign in flow. Open your **Authenticator** app and enter the number displayed on the screen to finish registration.
1. When a **Single Sign-On** window appears, enter your local account password and select **OK**. <!--TODO: Insert recording vid 1m09sec screenshot-->
1. If your local password differs to your Microsoft Entra ID password, an **Authentication Required** popup appears on the top right of the screen. Hover over the banner and select **Sign-in**.
1. When a **Microsoft Entra** window appears, enter your Microsoft Entra ID password and select **Sign In**. <!--TODO: Insert recording vid 1m21sec screenshot-->
1. After unlocking the Mac, you can now use macOS Platform SSO to access Microsoft app resources. From this point on, your local password won't work because you have enabled macOS Platform SSO for your device.

---

## Enabling macOS Platform SSO from an existing Microsoft Enterprise SSO plug-in

If your company has the Microsoft Enterprise SSO plugin already installed, there are a few ways you can successfully migrate to the new feature:

- User is targeted for PSSO and policy is downloaded, device falls out of compliance, user navigates to CP and runs through compliance remediation, triggering notification to start PSSO setup
- User is targeted for PSSO and is blocked by policy while trying to access some resource, Intune JIT kicks-in and prompts user to remediate, downloads the updated policy, user completes setup to satisfy compliance remediation and then access is unblocked.
- User initiates PSSO reg/setup through System Settings > Users and Groups > Info menu

1. In the **Authentication Required** notification at the top right of the screen, select **Sign in**.
1. Enter your email address and go through the MFA flow to allow your device to be registered. When prompted, enter your Microsoft Entra password to sign in.

## Device Enrollment

The steps outlined in [Registration with Automated Device Enrollment](#registration-with-automated-device-enrollment) is the recommended use, however the Device Enrollment method is another alternative.

1. Open Outlook and an **Add Account** window appears. Enter your email address and select **Continue**. <!--TODO: Insert slide 24 screenshot-->
1. Follow the steps in the MFA flow to complete sign-in.
1. You're prompted to set up your device to get access to company resources. Select **Continue**.
1. Select **Get started**, and allow the system to download a configuration profile. Close the window when prompted. <!--TODO: Insert slide 29 screenshot-->
1. Navigate to **Settings** > **Privacy and Security** > **Profiles** and select **Management Profile**. <!--TODO: Insert slide 90 screenshot-->
1. Select **Install** to install the profile, and enter your local account password when prompted.
1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**.
1. You're prompted to sign in to Company Portal. Enter your Microsoft Entra ID credentials and select **Next**. <!--TODO: Insert slide 35 screenshot-->
1. Follow the steps in the MFA flow to finish registration. The Company Portal app registers your device.
1. Once your device has finished registering, a Platform SSO window appears. Enter your Microsoft Entra ID password and select **Sign in**. <!--TODO: Insert slide 39 screenshot-->
1. Open the **Outlook** app and you're prompted to add an email account. Select **Add "Your email"**.
1. The **Company Portal** app checks that your device is registered. Once the window closes, you have access to your emails.

> [!NOTE]
> If you ignore or dismiss the **Registration Required** popup, when attempting to log into Outlook or another app, you will be prompted to register your device through an action item. A new popup will appear that says **Registration Required**.

## See also

- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
- [Self setup a Mac device with macOS Platform Single Sign-On with Company Portal](./device-self-setup-macos-pssoe.md)