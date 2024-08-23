---
title: macOS Platform single sign-on known issues and troubleshooting
description: Identify and resolve known issues with macOS Platform single sign-on (PSSO).

ms.service: entra-id
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 11/03/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel, miepping
#Customer intent: As a customer, I want to understand how to troubleshoot macOS Platform single sign-on (PSSO) issues, have some frequently asked questions answered, and understand different scenarios to validate.
---

# macOS Platform single sign-on known issues and troubleshooting (preview)

This article outlines the current known issues and common questions with macOS Platform single sign-on (PSSO). It provides issue solutions and information on how to report an issue that isn't covered. This article also includes troubleshooting guidance.

## Scenarios to validate

After deploying PSSO on your device, there are a few validation scenarios that you can do to ensure that the deployment is successful. If there are any issues, refer to [report an issue](#report-an-issue) for further instructions.

### Password change events

Confirm that changes to Microsoft Entra ID password made through self-service password reset (SSPR) are successfully synchronized to the local machine. If a user's Microsoft Entra ID password changes after syncing it to the Mac, the user is prompted to enter their new password within 4 hours.

### Repair or remove PSSO registration from a device

This section outlines how to repair or remove PSSO registration from a Mac device, depending on the macOS version.

### [macOS 14](#tab/macOS14)

On macOS 14 Sonoma, if there are problems with your device registration, you can repair the existing PSSO registration.

1. Open the **Settings** app and navigate to **Users & Groups** > **Network Account Server**.
1. Select **Edit**, then **Repair**. You're taken through the same device registration flow as when during your initial registration.

You can also deregister the device completely by doing the following steps.

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To deregister the device, select **Deregister**.

### [macOS 13](#tab/macOS13)

On macOS 13 Ventura, if there are problems with your device PSSO registration, or you need to deregister your device, use Company Portal and remove the device from your organization.

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To Deregister the device, select **Deregister**.

If you deregistered your device as a result of an error, and need to re-register it, refer to [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md) or [Join a Mac device with Microsoft Entra ID using Company Portal](./device-join-microsoft-entra-company-portal.md).

---

### Enterprise SSO plug-in does not activate after system update

If the Enterprise SSO plug-in fails to activate after system updates are applied to the device, you should reboot the software update daemon.

1. Open the **Terminal** app and enter the following command to kill the `swcd` process.

    ```console
    sudo killall swcd
    ```

2. Then enter the following command to reset the process.

    ```console
    sudo swcutil reset
    ```

### Temporary passwords issued during password reset cannot be synced with Platform SSO

Temporary passwords issued during password reset cannot be synced to the local device. Users are advised to complete the password reset process using their temporary password using the SSO extension.

### Device migration

Confirm that a previously registered device (with a Workplace Join key in Keychain Access) removes the key after successful PSSO device registration.

## Frequently asked questions

### Can I use macOS PSSO in a hybrid-join deployment?

No, macOS PSSO is only supported in Microsoft Entra join deployments. There are no plans to support hybrid-join deployments, as we recommend that Mac users go fully cloud based.

### How can I change my password when using Platform SSO?

Users can change their password using Self-Service Password Reset (SSPR) on their device. 

If SSPR is done on another machine users will be allowed to sign-in to the Mac device using either the old or the new password. Using the old password will unlock the device and then prompt the user for the new password to continue syncing data. Using the new password will unlock the device and sync data immediately.

### What should I do if I forget my password?

#### [Password Sync](#tab/PasswordSync)
If Users are at lock screen or login screen they can reset their password from there. If the user received a temporary password from an IT admin they should use another device to log in, set up a new password and use that new password at to log in to their own device. 

> [!NOTE] 
> If the device is booted and there is FileVault encryption the new Entra password will work on macOS15 only. 

#### [Secure Enclave](#tab/PasswordSync)
Users can reset the local password via Apple ID or an admin recovery key. 

## Known issues

### Passcode policy complexity mismatches

There's a known issue where an applied MDM configuration specifies a local password policy with a higher degree of complexity than the Microsoft Entra account used to sign-in to the machine. In this case, the password synchronization operation between Microsoft Entra ID and the local machine fails.

Ensure during the MDM configuration that the password complexity requirements are identical between the local machine and Microsoft Entra ID.

### Long running operations

#### [macOS 14](#tab/macOS14)

If the device registration fails through the Settings application, the Device Registration popup will reappear after about 10 minutes, and you can try again.

#### [macOS 13](#tab/macOS13)

The device registration can take a few minutes to complete. If the device registration fails, wait a few minutes and try again if prompted.

---

### SSO auth prompt dialog closed while the registration is in progress

If you cancel the registration process by closing the SSO auth prompt dialog, you need to sign out from your Mac device and sign in again. Upon a successful sign in, the registration notification reappears and works correctly.

### Per user MFA causes password sync failure

If a user has per user MFA enabled on the account where PSSO is being set up, you won't be able to enter Microsoft Entra ID credentials in the next steps, causing an error. To avoid this error, admins should ensure they have Conditional Access MFA enabled in accordance with [Microsoft Entra ID recommendations](../monitoring-health/recommendation-turn-off-per-user-mfa.md). This suppresses MFA during enrollment so that password synchronization can be completed successfully.

### PSSO reregistration required after password reset initiated from FileVault recovery or MDM-driven recovery

Because Secure Enclave keys are protected by your local account password, password resets that occur without providing this password (such as FileVault or MDM-based recovery) will reset the Secure Enclave. Resetting the Secure Enclave renders keys previously stored for this account inaccessible. Devices whose Secure Enclave keys have been lost must be reregistered to use Platform SSO.

## Report an issue

If you're experiencing issues with PSSO, you can report them on Company Portal.

1. Open the **Company Portal** app and navigate **Help** > **Send diagnostic report**.
1. A **Send diagnostic report** window appears. Select **Email logs** to send the logs.
1. Take note of your incident ID before closing the window.

You can check the current PSSO state on your machine at any time by opening the **Terminal** app. Run the following command.

```console
app-sso platform -s
```

### Contact us

We'd love to hear your feedback. You should include the following information:
- Sysdiagnose and diagnostic logs
- Steps to reproduce the issue
- Where applicable, include relevant screenshots and/or recordings

#### Capturing Sysdiagnose and diagnostic logs
1. Enable debug logs persistance by running the following command in Terminal.

    ```console
    sudo log config --mode "level:debug,persist:debug" --subsystem com.apple.AppSSO"
    ```
2. Reproduce the issue, such that new logs are generated for the affected scenario. Please provide relevant timestamps in your issue report to assist in log investigation.
3. Capture diagnostic data by running the following command in Terminal.

    ```console
    sudo sysdiagnose
    ```

## Troubleshooting guide

### Insufficient permissions

If a user has insufficient permissions to complete Microsoft Entra ID join and registration, no error message is shown. For the device join and registration to complete successfully, the user initiating the registration flow must be allowlisted.

1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **Identity** > **Devices** > **Overview** > **Device Settings**.
1. Under **Microsoft Entra ID join and registration settings**, ensure that the **All** option is selected in the toggle menu for **Users may join devices to Microsoft Entra**.
1. Select **Save** to apply the changes.

### Troubleshoot Passkey issues

Platform Credential as Passkey option is only available if Secure Enclave is configured as the authentication method for Platform SSO. You should check the following:

1. Ensure that your admin has set up your device with Secure Enclave as the authentication method, and has [enabled passkeys (FIDO2) for your organization](/entra/identity/authentication/how-to-enable-passkey-fido2#enable-passkey-authentication-method).
1. As a user, check that you have enabled Company Portal as a passkey provider in your device settings. Navigate to your **Settings** app, **Passwords** and **Password options**, and ensure that **Company Portal** is enabled.

### Troubleshoot Google Chrome SSO issues

If a user has the [Microsoft Single Sign On](https://chromewebstore.google.com/detail/microsoft-single-sign-on/ppnbnpeolgkicgegkbkbjmhlideopiji?pli=1) extension for Google Chrome installed then their Chrome browser should be able communicate with the Microsoft SSO broker for both a SSO user experience and to work with device-based Conditional Access policies. If users are not able to pass device-based Conditional Access policies in Google Chrome then there may be an issue with how the Company Portal application was installed, which can prevent Chrome from communicating with the SSO broker. You should take the following steps to remediate this issue:

1. Open the **Applications** folder on the Mac
1. Right click the **Company Portal** application and choose **Move to Trash**
1. Download the latest version of the Company Portal installer from [https://go.microsoft.com/fwlink/?linkid=853070](https://go.microsoft.com/fwlink/?linkid=853070)
1. Freshly install Company Portal using the downloaded **CompanyPortal-Installer.pkg**

Validate that the issue has been resolved by checking for the **existence of this file**: `~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/com.microsoft.browsercore.json`

```console
ls ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/com.microsoft.browsercore.json
```

Alternatively, you can deploy the following script via your MDM or other automation tools to copy the JSON file to the correct location. This script should be run in the user's context for each user who experiences the Chrome SSO issue:

```zsh
#!/usr/bin/env zsh
# Copy over Browser Core json file to the right location
# If the folder doesn't exist, create it

# For Google Chrome (user-specific, default path)

if [ ! -d ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts ]; then
  mkdir ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts
fi

cp /Applications/Company\ Portal.app/Contents/Resources/com.microsoft.browsercore.json ~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/

# For Edge (user-specific, default path, not channel specific)
# See: https://learn.microsoft.com/microsoft-edge/extensions-chromium/developer-guide/native-messaging?tabs=v3%2Cmacos

if [ ! -d ~/Library/Application\ Support/Microsoft\ Edge/NativeMessagingHosts ]; then
  mkdir ~/Library/Application\ Support/Microsoft\ Edge/NativeMessagingHosts
fi

cp /Applications/Company\ Portal.app/Contents/Resources/com.microsoft.browsercore.json ~/Library/Application\ Support/Microsoft\ Edge/NativeMessagingHosts/
```

> [!IMPORTANT]
> **Note: This issue is due to a bug with how Company Portal is installed or updated under certain circumstances. This issue will be resolved in a future update to Company Portal.**

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
- [Join a Mac device with Microsoft Entra ID using Company Portal](./device-join-microsoft-entra-company-portal.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](~/identity-platform/apple-sso-plugin.md)
- [Troubleshooting the Microsoft Enterprise SSO Extension plugin on Apple devices](./troubleshoot-mac-sso-extension-plugin.md)
