---
title: Join a Mac device with Microsoft Entra ID and configure it for shared device scenarios
description: How users can set up a Microsoft Entra Joined Mac that supports multiple users for shared device scenarios with macOS Platform Single Sign-on

ms.service: entra-id
ms.subservice: devices
ms.topic: tutorial
ms.date: 05/13/2023

ms.author: miepping
author: miepping
manager: 
ms.reviewer: brianmel
#Customer intent: As a user I want to understand how to set up a Mac device with macOS Platform Single Sign-on (PSSO) and configure it to support multiple user login. I want to configure this device for student lab scenarios or similar multi-user Mac scenarios for shared devices.
---

# Join a Mac device with Microsoft Entra ID and configure it for shared device scenarios (Preview)

In this tutorial, you will learn how to configure an Entra Joined Mac via MDM to support multiple users. There are three methods in which you can register a Mac device with PSSO, secure enclave, smart card, or password. We recommend using secure enclave or smart card for the best passwordless experience, however shared or multi-user Macs may benefit from using the password method instead. Common scenarios for shared Macs with passwords would be computer labs in schools or universities where students use multiple devices, multiple students use the same device, and they only have passwords and no MFA or passwordless credentials.

## Prerequisites

- A required minimum version of macOS 14 Sonoma. While macOS 13 Ventura is supported for PSSO overall, only Sonoma supports the necessary tools for the PSSO shared Mac scenario described in this guide.
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2404.0 or later
- A configured PSSO MDM payload in your MDM by an administrator

## MDM Profile Configuration

Your Platform SSO MDM profile should leverage the following configurations to support multi-user devices:

| Configuration Paramter | Value(s) | Note |
|-|-|-|
| Screen Locked Behavior | Do Not Handle | Required |
| Registration Token | {{DEVICEREGISTRATION}} | Recommended for the best registration user experience |
| Authentication Method | Password | Recommended for this article, secure enclave key is recommended for single user devices |
| Enable Authorization | Enabled | Required |
| Enable Create User At Login | Enabled | Required |
| New User Authorization Mode | Standard | Recommended |
| Token To User Mapping --> Account Name | preferred_username | Required |
| Token To User Mapping --> Full Name | name | Required |
| Use Shared Device Keys | Enabled | Required |
| User Authorization Mode | Standard | Recommended |
| Team Identifier | UBF8T346G9 | Required |
| Extension Identifier | com.microsoft.CompanyPortalMac.ssoextension | Required |
| Type | Redirect | Required |
| URLs | https://login.microsoftonline.com, https://login.microsoft.com, https://sts.windows.net, https://login.partner.microsoftonline.cn, https://login.chinacloudapi.cn, https://login.microsoftonline.us, https://login-us.microsoftonline.com | Required |

If you use Intune as your MDM of choice then the configuration profile settings will appear like this:

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/intune-psso-shared-device-profile.png" alt-text="Screenshot of a PSSO MDM profile in Intune.":::

## Intune MDM and Microsoft Entra Join using Company Portal

To register a Mac device with PSSO, you must first enroll your device in your MDM. If you are using Microsoft Intune then make sure the Company Portal app is installed. If you are using another MDM then make sure the device is enrolled in that MDM and you have deployed Company Portal to the device. Once enrolled, you can use your user account to register your device with PSSO. For shared devices the first user to do the setup will typically be an administrator or technician - this user will have local administrative rights unless there is alternative local admin account created.

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up {Company} access**. The placeholder "Company" is different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-set-up-access.png" alt-text="Screenshot of the Company portal access setup window.":::

1. You're presented with steps to install the management profile, which should be set up by an administrator using Microsoft Intune using the settings specified in the [MDM Profile Configuration](#mdm-profile-configuration) section of this guide. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-install-management-profile.png" alt-text="Screenshot of a Company Portal window requesting the user to download the management profile.":::

1. Open **Settings** > **Privacy & Security** > **Profiles** if it doesn't automatically appear. Select **Management Profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-settings-profiles-management-profile.png" alt-text="Screenshot of the Settings app Profiles showing a downloaded management profile.":::

1. Select **Install** to get access to company resources.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-settings-profiles-install-management-profile.png" alt-text="Screenshot the prompt to install the management profile in settings.":::

1. Enter your local device password in the **Profiles** window that appears and select **Enroll**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-profiles-enroll.png" alt-text="Screenshot of the profiles window requesting a password to enroll you into an MDM service.":::

1. You'll see a notification in **Company Portal** that the installation is complete. Select **Done**.

## Platform SSO registration

Now that the device MDM enrolled and has Company Portal installed, you need to register your device with PSSO. A **Registration Required** popup appears at the top right of the screen following successful completion of [Intune MDM and Microsoft Entra Join using Company Portal](#intune-mdm-and-microsoft-entra-join-using-company-portal). Use the popup to register your device with PSSO using your Entra ID credentials:

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png" alt-text="Screenshot of a desktop screen with a registration required popup in the top right of the screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. When a **Single Sign-On** window appears, enter your local account password and select **OK**. <!-- If you're on macOS 14, you'll be prompted to unlock your local account before this.-->

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-enter-local-password.png" alt-text="Screenshot of a single sign-on window prompting the user to enter their local account password.":::

1. If your local password differs to your Microsoft Entra ID password, an **Authentication Required** popup appears on the top right of the screen. Hover over the banner and select **Sign-in**.
1. When a **Microsoft Entra** window appears, enter your Microsoft Entra ID password and select **Sign In**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-entra-account-password-prompt.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. After unlocking the Mac, you can now use PSSO to access Microsoft app resources. From this point on, your old password doesn't work because PSSO is enabled for your device.

---

## Check your device registration status

Once you've completed the steps above, it's a good idea to check your device registration status.

1. To check that registration has completed successfully, navigate to **Settings** and select **Users & Groups**. 
1. Select **Edit** next to **Network Account Server** and check that **Platform SSO** is listed as **Registered**.
1. To verify the method used for authentication, navigate to your username in the **Users & Groups** window and select the **Information** icon. Check the method listed, which should be **Secure enclave**, **Smart Card**, or **Password**.

    > [!NOTE]
    >
    > You can also use the **Terminal** app to check the registration status. Run the following command to check the status of your device registration. You should see in the bottom of the output that SSO tokens are retrieved. For macOS 13 Ventura users, this command is required to check the registration status.
    >
    > ```console
    > app-sso platform -s
    > ```

## Test the Enable Create User At Login Functionality

Next you should validate that the device is ready for other users in the tenant to log into it.

1. Log out of the Mac with the account that you used to do the initial setup.
2. At the login screen, choose the **Other...** option to sign in with a new user account

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/psso-new-user-login.png" alt-text="Screenshot of the macOS login screen":::

3. Enter a user's Entra ID User Principal Name and password.

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/psso-new-user-login-upn.png" alt-text="Screenshot of the macOS login screen":::

4. If the User Principal Name and password were correct then the user will be logged in. The user will be directed to go through several Setup Assistant dialog screens by default and then they will land on the macOS desktop.

## Troubleshooting

If the user cannot sign in successfully then use the following resources to troubleshoot:

1. Refer to the [macOS Platform single sign-on known issues and troubleshooting](./troubleshoot-macos-platform-single-sign-on-extension.md) guide
1. Validate that the user can successfully sign in to Entra ID using their account using their User Principal Name and password in a browser on another device. You can test by having the user go to a web app, such as [https://myapps.microsoft.com](https://myapps.microsoft.com)

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)