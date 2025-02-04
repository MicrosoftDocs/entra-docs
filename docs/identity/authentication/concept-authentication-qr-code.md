---
title: QR code authentication method in Microsoft Entra ID (preview)
description: Learn about using QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/03/2025

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
It's bound only to the QR code and can't be used with any other user identifiers, such as UPN or phone number.

It's easy to remember and type when compared to complex alphanumeric passwords, which makes sign-in faster. 
A combination of QR code and PIN as way to sign-in into applications provides a simple and fast authentication solution to frontline workers. 
They can increase their productivity with a seamless authentication experience. 

:::image type="content" source="media/concept-authentication-qr-code/qr-code-plus-pin.png" alt-text="Image that shows a QR code plus PIN.":::

## Benefits of QR code authentication method

Benefit | Description
--------|------------
Easier and faster sign-in | Frontline workers might be less tech-savvy, work with difficult devices, or have accessibility requirements. Their productivity improves because they can sign in with a QR code and PIN quicker than a username and password. They also don't have to remember their username to sign in, which reduces support costs. 
Inexpensive | Printing a QR code costs less than a hardware key, which can be cost prohibitive for organizations with temporary frontline workers.

## QR code requirements for the Authentication method policy

Authentication Policy Administrators can enable QR code in Authentication methods in the Microsoft Entra admin center. QR code authnetication is disabled by default.

In the Authentication method policy for QR code, you can configure:

- PIN length: 8-20 digits.
- Lifetime of standard QR code: 1-395 days. Default is 365 days. An Authentication Policy Administrator can change the default value when they add a standard QR code for a user. 

  For example, an admin can set the value to 30 days in the Authentication method policy. 
  For every user in that tenant, the default expiration of a standard QR code is 30 days. 
  An admin can change the default lifetime of the standard QR code for a specific user.

In this screenshot, the PIN length is set to the default of 8 digits. The lifetime for the standard QR code is reduced to 200 days.

:::image type="content" source="media/concept-authentication-qr-code/qr-code-settings.png" alt-text="Screenshot that shows QR code settings.":::

## Add or delete a QR code authentication method

When an Authentication Policy Administrator creates a QR code authentication method, they can add only a standard QR code and PIN.
To create a temporary QR code, they need to edit a QR code authentication method. 

Only one QR code authentication method can be active at a time for a user.
When a QR code authentication method is deleted for the user, they can't sign-in with their existing QR code and PIN. The QR code data is removed from storage.

A PIN works with both standard and temporary QR codes because PIN is valid for the QR code authentication method.
An Authentication Policy Administrator can provide a custom PIN when they create a QR code authentication method. 
They can automatically generate a custom PIN when they reset or create a new QR code authentication method.

Admins can only see a temporary PIN when they create a QR code authentication method. 
The PIN is masked after it's added to the QR code authentication method to prevent exposure.

The states for a standard QR code, a temporary QR code, and the PIN for a QR code authentication method aren't related to each other. 
For example, an active QR code authentication method can have a deleted or expired standard QR code, and an active temporary QR code. 
At any given point of time, there can be only a single active standard QR code and a single active temporary QR code.

The following table lists examples for combinations for the states for a standard QR code, a temporary QR code, and PIN. 
An active QR code and active PIN are required for successful authentication. 

Standard QR code | Temporary QR code | PIN for QR code authentication method
:---------------:|:-----------------:|:------------------------------------:
Active           | Doesn't exist     | Temporary, or user updated
Active           | Active            | Temporary, or user updated
Deleted          | Doesn't exist     | Temporary, or user updated
Expired          | Active            | Temporary, or user updated
Expired          | Expired           | Temporary, or user updated

For more information about how to manage QR codes, see [How to enable the QR code authentication method in Microsoft Entra ID (Preview)](how-to-authentication-qr-code.md).

### PIN properties

The following policies are applied when an Authentication Policy Administrator creates or resets a PIN. 

Policy | Values 
-------|--------
Allowed characters | Numbers (0-9) 
Unallowed characters | - Characters (A-Z,a-z)<br>- Symbols (- @ # $ % ^ & * - _ ! + = [ ] { } \| \ : ' , . ? / ` ~ " ( ) ; < >)<br>- Unicode characters<br>- Blank space 
Minimum PIN length |  8-20 digits 
PIN complexity     | Should be enforced to avoid repetition and common sequences. The following patterns are checked:<br>- Don't contain 0123456789 or 9876543210.<br>- Don't repeat a sequence of 2-3 digits in the PIN, like 121212, or 123123 or 342342.<br>An **Invalid PIN** error appears if the PIN has unallowed characters or is less than the minimum PIN length. 
PIN not recently used | Don't repeat the last 3 PINs during admin reset, or user reset. 

## QR code authentication management for users


## Accelerating 

You can also create an accelerated QR code endpoint for your apps by using the Microsoft Authentication Library (MSAL). 
An accelerated QR code endpoint helps users sign in with fewer clicks. 
For example, following screenshot shows how the Teams app has a way to scan a QR code to sign in rather than enter a username and password.

:::image type="content" source="media/how-to-authentication-qr-code/sign-in.png" alt-text="Screenshot that shows how to scan a QR code to sign in to Teams.":::



## Known issues and mitigation for QR code authentication method 

Admins should replace a QR code thet gets lost or stolen. 
A QR code can't be used alone without a PIN. 

The PIN can't be used with any other identifier, such as a UPN, or email account. 
A QR code also has a secret that is replay resistant to online threats for a primary credential.

Admins can also take following precautions to mitigate the risk of a lost or stolen QR code:

- Don't use QR code authentication for resources that require MFA.
- Configure a PIN lockout experience, similar to passwords.
- Replace QR codes that get lost or stolen.
- Create Conditional Access policies to restrict the authentication method to specified apps, store devices, and secure networks.


## Related content

[How to enable the QR code authentication method in Microsoft Entra ID (Preview)](how-to-authentication-qr-code.md)
