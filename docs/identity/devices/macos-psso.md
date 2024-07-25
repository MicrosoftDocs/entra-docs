---
title: macOS Platform Single Sign-on (PSSO) overview (preview)
description: Overview of macOS Platform Single Sign On (PSSO) for Microsoft Entra ID registered devices.
ms.service: entra-id
ms.subservice: devices
ms.topic: overview
ms.date: 12/08/2023
ms.author: godonnell
ms.reviewer: brianmel
author: garrodonnell
manager: celested

#Customer intent: As a customer, I want to understand how to configure macOS Platform Single Sign-on (PSSO) for Microsoft Entra ID registered devices.
---

# macOS Platform Single Sign-on overview (preview)

macOS Platform Single Sign-on (PSSO) is a new feature powered by Microsoft’s Enterprise SSO plug-in, Platform Credentials for macOS that enables users to sign in to Mac devices using their Microsoft Entra ID credentials. This feature provides benefits for admins by simplifying the sign-in process for users and reducing the number of passwords they need to remember. It also allows users to authenticate with Microsoft Entra ID with a smart card or hardware-bound key. This feature improves the end-user experience by not having to remember two separate passwords and diminishes the need for admins to manage the local account password. 

There are three different authentication methods that determine the end-user experience;

* **Platform Credential for macOS**: Provisions a secure enclave backed hardware-bound cryptographic key that is used for SSO across apps that use Microsoft Entra ID for authentication. The user’s local account password is not affected and is required to log on to the Mac.
* **Smart card**: The user signs in to the machine using an external smart card, or smart card-compatible hard token (for example, Yubikey). Once the device is unlocked, the smart card is used with Microsoft Entra ID to grant SSO across apps that use Microsoft Entra ID for authentication.
* **Password as authentication method**: Syncs the user’s Microsoft Entra ID password with the local account and enables SSO across apps that use Microsoft Entra ID for authentication.

Powered by the [Microsoft Enterprise SSO plug in Apple devices](../../identity-platform/apple-sso-plugin.md), PSSO;

* Allows users to go passwordless by using Touch ID.
* Uses phish resistant credentials, based on Windows Hello for Business technology.
* Saves customer organizations money by removing the need for security keys.
* Advances Zero Trust objectives using integration with the Secure Enclave.

To enable it, an administrator needs to configure PSSO through Microsoft Intune or other supported MDM. Depending on the how the device is configured, the end-user can set up their device with PSSO via secure enclave, smart card or password based authentication method.

## Requirements

To deploy Platform SSO for macOS, you need the meet following minimum requirements.

* A recommended minimum version of macOS 14 Sonoma. While macOS 13 Ventura is supported, we strongly recommend using macOS 14 Sonoma for the best experience.
* [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc)
* Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2404.0 or later installed. This version is required before users are targeted for PSSO.

## Deployment

You can find more information and instructions on how to deploy Platform SSO for macOS in these articles.

* [Join a Mac device with Microsoft Entra ID during the out of box experience](./device-join-macos-platform-single-sign-on.md)
* [Join a Mac device with Microsoft Entra ID using Company Portal](./device-join-microsoft-entra-company-portal.md)

## Passwordless authentication

Passwords are a primary attack vector for bad actors. They use social engineering, phishing, and spray attacks to compromise passwords. A passwordless authentication strategy mitigates the risk of these attacks.

Learn how you can use Platform SSO for macOS to enable passwordless authentication for your organization.

* [Passwordless authentication options for Microsoft Entra ID](../../identity/authentication/concept-authentication-passwordless.md)
* [Plan a passwordless authentication deployment in Microsoft Entra ID](../../identity/authentication/howto-authentication-passwordless-deployment.md)

Platform Credential for macOS can also be used as a phishing resistant credential for use in WebAuthn challenges (including browser re-auth scenarios). Admins will need to enable the FIDO2 security key authentication method for this capability. If you leverage Key Restriction Policies in your FIDO policy then you will need to add the AAGUID for the macOS Platform Credential to your list of allowed AAGUIDs: `7FD635B3-2EF9-4542-8D9D-164F2C771EFC`

## National Institute of Standards and Technology (NIST)

The National Institute of Standards and Technology (NIST) is a non-regulatory federal agency within the U.S. Department of Commerce. NIST develops and issues standards, guidelines, and other publications to assist federal agencies in managing cost-effective programs to protect their information and information systems.

You can learn more about using macOS Platform SSO to meet NIST requirements in these articles.

* [Configure Microsoft Entra ID to meet NIST authenticator assurance levels](../../standards/nist-overview.md)
* [NIST authenticator types and aligned Microsoft Entra methods](../../standards/nist-authenticator-types.md).
* [NIST authenticator assurance level 3 by using Microsoft Entra ID](../../standards/nist-authenticator-assurance-level-3.md)

## Troubleshooting 

If you experience issues when implementing macOS Platform SSO, refer to our documentation on [macOS Platform single sign-on known issues and troubleshooting](troubleshoot-macos-platform-single-sign-on-extension.md)

