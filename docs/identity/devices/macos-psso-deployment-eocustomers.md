---
title: Configuring macOS Platform SSO (PSSO) to meet NIST SP 800-63 and EO 14028 Requirements (preview)
description: How to deploy macOS Platform Single Sign On (PSSO) to meet NIST SP 800-63 and EO 14028 Requirements.
ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 05/01/2025
ms.author: godonnell
author: garrodonnell
manager: celested

#Customer intent: As an IT Admin for a US Government Agency, I want to understand how to configure macOS Platform Single Sign-on (PSSO) for Microsoft Entra ID registered devices to meet the National Institute of Standards and Technology (NIST) Special Publication (SP) 800-63 Revision 4 and Executive Order (EO) 14028 requirements.
---

# Configuring macOS Platform SSO (PSSO) to meet NIST SP 800-63 and EO 14028 Requirements (preview)

This document provides a comprehensive guidance for deploying macOS Platform Single Sign-On (PSSO) by US government agencies to meet the National Institute of Standards and Technology (NIST) Special Publication (SP) 800-63 Revision 4 and Executive Order (EO) 14028 requirements. By following the instructions and best practices outlined in this document, organizations can ensure a seamless and secure SSO experience for their macOS users.

## Prerequisites

* Minimum version of macOS 13 Ventura (macOS 14 Sonoma or later recommended)
* Users must be able to perform a multifactor authentication during registration using one of the supported MFA methods in Entra ID.
    * [Microsoft Entra MFA](../authentication/concept-mfa-howitworks.md)
    * [Federated MFA](/windows-server/identity/ad-fs/operations/configure-ad-fs-and-azure-mfa)
    * [External Auth Methods](../authentication/how-to-authentication-external-method-manage.md)
* [Microsoft Intune Company Portal app version 5.2408.0](/mem/intune/apps/apps-company-portal-macos) or later installed. This version is required before users are targeted for PSSO.
* (Highly recommended) Users are advised to [register a passkey on their mobile devices.](../authentication/how-to-register-passkey-mobile.md)


## Authentication Method Selection

US government agencies must use a phishing-resistant authentication method in the Platform SSO configuration deployed to their devices.

macOS 14 Sonoma and later offer two phishing-resistant methods in the Apple Platform SSO framework:

1. [Secure Enclave](/mem/intune/configuration/platform-sso-macos#secure-enclave) (Recommended).        
2. [Smart card](/mem/intune/configuration/platform-sso-macos#smart-card).

For more information and a comparison of available authentication methods with Platform SSO, please see [Decide the authentication method](/mem/intune/configuration/platform-sso-macos#step-1---decide-the-authentication-method).

## Microsoft Intune Configuration

See [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos).

## Configuration for other MDMs

Please refer to your MDM provider’s documentation for information on support and provisioning Platform SSO for macOS.

## Enable SSO for Applications that don’t use Microsoft Authentication Library (MSAL)

See [Enable SSO for apps that don’t use MSAL](../../identity-platform/apple-sso-plugin.md).

## Configure Kerberos SSO Integration

See [Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in Platform SSO](./device-join-macos-platform-single-sign-on-kerberos-configuration.md).

## Account Management

### Create and Provision Accounts

To use Platform SSO, the devices must be MDM-enrolled. If using Intune, use one of the following methods:

* For organization-owned devices, you can:

    * Create an [Automated device enrollment](/mem/intune/enrollment/device-enrollment-program-enroll-macos) policy using Apple Business Manager.

    * Create a [Direct enrollment](/mem/intune/enrollment/device-enrollment-direct-enroll-macos) policy using Apple Configurator.

* For personally owned devices, create a [Device enrollment](/mem/intune/fundamentals/deployment-guide-enrollment-macos#byod-device-enrollment) policy. With this enrollment method, end users open the Company Portal app and sign in with their Microsoft Entra ID user account. When the successfully signed in, the enrollment policy applies.    

For new devices, we recommend you pre-create and configure all the necessary policies, including the enrollment policy. Then, when the devices enroll in Intune, the policies automatically apply.

For existing devices already enrolled in Intune, assign the Platform SSO policy to your users or user groups. The next time the devices sync or check-in with Intune, they receive the Platform SSO policy settings you create.

### Create Device Compliance Policies

Device Compliance Policies in Microsoft Intune allow administrators to ensure that enrolled devices meet organizational security standards and are configured properly. These policies help safeguard corporate data by enforcing requirements such as encryption, operating system versions, and security measures like password strength. For more information on configuring Device Compliance Policies, please see [Device Compliance Settings for macOS Settings in Intune](/mem/intune/protect/compliance-policy-create-mac-os).

### Deprovision or Offboard Accounts

#### Deleting users from a tenant

See [How to create, invite, and delete users](../../fundamentals/how-to-create-delete-users.yml). 

#### Revoke a user's access

See [Revoke user access in Microsoft Entra ID](../users/users-revoke-access.md).

#### Remotely lock devices with Intune

See [Remotely lock devices with Intune](/mem/intune/remote-actions/device-remote-lock).

### MDM Unenrollment

#### Step 1 - Remove PSSO targeted users from the Configuration Profile assignment
1. In the Microsoft Intune admin center click on **Home**.
1. Go to **Devices** and then **Configuration profiles**.
1. Select the configuration profile you want to edit from the list.
1. Next to **Assignments**, select **Edit**.
1. To remove the assignment select **Remove**.
1. Select **Review + Save** to complete the changes.

#### Step 2 - Perform a Bulk Device Action to synchronize the policy removal
1. In Microsoft Endpoint Management center select **Devices**.
1. Choose **All devices** and select **Bulk device actions**.
1. On the **Bulk Device Action** page, select *macOS* as the OS, and *Sync* as the device action.
1. Select **Next** and choose the maximum number of devices that the action supports and select **Next**.
1. On the **Review + Create** page, select **Create** and run the action.

> [!TIP] 
> If you would like to synchronize a specific device, please refer to [Sync devices to get the latest policies and actions with Intune](/mem/intune/remote-actions/device-sync#sync-a-device).

#### Detect and Remove Stale Devices in Microsoft Entra ID and Intune

See [How To: Manage stale devices in Microsoft Entra ID](./manage-stale-devices.md) and [Delete devices from the Intune Admin Center](/mem/intune/remote-actions/devices-wipe#delete-devices-from-the-intune-admin-center).

## Integrate Applications with the SSO Broker

[MSAL for Apple devices](https://github.com/AzureAD/microsoft-authentication-library-for-objc) versions 1.1.0 and later support the Microsoft Enterprise SSO plug-in for Apple devices natively for work and school accounts.

You don’t need any special configuration if you followed [Quickstart: Sign in users and call Microsoft Graph from an iOS or macOS app](../../identity-platform/quickstart-mobile-app-ios-sign-in.md) and used the [default redirect URI format](/mem/intune/remote-actions/devices-wipe#delete-devices-from-the-intune-admin-center). 

On devices that have the SSO plug-in, MSAL automatically invokes it for all interactive and silent token requests. It also invokes it for account enumeration and account removal operations. Because MSAL implements a native SSO plug-in protocol that relies on customer operations, this setup provides the smoothest native experience to the end user.

## Best Practices

### Smart Card Certificate Pinning
When using smart card-based authentication, it is highly recommended that you specify which Certificate Issuing Authorities are used for the trust evaluation of smart card certificates. This trust, which works in conjunction with Certificate Trust settings, is known as certificate pinning. For more information, see [Advanced Smart card Options on Mac](https://support.apple.com/guide/deployment/advanced-smart-card-options-dep7b2ede1e3/web#:~:text=Certificate%20pinning,%3C/plist%3E).

#### Example configuration

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" http://www.apple.com/DTDs/PropertyList-1.0.dtd>
    <plist version="1.0">
    <dict>
        <key>AttributeMapping</key>
        <dict>
            <key>dsAttributeString</key
            <string>dsAttrTypeStandard:AltSecurityIdentities</string>
            <key>fields</key>
            <array>
                <string>NT Principal Name</string>
            </array>
            <key>formatString</key>
            <string>PlatformSSO:$1</string>
        </dict>
        <key>TrustedAuthorities</key>
        <array>
    <string>SHA256_HASH_OF_CERTDOMAIN_1,SHA256_HASH_OF_CERTDOMAIN_2</string>
        </array>
    </dict>
    </plist>
```

## Troubleshooting

If you experience issues when deploying macOS Platform SSO, refer to our documentation on [macOS Platform Single Sign-on known issues and troubleshooting](./troubleshoot-macos-platform-single-sign-on-extension.md).

## See also

- [macOS Platform Single Sign-on overview (preview)](../devices/macos-psso.md)
- [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Configure Microsoft Entra ID to meet NIST authenticator assurance levels](../../standards/nist-overview.md)
- [NIST authenticator types and aligned Microsoft Entra methods](../../standards/nist-authenticator-types.md)
- [NIST authenticator assurance level 3 by using Microsoft Entra ID](../../standards/nist-authenticator-assurance-level-3.md)
