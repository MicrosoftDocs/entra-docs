---
title: FIDO2 security key sign-in to Windows
description: Learn how to enable passwordless security key sign-in to Windows with Microsoft Entra ID using FIDO2 security keys. 

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/06/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: librown, aakapo
---
# Enable FIDO2 security key sign-in to Windows 10 and 11 devices with Microsoft Entra ID 

This document focuses on enabling FIDO2 security key based passwordless authentication with Windows 10 and 11 devices. After completing the steps in this article, you're able to sign in to both your Microsoft Entra ID and Microsoft Entra hybrid joined Windows devices with your Microsoft Entra account using a FIDO2 security key.

## Requirements

| Device Type | Microsoft Entra joined | Microsoft Entra hybrid joined |
| --- | --- | --- |
| [Microsoft Entra multifactor authentication](howto-mfa-getstarted.md) | X | X |
| [Combined security information registration](concept-registration-mfa-sspr-combined.md) | X | X |
| Compatible [FIDO2 security keys](concept-authentication-passwordless.md) | X | X |
| WebAuthN requires Windows 10 version 1903 or higher | X | X |
| [Microsoft Entra joined devices](~/identity/devices/concept-directory-join.md) require Windows 10 version 1909 or higher | X |   |
| [Microsoft Entra hybrid joined devices](~/identity/devices/concept-hybrid-join.md) require Windows 10 version 2004 or higher |   | X |
| Fully patched Windows Server 2016/2019 Domain Controllers. |   | X |
| [Microsoft Entra Hybrid Authentication Management module](https://www.powershellgallery.com/packages/AzureADHybridAuthenticationManagement/2.1.1.0) |   | X |
| [Microsoft Intune](/mem/intune/fundamentals/what-is-intune) (Optional) | X | X |
| Provisioning package (Optional) | X | X |
| Group Policy (Optional) |   | X |

### Unsupported scenarios

The following scenarios aren't supported:

- Signing in or unlocking a Windows device with a passkey in Microsoft Authenticator.
- Windows Server Active Directory Domain Services (AD DS) domain-joined (on-premises only devices) deployment.
- Scenarios, such as RDP, VDI, and Citrix, that use a security key other than [webauthn redirection](/azure/virtual-desktop/authentication).
- S/MIME using a security key.
- *Run as* using a security key.
- Signing in to a server using a security key.
- If you're not using a security key to sign in to your device while online, you can't use it to sign in or unlock offline.
- Signing in or unlocking a Windows device with a security key containing multiple Microsoft Entra accounts. This scenario utilizes the last account added to the security key. WebAuthN allows users to choose the account they wish to use.
- Unlocking a device running Windows 10 version 1809. For the best experience, use Windows 10 version 1903 or higher.

## Prepare devices

Microsoft Entra joined devices must run Windows 10 version 1909 or higher.

Microsoft Entra hybrid joined devices must run Windows 10 version 2004 or newer.

## Enable security keys for Windows sign-in

Organizations can choose to use one or more of the following methods to enable the use of security keys for Windows sign-in based on their organization's requirements:

- [Enable with Microsoft Intune](#enable-with-microsoft-intune)
- [Targeted Microsoft Intune deployment](#targeted-intune-deployment)
- [Enable with a provisioning package](#enable-with-a-provisioning-package)
- [Enable with Group Policy (Microsoft Entra hybrid joined devices only)](#enable-with-group-policy)

> [!IMPORTANT]
> Organizations with **Microsoft Entra hybrid joined devices** must **also** complete the steps in the article, [Enable FIDO2 authentication to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md) before Windows 10 FIDO2 security key authentication works.
>
> Organizations with **Microsoft Entra joined devices** must do this before their devices can authenticate to on-premises resources with FIDO2 security keys.

### Enable with Microsoft Intune

To enable the use of security keys using Intune, complete the following steps:

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/).
1. Browse to **Devices** > **Enroll Devices** > **Windows enrollment** > **Windows Hello for Business**.
1. Set **Use security keys for sign-in** to **Enabled**.

Configuration of security keys for sign-in isn't dependent on configuring Windows Hello for Business.

> [!NOTE]
> This will not enable security keys on already provisioned devices. In that case use the next method (Targeted Intune deployment)

### Targeted Intune deployment

To target specific device groups to enable the credential provider, use the following custom settings via Intune:

1. Sign in to the [Microsoft Intune admin center](https://intune.microsoft.com/).
1. Browse to **Devices** > **Windows** > **Configuration profiles** > **Create profile**.
1. Configure the new profile with the following settings:
   - Platform: Windows 10 and later
   - Profile type: Templates > Custom
   - Name: Security Keys for Windows Sign-In
   - Description: Enables FIDO Security Keys to be used during Windows Sign In
1. Select **Next** > **Add** and in **Add Row**, add the following Custom OMA-URI settings:
      - Name: Turn on FIDO Security Keys for Windows Sign-In
      - Description: (Optional)
      - OMA-URI: ./Device/Vendor/MSFT/PassportForWork/SecurityKey/UseSecurityKeyForSignin
      - Data Type: Integer
      - Value: 1
1. Assign the remainder of the policy settings, including specific users, devices, or groups. For more information, see [Assign user and device profiles in Microsoft Intune](/mem/intune/configuration/device-profile-assign).

### Enable with a provisioning package

For devices not managed by Microsoft Intune, a provisioning package can be installed to enable the functionality. The Windows Configuration Designer app can be installed from the [Microsoft Store](https://www.microsoft.com/p/windows-configuration-designer/9nblggh4tx22). Complete the following steps to create a provisioning package:

1. Launch the Windows Configuration Designer.
1. Select **File** > **New project**.
1. Give your project a name and take note of the path where your project is created, then select **Next**.
1. Leave *Provisioning package* selected as the **Selected project workflow** and select **Next**.
1. Select *All Windows desktop editions* under **Choose which settings to view and configure**, then select **Next**.
1. Select **Finish**.
1. In your newly created project, browse to **Runtime settings** > **WindowsHelloForBusiness** > **SecurityKeys** > **UseSecurityKeyForSignIn**.
1. Set **UseSecurityKeyForSignIn** to *Enabled*.
1. Select **Export** > **Provisioning package**
1. Leave the defaults in the **Build** window under **Describe the provisioning package**, then select **Next**.
1. Leave the defaults in the **Build** window under **Select security details for the provisioning package** and select **Next**.
1. Take note of or change the path in the **Build** windows under **Select where to save the provisioning package** and select **Next**.
1. Select **Build** on the **Build the provisioning package** page.
1. Save the two files created (*ppkg* and *cat*) to a location where you can apply them to machines later.
1. To apply the provisioning package you created, see [Apply a provisioning package](/windows/configuration/provisioning-packages/provisioning-apply-package).

> [!NOTE]
> Devices running Windows 10 Version 1903 must also enable shared PC mode (*EnableSharedPCMode*). For more information about enabling this functionality, see [Set up a shared or guest PC with Windows 10](/windows/configuration/set-up-shared-or-guest-pc).

### Enable with Group Policy

For **Microsoft Entra hybrid joined devices**, organizations can configure the following Group Policy setting to enable FIDO security key sign-in. The setting can be found under **Computer Configuration** > **Administrative Templates** > **System** > **Logon** > **Turn on security key sign-in**:

- Setting this policy to **Enabled** allows users to sign in with security keys.
- Setting this policy to **Disabled** or **Not Configured** stops users from signing in with security keys.

This Group Policy setting requires an updated version of the `CredentialProviders.admx` Group Policy template. This new template is available with the next version of Windows Server and with Windows 10 20H1. This setting can be managed with a device running one of these newer versions of Windows or centrally by following the guidance here: [How to create and manage the Central Store for Group Policy Administrative Templates in Windows](https://support.microsoft.com/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administra).

## Sign in with FIDO2 security key

In this example, a user named Bala Sandhu already provisioned their FIDO2 security key using the steps in the previous article, [Enable passwordless security key sign in](howto-authentication-passwordless-security-key.md#user-registration-and-management-of-fido2-security-keys). For Microsoft Entra hybrid joined devices, make sure you also [enabled passwordless security key sign-in to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md). Bala can choose the security key credential provider from the Windows 10 lock screen and insert the security key to sign into Windows.

![Security key sign-in at the Windows 10 lock screen](./media/howto-authentication-passwordless-security-key/fido2-windows-10-1903-sign-in-lock-screen.png)

### Manage security key biometric, PIN, or reset security key

* Windows 10 version 1903 or higher
   * On a device, users can go to **Windows Settings** > **Accounts** > **Sign-in options** > **Security Key**, and then select the **Manage** button.
   * Users can change their PIN, update biometrics, or reset their security key

## Troubleshooting and feedback

If you'd like to share feedback or encounter issues about this feature, share via the Windows Feedback Hub app using the following steps:

1. Launch **Feedback Hub** and make sure you're signed in.
1. Submit feedback under the following categorization:
   - Category: Security and Privacy
   - Subcategory: FIDO
1. To capture logs, use the option to **Recreate my Problem**.

## Next steps

[Enable access to on-premises resources for Microsoft Entra ID and Microsoft Entra hybrid joined devices](howto-authentication-passwordless-security-key-on-premises.md)

[Learn more about device registration](~/identity/devices/overview.md)

[Learn more about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
