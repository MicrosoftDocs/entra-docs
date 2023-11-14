---
title: Deploy macOS Platform Single Sign-on as an administrator (preview)
description: How admins can enroll a macOS device into Microsoft Entra ID using Platform SSO.

services: active-directory
ms.service: active-directory
ms.subservice: devices
ms.topic: tutorial
ms.date: 11/14/2023
ms.author: owenrichards
author: OwenRichards1
manager: CelesteDG
ms.reviewer: brianmel
---

# Deploy macOS Platform Single Sign-on as an administrator (preview)

Platform single sign-on (PSSO) is a feature that enables users to sign in to Mac devices using their Microsoft Entra ID credentials. This feature provides benefits for admins by simplifying the sign-in process for users and reducing the number of passwords they need to remember. PSSO is supported on Macs enrolled using both Automated Device Enrollment and Device Enrollment, running macOS 13 Ventura or later.

## Prerequisites

- A minimum requirement of macOS 13 Ventura
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) (version 5.2307.99.2235 only)
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc)

> [!NOTE]
> Currently, Platform SSO is supported only with Microsoft Intune. Support for other third-party MDM providers will be added in the future.

## Configure SSO extension with Microsoft Intune

A payload is a set of instructions or settings that can be delivered to a device via Mobile Device Management (MDM) to configure or manage that device. To configure the macOS SSO extension payload via MDM, you'll need to complete the following steps:

1. Go to the [Microsoft Intune Admin Center](https://intune.microsoft.com/#home).
1. In the sidebar, select **Devices** > **macOS** > **Configuration profiles**.
1. Select the **Create** option.
1. When the **Create a profile** window appears, under **Profile type** select **Settings Catalog**.
1. Select **Create**.
1. Provide a **Name** and **Description** for the profile.
1. On the Configuration settings page, select **Add settings**.
1. When the **Setting picker** window appears, select **Authentication** > **Extensible Single Sign-On (SSO)**.
1. The following settings need to be selected:

     - Authentication Method (Deprecated)
     - Extension Identifier
     - Platform SSO > Authentication Method (macOS 14 only)
     - Screen Locked Behavior
     - Team identifier
     - Type
     - URLs

> [!NOTE]
> Please note that both **Authentication Method (Deprecated)** and **Authentication Method** are available to be selected. This is expected behavior and depending on your version of macOS, will determine what options to select.
>
> - For users running macOS 14, **both** options should be selected.
> - For users running macOS 13, **only** the **Authentication Method (Deprecated)** option should be selected.

1. Close the **Setting picker** window.

### Configure the SSO extension payload

1. In the **Extensible Single Sign-On (SSO)** window, configure the following settings **exactly as shown**:

    - **Screen Locked Behavior**: Do Not Handle
    - **Team Identifier** - `UBF8T346G9`
    - **URLs**:
        - https://login.microsoftonline.com
        - https://login.microsoft.com
        - https://sts.windows.net
        - https://login.partner.microsoftonline.cn
        - https://login.chinacloudapi.cn
        - https://login.microsoftonline.us
        - https://login-us.microsoftonline.com
    - **Platform SSO**
        - **Authentication Method** - `Password` (macOS 14 only)
        - **Authentication Method (Deprecated)**
            - **Password**: choosing this option allows the user to authenticate with Microsoft Entra ID via the user's Microsoft Entra ID password. The local account password is updated and kept in sync with Microsoft Entra ID.
            - **UserSecureEnclaveKey**: choosing this option allows the user to use a Secure Enclave backed key to authenticate with the Microsoft Entra ID. This authentication method does not affect the local account password.
            - **SmartCard**: choosing this option allows the user to use a SmartCard to authenticate with the Microsoft Entra ID. Please note that this option is only supported on macOS 14 Sonoma or later.
                - **Registration Token**:
        - `{{DEVICEREGISTRATION}}` - this value must be added exactly as shown, including the double curly braces.
        - **Extension Identifier**- `com.microsoft.CompanyPortalMac.ssoextension`
        - **Type** -  **Redirect**

[Screenshot of adding setting from the settings picker](./media/enroll-macos-admin/add-settings-from-setting-picker.png)

1. Select **Next**.
1. In the **Scope tags** tab, the default scope tags will be used. Select **Next**.
1. In the **Assignments** tab, select the **+** icon to add a group to assign the profile to. Select **Next**.
1. In the **Review + create** tab, once you have reviewed the settings, select **Create**.

## Deploy Mac Company Portal as a mandatory app

Platform SSO preview requires the use of a special Company Portal build. The build can be downloaded from [here](https://aka.ms/pssopreview). The Company portal app can be deployed using one of the following options:

- **Manual install of Company Portal locally** - Download and run the Company portal installer. Once installed, the app can be launched from the Applications folder.
- **Deploy Company Portal as an un-managed app** - this method deploys the app using the Intune agent for macOS and doesn't use the MDM channel in Intune. Once the app is added to Intune, assign it as a "required" app. To assign as a required app, [learn more](/mem/intune/apps/macos-unmanaged-pkg).
- **Deploy Company Portal using a script** - the Company Portal can be deployed using a script by following the steps outline in [use shell scripts on macOS devices in Intune](/mem/intune/apps/macos-shell-scripts).
- **Deploy Company Portal as line-of-business app** - the Company Portal can be deployed as a line-of-business app by following the steps outlined in [how to add macOS line-of-business (LOB) apps to Microsoft Intune](/mem/intune/apps/lob-apps-macos).

> [!NOTE]
> This deployment method only applies to Macs enrolled using Automated Device Enrollment.

### Device with existing Company Portal app that is different from the private preview build

On devices with existing Company Portal app that is different from the  preview build, before installing the preview build, the existing CP app must be removed.

To ensure a successful enrollment of your Mac into MDM, follow these steps:

1. Open Activity Monitor and search for any existing SSO extension processes. If found, select them and select "Quit Process" to end them.
2. If the AppSSOAgent process is running, select it and select "Quit Process" to end it.
3. Move any old Company Portal app to the Trash.
4. Restart your device.
5. Install the Mac Company Portal Preview build.

## Enroll a Mac into MDM

Platform SSO is supported on Macs enrolled using both Automated Device Enrollment and Device Enrollment, running macOS 13 Ventura or later. To enrole a mac, follow the steps outlined in the following sections.

### Enrolling a Mac using Automated Device Enrollment

To enroll a Mac using Automated Device Enrollment, follow the steps outlined in the [Automated Device Enrollment for macOS](/mem/intune/enrollment/device-enrollment-program-enroll-macos) article.

### Enrolling a Mac using Device Enrollment

To enroll your Mac into Platform SSO, launch the Company Portal app and sign in as an Intune-licensed Microsoft Entra ID user. Follow the Company Access setup flow to complete device enrollment. Once your Mac has been enrolled and the assigned configuration profile and Company Portal app have been installed, Platform SSO will be ready to use.

You can verify the presence of the SSO extension by going to **Settings** > **Privacy** and **security** > **Profiles** on your enrolled Mac. An example is shown in the following screenshot:

<!-- SCREENSHOT HERE -->

## See also

- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
