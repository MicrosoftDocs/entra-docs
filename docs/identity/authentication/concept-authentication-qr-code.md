---
title: QR code authentication method in Microsoft Entra ID (preview)
description: Learn about using QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/15/2024

ms.author: justinha
author: aanjusingh
ms.reviewer: anjusingh
manager: amycolannino

# Customer intent: As an identity administrator, I want to understand how to use QR code authentication in Microsoft Entra ID to improve and secure user sign-in events for frontline workers
---

# Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)

The QR code authentication method (QR code and PIN) is a cost-effective, simple, and fast authentication solution for Microsoft Entra ID. 
You can print a QR code and distribute it to users, who can attach it to a badge or any other wearable. 

A QR code has an embedded user principal name (UPN), tenant ID, and private key. 
Frontline workers don't need to type their UPN on a keypad. They only need to scan the QR code and enter a PIN to sign in. 

The PIN can be from 8 to 20 digits in length. 
It's bound only to the QR code and can’t be used with any other user identifiers, such as UPN or phone number.

It's easy to remember and type when compared to complex alphanumeric passwords, which makes sign-in faster. 
A combination of QR code and PIN as way to sign-in into applications provides a simple and fast authentication solution to frontline workers. 
They can increase their productivity with a seamless authentication experience. 

:::image type="content" source="media/concept-authentication-qr-code/qr-code-plus-pin.png" alt-text="Image of a QR code plus PIN.":::


## Benefits of QR code authentication method

Benefit | Description
--------|------------
Easier and faster sign-in | Frontline workers might be less tech-savvy, work with difficult devices, or have accessibility requirements. They can sign in with a QR code and PIN quicker than a username and password, which increases their productivity. They also don't have to remember their username to sign in, which reduces support costs. 
Inexpensive | Printing a QR code costs less than a hardware keys, which can be cost probitive for organizations with temporary frontline workers.

## QR code Authentication method policy requirements 

Authentication Policy Administrators can enable QR code in Authentication methods in the Microsoft Entra admin center. QR code authnetication is disabled by default.

In the Authentication method policy for QR code, you can configure:

- PIN length: min. default is 8 digits as per NIST standard; Range: 8-20 digits. PIN length is minimum PIN length allowed based on admin configuration settings.
- Lifetime of standard QR code: default is 365 days; Range: 1-395 days. This property is customizable at user level while adding the standard QR code. For example, if admin set the expiration in Auth method Policies | configuration to be ‘30-days’. For every user in that tenant, the default expiration of standard QR Code will be 30 days. However, admin can change the expiry time of standard QR code for a specific user’s QR code auth method if they want.

In this screenshot, the PIN length is set to the default of 8 digits, and the lifetime for the standard QR code is reduced to 200 days.

:::image type="content" source="media/concept-authentication-qr-code/qr-code-settings.png" alt-text="Screenshot that shows QR code settings.":::

3.3	QR code Auth Method Details and Properties

1	Only one QR code auth method can be active at a time for a user.
2	When QR code auth method is deleted for the user, they will not be able to sign-in with existing QR code and PIN. Deleting the QR code removes the data from storage.
3	When a QR code auth method is created only Standard QR code and PIN will be added.
4	Temporary QR code can be added only on ‘Edit’ page of QR code auth method.
5	States of Standard QR code, Temporary QR code, and PIN on QR code auth method are not related to each other. For instance, an active QR code auth method can have deleted or expired Standard QR code and active temporary QR code. 
6	At any given point of time, there can be only a single active standard QR code and a single active temporary QR code.
7	User PIN will work with both Standard and Temporary QR codes because PIN is per QR code auth method.
8	Admin will be able to provide custom PIN during QR code auth method creation. Auto-generate PIN capability will exist for both reset and QR code auth method creation.
9	Admins will be able to see only temporary PIN during creation. PIN will be shown in masked format after it is added to the QR code auth method to protect the exposure of user chosen PIN.
10	Combinations examples of valid states of Standard QR code, Temporary QR code, and PIN on QR code auth method. An active QR code and active PIN are required for successful authentication. When QR code is deleted or expired, the user will not be able to perform authentication.
a.	Standard QR code is active, Temporary QR code doesn’t exist, and PIN is Temporary, or user updated.
b.	Standard QR code is active, Temporary QR code is active, and PIN is Temporary, or user updated.
c.	Standard QR code is deleted, Temporary QR code doesn’t exist, and PIN is Temporary, or user updated.
d.	Standard QR code is expired, Temporary QR code is active, and PIN is Temporary, or user updated.
e.	Standard QR code is expired, Temporary QR code is expired, and PIN is Temporary, or user updated.




### PIN properties

3.3.2	PIN Properties 
The following policies will be applied for PIN generation and reset. 

1.	Character Allowed: Numbers (0-9)
2.	Characters not Allowed: characters (A-Z; a-z), Symbols (- @ # $ % ^ & * - _ ! + = [ ] { } | \ : ' , . ? / ` ~ " ( ) ; < >), Unicode characters, and blank space
3.	Pin length: min. 8 digits default (max. length 20 digits). It can be configured at QR code auth method level in Auth Method policy. Pin length setting is to configure minimum PIN length for all the users.
4.	Pin complexity: PIN complexity should be enforced to avoid repetition and sequencing such as Common sequences from a keyboard row: 12345678, 1111111, 12121212, 123123123, etc. Currently, password checks weak and bad passwords. We can use existing digit pattern checks for PIN. (server will validate the pin complexity and auth method policy configurations on pin length; UX will validate min length and all digits). Based on existing rules, following pattern will be checked:
•	Do not contain 0123456789 or 9876543210
•	Do not repeat a 2–3-digit sequence across the pin like 121212, or 123123 or 342342

If PIN is all digits but not correct/ PIN length doesn’t meet auth method policy configuration (less than min. PIN length), ‘Invalid PIN’ error is shown.

5.	Pin not recently used: Don’t repeat last 3 PINs for both admin reset, and user forced reset flows. Self-service PIN reset is out of scope in V1.


3.4	QR code auth management at user level: User | Authentication methods | QR code

## Known issues and mitigation for QR code authentication method 

Admins should replace a QR code thet gets lost or stolen. 
A QR code can't be used alone without a PIN. 

The PIN can’t be used with any other identifier, such as a UPN, or email account. 
A QR code also has a secret that is replay resistant to online threats for a primary credential.

Admins can also take following precautions to mitigate the risk of a lost or stolen QR code:

- Don't use QR code authentication for resources that require MFA.
- Configure a PIN lockout experience, similar to passwords.
- Replace QR codes that get lost or stolen.
- Create Conditional Access policies to restrict the authentication method to specified apps, store devices, and secure networks.


## Related content

[How to enable the QR code authentication method in Microsoft Entra ID (Preview)](how-to-authentication-qr-code.md)
