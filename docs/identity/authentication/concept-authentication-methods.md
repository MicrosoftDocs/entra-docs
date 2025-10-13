---
title: Authentication methods and features
description: Learn about the different authentication methods and features available in Microsoft Entra ID that help improve and secure sign-in events
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand what authentication options are available in Microsoft Entra ID and how or why I can use them to improve and secure user sign-in events.
---
# What authentication and verification methods are available in Microsoft Entra ID?

Microsoft recommends passwordless authentication methods such as Windows Hello, Passkeys (FIDO2), and the Microsoft Authenticator app because they provide the most secure sign-in experience. Although a user can sign-in using other common methods such as a username and password, passwords should be replaced with more secure authentication methods.

:::image type="content" border="true" source="media/concept-authentication-methods/authentication-methods.png" alt-text="Illustration of the strengths and preferred authentication methods in Microsoft Entra ID." :::

Microsoft Entra multifactor authentication adds another layer of security over only using a password when a user signs in. The user can be prompted for other forms of authentication, such as to respond to a push notification, enter a code from a software or hardware token, or respond to a text message or phone call.

To simplify the user on-boarding experience and register for both MFA and self-service password reset (SSPR), we recommend you [enable combined security information registration](howto-registration-mfa-sspr-combined.md). For resiliency, we recommend that you require users to register multiple authentication methods. When one method isn't available for a user during sign-in or SSPR, they can choose to authenticate with another method. For more information, see [Create a resilient access control management strategy in Microsoft Entra ID](concept-resilient-controls.md).

## How each authentication method works

Some authentication methods can be used as the primary factor when you sign in to an application or device, such as using a FIDO2 security key or a password. Other authentication methods are only available as a secondary factor when you use Microsoft Entra multifactor authentication or SSPR.

The following table outlines when an authentication method can be used during a sign-in event:

| Method                         | Primary authentication | Secondary authentication  |
|--------------------------------|:----------------------:|:-------------------------:|
| Windows Hello for Business     | Yes                    | MFA<sup>1</sup>           |
| Microsoft Authenticator push   | No                     | MFA and SSPR              |
| Microsoft Authenticator passwordless | Yes              | No<sup>2</sup>            |
| Microsoft Authenticator passkey| Yes                    | MFA                       |
| Authenticator Lite             | No                     | MFA                       |
| Passkey (FIDO2)                | Yes                    | MFA                       |
| Certificate-based authentication (CBA) | Yes            | MFA                       |
| Hardware OATH tokens (preview) | No                     | MFA and SSPR              |
| Software OATH tokens           | No                     | MFA and SSPR              |
| External authentication methods (preview)| No           | MFA                       |
| Temporary Access Pass (TAP)    | Yes                    | MFA                       |
| Text                           | Yes                    | MFA and SSPR              |
| Voice call                     | No                     | MFA and SSPR              |
| QR code                        | Yes                    | No                        |
| Password                       | Yes                    | No                        |

<sup>1</sup>Windows Hello for Business can serve as a step-up MFA credential if it's used in FIDO2 authentication. Users need to be registered for passkey (FIDO2).

<sup>2</sup>Passwordless sign-in can be used for secondary authentication only if [CBA is used for primary authentication](~/identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#mfa-with-single-factor-cba).

<sup>3</sup>Alternate phone methods can only be used for MFA.

All of these authentication methods can be configured in the Microsoft Entra admin center, and increasingly using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).

To learn more about how each authentication method works, see the following separate conceptual articles:

* [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview)
* [Microsoft Authenticator app](concept-authentication-authenticator-app.md)
* [Authenticator Lite](/entra/identity/authentication/how-to-mfa-authenticator-lite)
* [Passkey (FIDO2)](concept-authentication-passwordless.md)
* [Certificate-based authentication](concept-certificate-based-authentication.md)
* [Hardware OATH tokens (preview)](concept-authentication-oath-tokens.md#hardware-oath-tokens-preview)
* [Software OATH tokens](concept-authentication-oath-tokens.md#software-oath-tokens)
* [External authentication methods (preview)](/entra/identity/authentication/how-to-authentication-external-method-manage)
* [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md)
* [Short Message Service (SMS) sign-in](howto-authentication-sms-signin.md) and [verification](concept-authentication-phone-options.md#mobile-phone-verification)
* [Voice call verification](concept-authentication-phone-options.md)
* [QR code (preview)](concept-authentication-qr-code.md)

* Password

> [!NOTE]
> In Microsoft Entra ID, a password is often one of the primary authentication methods. You can't disable the password authentication method. If you use a password as the primary authentication factor, increase the security of sign-in events using Microsoft Entra multifactor authentication.

These other verification methods can be used in certain scenarios:

* [App passwords](howto-mfa-app-passwords.md) - used for old applications that don't support modern authentication and can be configured for per-user Microsoft Entra multifactor authentication.
* [Security questions](concept-authentication-security-questions.md) - only used for SSPR
* [Email address](concept-sspr-howitworks.md#authentication-methods) - only used for SSPR


## Usable and nonusable methods

Administrators can view user authentication methods in the Microsoft Entra admin center. Usable methods are listed first, followed by nonusable methods. 

Each authentication method can become nonusable for different reasons. For example, a Temporary Access Pass may expire, or FIDO2 security key may fail attestation. The portal gets updated to provide the reason for why the method isn't usable. 

Authentication methods that are no longer available due to **Require re-register multifactor authentication** also appear here.

:::image type="content" border="true" source="media/concept-authentication-methods/non-usable.png" alt-text="Screenshot of nonusable authentication methods." :::


## Related content

To get started, see the [tutorial for self-service password reset (SSPR)][tutorial-sspr] and [Microsoft Entra multifactor authentication][tutorial-azure-mfa].

To learn more about SSPR concepts, see [How Microsoft Entra self-service password reset works][concept-sspr].

To learn more about MFA concepts, see [How Microsoft Entra multifactor authentication works][concept-mfa].

Learn more about configuring authentication methods using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).

To review what authentication methods are in use, see [Microsoft Entra multifactor authentication authentication method analysis with PowerShell](https://github.com/Azure-Samples/azure-mfa-authentication-method-analysis).

<!-- INTERNAL LINKS -->
[tutorial-sspr]: tutorial-enable-sspr.md
[tutorial-azure-mfa]: tutorial-enable-azure-mfa.md
[tutorial-tap]: howto-authentication-temporary-access-pass.md
[concept-sspr]: concept-sspr-howitworks.md
[concept-mfa]: concept-mfa-howitworks.md
