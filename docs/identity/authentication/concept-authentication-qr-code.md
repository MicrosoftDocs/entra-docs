---
title: QR code authentication method in Microsoft Entra ID (preview)
description: Learn about using QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/06/2025

ms.author: justinha
author: aanjusingh
ms.reviewer: anjusingh
manager: amycolannino

# Customer intent: As an identity administrator, I want to understand how to use QR code authentication in Microsoft Entra ID to improve and secure user sign-in events for frontline workers
---

# Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)

QR code authentication method enables frontline workers to sign in efficiently in apps on shared devices. Users will be able to use unique QR code provided to them and enter their PIN to sign in, eliminating the need to enter intricate usernames and passwords. QR code authentication is supported on mobilde device (iOS, Android, and iPad).

## What is QR code authentication?

QR code authentication is a simple authentication method primarly designed for frontline workers. 
It consists of a unique QR code and numeric PIN. 
The QR code serves as an identifier and is unique to the user. 
It can be downloaded and printed from the Microsoft Entra admin center, MyStaff, or MSGraph API. 
For convenience, the QR code can be attached to a badge or any other wearable item. 

Authentication Administrators provide a temporary PIN to users, who then change it during sign-in. Only user will know the PIN.
It's exclusively bound to the QR code only. 
It can't be used with other user identifiers, such as username or phone number.
QR code authentication is a single-factor method in which PIN (something you know) is a credential.

## Benefits of QR code authentication
Benefit | Description
--------|------------
Easier and faster sign-in | Frontline workers don't have to enter complex usernames and complex passwords to sign in multiple times into shared devices through their shift
Inexpensive | Printing a QR code costs less than a hardware key, which can be cost prohibitive for organizations with temporary frontline workers.

### PIN properties

The following policies are applied when an Authentication Policy Administrator creates or resets a PIN. 

Policy | Values 
-------|--------
Allowed characters | Numbers (0-9) 
Unallowed characters | - Characters (A-Z, a-z)<br>- Symbols (- @ # $ % ^ & * - _ ! + = [ ] { } \| \ : ' , . ? / ` ~ " ( ) ; < >)<br>- Unicode characters<br>- Blank space 
Minimum PIN length |  8-20 digits 
PIN complexity     | Should be enforced to avoid repetition and common sequences. The following patterns are checked:<br>- Don't contain 0123456789 or 9876543210.<br>- Don't repeat a sequence of 2-3 digits in the PIN, like 121212, or 123123 or 342342.<br>An **Invalid PIN** error appears if the PIN has unallowed characters or is less than the minimum PIN length. 

## Best security practices to apply with QR code authentication 

We recommend the following measures when you enable QR code authentication method as it is a single factor authentication (something you know).  

- QR code authentication is primarily for frontline workers and not for IW workers. We recommend MFA or Phishing resistant auth methods for IW workers.
- Combine QR code authentication with Conditional Access policies to add another security layer. Recommended policies are compliant devices, access within network, allow for certain applications, and shared device mode. 
- Enforce phishing-resistant or multifactor authentication when users access resources from outside of the store or workplace network.
- Replace QR codes that are lost or stolen.

## QR code configurations in the Authentication method policy

Authentication Policy Administrators can enable QR code in Authentication methods in the Microsoft Entra admin center. QR code authentication is disabled by default.

In the Authentication method policy for QR code, you can configure:

- PIN length: 8-20 digits.
- Lifetime of standard QR code: 1-395 days. Default is 365 days. An Authentication Policy Administrator can change the default value when they add a standard QR code for a user. 

  For example, an admin can set the value to 30 days in the Authentication method policy. 
  For every user in that tenant, the default expiration of a standard QR code is 30 days. 
  An admin can change the default lifetime of the standard QR code for a specific user.

In this screenshot, the PIN length is set to the default of 8 digits. The lifetime for the standard QR code is reduced to 200 days.

:::image type="content" source="media/concept-authentication-qr-code/qr-code-settings.png" alt-text="Screenshot that shows QR code settings.":::

## Functional details of QR code authentication method

When an Authentication Policy Administrator adds a QR code authentication method for a user, they can add only a standard QR code and PIN.
To create a temporary QR code, they need to edit a QR code authentication method. Only one QR code authentication method can be active at a time for a user. When a QR code authentication method is deleted for the user, they can't sign-in with their existing QR code and PIN.

A PIN works with both standard and temporary QR codes because PIN is valid for the QR code authentication method.
An Authentication Policy Administrator can provide a custom PIN or generate a PIN when they create a QR code authentication method. Admins can copy a temporary PIN only when generated. The PIN is masked after it's added to prevent exposure.

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


## User sign-in experience with QR code authentication

### Mobile web expereince
You can use Microsoft's web browser login experience (login.microsoft.com) to sign in users. User need to click 'Sign in options'- 'Sign in to an organization'- 'Sign in with a QR code'

![image](https://github.com/user-attachments/assets/aebf52f5-1a25-4fb3-863f-cca86c66c70c)

### Mobile native app expereince 
The above login expereince can be optimized for your apps by using Microsoft Authentication Library (MSAL) to add an QR code sign-in option on your apps login page. This option eliminates two clicks to scan the QR code. For example, see Teams login page with QR code sign-in entry point.
![image](https://github.com/user-attachments/assets/13bf065e-f73c-43ea-b410-9f92bf58fc49)

## Unsupported user scenarios in current release

- Self-service PIN reset for users
- Bulk provisioning of QR code and PIN
- QR code scan via Barcode scanners
- QR code auth is unviable on Desktop apps or browsers
- Tenanted endpoint for login


## Related content

[How to enable the QR code authentication method in Microsoft Entra ID (Preview)](how-to-authentication-qr-code.md)
