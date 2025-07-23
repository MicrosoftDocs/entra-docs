---
title: macOS Platform Single Sign-on (PSSO) overview
description: Overview of macOS Platform Single Sign On (PSSO) for Microsoft Entra ID registered devices.
ms.service: entra-id
ms.subservice: devices
ms.topic: overview
ms.date: 06/12/2025
ms.author: godonnell
author: garrodonnell
manager: dougeby

#Customer intent: As a customer, I want to understand how to configure macOS Platform Single Sign-on (PSSO) for Microsoft Entra ID registered devices.
---

# macOS Platform Single Sign-on overview 

macOS Platform Single Sign-on (PSSO) is a new feature powered by Microsoft’s Enterprise SSO plug-in, Platform Credentials for macOS that enables users to sign in to Mac devices using their Microsoft Entra ID credentials. This feature provides benefits for admins by simplifying the sign-in process for users and reducing the number of passwords they need to remember. It also allows users to authenticate with Microsoft Entra ID with a smart card or hardware-bound key. This feature improves the end-user experience by not having to remember two separate passwords and diminishes the need for admins to manage the local account password. 

There are three different authentication methods that determine the end-user experience;

* **Platform Credential for macOS**: Provisions a secure enclave backed hardware-bound cryptographic key that is used for SSO across apps that use Microsoft Entra ID for authentication. The user’s local account password isn't affected and is required to sign in to the Mac.
* **Smart card**: The user signs in to the machine using an external smart card, or smart card-compatible hard token (for example, Yubikey). Once the device is unlocked, the smart card is used with Microsoft Entra ID to grant SSO across apps that use Microsoft Entra ID for authentication.
* **Password as authentication method**: Syncs the user’s Microsoft Entra ID password with the local account and enables SSO across apps that use Microsoft Entra ID for authentication.

Powered by the [Microsoft Enterprise SSO plug in Apple devices](../../identity-platform/apple-sso-plugin.md), PSSO;

* Allows users to go passwordless by using Touch ID.
* Uses phish resistant credentials, based on Windows Hello for Business technology.
* Saves customer organizations money by removing the need for security keys.
* Advances Zero Trust objectives using integration with the Secure Enclave.

To enable it, an administrator needs to configure PSSO through Microsoft Intune or other supported MDM. Depending on how the device is configured, the end-user can set up their device with PSSO via secure enclave, smart card, or password based authentication method.

## Requirements

To deploy Platform SSO for macOS, you need the meet following minimum requirements.

* A recommended minimum version of macOS 14 Sonoma. While macOS 13 Ventura is supported, we strongly recommend using macOS 14 Sonoma for the best experience.
* [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc)
* Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2404.0 or later installed. This version is required before users are targeted for PSSO.
* Users must have sufficient permissions to [register and join devices to Microsoft Entra ID](./troubleshoot-macos-platform-single-sign-on-extension.md?tabs=macOS14#insufficient-permissions).

## Configuration

You can find more information and instructions on how to configure in these articles:

- [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos)

> [!NOTE]
> If you are configuring Platform SSO for macOS devices using a 3rd party MDM, refer to the documentation provided by your MDM vendor for specific instructions on how to configure Platform SSO.
>
> If you are a developer of a 3rd party MDM solution, refer to the [Integrate macOS Platform Single Sign On (PSSO) into your MDM solution](./macos-psso-integration-guide.md) guide for more information on how to integrate PSSO into your MDM solution.

## Deployment

You can find more information and instructions on how to deploy Platform SSO for macOS in these articles.

* [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
* [Join a Mac device with Microsoft Entra ID using Company Portal](./device-join-microsoft-entra-company-portal.md)

## Passwordless authentication

Passwords are a primary attack vector for bad actors. They use social engineering, phishing, and spray attacks to compromise passwords. A passwordless authentication strategy mitigates the risk of these attacks.

Learn how you can use Platform SSO for macOS to enable passwordless authentication for your organization.

* [Passwordless authentication options for Microsoft Entra ID](../../identity/authentication/concept-authentication-passwordless.md)
* [Plan a passwordless authentication deployment in Microsoft Entra ID](../../identity/authentication/howto-authentication-passwordless-deployment.md)

Platform Credential for macOS can also be used as a phishing resistant credential for use in WebAuthn challenges (including browser re-authentication scenarios). Admins need to enable the FIDO2 security key authentication method for this capability. If you use key restrictions in your FIDO policy then you'll need to add the AAGUID for the macOS Platform Credential to your list of allowed AAGUIDs: `7FD635B3-2EF9-4542-8D9D-164F2C771EFC`

### Microsoft Platform SSO: UserSecureEnclaveKeyBiometricPolicy

Microsoft Platform SSO supports the [UserSecureEnclaveKeyBiometricPolicy](https://developer.apple.com/documentation/authenticationservices/asauthorizationproviderextensionloginconfiguration/usersecureenclavekeybiometricpolicy) option when using Platform SSO with the UserSecureEnclaveKey authentication method. This policy enhances security by requiring users to authenticate with Touch ID whenever the User Secure Enclave Key needs to be accessed.

- When this policy is enabled, users are prompted for Touch ID authentication whenever the User Secure Enclave Key is accessed. Prompting will occur during PSSO registration, browser re-authentication scenarios using the user key as a passkey, and authentication during sign in to obtain the PSSO token.
- Enabling this policy requires that the device supports Touch ID biometric authentication. Users need to configure Touch ID to proceed with PSSO registration. Administrators should ensure that users have a biometric-supported device or an external keyboard supporting Touch ID before enabling this policy.

> [!NOTE]
> There is no option for password fallback while authenticating with User Secure Enclave Key when UserSecureEnclaveKeyBiometricPolicy is enabled. Therefore, users won't be able to authenticate to Microsoft Entra ID if they don't have Touch ID biometrics available.

#### Requirements for UserSecureEnclaveKeyBiometricPolicy

- Operating system: macOS 14.6 and later
- Company Portal version: 2504 and later

   > [!IMPORTANT]
   > If this feature is enabled after PSSO registration is completed, all users will need to undergo a full PSSO re-registration process for the policy to take effect. This re-registration process must be admin-driven, as users won't see a re-registration prompt. Administrators should carefully consider whether to enable this policy and plan the deployment of PSSO accordingly. 

#### How to Enable UserSecureEnclaveKeyBiometricPolicy

High-security customers can opt in to enable this feature by setting a flag in the SSO extension's data dictionary.

- Key Name: enable_se_key_biometric_policy
- Value: true

:::image type="content" source="media/macos-psso/enable-secure-enclave-key-biometric-policy.png" alt-text="Screenshot of the UserSecureEnclaveKeyBiometricPolicy configuration in Microsoft Intune.":::

#### Benefits of UserSecureEnclaveKeyBiometricPolicy

- Enhanced Security: The User Secure Enclave Key access is hardware-protected and can only be accessed after successful Touch ID authentication, providing an extra layer of security.

#### Drawbacks of UserSecureEnclaveKeyBiometricPolicy

- More Prompts: Users will encounter extra prompts during PSSO registration as the key is accessed multiple times during the process.
- Biometric-Only Access: The PSSO passkey can only be accessed with biometric authentication. There's no password fallback. If the device is unlocked with a password, users will still be prompted for biometric authentication to obtain the PSSO token.

## Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources
macOS allows users to configure Platform SSO to support Kerberos-based SSO to on-premises and cloud resources, in addition to SSO to Microsoft Entra ID. Kerberos SSO is an optional capability within Platform SSO, but it's recommended if users still need to access on-premises Active Directory resources that use Kerberos for authentication.

To learn more, see [Kerberos SSO to on-premises Active Directory and Microsoft Entra ID Kerberos resources](./device-join-macos-platform-single-sign-on-kerberos-configuration.md).

## Graph API support
You can use the Microsoft Graph API to manage the PlatformCredential authentication method.

The following APIs are available:

* [platformCredentialAuthenticationMethod resource type](/graph/api/resources/platformcredentialauthenticationmethod?preserveview=graph-rest-1.0).
* [List platformCredentialAuthenticationMethods](/graph/api/platformcredentialauthenticationmethod-list?preserveview=graph-rest-1.0).
* [Delete platformCredentialAuthenticationMethod](/graph/api/platformcredentialauthenticationmethod-delete?preserveview=graph-rest-1.0).
   
## National Institute of Standards and Technology (NIST)

The National Institute of Standards and Technology (NIST) is a non-regulatory federal agency within the U.S. Department of Commerce. NIST develops and issues standards, guidelines, and other publications to assist federal agencies in managing cost-effective programs to protect their information and information systems.

You can learn more about using macOS Platform SSO to meet NIST requirements in these articles.

* [Configure Microsoft Entra ID to meet NIST authenticator assurance levels](../../standards/nist-overview.md)
* [NIST authenticator types and aligned Microsoft Entra methods](../../standards/nist-authenticator-types.md).
* [NIST authenticator assurance level 3 by using Microsoft Entra ID](../../standards/nist-authenticator-assurance-level-3.md)

## Troubleshooting 

If you experience issues when implementing macOS Platform SSO, refer to our documentation on [macOS Platform single sign-on known issues and troubleshooting](troubleshoot-macos-platform-single-sign-on-extension.md)

