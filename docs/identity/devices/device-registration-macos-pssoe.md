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

## Intune MDM enrollment with Microsoft Entra Join

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up Contoso Labs access**. Select **Begin**, then on the next screen, select **Continue**. <!--TODO: Insert slide 84 screenshot-->
1. You're presented with steps to install the management profile, which has already been set up by an administrator using Microsoft Intune. Select **Download profile**. <!--TODO: Insert slide 87 screenshot-->
1. Hover over the popup that appears in the top right corner of the screen and select **Install**, which opens **Profiles** in the Mac's **Settings**. <!--TODO: Insert slide 89 screenshot-->
1. Select **Management Profile**, and in the new window, select **Install**. <!--TODO: Insert slide 90 screenshot-->
1. Enter your local device password in the **Profiles** window that appears and select **Enroll**. Upon completion, you see that the Mac is supervised and managed by **Contoso Labs**.
1. Return to the **Company Portal** app, and wait for enrollment to finish. Wait for the **Registration Required** notification to appear Select **Register** in the Company Portal popup that appears.<!--TODO: Insert slide 97 screenshot-->
1. You're prompted to register your Mac device with Microsoft Entra ID. Enter your Microsoft Entra ID credentials and wait for your device to register.
1. Return to the **Company Portal** app, and you should see that your device is now in compliance. <!--TODO: Insert slide 103 screenshot-->

## Update your Mac device to enable PSSO

For macOS users who their device enrolled in Company Portal, your administrator can enable PSSO by updating your device's SSO extension profile. Once the PSSO profile is deployed and installed on your device, you're prompted to register your device with PSSO via the **Registration Required** notification at the top right of the screen. This will remove the old SSO registration from your device in place of the new PSSO registration.

Although it's recommended to do it immediately, you can choose to select this and start your device registration at a time convenient to you.

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-pssoe-out-of-box.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)