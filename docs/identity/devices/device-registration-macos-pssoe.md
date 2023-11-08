---
title: Register a Mac device with macOS Platform Single Sign-On using Company Portal
description: How users can set up a new macOS with macOS Platform Single Sign-On Extension, using Company Portal.

ms.service: active-directory
ms.subservice: devices
ms.topic: tutorial
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
---

# Register a Mac device with macOS Platform Single Sign-On using Company Portal (preview)

You can register a Mac device with the macOS Platform Single Sign-On (PSSO) using Company Portal. There are two workflows that are supported with Company Portal, Intune MDM enrollment with Microsoft Entra Join and Just In Time Rendering.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) <!--TODO: version-->
- A configured the SSO extension MDM payload with PSSO settings in Intune by an administrator
<!--TODO: Link to other article-->
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration.

## Intune MDM enrollment with Microsoft Entra Join using Company Portal

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up Contoso Labs access**. Select **Begin**, then on the next screen, select **Continue**. <!--TODO: Insert slide 84 screenshot-->
1. You're presented with steps to install the management profile, which has already been set up by an administrator using Microsoft Intune. Select **Download profile**. <!--TODO: Insert slide 87 screenshot-->
1. Hover over the popup that appears in the top right corner of the screen and select **Install**, which opens **Profiles** in the Mac's **Settings**. <!--TODO: Insert slide 89 screenshot-->
1. Select **Management Profile**, and in the new window, select **Install**. <!--TODO: Insert slide 90 screenshot-->
1. Enter your local device password in the **Profiles** window that appears and select **Enroll**. Upon completion, you see that the Mac is supervised and managed by **Contoso Labs**.
1. Return to the **Company Portal** app, and wait to be prompted. Select **Register** in the Company Portal popup that appears.<!--TODO: Insert slide 97 screenshot-->
1. You're prompted to register your Mac. Sign in to Company Portal, enter your Microsoft Entra ID credentials and wait for your device to register.
1. Return to the **Company Portal** app, and select **Done** to complete the process. <!--TODO: Insert slide 103 screenshot-->

## Just In Time Rendering (JITR) workflow when a user is enrolled using Company Portal

1. Open the **Company Portal** app and navigate to the **Devices** tab.
1. The Company Portal app window raises an action item to register your Mac. This triggers a notification in the top right corner of the screen to register your device using your identity provider. <!--TODO: Insert slide 71 screenshot-->
1. Enter your Microsoft Entra ID credentials and wait for your device to register. The window closes automatically.
1. Return to the **Company Portal** app, which displays a confirmation message upon successful device registration. The application can now be closed. <!--TODO: Insert slide 77 screenshot-->

> [!NOTE]
> The notification reappears after a short time if missed.

## Enabling PSSO from an existing Microsoft Enterprise SSO plug-in

If your company has the Microsoft Enterprise SSO plugin already installed, you can successfully migrate to the new feature. You can initiate the registration yourself, or your administrator can start the process.

### Initiate PSSO registration

1. Open **Settings** and navigate to **Users & Groups**.
1. Open **Info menu**.
<!--TODO: Clarify steps-->

### Device falls out of compliance

When a user is targeted for PSSO and the management policy is downloaded, the device falls out of compliance. To fix this, navigate to Company Portal, and follow the steps for compliance mediation. This triggers the **Authentication Required** notification to start the PSSO setup. Enter your email address and go through the MFA flow to allow your device to be registered. When prompted, enter your Microsoft Entra password to sign in.

### User blocked by management policy

When a user is targeted for PSSO and is blocked by policy while trying to access some resource, the Intune JIT workflow starts and prompts the user to register the device. The user downloads the updated policy, and completes the setup, and access is unblocked.

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-pssoe-out-of-box.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)