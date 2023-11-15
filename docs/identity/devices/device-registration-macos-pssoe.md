---
title: Register a Mac device with macOS Platform Single Sign-On using Company Portal
description: How users can set up a new macOS with macOS Platform Single Sign-On Extension, using Company Portal.

ms.service: active-directory
ms.subservice: devices
ms.topic: how-to
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
---

# Register a Mac device with macOS Platform Single Sign-On using Company Portal (preview)

You can register a Mac device with the macOS Platform Single Sign-On (PSSO) using Company Portal. There are two workflows that are supported with Company Portal, [Web Enrollment](#web-enrollment) and [Intune MDM enrollment with Microsoft Entra Join](#intune-mdm-enrollment-with-microsoft-entra-join).

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) <!--TODO: version-->
- A configured the SSO extension MDM payload with PSSO settings in Intune by an administrator
<!--TODO: Link to other article-->
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration.

## Web Enrollment

Although registration with Automated Device Enrollment during an out-of-the-box experience is the recommended use, you can also use the Web Enrollment method to register your device with PSSO.

1. Once the Home screen appears, open Outlook and an **Add Account** window appears. Enter your email address and select **Continue**. <!--TODO: Insert slide 24 screenshot-->
1. Follow the steps in the MFA flow to complete sign-in.
1. You're prompted to set up your device to get access to company resources. Select **Continue**.
1. Select **Get started**, and allow the system to download a configuration profile. Close the window when prompted. <!--TODO: Insert slide 29 screenshot-->
1. Navigate to **Settings** > **Privacy and Security** > **Profiles** and select **Management Profile**. <!--TODO: Insert slide 90 screenshot-->
1. Select **Install** to install the profile, and enter your local account password when prompted.
1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**.
1. You're prompted to sign in to Company Portal. Enter your Microsoft Entra ID credentials and select **Next**. <!--TODO: Insert slide 35 screenshot-->
1. Follow the steps in the MFA flow to finish registration. The Company Portal app registers your device.
1. Once your device finishes registering, a Platform SSO window appears. Enter your Microsoft Entra ID password and select **Sign in**. <!--TODO: Insert slide 39 screenshot-->
1. Open the **Outlook** app and you're prompted to add an email account. Select **Add "Your email"**.
1. The **Company Portal** app checks that your device is registered. Once the window closes, you have access to your emails.

> [!NOTE]
> If you ignore or dismiss the **Registration Required** popup, when attempting to log into Outlook or another app, you're prompted to register your device through an action item to register your device. A new popup appears that says **Registration Required**. This popup reappears every 10 minutes until you register your device.

## Intune MDM and Microsoft Entra Join using Company Portal

### [Secure Enclave](#tab/secure-enclave)

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up {Company} access**. The placeholder "Company" will be different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-company-portal-setup-access.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. You're presented with steps to install the management profile, which has already been set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-company-portal-install-management-prof.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. Open **Settings** > **Privacy & Security** > **Profiles** if it doesn't automatically appear. Select **Management Profile**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-settings-profiles-management-prof.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. Select **Install** to get access to company resources.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-settings-profiles-install-management-prof.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. Enter your local device password in the **Profiles** window that appears and select **Enroll**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-profiles-enroll.png" alt-text="Screenshot of the profiles window":::

1. You'll see a notification in **Company Portal** that the installation is complete. Select **Done**. A **Registration Required** notification appears in the top right of the screen. Hover over the notification and select **Register**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-registration-req-notification.png" alt-text="Screenshot of the profiles window":::

1. The Platform SSO window appears to enable your macOS account to be registered with your identity provider. There are two ways you can do this:
    - **Touch ID**: Use your device's touch ID capability. The device selects your secure enclave key and wait for your device to confirm it is in compliance.
    - **Use Password**: You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Sign in**. As MFA is required as part of this sign in flow, open your **Authenticator app** (recommended) or use another verification method to complete the sign in flow.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-register-window.png" alt-text="Screenshot of the profiles window":::

1. You can now use PSSO to access Microsoft app resources.

### [Smartcard](#tab/smartcard)

### [Password](#tab/password)

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up {Company} access**. The placeholder "Company" will be different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-company-portal-setup-access.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. You're presented with steps to install the management profile, which has already been set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-company-portal-install-management-prof.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. A **Registration Required** notification appears in the top right of the screen. Hover over the notification and select **Register**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-registration-required-popup-password-flow.png" alt-text="Screenshot of the profiles window":::

1. The Platform SSO window appears to enable your macOS account to be registered with your identity provider. Enter your local account password and select **OK**.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-registration-local-password-prompt.png" alt-text="Screenshot of the profiles window":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Sign in**.
1. An **Authentication Required** notification appears in the top right of the screen. Hover over the notification and select **Sign in**.
1. In the **Microsoft Entra** window, enter your Microsoft Entra ID password and select **Sign in**. Once entered, there's a notification that your password has been successfully synced with your Microsoft Entra account.

    :::image type="content" source="media/device-registration-macos-pssoe/pssoe-entra-password-entry.png" alt-text="Screenshot of the profiles window":::

1. Your device will now show as being in compliance in Company Portal. You can now use PSSO to access Microsoft app resources.

---

## Update your Mac device to enable PSSO

For macOS users whose device is already enrolled in Company Portal, your administrator can enable PSSO by updating your device's SSO extension profile. Once the PSSO profile is deployed and installed on your device, you're prompted to register your device with PSSO via the **Registration Required** notification at the top right of the screen. This will remove the old SSO registration from your device in place of the new PSSO registration.

Although it's recommended to do it immediately, you can choose to select this and start your device registration at a time convenient to you.

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-pssoe-out-of-box.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)