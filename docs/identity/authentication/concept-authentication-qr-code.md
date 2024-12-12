---
title: QR code authentication in Microsoft Entra ID (preview)
description: Learn about using QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/11/2024

ms.author: justinha
author: justinha
ms.reviewer: anjusingh
manager: amycolannino

# Customer intent: As an identity administrator, I want to understand how to use QR code authentication in Microsoft Entra ID to improve and secure user sign-in events for frontline workers
---

# Authentication methods in Microsoft Entra ID - QR code (Preview)

Frontline Worker (FLW) 	Frontline workers are in every industry, such as Retail, Manufacturing, and healthcare. Generally, they are temporary workers, have multiple jobs, and are less tech savvy. For example, retail/grocery store workers, students doing multiple job at stores during summer, etc.
Frontline Managers (FLM) 	Frontline managers are store managers and can act as delegated auth admins 
QR code 	QR code has user UPN, tenant ID, and private key. A specific QR code can be generated only once since the private key is unique. Entra ID will not persist QR code image. QR code needs to be distributed to frontline worker (FLW) in printed form. 
Standard QR code 	QR code assigned at the time of onboarding the user first time. It has default expiry is 365 days 
Temporary QR code 	QR code assigned only when FLW forgot the standard QR code to bring at work. It has a lifetime of 12 hours. 
PIN	PIN is an 8-digit memorized secret. This PIN can be used with only QR code.
QR code auth v1 (MVP	In the document, v1 is referred to 1st   GA release of QR code Auth Method. 
QR code auth method	QR code auth method term is used for the authentication method which consists of both QR code identifier and PIN credential. Active QR code auth method is required for successful sign-in.
QR code	 QR code term is used for the identifier equivalent not for the auth method.


The QR code authentication method consists of both a QR code identifier and a PIN. QR code and PIN is a cost-effective, simple, and fast Microsoft Entra ID authentication solution.


Admins can print QR codes and attach them to badges or other wearables to distribute them to frontline workers. QR code consists of a user principal name (UPN), tenant id, and a secret key.


A PIN is an 8-digit secret chosen by the user upon change of default temporary PIN that was assigned by the admin. PIN is bound only to QR code and can’t be used with any other user identifiers such as UPN, phone number etc. PIN is easy to use on FLW devices and easy to remember as well. 

A combination of QR code and PIN as way to sign-in into applications provides a simple and fast auth solution to frontline workers, increases FLW productivity and seamless auth experience. 


## Benefits of QR code authentication method

Benefit | Description
--------|------------
Easier and faster sign-in | Frontline workers might be less tech-savvy, work with difficult devices, or have accessibility requirements. They can sign in with a QR code and PIN quicker than a username and password, which increases their productivity. They also don't have to remember their username to sign in, which reduces support costs. 
Inexpensive | Printing a QR code costs less than a hardware keys, which can be cost probitive for organizations with temporary frontline workers.

## Known issues and mitigation for QR code authentication method 

Admins should replace a QR code thet gets lost or stolen. A QR code can't be used alone without a PIN. 

The PIN can’t be used with any other identifier, such as a UPN, or email account. A QR code also has a secret that is replay resistant to online threats for a primary credential.


Admins can also take following precautions to mitigate the risk of a lost or stolen QR code:

- Don't use QR code authentication method for resources that require MFA.
- Configure a PIN lockout experience, similar to passwords.
- Replace QR codes that get lost or stolen.
- Create Conditional Access policies to restrict the authentication method to specified apps, store devices, and secure networks.


