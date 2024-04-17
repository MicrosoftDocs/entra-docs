---
title: Join a Mac device with Microsoft Entra ID using Company Portal (preview)
description: How users can set up a new macOS with macOS Platform single sign-on extension, using Company Portal.

ms.service: entra-id
ms.subservice: devices
ms.topic: tutorial
ms.date: 09/26/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
# Customer intent: As a user, I want to register my Mac device with macOS Platform single sign-on using Company Portal. I need to know the differences between the three methods of registration, secure enclave, smart card, and password, and how to register my device with each method.
---

# Join a Mac device with Microsoft Entra ID using Company Portal (preview)

In this tutorial, you will learn how to register a Mac device with macOS Platform Single Sign-on (PSSO) using Company Portal and the Intune MDM enrollment with Microsoft Entra Join. There are three methods in which you can register a Mac device with PSSO, secure enclave, smart card, or password. We recommend using secure enclave or smart card for the best passwordless experience, however it's important to note that this method will be preset by your company administrator using Microsoft Intune.

## Prerequisites

- A recommended minimum version of macOS 14 Sonoma. While macOS 13 Ventura is supported, we strongly recommend using macOS 14 Sonoma for the best experience.
- Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2401.2 or later
- A configured the SSO extension MDM payload with PSSO settings in Intune by an administrator
- [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc) (recommended), the user must be registered for some form of Microsoft Entra ID multifactor authentication (MFA) to complete device registration.

## Intune MDM and Microsoft Entra Join using Company Portal

To register a Mac device with PSSO, you must first enroll your device in Microsoft Intune using the Company Portal app. Once enrolled, you can use secure enclave, smart card, or password to register your device with PSSO.

### [Secure Enclave](#tab/secure-enclave)

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up {Company} access**. The placeholder "Company" is different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-set-up-access.png" alt-text="Screenshot of the Company portal access setup window.":::

1. You're presented with steps to install the management profile, which should be set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-install-management-profile.png" alt-text="Screenshot of a Company Portal window requesting the user to download the management profile.":::

1. Open **Settings** > **Privacy & Security** > **Profiles** if it doesn't automatically appear. Select **Management Profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-settings-profiles-management-profile.png" alt-text="Screenshot of the Settings app Profiles showing a downloaded management profile.":::

1. Select **Install** to get access to company resources.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-settings-profiles-install-management-profile.png" alt-text="Screenshot the prompt to install the management profile in settings.":::

1. Enter your local device password in the **Profiles** window that appears and select **Enroll**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-profiles-enroll.png" alt-text="Screenshot of the profiles window requesting a password to enroll you into an MDM service.":::

1. You'll see a notification in **Company Portal** that the installation is complete. Select **Done**. A **Registration Required** notification appears in the top right of the screen. Hover over the notification and select **Register**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-registration-required-notification.png" alt-text="Screenshot of the Registration Required notification.":::

1. The Platform SSO window appears to enable your macOS account to be registered with your identity provider. You can unlock the device with Touch ID or local account password depending on the device setup. We strongly recommend setting up Touch ID.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-register-window.png" alt-text="Screenshot of the Platform SSO notification requesting to use password or Touch ID.":::

### [Smart Card](#tab/smart-card)

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. When prompted to **Choose a way to sign in**, select **Use a certificate or smart card**. Select the certificate to use and select **Choose**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/platform-single-sign-on-certificate-selection.png" alt-text="Screenshot of the window showing the prompt to choose a certificate.":::

1. Enter the smart card pin in the **Company Portal** window and select **OK**. 
1. You're prompted to **Set up {Company} access**. The placeholder "Company" is different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-set-up-access.png" alt-text="Screenshot of the Company portal access setup window.":::

1. You're presented with steps to install the management profile, which should be set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-install-management-profile.png" alt-text="Screenshot of a Company Portal window requesting the user to download the management profile.":::

1. Open **Settings** > **Privacy & Security** > **Profiles** if it doesn't automatically appear. Select **Management Profile**, then select **Install** to get access to company resources.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-settings-profiles-install-management-profile.png" alt-text="Screenshot the prompt to install the management profile in settings.":::

1. Enter your local device password in the **Profiles** window that appears and select **Enroll**.
1. A **Registration Required** notification appears in the top right of the screen. Hover over the notification and select **Register**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-registration-required-notification.png" alt-text="Screenshot of the Registration Required notification.":::

1. Enter the smart card pin in the **Platform SSO** window and select **OK**. Repeat this step if prompted to enter the smart card pin again. 

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/platform-single-sign-on-enter-pin.png" alt-text="Screenshot of the Platform SSO pin entry window.":::

1. You can now unlock the device with the smart card pin. You'll need to use the local password to log in after a reboot to unlock the keychain access.

### [Password](#tab/password)

1. Open the **Company Portal** app and select **Sign in**.
1. Enter your Microsoft Entra ID credentials and select **Next**.
1. You're prompted to **Set up {Company} access**. The placeholder "Company" will be different depending on your setup. Select **Begin**, then on the next screen, select **Continue**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-set-up-access.png" alt-text="Screenshot of the Company portal access setup window.":::

1. You're presented with steps to install the management profile, which has already been set up by an administrator using Microsoft Intune. Select **Download profile**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-company-portal-install-management-profile.png" alt-text="Screenshot of a Company Portal window requesting the user to download the management profile.":::

1. A **Registration Required** notification appears in the top right of the screen. Hover over the notification and select **Register**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-registration-required-popup-password-flow.png" alt-text="Screenshot of the Registration Required notification.":::

1. The Platform SSO window appears to enable your macOS account to be registered with your identity provider. Enter your local account password and select **OK**.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-registration-local-password-prompt.png" alt-text="Screenshot of the Platform SSO password prompt.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Sign in**.
1. An **Authentication Required** notification appears in the top right of the screen. Hover over the notification and select **Sign in**.
1. In the **Microsoft Entra** window, enter your Microsoft Entra ID password and select **Sign in**. Once entered, there's a notification that your password has been successfully synced with your Microsoft Entra account.

    :::image type="content" source="media/device-registration-macos-platform-single-sign-on/pssoe-entra-password-entry.png" alt-text="Screenshot of the Microsoft Entra sign in window.":::

1. Your device will now show as being in compliance in Company Portal. 

---

## Platform SSO registration

Now that the device is in compliance with Company Portal, you need to register your device with PSSO. Use the tabs to register your device with PSSO using secure enclave, smart card, or password.

### [Secure Enclave](#tab/secure-enclave)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. For macOS 14 Sonoma users, you'll see a prompt to register your device with Microsoft Entra. This prompt doesn't appear for macOS 13 Ventura.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/macos-14-microsoft-entra-registration-required.png" alt-text="Screenshot of a Microsoft Entra registration prompt that appears on macOS 14 after the registration required notification is selected.":::

1. Once your account is unlocked with Touch ID or password, select the account to sign in to, enter your sign-in credentials and select **Next**.
1. MFA is required as part of this sign in flow. Open your **Authenticator app** (recommended) or use your other MFA methods you have registered, and enter the number displayed on the screen to finish registration.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-2fa-challenge.png" alt-text="Screenshot of a two-factor authentication window, prompting the user to open the Authenticator app.":::

1. When the MFA flow completes and the loading screen disappears, your device should be registered with PSSO. You can now use PSSO to access Microsoft app resources.

### Enable Platform Credential for macOS for use as a passkey

Setting up your device using secure enclave method enables you to use the resulting credential saved to the Mac as a passkey in the browser. To enable it;

1. Open the **Settings** app, and navigate to **Passwords** > **Password options**.
1. Under **Password Options**, find **Use passwords and passkeys from** and enable **Company Portal** through the toggle switch.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/password-options-enable-passkeys.png" alt-text="Screenshot of the Password Options window indicating that the use of passwords and passkeys from Company Portal has been enabled by a switch.":::

### [Smart Card](#tab/smart-card)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. If your smart card is paired with your local account, you'll see a prompt to enter the smart card pin

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/smartcard-paired-registration-prompt.png" alt-text="Screenshot of the Platform SSO registration prompting the user to enter their smart card pin.":::

1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. If the certificate is not already paired with the local account, the user will see a prompt to use the smart card. Select **Smart card**.
1. You're prompted to enter the pin for your smart card. Enter your pin and select **Enter pin for the smart card**. When the correct pin is entered, PSSO registration with smart card authentication is complete.
1. You can now use PSSO to access Microsoft app resources, and unlock the device with the smart card pin. You'll need to use the local password to log in after a reboot to unlock the keychain access.

### [Password](#tab/password)

1. Navigate to the **Registration Required** popup at the top right of the screen. Hover over the popup and select **Register**. 
    - For macOS 13 Ventura users, you'll see a prompt to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**. 

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-registration-required-popup.png" alt-text="Screenshot of a desktop screen with a registration required popup in the top right of the screen.":::

1. You're prompted to register your device with Microsoft Entra ID. Enter your sign-in credentials and select **Next**.
    1. Your administrator may have configured MFA for the device registration flow. If so, open your **Authenticator** app on your mobile device and complete the MFA flow.

    :::image type="content" source="media/device-join-macos-platform-single-sign-on-out-of-box/psso-register-device-prompt.png" alt-text="Screenshot of the registration window prompting sign in with Microsoft.":::

1. When a **Single Sign-On** window appears, enter your local account password and select **OK**. If you're on macOS 14, <!--you'll be prompted to unlock your local account before this.-->

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

## Update your Mac device to enable PSSO

For macOS users whose device is already enrolled in Company Portal, your administrator can enable PSSO by updating your device's SSO extension profile. Once the PSSO profile is deployed and installed on your device, you're prompted to register your device with PSSO via the **Registration Required** notification at the top right of the screen. This will remove the old SSO registration from your device in place of the new PSSO registration.

Although it's recommended to do it immediately, you can choose to select this and start your device registration at a time convenient to you.

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)