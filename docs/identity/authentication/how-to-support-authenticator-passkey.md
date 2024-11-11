---
title: Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant
description: Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/09/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant

This topic covers issues that users might see when they use passkeys in Microsoft Authenticator, and possible ways for administrators to resolve them.

## Workarounds for an authentication strength Conditional Access policy loop

Organizations that are deploying passkeys and have Conditional Access policies that require phishing-resistant authentication when accessing **All resources (formerly 'All cloud apps')** can run into a looping issue when users attempt to add a passkey to Microsoft Authenticator. An example of such a policy configuration:

- Condition: **All devices (Windows, Linux, MacOS, Windows, Android)** 
- Targeted resource: **All resources (formerly 'All cloud apps')** 
- Grant control: **Authentication strength – Require passkey in Authenticator** 

The policy effectively enforces that the targeted users must use a passkey to authenticate to all cloud applications, which includes the Microsoft Authenticator app. This means users need to use a passkey to provision a passkey when they go through the in-app registration flow within the Authenticator app. This affects both Android and iOS.

There are a couple workarounds:

- You can [filter for applications](~/identity/conditional-access/concept-filter-for-applications.md) and transition the policy target from **All resources (formerly 'All cloud apps')** to specific applications. Start with a review of applications that are used in your tenant and use filters to tag Microsoft Authenticator and other applications.

- To further reduce support costs, you can run an internal campaign to help users adopt passkeys before enforcing the use of passkeys. When you're ready to enforce passkey usage, create two Conditional Access policies: 

  - A policy for mobile operating system (OS) versions
  - A policy for desktop OS versions 

  Require a different authentication strength for each policy, and configure other policy settings listed in the following table. You'll likely want to [enable the use of a Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md), or enable other authentication methods that users can use to register the passkey. By issuing a TAP to a user only when they are registering a credential, and accepting it only on mobile platforms where passkey registration can occur, you can ensure that users are using permitted authentication methods for all flows and using TAP only for a limited amount of time during registration. 

  | Conditional Access policy | Desktop OS     | Mobile OS     |
  |---------------------------|----------------|---------------|
  | Name              | Require a passkey in Authenticator to access a desktop OS | Require a TAP, a phishing-resistant credential, or any other specified authentication method to access a mobile OS |
  | Condition         | Specific devices (desktop operating systems) | Specific devices (mobile operating systems) |
  | Devices           | N/A                                          | Android, iOS            | 
  | Exclude devices   | Android, iOS                                 | N/A                     |
  | Targeted resource | All resources                               | All resources          |
  | Grant control     | Authentication strength                      | Authentication strength<sup>1</sup> |
  | Methods           | Passkey in Microsoft Authenticator |TAP, passkey in Microsoft Authenticator. |
  | Policy result     | Users who can’t sign-in with a passkey in Authenticator are directed to My Sign-ins wizard mode. After registration, they're asked to sign in to Authenticator on their mobile device. | Users who sign in to Authenticator with a TAP or another allowed method can register a passkey directly in Authenticator. No loop occurs because the user meets the authentication requirements. |

  <sup>1</sup>For users to register new sign-in methods, your grant control for the mobile policy needs to match your Conditional Access policy to register [Security info](https://mysignins.microsoft.com/security-info). 

>[!NOTE]
>With either workaround, users must also satisfy any Conditional Access policy that targets **Register security info**, or they can't register the passkey. Additionally, if you have other conditions set up with the **All resources** policies, those will have to be met when registering the passkey.  

## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

## Next steps 

For more information about passkeys in Authenticator, see [Microsoft Authenticator authentication method](concept-authentication-authenticator-app.md).
To enable passkeys in Authenticator as a way for users to sign in, see [Enable passkeys in Microsoft Authenticator ](how-to-enable-authenticator-passkey.md).