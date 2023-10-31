---
title: Self setup a Mac device with macOS Platform Single Sign-On with Company Portal
description: How users can set up a new macOS with the macOS Platform Single Sign-On Extension, using Company Portal.

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

# Self setup a Mac device with macOS Platform Single Sign-On with Company Portal

You can set up a new Mac device with the macOS Platform Single Sign-On Extension, using Company Portal.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) (version 5.2307.99.2235 only)
- An admin has configured the SSO extension MDM payload with Platform SSO settings in Intune
- Completion of the prerequisites and steps in Configure Platform Single Sign-On Extension
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration

## Intune MDM enrollment and Microsoft Entra Join using Company Portal

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up Contoso Labs access**. Select **Begin**, then on the next screen, select **Continue**. <!--TODO: Insert slide 84 screenshot-->
1. You're presented with steps to install the management profile. This has been set up by an administrator using Microsoft Intune. Select **Download profile**. <!--TODO: Insert slide 87 screenshot-->
1. Hover over the popup that appears in the top right corner of the screen and select **Install**, which opens **Profiles** in the Mac's **Settings**. <!--TODO: Insert slide 89 screenshot-->
1. Select **Management Profile**, and in the new window, select **Install**. <!--TODO: Insert slide 90 screenshot-->
1. Enter your local device password in the **Profiles** window that appears and select **Enroll**. Upon completion, you see that the Mac is supervised and managed by **Contoso Labs**.
1. Return to the **Company Portal** app, and wait to be prompted. Select **Register** in the Company Portal popup that appears.<!--TODO: Insert slide 97 screenshot-->
1. You're prompted to register your Mac. Sign in to Company Portal, enter your Microsoft Entra ID credentials and wait for your device to register.
1. Return to the **Company Portal** app, and select **Done** to complete the process. <!--TODO: Insert slide 103 screenshot-->

## Just In Time Rendering (JITR) workflow when a user is enrolled using Company Portal

1. Open the **Company Portal** app and navigate to the **Devices** tab.
1. The Company Portal app window will raise an action item to register your Mac. This triggers a notification in the top right corner of the screen to register your device using your identity provider. <!--TODO: Insert slide 71 screenshot-->
1. Enter your Microsoft Entra ID credentials and wait for your device to register. The window closes automatically.
1. Return to the **Company Portal** app which will display a confirmation message upon successful device registration. The application can now be closed. <!--TODO: Insert slide 77 screenshot-->

> [!NOTE]
> If you miss the notification, it will reappear after a short time.

### Deregister a device with macOS 13 Ventura <!--TODO: macOS 14 tab-->

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To unregister the device, select **Unregister**.
1. Alternatively, to sign out your work account on the device, select **Sign out**. <!--TODO: Insert slide 107 screenshot-->

## See also

- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)