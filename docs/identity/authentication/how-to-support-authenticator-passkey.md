---
title: Support passkeys in Authenticator in your Microsoft Entra ID tenant
description: Learn how to support passkeys in Microsoft Authenticator in your Microsoft Entra ID tenant.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: calui, tilarso

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users can register a passkey in Microsoft Authenticator.

---
# Support passkeys in Authenticator in your Microsoft Entra ID tenant

This article covers issues that users might see when they use passkeys in Authenticator and possible ways for administrators to resolve them.

## Store passkeys in Android profiles

Passkeys on Android are used only from the profile where they're stored. If a passkey is stored in an Android Work profile, it's used from that profile. If a passkey is stored in an Android Personal profile, it's used from that profile. To make sure that users can access and use the passkey they need, users with both an Android Personal profile and an Android Work profile should create their passkeys in Authenticator for each profile.

## Workarounds

Use the following workarounds for Authenticator passkey issues.

### Workarounds for an authentication strength Conditional Access policy loop

Users can get in a loop when they try to add a passkey in Authenticator if a Conditional Access policy requires phishing-resistant authentication to access **All resources (formerly 'All cloud apps')**. For example:

- Condition: **All devices (Windows, Linux, macOS, Windows, Android)**
- Targeted resource: **All resources (formerly 'All cloud apps')**
- Grant control: **Authentication strength – Require passkey in Authenticator**

The policy forces targeted users to use a passkey to sign in to all cloud applications, which includes the Authenticator app. It requires users to use a passkey when they try to add a passkey in Authenticator on either Android or iOS.

Here are some workarounds:

- You can [filter for applications](~/identity/conditional-access/concept-filter-for-applications.md) and transition the policy target from **All resources (formerly 'All cloud apps')** to specific applications. Start with a review of applications that are used in your tenant. Use filters to tag Authenticator and other applications.
- To further reduce support costs, you can run an internal campaign to help users adopt passkeys before you enforce them. When you're ready to enforce passkey usage, create two Conditional Access policies:

  - A policy for mobile operating system (OS) versions
  - A policy for desktop OS versions

  Require a different authentication strength for each policy, and configure other policy settings listed in the following table. You can enable a [Temporary Access Pass (TAP)](howto-authentication-temporary-access-pass.md) for users or enable other authentication methods to help users register the passkey.
  
  A TAP limits the time when users can register a passkey. You can accept it only on mobile platforms where you allow passkey registration.

  | Conditional Access policy | Desktop OS     | Mobile OS     |
  |---------------------------|----------------|---------------|
  | Name              | Require a passkey in Authenticator to access a desktop OS. | Require a TAP, a phishing-resistant credential, or any other specified authentication method to access a mobile OS. |
  | Condition         | Specific devices (desktop operating systems). | Specific devices (mobile operating systems). |
  | Devices           | N/A.                                          | Android, iOS.            | 
  | Exclude devices   | Android, iOS.                                 | N/A.                     |
  | Targeted resource | All resources.                               | All resources.          |
  | Grant control     | Authentication strength.                      | Authentication strength.<sup>1</sup> |
  | Methods           | Passkey in Authenticator. |TAP, passkey in Authenticator. |
  | Policy result     | Users who can't sign in with a passkey in Authenticator are directed to the **My Sign-ins** wizard mode. After registration, they're asked to sign in to Authenticator on their mobile device. | Users who sign in to Authenticator with a TAP or another allowed method can register a passkey directly in Authenticator. No loop occurs because the user meets the authentication requirements. |

  <sup>1</sup>For users to register new sign-in methods, your grant control for the mobile policy needs to match your Conditional Access policy to register [Security info](https://mysignins.microsoft.com/security-info).

> [!NOTE]
> With either workaround, users must also satisfy any Conditional Access policy that targets **Register security info** or they can't register the passkey. If you have other conditions set up with the **All resources** policies, those conditions must be met when the passkey is registered.

### Users who can't register passkeys because of Require approved client app or Require app protection policy Conditional Access grant controls

Users can't register passkeys in Authenticator if they're included in the following Conditional Access policy:

- Condition: **All devices (Windows, Linux, macOS, Windows, Android)**
- Targeted resource: **All resources (formerly 'All cloud apps')**
- Grant control: **Require approved client app** or **Require app protection policy**

The policy forces users to sign in to all cloud applications by using an app that supports [Microsoft Intune app protection policies](/mem/intune/apps/app-protection-policy). Authenticator doesn't support this policy on either Android or iOS.

Here are some workarounds:

- You can [filter for applications](~/identity/conditional-access/concept-filter-for-applications.md) and transition the policy target from **All resources (formerly 'All cloud apps')** to specific applications. Start with a review of applications that are used in your tenant. Use filters to tag appropriate applications.
- You can use mobile device management (MDM) and the **Require device to be marked as compliant** control. Authenticator can satisfy this grant control if MDM fully manages the device and it's compliant. For example:

  - Condition: **All devices (Windows, Linux, macOS, Windows, Android)**
  - Targeted resource: **All resources (formerly 'All cloud apps')**
  - Grant control: **Require approved client app**, or **Require app protection policy**, or **Require device to be marked as compliant**

- You can grant users a temporary exemption from the Conditional Access policy. We recommend that you use one or more compensating controls:
  - Allow the exemption for only a limited period of time. Communicate to the user when they're allowed to register a passkey. Remove the exemption after the time period. Then direct users to call the help desk if they missed their time.
  - Use another Conditional Access policy to require that users register only from a specific network location or a compliant device.

> [!NOTE]
> With any proposed workaround, users must also satisfy any Conditional Access policy that targets **Register security info** or they can't register the passkey. If you have other conditions set up with the **All resources** policies, they also must be met before users can register a passkey.

## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

## Related content

- For more information about passkeys in Authenticator, see [Microsoft Authenticator authentication method](concept-authentication-authenticator-app.md).
- To enable passkeys in Authenticator as a way for users to sign in, see [Enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md).
