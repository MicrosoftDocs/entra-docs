---
title: Platform Credential for macOS authentication method in Microsoft Entra ID
description: Learn about using Platform Credential for macOS authentication in Microsoft Entra ID to help improve and secure sign-in events
ms.topic: concept-article
ms.date: 10/25/2025
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how to use Platform Credential for macOS authentication in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - Platform Credential for macOS

Platform Credential for macOS is a new capability on macOS that is enabled using the Microsoft Enterprise single sign-on Extension (SSOe). It provisions a secure enclave backed hardware-bound cryptographic key that is used for SSO across apps that use Microsoft Entra ID for authentication. The user’s local account password is not affected and is required to log on to the Mac.

![Screenshot showing an example of a pop up window prompting user to register their macOS account with their identity provider using Platform single sign-on.](./media/concept-authentication-passwordless/macos-platform-sso.png)

Platform Credential for macOS allows users to go passwordless by configuring Touch ID to unlock the device, and uses phish-resistant credentials, based on Windows Hello for Business technology. This saves customer organizations money by removing the need for security keys and advances Zero Trust objectives using integration with the Secure Enclave.

Platform Credential for macOS can also be used as a phishing-resistant credential for use in WebAuthn challenges, including browser re-authentication scenarios. If you use Key Restriction Policies in your FIDO policy, you need to add the AAGUID for the macOS Platform Credential to your list of allowed AAGUIDs: `7FD635B3-2EF9-4542-8D9D-164F2C771EFC`.

![Diagram that outlines the steps involved for user sign-in with macOS Platform SSO.](./media/concept-authentication-passwordless/macos-platform-single-sign-on-flow.png)

1. A user unlocks macOS using fingerprint or password gesture, which unlocks the key bag to provide access to UserSecureEnclaveKey.
1. The macOS requests a nonce (a random arbitrary number that can be used just once) from Microsoft Entra ID.
1. Microsoft Entra ID returns a nonce that's valid for 5 minutes.
1. The operating system (OS) sends a login request to Microsoft Entra ID with an embedded assertion signed with the UserSecureEnclaveKey that resides in the Secure Enclave.
1. Microsoft Entra ID validates the signed assertion using the user's securely registered public key of UserSecureEnclave key. Microsoft Entra ID validates the signature and nonce. Once the assertion is validated, Microsoft Entra ID creates a [primary refresh token (PRT)](../devices/concept-primary-refresh-token.md) encrypted with the public key of the UserDeviceEncryptionKey that is exchanged during registration and sends the response back to the OS.
1. The OS decrypts and validates the response, retrieves the SSO tokens, stores and shares it with the SSO extension for providing SSO. The user is able to access macOS, cloud and on-premises applications by using SSO.

Refer to [macOS Platform SSO](../devices/macos-psso.md) for more information on how to configure and deploy Platform Credential for macOS.

## Platform single sign-on for macOS with SmartCard

Platform single sign-on (PSSO) for macOS allows users to go passwordless using the SmartCard authentication method. The user signs in to the device by using an external smart card, or smart card-compatible hardware-based token (such as Yubikey). Once the device is unlocked, the smart card is used with Microsoft Entra ID to grant SSO across apps that use Microsoft Entra ID for authentication by using [certificate-based authentication (CBA)](concept-certificate-based-authentication.md). CBA needs to be configured and enabled for users for this feature to work. For more information about how to configure CBA, see [How to configure Microsoft Entra certificate-based authentication](how-to-certificate-based-authentication.md).

To enable it, an administrator needs to configure PSSO by using Microsoft Intune or another supported Mobile Device Management (MDM) solution. 

![Diagram that outlines the steps involved for user sign-in with macOS Platform SSO.](./media/concept-authentication-passwordless/macos-platform-single-sign-on-flow.png)

1. A user unlocks macOS using smart card pin, which unlocks the smart card and the key bag to provide access to device registration keys present in Secure Enclave.
1. The macOS requests a nonce (a random arbitrary number that can be used only once) from Microsoft Entra ID.
1. Microsoft Entra ID returns a nonce that's valid for 5 minutes.
1. The operating system (OS) sends a login request to Microsoft Entra ID with an embedded assertion signed with the user's Microsoft Entra certificate from the smart card.
1. Microsoft Entra ID validates the signed assertion, signature and nonce. Once the assertion is validated, Microsoft Entra ID creates a [primary refresh token (PRT)](../devices/concept-primary-refresh-token.md) encrypted with the public key of the UserDeviceEncryptionKey that is exchanged during registration and sends the response back to the OS.
1. The OS decrypts and validates the response, retrieves the SSO tokens, stores and shares it with the SSO extension for providing SSO. The user is able to access macOS, cloud and on-premises applications by using SSO.

## Related content

[What authentication and verification methods are available in Microsoft Entra ID?](concept-authentication-methods.md)