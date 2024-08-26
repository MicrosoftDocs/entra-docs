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


## Authentication strength policy

If you configure an authentication strength Conditional Access policy with the following conditions, users can get caught in a loop when they try to sign in: 

- Condition: All devices (Windows, Linux, MacOS, Windows, Android) 
- Targeted resource: All cloud applications 
- Grant control: Authentication strength – require passkey in Authenticator 

The policy requires targeted users to sign in with a passkey to access all cloud applications, which includes Microsoft Authenticator. As a result, when a user tries to add a passkey in Authenticator, they are redirected to [Security info](https://mysignins.microsoft.com/security-info). But [Security info](https://mysignins.microsoft.com/security-info) provides only **Passkey in Microsoft Authenticator** as a registration option because of the authentication strength requirement. 

## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).