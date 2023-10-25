---
title: Self set up a macOS device with Company Portal
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

# Self set up a macOS device with Company Portal

You can set up a new macOS device with the macOS Platform Single Sign-On Extension, using Company Portal.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) (version 5.2307.99.2235 only)
- An admin has configured the SSO extension MDM payload with Platform SSO settings in Intune <!--ADDING LINK LATER-->
- Completion of the prerequisites and steps in Configure Platform Single Sign-On Extension <!--ADDING LINK LATER-->
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration.

## Intune MDM enrollment and Microsoft Entra Join using Company Portal

<!--78-104-->

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up Contoso Labs access**. Select **Begin** <!--Contoso Labs? Is this correct or does it vary depending on the identity provider?-->, then on the next screen, select **Continue**. <!--Is it the next screen?-->

    :::image type="content" source="media/device-self-setup-mac-pssoe/p84-company-portal-begin-setup.png" alt-text="Screenshot of Contoso Labs begin setup.":::

1. You're presented with steps to install the management profile. This has been set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-self-setup-mac-pssoe/p87-install-management-profile.png" alt-text="Screenshot of Contoso Labs begin management profile window.":::

1. Hover over the popup that appears in the top right corner of the screen and select **Install**, which opens **Profiles** in the Mac's **Settings**. <!--Is it install or another button, like register-->

    :::image type="content" source="media/device-self-setup-mac-pssoe/p89-profile-installation-popup.png" alt-text="Screenshot of Profile installation popup prompt.":::

1. Select **Management Profile**, and in the new window, select **Install**.

    :::image type="content" source="media/device-self-setup-mac-pssoe/p90-management-profile-setup.png" alt-text="Screenshot of Management Profile in Privacy and Security Settings.":::

1. Enter your local device password in the **Profiles** window that appears and select **Enroll**. Upon completion, you see that the Mac is supervised and managed by **Contoso Labs**.
1. Return to the **Company Portal** app, and wait to be prompted. Select **Register** in the Company Portal popup that appears. 

    :::image type="content" source="media/device-self-setup-mac-pssoe/p97-company-portal-and-registration-popup.png" alt-text="Screenshot of Company Portal with Registration required popup.":::

1. You're prompted to register your Mac. Sign in to Company Portal, enter your Microsoft Entra ID credentials and wait for your device to register.
1. Return to the **Company Portal** app, and select **Done** to complete the process.

    :::image type="content" source="media/device-self-setup-mac-pssoe/p103-finishing-screen.png" alt-text="Screenshot of the completion screen in Company Portal.":::

## Just In Time Rendering (JITR) workflow when a user is enrolled using Company Portal 

<!--69-77-->

1. Open the **Company Portal** app and navigate to the **Devices** tab. <!--How? We need more screenshots for this-->
1. The Company Portal app window will raise an action item to register your Mac. This triggers a notification in the top right corner of the screen to register your device using your identity provider. <!--Does it do this automatically?-->

    :::image type="content" source="media/device-self-setup-mac-pssoe/p71-company-portal.png" alt-text="Screenshot of Contoso Company portal action item and registration popup.":::

1. Enter your Microsoft Entra ID credentials and wait for your device to register. The window closes automatically. <!--Does it do this automatically?-->
1. Return to the **Company Portal** app which will display a confirmation message upon successful device registration. The application can now be closed. 

    :::image type="content" source="media/device-self-setup-mac-pssoe/p77-company-portal-registered.png" alt-text="Screenshot of Contoso Company portal confirming registration.":::

## How to deregister a device

<!--Panes 106/107-->

### [macOS 13](#tab/macos13)

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To unregister the device, select **Unregister**. <!--Then what happens??-->
1. Alternatively, to sign out your work account on the device, select **Sign out**.

    :::image type="content" source="media/device-self-setup-mac-pssoe/p107-company-portal-preferences.png" alt-text="Screenshot of Company Portal Preferences to sign out or unregister.":::

### [macOS 14](#tab/macos14)

TODO
---

## See also

- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../develop/apple-sso-plugin.md)
- [Setup a macOS device with Platform Single Sign-On Extension (3P)](./device-setup-macos-pssoe-3p.md)