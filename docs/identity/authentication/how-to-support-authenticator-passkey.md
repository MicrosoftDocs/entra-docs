---
title: Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant
description: Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 08/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator 

---
# Support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant

This topic covers some support issues that administrators might see after they enable users to sign in with passkeys in Aithenticator.

## Authentication strength policy

If you configure an authentication strength Conditional Access policy with the following conditions, users can get caught in a loop when they try to sign in: 

- Condition: **All devices (Windows, Linux, MacOS, Windows, Android)** 
- Targeted resource: **All cloud apps** 
- Grant control: **Authentication strength – Require passkey in Authenticator** 

The policy creates a loop for the user because the authentication strength requires Authenticator, and the targeted resource is **All cloud apps**, which includes Authenticator. As a result, when a user tries to add a passkey in Authenticator, they are directed to [Security info](https://mysignins.microsoft.com/security-info) for passkey registration. But they only can add **Passkey in Microsoft Authenticator** as a registration option because of the authentication strength requirement. 

There are a couple workarounds:

- You can [filter for applications](~/identity/conditional-access/concept-filter-for-applications.md) and transition the policy target from **All cloud apps** to specific applications. Start with a review of applications that are used in their tenant and use filters to tag Microsoft Authenticator and other applications.

- To further reduce support costs, you can run an internal campaign to help users adopt passkeys. When you're ready to enforce passkey usage, create two Conditional Access policies: one for mobile operating system (OS) versions, and another for desktop OS versions. Make each policy require a different authentication strength. This workaround requires the tenant to allow use of a Temporary Access Pass (TAP) or other authentication methods. 

  |                   | Desktop OS     | Mobile OS     |
  |-------------------|----------------|---------------|
  | Policy            | Require a passkey in Authenticator to access a desktop operating system | Require a TAP, a passkey in Microsoft Authenticator, or another specified authentication method to access a mobile operating system |
  | Condition         | Specific devices (desktop operating systems) | Specific devices (mobile operating systems) |
  | Devices           | N/A                                          | Android, iOS            | 
  | Exclude devices   | Android, iOS                                 | N/A                     |
  | Targeted resource | All cloud apps                               | All cloud apps          |
  | Grant control     | Authentication strength                      | Authentication strength<sup>1</sup> |
  | Methods           | Passkey in Microsoft Authenticator |TAP, passkey in Microsoft Authenticator, or other methods allowed for MFA |
  | Policy result     | Users who can’t satisfy the requirement to sign-in with a passkey in Authenticator are directed to My Sign-ins wizard mode, and then asked to sign in to Authenticator on their mobile device.</br>You'll need to provision a TAP as part of this process. Optionally, you can enable and ensure the user has other MFA methods available to use, but TAP is recommended for secure onboarding. | when the user signs in to Authenticator with a TAP or another allowed method, direct registration occurs in Authenticator. No loop occurs because the user meets the authentication requirements. |

  <sup>1</sup>Make sure your grant control for the mobile policy matches your Conditional Access policy to register [Security info](https://mysignins.microsoft.com/security-info) so users can register new sign-in methods. 

>[!NOTE]
>With either workaround, users must also satisfy any Conditional Access policy that targets **Register security info**, or they can't sign in.  

## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](https://review.learn.microsoft.com/en-us/windows/security/identity-protection/passkeys/?branch=pr-en-us-10051&tabs=windows#passkeys-in-bluetooth-restricted-environments).

## Next steps 

For more information about passkeys in Authenticator, see [Microsoft Authenticator authentication method](concept-authentication-authenticator-app.md).
To enable passkeys in Authenticator as a way for users to sign in, see []