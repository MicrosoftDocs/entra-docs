---
title: Enable Kerberos SSO to On-Premises Active Directory and Entra ID Kerberos Resources in Platform SSO
description: How administrators can set up macOS Platform Single Sign-on to support Kerberos authentication to on-premises Active Directory and Entra ID kerberos-integrated resources.

ms.service: entra-id
ms.subservice: devices
ms.topic: tutorial
ms.date: 05/13/2024

ms.author: cwerner
author: cilwerner
manager: 
ms.reviewer: brianmel
#Customer intent: As a user I want to understand how to set up a Mac device with macOS Platform Single Sign-on (PSSO) during the out of box experience. I want to know the difference betwwen setting up with secure enclave, smart card or password based authentication methods.
---

# Enable Kerberos SSO to on-premises Active Directory and Entra ID Kerberos resources in Platform SSO

Mac users can join their new device to Microsoft Entra ID during the first-run out-of-box experience (OOBE). The macOS Platform single sign-on (PSSO) is a capability on macOS that is enabled using the [Microsoft Enterprise Single Sign-on Extension](../../identity-platform/apple-sso-plugin.md). PSSO allows users to sign in to a Mac device using a hardware-bound key, smart card or their Microsoft Entra ID password.

This tutorial shows you how to configure Platform SSO to support Kerberos-based SSO to on-premises and cloud resources, in addition to SSO to Entra ID. This is an optional capability within Platform SSO, but it is recommended if users still need to access on-premises Active Directory resources that use Kerberos for authentication.

## Prerequisites

- A minimum version of **macOS 14.6 Sonoma**.
- [Microsoft Intune Company Portal](/mem/intune/apps/apps-company-portal-macos) version 5.2408.0 or later
- A Mac device enrolled in mobile device management (MDM).
- A configured SSO extension MDM payload with Platform SSO settings by an administrator, already deployed to the device. Refer to the [Platform SSO documentation](./macos-psso.md) or [Intune deployment guide](/mem/intune/configuration/platform-sso-macos) if Intune is your MDM.

## Set up your macOS device

Refer to the [Microsoft Entra ID macOS Platform SSO documentation](./macos-psso.md) to learn how to configure and deploy Platform SSO. This must be performed regardless of whether you choose to deploy Kerberos SSO using this guide.

## Kerberos SSO MDM profile configuration

You must configure a Kerberos SSO MDM profile. Use the following settings, ensuring that you replace all references to **contoso.com** and **Contoso** with the proper values for your environment:

| Configuration Key | Recommended Value | Note |
|-|-|-|
| `preferredKDCs` | `<string>kkdcp://login.microsoftonline.com/contoso.com/kerberos</string>` | Replace the **contoso.com** value with the value of one of your tenant domains or your tenant's GUID |
| `Hosts` | `<string>contoso.com</string>` | Replace **contoso.com** with your on-premises domain/forest name |
| `Hosts` | `<string>*.contoso.com</string>` | Replace **contoso.com** with your on-premises domain/forest name. Keep the preceding `*.` characters before your domain/forest name |
| `PayloadOrganization` | `<string>Contoso</string>` | Replace **Contoso** with the name of your organization |

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PayloadContent</key>
    <array>
        <dict>
            <key>ExtensionData</key>
            <dict>
                <key>allowPasswordChange</key>
                <true/>
                <key>allowPlatformSSOAuthFallback</key>
                <true/>
                <key>performKerberosOnly</key>
                <true/>
                <key>pwReqComplexity</key>
                <true/>
                <key>syncLocalPassword</key>
                <true/>
                <key>usePlatformSSOTGT</key>
                <true/>
                <key>preferredKDCs</key>                         
                <array>
                <string>kkdcp://login.microsoftonline.com/contoso.com/kerberos</string>
                </array>
            </dict>
            <key>ExtensionIdentifier</key>
            <string>com.apple.AppSSOKerberos.KerberosExtension</string>
            <key>Hosts</key>
            <array>
                <string>contoso.com</string>
                <string>*.contoso.com</string>
                <string>windows.net</string>
                <string>*.windows.net</string>
                <string>KERBEROS.MICROSOFTONLINE.COM</string>
                <string>MICROSOFTONLINE.COM</string>
                <string>*.MICROSOFTONLINE.COM</string>
            </array>
            <key>PayloadDisplayName</key>
            <string>Single Sign-On Extensions Payload</string>
            <key>PayloadIdentifier</key>
            <string>1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5C</string>
            <key>PayloadType</key>
            <string>com.apple.extensiblesso</string>
            <key>PayloadUUID</key>
            <string>1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5</string>
            <key>PayloadVersion</key>
            <integer>1</integer>
            <key>Realm</key>
            <string>KERBEROS.MICROSOFTONLINE.COM</string>
            <key>TeamIdentifier</key>
            <string>apple</string>
            <key>Type</key>
            <string>Credential</string>
            <key>URLs</key>
            <array/>
        </dict>
    </array>
    <key>PayloadDescription</key>
    <string></string>
    <key>PayloadDisplayName</key>
    <string>Kerberos SSO Extension for macOS</string>
    <key>PayloadEnabled</key>
    <true/>
    <key>PayloadIdentifier</key>
    <string>2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6</string>
    <key>PayloadOrganization</key>
    <string>Contoso</string>
    <key>PayloadRemovalDisallowed</key>
    <true/>
    <key>PayloadScope</key>
    <string>System</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>2bbbbbb2-3cc3-4dd4-5ee5-6ffffffffff6</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
</dict>
</plist>
```

Once you have updated the configuration to use the proper values for your environment, save the configuration using a text editor with the *.mobileconfig* file extension (e.g., *kerberos.mobileconfig*).

### Intune configuration steps

If you use Intune as your MDM you can perform the following steps to deploy the profile. Make sure you follow the [previous instructions](#kerberos-sso-mdm-profile-configuration) about replacing **contoso.com** values with the proper values for your organization.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
1. Select **Devices** > **Configuration** > **Create** > **New policy**.
1. Enter the following properties:
    - **Platform**: Select **macOS**.
    - **Profile type**: Select **Templates**.
1. Choose the **Custom** template and select **Create**.
1. In **Basics**, enter the following properties:
    - **Name**: Enter a descriptive name for the policy. Name your policies so you can easily identify them later. For example, name the policy **macOS - Platform SSO Kerberos**.
    - **Description**: Enter a description for the policy. This setting is optional, but recommended.
1. Select **Next**.
1. Enter a name in the **Custom configuration profile name** box.
1. Choose a **Deployment channel**. Device channel is recommended.
1. Click the folder icon to upload your **Configuration profile file**. Choose the *kerberos.mobileconfig* file you [saved previously](#kerberos-sso-mdm-profile-configuration) after customizing the template.
1. Select **Next**.
1. In **Scope tags** (optional), assign a tag to filter the profile to specific IT groups, such as `US-NC IT Team` or `JohnGlenn_ITDepartment`. Select **Next**.
  - For more information about scope tags, see [Use RBAC roles and scope tags for distributed IT](/mem/intune/fundamentals/scope-tags).
1. In **Assignments**, select the users or user groups that will receive your profile. Platform SSO policies are user-based policies. Don't assign the platform SSO policy to devices.

    For more information on assigning profiles, see [Assign user and device profiles](/mem/intune/configuration/device-profile-assign).

    Select **Next**.

1. In **Review + create**, review your settings. When you select **Create**, your changes are saved, and the profile is assigned. The policy is also shown in the profiles list.

The next time the device checks for configuration updates, the settings you configured are applied.
2. Test Microsoft Entra ID Kerberos functionality by accessing an Azure Files share enabled for Microsoft Entra ID cloud kerberos. The user should be able to access the file share without being challenged for interactive credentials. Refer to [this guide](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable) if you need to configure a cloud file share in Azure Files.
