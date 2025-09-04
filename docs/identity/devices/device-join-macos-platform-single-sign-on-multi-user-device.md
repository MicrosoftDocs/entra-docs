---
title: Join a Mac device with Microsoft Entra ID and configure it for shared device scenarios
description: How users can set up a Microsoft Entra Joined Mac that supports multiple users for shared device scenarios with macOS Platform Single Sign-on
ms.service: entra-id
ms.subservice: devices
ms.topic: tutorial
ms.date: 05/13/2023
ms.author: godonnell
author: garrodonnell
manager: leventbesik
ms.reviewer: jploegert
ms.custom: sfi-image-nochange
#Customer intent: As a user I want to understand how to set up a Mac device with macOS Platform Single Sign-on (PSSO) and configure it to support multiple user login. I want to configure this device for student lab scenarios or similar multi-user Mac scenarios for shared devices.
---

# Join a Mac device with Microsoft Entra ID and configure it for shared device scenarios

In this tutorial, you will learn how to configure a Microsoft Entra Joined Mac via Mobile Device Management (MDM) to support multiple users. There are three methods in which you can register a Mac device with Platform SSO (PSSO), secure enclave, smart card, or password. We recommend using secure enclave or smart card for the best passwordless experience, however shared or multi-user Macs may benefit from using the password method instead. Common scenarios for shared Macs with passwords would be computer labs in schools or universities. In these scenarios, students use multiple devices, multiple students use the same device, and they only have passwords and no MFA or passwordless credentials.

## Prerequisites

- A required minimum version of macOS 14 Sonoma or later. While macOS 13 Ventura is supported for Platform SSO overall, only Sonoma supports the necessary tools for the Platform SSO shared Mac scenario described in this guide.
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2404.0 or later.
- A configured Platform SSO MDM payload in your MDM by an administrator.

## MDM configuration

There are three main steps for configuring Platform SSO on a shared device:

1. **Deploy Company Portal.** For more information, see [Add the Company Portal for macOS app](/mem/intune/apps/apps-company-portal-macos).
1. **Deploy Platform SSO Configuration.** Create and deploy a settings catalog profile with the required Platform SSO Configuration.
1. **Deploy macOS Login Screen Configuration.** The macOS Login screen configuration can be changed to allow new users to log in.

### Shared Device Limitations

Please note the following regarding shared macOS devices:

- macOS devices that are intended to be shared between users should ensure they are enrolled as user-less ([enrollment w/o user affinity for ADE](/intune/intune-service/enrollment/device-enrollment-program-enroll-macos"https://learn.microsoft.com/en-us/intune/intune-service/enrollment/device-enrollment-program-enroll-macos#:~:text=enrollment%20without%20user%20device%20affinity"), [direct enrollment for non-ADE](/intune/intune-service/enrollment/device-enrollment-direct-enroll-macos"https://learn.microsoft.com/en-us/intune/intune-service/enrollment/device-enrollment-direct-enroll-macos")).

- Conditional access policies are not supported on macOS devices that are shared with multiple users.

### Platform SSO profile configuration

Your Platform SSO MDM profile should apply the following configurations to support multi-user devices:

| Configuration Parameter | Value(s) | Note |
|-|-|-|
| Screen Locked Behavior | Do Not Handle | Required |
| Registration Token | {{DEVICEREGISTRATION}} | Recommended for the best registration user experience |
| Authentication Method | Password, smartcard, secure enclave|During new user creation at the login screen, user will need to specify a  will need user name and password regardless of the auth method chosen. Secure enclave key is recommended for single user devices |
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

If you use Intune as your MDM of choice, then the configuration profile settings will appear like this:

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/intune-psso-shared-device-profile.png" alt-text="Screenshot of a Platform SSO MDM profile in Intune.":::

### macOS login screen configuration

To allow new users to log on and be created from the macOS login screen, there are two configurations that can be used:

- **Show Other Users Managed**. With this configuration, the macOS login screen shows a list of profiles that have been created and an "other user" button that can be used to log in with a username and password. Users can select their existing profile to log in or log in with their Microsoft Entra ID user principal name (UPN).
    
 - **Show full name**. With this configuration, the macOS login screen displays and username and password field with no list of users. Users can log in with their Microsoft Entra ID UPN.

These configurations can be found in Intune Settings Catalog under **Login** > **Login Window Behavior**.

## Enrolling and registering devices

To register a Mac device with Platform SSO, devices must be enrolled into MDM. For shared devices, the user who sets up the device would typically be an administrator or technician - this user will have local administrative rights unless there is alternative local admin account created.

> [!NOTE]
> If you are enrolling using Automated Device Enrollment you may choose to encourage the user setting up the device to create the local account as:
>  - **Account name:** Microsoft Entra ID username (eg. user@domain.com).
>  - **Full Name:** First and Last Name.
> This is because the local account that is created during setup assistant will be associated with the Microsoft Entra ID account during registration. 

There are three high-level steps to set up Platform SSO on a shared device:

1. IT admin or delegated person enrolls device with Intune.
1. IT admin or delegated person registers the device with Microsoft Entra ID using their credentials.
1. Now the device is ready for new users to log in from the Microsoft Entra ID login screen.

Organizations can enroll shared devices into Intune using different methods depending on the device ownership.

| Enrollment method | Device Ownership | Requirements |
|---|---|---|
| [Automated Device Enrollment with no user affinity](/mem/intune/enrollment/device-enrollment-program-enroll-ios) | Company or school owned | ✔️Registration in Apple Business Manager</br>✔️ Automated Device Enrollment configured in Intune|
| [Company Portal](/mem/intune/user-help/enroll-your-device-in-intune-macos-cp) | Personal | None |

### Platform SSO registration

Once the device is MDM enrolled and has Company Portal installed, you need to register your device with Platform SSO. A **Registration Required** popup appears at the top right of the screen. Use the popup to register your device with Platform SSO using your Microsoft Entra ID credentials:

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png" alt-text="Screenshot of a desktop screen with a registration required popup in the top right of the screen." lightbox="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. When a **Single Sign-On** window appears, enter your local account password and select **OK**. <!-- If you're on macOS 14, you'll be prompted to unlock your local account before this.-->

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-enter-local-password.png" alt-text="Screenshot of a single sign-on window prompting the user to enter their local account password.":::

1. If your local password differs to your Microsoft Entra ID password, an **Authentication Required** popup appears on the top right of the screen. Hover over the banner and select **Sign-in**.
1. When a **Microsoft Entra** window appears, enter your Microsoft Entra ID password and select **Sign In**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-entra-account-password-prompt.png" alt-text="Screenshot of a Microsoft Entra sign in window.":::

1. After unlocking the Mac, you can now use Platform SSO to access Microsoft app resources. From this point on, your old password doesn't work because Platform SSO is enabled for your device.

---

## Check your device registration status

After completing the steps above, it's recommended to check your device registration status.

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

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/psso-new-user-login.png" alt-text="Screenshot of the macOS login screen.":::

3. Enter a user's Microsoft Entra ID User Principal Name and password.

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/psso-new-user-login-upn.png" alt-text="Screenshot of the macOS login box where a user has entered their credentials.":::

4. If the User Principal Name and password were correct then the user will be logged in. The user is directed to go through several Setup Assistant dialog screens by default and then they land on the macOS desktop.

## Troubleshooting

If the user cannot sign in successfully, then use the following resources to troubleshoot:

1. Refer to the [macOS Platform single sign-on known issues and troubleshooting](./troubleshoot-macos-platform-single-sign-on-extension.md) guide
1. Validate that the user can successfully sign in to Microsoft Entra ID using their User Principal Name and password in a browser on another device. You can test by having the user go to a web app, such as [https://myapps.microsoft.com](https://myapps.microsoft.com)

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
