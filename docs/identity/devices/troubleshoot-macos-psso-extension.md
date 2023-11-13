---
title: MacOS Platform single sign-on known issues and troubleshooting
description: Identify and resolve known issues with MacOS Platform single sign-on (PSSO).

ms.service: active-directory
ms.subservice: devices
ms.topic: troubleshooting
ms.date: 11/03/2023

ms.author: cwerner
author: cilwerner
manager: CelesteDG
ms.reviewer: brianmel
---

# MacOS Platform single sign-on known issues and troubleshooting (preview)

This article outlines the current known issues with macOS Platform single sign-on (PSSO) that can be encountered. It provides issue solutions and information on how to report an issue that isn't covered. This article also includes troubleshooting guidance.

## Scenarios to validate

After deploying PSSO on your device, there are a few validation scenarios that you can do to ensure that the deployment is successful. If there are any issues, refer to [report an issue](#report-an-issue) for further instructions.

### Password change events

Confirm that changes to Microsoft Entra ID password made through self-service password reset (SSPR) are successfully synchronized to the local machine. If a user's Microsoft Entra ID password changes after syncing it to the Mac, the user is prompted to enter their new password within 4 hours.

### Repair or remove PSSO registration from a device

### [macOS 14](#tab/macOS14)

On macOS 14 Sonoma, if there are problems with your device registration, you can repair the existing PSSO registration.

1. Open the **Settings** app and navigate to **Users & Groups** > **Network Account Server**.
1. Select **Edit**, then **Repair**. You'll be taken through the same device registration flow as when during your initial registration.

You can also deregister the device completely;

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To unregister the device, select **Unregister**.
1. Alternatively, to sign out your work account on the device, select **Sign out**. <!--TODO: Insert slide 107 screenshot--> This is done silently and there's no confirmation that your device is deregistered.

### [macOS 13](#tab/macOS13)

On macOS 13 Venture, if there are problems with your device PSSO registration, or you need to deregister your device, you need to use Company Portal and remove the device from your organization.

1. Open the **Company Portal** app and navigate to **Preferences**.
1. To unregister the device, select **Unregister**.
1. Alternatively, to sign out your work account on the device, select **Sign out**. <!--TODO: Insert slide 107 screenshot--> This is done silently and there's no confirmation that your device is deregistered.

If you deregistered your device as a result of an error, and need to re-register it, refer to [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-pssoe-out-of-box.md) or [Register a Mac device with macOS Platform Single Sign-On using Company Portal](./device-registration-macos-pssoe.md).

---

### Device migration

Confirm that a previously registered device (with a Workplace Join key in Keychain Access) removes the key after successful PSSO device registration.

## Known issues

### Passcode policy complexity mismatches

If the applied MDM configuration specifies a local password policy with a higher degree of complexity than the Microsoft Entra account used to sign-in to the machine, the password synchronization operation between Microsoft Entra ID and the local machine will fail.

Ensure during the MDM configuration that the password complexity requirements are identical between the local machine and Microsoft Entra ID.

### Long running operations

### [macOS 14](#tab/macOS14)

If the device registration fails through the Settings application, the Device Registration popup will reappear after about 10 minutes, and you can try again.

### [macOS 13](#tab/macOS13)

The device registration can take a few minutes to complete. If the device registration fails, wait a few minutes and try again if prompted.

---

### SSO auth prompt dialog closed while the registration is in progress

If you cancel the registration process by closing the SSO auth prompt dialog, you need to sign out from your Mac device and sign in again. Upon a successful sign in, the registration notification reappears and will work correctly.

### No error message if user has insufficient permissions

If a user has insufficient permissions to complete Microsoft Entra ID join and registration, there's no error message. For the device join and registration to complete successfully.

### Per user MFA causes password sync failure

If a user has per user MFA enabled on the account where PSSO is being set up, you won't be able to enter Microsoft Entra ID credentials in the next steps, causing an error. To avoid this, admins should ensure they have Conditional Access MFA enabled in accordance with [Microsoft Entra ID recommendations](../monitoring-health/recommendation-turn-off-per-user-mfa.md). This suppresses MFA during enrollment so that password synchronization can be completed successfully.

## Report an issue

If you're experiencing issues with PSSO, you can report them on Company Portal.

1. Open the **Company Portal** app and navigate **Help** > **Send diagnostic report**.
1. A **Send diagnostic report** window appears. Select **Email logs** to send the logs.
1. Take note of your incident ID before closing the window.

You can check the current PSSO state on your machine at any time by opening the **Terminal** app. Run the following command.

### Contact us

We'd love to hear your feedback. You can contact us at [Platform SSO Feedback @ Microsoft](mailto:macos-sso-feedback@microsoft.com). Include;

- Apple logs

    ```console
    sudo log config --mode "level:debug,persist:debug" --subsystem com.apple.AppSSO"
    ```

- Diagnostic data

    ```console
    sudo sysdiagnose
    ```

- Steps to reproduce the issue
- Where applicable, include relevant screenshots and/or recordings

## Troubleshooting guide

### Insufficient permissions

If a user has insufficient permissions to complete Microsoft Entra ID join and registration, no error message is shown. For the device join and registration to complete successfully, the user initiating the registration flow must be allowlisted.

1. In the Microsoft Intune admin center, navigate to **Devices** > **Device Settings**.
1. Under **Microsoft Entra ID join and registration settings**, ensure that the **All** option is selected in the toggle menu.
1. Select **Save** to apply the changes.

## See also

- [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-pssoe-out-of-box.md)
- [Register a Mac device with macOS Platform Single Sign-On using Company Portal](./device-registration-macos-pssoe.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](~/identity-platform/apple-sso-plugin.md)
- [Troubleshooting the Microsoft Enterprise SSO Extension plugin on Apple devices](./troubleshoot-mac-sso-extension-plugin.md)