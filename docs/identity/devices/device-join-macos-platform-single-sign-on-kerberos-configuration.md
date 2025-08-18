---
title: Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos Resources in Platform SSO
description: How administrators can set up macOS Platform Single Sign-on to support Kerberos authentication to on-premises Active Directory and Microsoft Entra ID kerberos-integrated resources.
ms.service: entra-id
ms.subservice: devices
ms.topic: tutorial
ms.date: 05/13/2024
ms.author: cwerner
author: cilwerner
manager: pmwongera
ms.reviewer: brianmel
ms.custom: sfi-image-nochange
#Customer intent: As a user I want to understand how to set up a Mac device with macOS Platform Single Sign-on (PSSO). I want to know the difference between setting up with secure enclave, smart card or password based authentication methods.
---

# Enable Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources in Platform SSO

The macOS Platform single sign-on (PSSO) is a capability on macOS that is enabled using the [Microsoft Enterprise Single Sign-on Extension](../../identity-platform/apple-sso-plugin.md). Platform SSO enables users to Entra join their macOS devices and sign in using a hardware-bound key, smart card, or their Microsoft Entra ID password through a PSSO Primary Refresh Token (PRT). 

In addition to the PSSO PRT, Microsoft Entra also issues both on-premises and cloud-based Kerberos Ticket Granting Tickets (TGTs) which are then shared with the native Kerberos stack in macOS via TGT mapping in PSSO. Customers have the flexibility to determine how these TGTs are utilized in their environment and can configure either the Kerberos SSO extension file accordingly. The Kerberos SSO extension, owned and maintained by Apple, is designed to provide seamless single sign-on for Kerberos-based resources on macOS. For any help needed with Kerberos sso extension configuration, please engage with Apple.

This tutorial illustrates how to leverage Platform SSO TGT to support Kerberos-based SSO to on-premises and cloud resources, in addition to SSO to Microsoft Entra ID. Kerberos SSO is an optional capability within Platform SSO, but it's recommended if users still need to access on-premises Active Directory resources that use Kerberos for authentication.

## Customize Kerberos TGT setting

Customers can customize the TGT mapping setting using the below key/value in the extension data dictionary in SSO extension configuration. This option is **only enabled in Company portal version 2508 and above.**

- **Key**: `custom_tgt_setting`  
- **Type**: `Integer`

| Value | Description                                                                                                         |
|--------|--------------------------------------------------------------------------------------------------------------------|
| `0`    | **Both On-Prem and Cloud TGTs** – Maps both on-premises and cloud TGTs. This is the default configuration.         |
| `1`    | **On-Prem TGT Only** – Maps only the on-premises TGT.                                                              |
| `2`    | **Cloud TGT Only** – Maps only the cloud-based TGT.                                                                |
| `3`    | **No TGTs** – Disables TGT mapping entirely.                                                                       |


Configuration example:

:::image type="content" source="media/device-join-macos-platform-single-sign-on-kerberos-configuration/customize-tgt-setting.png" alt-text="Screenshot of customizing Kerberos TGT SSO setting.":::


## Prerequisites

- A minimum version of **macOS 14.6 Sonoma**.
- [Microsoft Intune Company Portal](/mem/intune/apps/apps-company-portal-macos) version 5.2408.0 or later
- A Mac device enrolled in mobile device management (MDM).
- A configured SSO extension MDM payload with Platform SSO settings by an administrator, already deployed to the device. Refer to the [Platform SSO documentation](./macos-psso.md) or [Intune deployment guide](/mem/intune/configuration/platform-sso-macos) if Intune is your MDM.
- Deploy Microsoft Entra Kerberos, which is required for some Kerberos capabilities in on-premises Active Directory. For more information, see the [Cloud Kerberos trust deployment guide for Windows Hello for Business](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust) or refer directly to the [Cloud Kerberos trust configuration instructions](/entra/identity/authentication/howto-authentication-passwordless-security-key-on-premises#install-the-azureadhybridauthenticationmanagement-module) to begin the setup. If you have already deployed Windows Hello for Business with Cloud Kerberos trust or passwordless security key sign-in for Windows, then this step has already been completed.

## Set up your macOS device

Refer to the [Microsoft Entra ID macOS Platform SSO documentation](./macos-psso.md) to configure and deploy Platform SSO. Platform SSO should be deployed on Enterprise-managed Macs regardless of whether you choose to deploy Kerberos SSO using this guide.

## Kerberos SSO MDM profile configuration for on-premises Active Directory

You should configure separate Kerberos SSO MDM profiles if you plan to use both Microsoft Entra ID Cloud Kerberos and on-premises Active Directory realms. If you don't plan to use the Microsoft Entra Cloud Kerberos TGT, then you only need to configure the on-premises Kerberos SSO profile.

Use the following settings to configure the on-premises Active Directory profile, ensuring that you replace all references to **contoso.com** and **Contoso** with the proper values for your environment:

| Configuration Key     | Recommended Value               | Note                                                                                                                               |
|-----------------------|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| `Hosts`               | `<string>.contoso.com</string>` | Replace **contoso.com** with your on-premises domain/forest name. Keep the preceding `.` character before your domain/forest name                                                                 |
| `Hosts`               | `<string>contoso.com</string>`  | Replace **contoso.com** with your on-premises domain/forest name |
| `Realm`               | `<string>CONTOSO.COM</string>`  | Replace **CONTOSO.COM** with your on-premises realm name. The value should be all capitalized.                                     |
| `PayloadOrganization` | `<string>Contoso</string>`      | Replace **Contoso** with the name of your organization                                                                             |

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
                <false/>
                <key>usePlatformSSOTGT</key>
                <true/>
            </dict>
            <key>ExtensionIdentifier</key>
            <string>com.apple.AppSSOKerberos.KerberosExtension</string>
            <key>Hosts</key>
            <array>
                <string>.contoso.com</string>
                <string>contoso.com</string>
            </array>
            <key>Realm</key>
            <string>CONTOSO.COM</string>
            <key>PayloadDisplayName</key>
            <string>Single Sign-On Extensions Payload for On-Premises</string>
            <key>PayloadType</key>
            <string>com.apple.extensiblesso</string>
            <key>PayloadUUID</key>
            <string>1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5</string>
            <key>TeamIdentifier</key>
            <string>apple</string>
            <key>Type</key>
            <string>Credential</string>
        </dict>
    </array>
    <key>PayloadDescription</key>
    <string></string>
    <key>PayloadDisplayName</key>
    <string>Kerberos SSO Extension for macOS for On-Premises</string>
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

Save the configuration using a text editor with the *mobileconfig* file extension (for example, the file could be named *on-prem-kerberos.mobileconfig*) after updating the configuration with the proper values for your environment.

## Kerberos SSO MDM profile configuration for Microsoft Entra ID Cloud Kerberos

You should configure separate Kerberos SSO MDM profiles if you plan to use both Microsoft Entra ID Cloud Kerberos and on-premises Active Directory realms. It's recommended to deploy on-premises Active Directory profile before the Microsoft Entra ID Cloud Kerberos profile.

Use the following settings to configure the Microsoft Entra ID Cloud Kerberos profile, ensuring that you replace all references with the proper values for your tenant:

| Configuration Key     | Recommended Value                                                                                  | Note                                                                                                                                                                                               |
|-----------------------|----------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `preferredKDCs`       | `<string>kkdcp://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/kerberos</string>` | Replace the **aaaabbbb-0000-cccc-1111-dddd2222eeee** value with the Tenant ID of your tenant, which can be found on the Overview page of the [Microsoft Entra Admin Center](https://entra.microsoft.com) |
| `PayloadOrganization` | `<string>Contoso</string>`                                                                         | Replace **Contoso** with the name of your organization                                                                                                                                             |
| `Hosts`               | `<string>.windows.net</string>` |                                                                    |
| `Hosts`               | `<string>windows.net</string>`  | |
| `Realm`               | `<string>KERBEROS.MICROSOFTONLINE.COM</string>`  | The value should be all capitalized.                                     |
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
                <key>usePlatformSSOTGT</key>
                <true/>
                <key>performKerberosOnly</key>
                <true/>
                <key>preferredKDCs</key>                         
                <array>
                <string>kkdcp://login.microsoftonline.com/aaaabbbb-0000-cccc-1111-dddd2222eeee/kerberos</string>
                </array>
            </dict>
            <key>ExtensionIdentifier</key>
            <string>com.apple.AppSSOKerberos.KerberosExtension</string>
            <key>Hosts</key>
            <array>
                <string>windows.net</string>
                <string>.windows.net</string>
            </array>
            <key>Realm</key>
            <string>KERBEROS.MICROSOFTONLINE.COM</string>
            <key>PayloadDisplayName</key>
            <string>Single Sign-On Extensions Payload for Microsoft Entra ID Cloud Kerberos</string>
            <key>PayloadType</key>
            <string>com.apple.extensiblesso</string>
            <key>PayloadUUID</key>
            <string>00aa00aa-bb11-cc22-dd33-44ee44ee44ee</string>
            <key>TeamIdentifier</key>
            <string>apple</string>
            <key>Type</key>
            <string>Credential</string>
        </dict>
    </array>
    <key>PayloadDescription</key>
    <string></string>
    <key>PayloadDisplayName</key>
    <string>Kerberos SSO Extension for macOS for Microsoft Entra ID Cloud Kerberos</string>
    <key>PayloadEnabled</key>
    <true/>
    <key>PayloadIdentifier</key>
    <string>11bb11bb-cc22-dd33-ee44-55ff55ff55ff</string>
    <key>PayloadOrganization</key>
    <string>Contoso</string>
    <key>PayloadRemovalDisallowed</key>
    <true/>
    <key>PayloadScope</key>
    <string>System</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>11bb11bb-cc22-dd33-ee44-55ff55ff55ff</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
</dict>
</plist>
```

Save the configuration using a text editor with the *mobileconfig* file extension (for example, the file could be named *cloud-kerberos.mobileconfig*) after updating the configuration with the proper values for your environment.

> [!NOTE]
> Make sure you pay attention to the usePlatformSSOTGT and performKerberosOnly keys.
> If usePlatformSSOTGT is set to true, the Kerberos Extension uses the TGT from Platform SSO with the same realm. The default is false.
> If performKerberosOnly is set to true, the Kerberos extension doesn't perform password expiration checks, external password change checks, or retrieve the user’s home directory. The default is false.
> This is applicable to both the on-premises and cloud configurations, these keys should be configured in both profiles.

## Intune configuration steps

If you use Intune as your MDM, you can perform the following steps to deploy the profile. Make sure you follow the [previous instructions](#Kerberos SSO MDM profile configuration for on-premises Active Directory) about replacing **contoso.com** values with the proper values for your organization.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Devices** > **Configuration** > **Create** > **New policy**.
3. Enter the following properties:
    - **Platform**: Select **macOS**.
    - **Profile type**: Select **Templates**.
4. Choose the **Custom** template and select **Create**.
5. In **Basics**, enter the following properties:
    - **Name**: Enter a descriptive name for the policy. Name your policies so you can easily identify them later. For example, name the policy **macOS - Platform SSO Kerberos**.
    - **Description**: Enter a description for the policy. This setting is optional, but recommended.
6. Select **Next**.
7. Enter a name in the **Custom configuration profile name** box.
8. Choose a **Deployment channel**. Device channel is recommended.
9. Click the folder icon to upload your **Configuration profile file**. Choose the *kerberos.mobileconfig* file you [saved previously](#Kerberos SSO MDM profile configuration for on-premises Active Directory) after customizing the template.
10. Select **Next**.
11. In **Scope tags** (optional), assign a tag to filter the profile to specific IT groups, such as `US-NC IT Team` or `JohnGlenn_ITDepartment`. Select **Next**.
    - For more information about scope tags, see [Use RBAC roles and scope tags for distributed IT](/mem/intune/fundamentals/scope-tags).
12. In **Assignments**, select the users or user groups that will receive your profile. Platform SSO policies are user-based policies. Don't assign the platform SSO policy to devices.
    - For more information on assigning profiles, see [Assign user and device profiles](/mem/intune/configuration/device-profile-assign).
13. Select **Next**.
14. In **Review + create**, review your settings. When you select **Create**, your changes are saved, and the profile is assigned. The policy is also shown in the profiles list.
15. Repeat this process if you need to deploy both profiles because you will use both on-premises Kerberos SSO and Microsoft Entra ID Cloud Kerberos.

The next time the device checks for configuration updates, the settings you configured are applied.

## Testing Kerberos SSO

Once the user has completed Platform SSO registration, you can check that the device has Kerberos tickets by running the `app-sso platform -s` command in the Terminal app:

```console
app-sso platform -s
```

You should have two Kerberos tickets, one for your on-premises AD with the ticketKeyPath value of **tgt_ad** and one for your Microsoft Entra ID tenant with the ticketKeyPath value of **tgt_cloud**. The output should resemble the following:

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/platform-sso-kerberos-terminal-output.png" alt-text="Screenshot of the output of app-sso platform -s in the macOS Terminal app.":::

Validate your configuration is working by testing with appropriate Kerberos-capable resources:

- Test on-premises Active Directory functionality by accessing an on-premises AD-integrated file server using Finder or a web application using Safari. The user should be able to access the file share without being challenged for interactive credentials.
- Test Microsoft Entra ID Kerberos functionality by accessing an Azure Files share enabled for Microsoft Entra ID cloud kerberos. The user should be able to access the file share without being challenged for interactive credentials.

> [!NOTE]
> Note that Microsoft's Platform SSO implementation is responsible for issuing the Kerberos TGTs and delivering them to macOS so that macOS can import them. If you see TGTs when running `app-sso platform -s`, then the TGTs have been successfully imported. If you experience any ongoing Kerberos issues, such as issues accessing on-premises resources via Kerberos, then it's recommended to reach out to Apple for support with further configuration of your Kerberos MDM profiles. The Kerberos implementation in macOS uses native Apple-provided Kerberos capabilities.

## Use Cloud Kerberos TGT to access Azure File Storage

Cloud TGT issued through Platform SSO enable seamless access to Azure file shares without prompting users for interactive credentials. Please note that access to Azure file shares using the PSSO Kerberos TGT feature is currently in limited preview. If you're interested in trying it out, reach out to azurefiles@microsoft.com for onboarding support.
If you need guidance on configuring a cloud file share in Azure Files, please refer to [this guide](/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable).

> [!NOTE]
> When mounting the file share via SMB, ensure that the manifest file associated with the app registration for Azure File Share includes the `cifs` mapping in **lowercase**. If this value is set to uppercase `CIFS`, it may lead to issues during the mounting process.


## Known Issues

### Kerberos SSO extension menu extra

When deploying support for Kerberos SSO with Platform SSO, the standard Kerberos SSO extension capabilities of macOS are still used. Like with a deployment of the native [Kerberos SSO extension](https://support.apple.com/guide/deployment/kerberos-sso-extension-depe6a1cda64/web) without Platform SSO, the Kerberos SSO extension menu extra will appear in the macOS menu bar:

:::image type="content" source="media/device-registration-macos-platform-single-sign-on/platform-sso-kerberos-menu-bar-applet.png" alt-text="Screenshot of the macOS Kerberos SSO extension menu extra.":::

When deploying Kerberos support with Platform SSO, users don't need to interact with the Kerberos SSO extension menu extra to have Kerberos functionality work. Kerberos SSO functionality will still operate if the user doesn't sign into the menu bar extra and the menu bar extra reports "Not signed in". You may instruct users to ignore the menu bar extra when deploying with Platform SSO, per this article. Instead, make sure that you validate that kerberos functionality works as expected without interaction with the menu bar extra, as outlined in the [Testing Kerberos SSO](#testing-kerberos-sso) section of this article.

### Browser Support for Kerberos SSO

Some browsers require additional configuration to enable Kerberos SSO support, including if you are using Platform SSO to enable Kerberos on your macOS devices. When deploying Kerberos support on macOS, deploy the appropriate settings for each of the browsers you utilize to ensure they can interact with the macOS Kerberos SSO features:

- Safari: supports Kerberos SSO by default
- Microsoft Edge:
    - Configure the **AuthNegotiateDelegateAllowlist** setting to include your on-premises Active Directory forest information: [AuthNegotiateDelegateAllowlist](/DeployEdge/microsoft-edge-policies#authnegotiatedelegateallowlist)
    - Configure the **AuthServerAllowlist** setting to include your on-premises Active Directory forest information: [AuthServerAllowlist](/DeployEdge/microsoft-edge-policies#authserverallowlist)
- Google Chrome
    - Configure the **AuthNegotiateDelegateAllowlist** setting to include your on-premises Active Directory forest information: [AuthNegotiateDelegateAllowlist](https://chromeenterprise.google/policies/#AuthNegotiateDelegateAllowlist)
    - Configure the **AuthServerAllowlist** setting to include your on-premises Active Directory forest information: [AuthServerAllowlist](https://chromeenterprise.google/policies/#AuthServerAllowlist)
- Mozilla Firefox
    - Configure the Mozilla Firefox **network.negotiate-auth.trusted-uris** and **network.automatic-ntlm-auth.trusted-uris** settings to enable Kerberos SSO support

## See also

- [Join a Mac device with Microsoft Entra ID using Company Portal](./device-join-microsoft-entra-company-portal.md)
- [Passwordless authentication options for Microsoft Entra ID](../authentication/concept-authentication-passwordless.md)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](../authentication/howto-authentication-passwordless-deployment.md)
- [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md)
