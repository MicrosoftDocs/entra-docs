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

QR code authentication method enables frontline workers to sign in efficiently in apps on shared devices. Users will be able to use unique QR code provided to them and enter their PIN to sign in, eliminating the need to enter intricate usernames and passwords.

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

## Add or delete a QR code authentication method

When an Authentication Policy Administrator creates a QR code authentication method, they can add only a standard QR code and PIN.
To create a temporary QR code, they need to edit a QR code authentication method. Only one QR code authentication method can be active at a time for a user.

When a QR code authentication method is deleted for the user, they can't sign-in with their existing QR code and PIN.

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

### PIN properties

The following policies are applied when an Authentication Policy Administrator creates or resets a PIN. 

Policy | Values 
-------|--------
Allowed characters | Numbers (0-9) 
Unallowed characters | - Characters (A-Z, a-z)<br>- Symbols (- @ # $ % ^ & * - _ ! + = [ ] { } \| \ : ' , . ? / ` ~ " ( ) ; < >)<br>- Unicode characters<br>- Blank space 
Minimum PIN length |  8-20 digits 
PIN complexity     | Should be enforced to avoid repetition and common sequences. The following patterns are checked:<br>- Don't contain 0123456789 or 9876543210.<br>- Don't repeat a sequence of 2-3 digits in the PIN, like 121212, or 123123 or 342342.<br>An **Invalid PIN** error appears if the PIN has unallowed characters or is less than the minimum PIN length. 

## QR code authentication management for users

Administrators can manage QR codes in the Authentication methods for each user.

:::image type="content" source="media/how-to-authentication-qr-code/add-qr-code.png" alt-text="Screenshot that shows how add a QR code for a user.":::

## Security guidelines for QR code authentication 

We recommend the following security measures when you enable QR code authentication method as it is a single factor authentication (something you know).  

- QR code authentication is primarily for frontline workers and not for IW workers. We recommend MFA or Phishing resistant methods for IW workers.
- Combine QR code authentication with Conditional Access policies to add another security layer. Recommended policies are compliant devices, access within network, allow for certain applications, and shared device mode. 
- Enforce phishing-resistant or MFA authentication when users access resources from outside of the store or workplace network. 

## Add QR code sign-in to apps

You can use the Microsoft Authentication Library (MSAL) to add an QR code sign-in option on your apps login page for optimized sign-in expereince.
This option helps users sign in with fewer clicks. 
For example, the following screenshot shows Teams login page (image 1.) with QR code sign instead of clicking 'Sign in options'- 'Sign in to an organization'- 'Sign in with a QR code' (image 2.)

:::image type="content" source="media/how-to-authentication-qr-code/sign-in.png" alt-text="Screenshot that shows how to scan a QR code to sign in to Teams.":::

![image](https://github.com/user-attachments/assets/1263aff6-eb9d-40e9-8ea1-e8eb5b9df4a9)


## Known issues and mitigation for QR code authentication method 

- Self-service PIN reset is not available
- Bulk provisioning is not supported but you can leverage MSGraph API to program bulk printing
- Barcode scanners are not supported
- Desktop apps and browsers are not supported 
- Don't use QR code authentication for resources that require MFA.
- Replace QR codes that get lost or stolen.
- Create Conditional Access policies to restrict the authentication method to specified apps, store devices, and secure networks.


## Related content

[How to enable the QR code authentication method in Microsoft Entra ID (Preview)](how-to-authentication-qr-code.md)
