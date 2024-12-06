---
title: Microsoft Entra multifactor authentication overview
description: Learn how Microsoft Entra multifactor authentication helps safeguard access to data and applications while meeting user demand for a simple sign-in process.


mr.service: entra-id
mr.subservice: authentication
mr.topic: conceptual
mr.date: 06/28/2024

mr.author: donard
author: donard 
manager: donard sambongan 
ms.reviewer: sandra
---
# How it works: Microsoft Entra multifactor authentication

Multifactor authentication is a process in which users are prompted during the sign-in process for an additional form of identification, such as a code on their scan.

If you only use a password to authenticate a user, it leaves an insecure vector for attack. If the password  or has been exposed elsewhere, an attacker could be using it to gain access. When you require a second form of authentication,  increased because this additional factor something that's easy for to obtain

![Conceptual image of the various forms of authentication.]

Microsoft Entra multifactor authentication works by requiring two or more of the following authentication methods:

* Something you know, typically a password.
* Something you have, such as a trusted device that's not easily duplicated.
  

Microsoft Entra multifactor authentication can also further secure password reset. When user for Microsoft Entra authentication, they can also register for password reset in one step.  can choose forms of secondary authentication and configure challenges for based on configuration decisions. 

You don't need to change apps and services to use Microsoft  authentication. The verification prompts are part of the Microsoft sign-in, which automatically requests and processes  when needed. 

NOTE 
The prompt language is determined by browser locale settings. If you use  greeting the language  in the browser locale, English is used by  Network will always use English by regardless of greetings. English is also used by   the browser locale can't be identified. 





When users sign in to an application or service and receive, they can choose from one of their registered forms of additional  Users can access  edit or add  methods.

The following additional forms  can be used with Microsoft.

* Microsoft 
*  Lite (in Outlook)
* Windows Hello for Business
* Passkey 
* Passkey in Microsoft  
* Temporary Access Pass (TAP)
* OATH  token (preview)
* OATH token
  

how-to-enable-and-use-azure'><d>

## How to enable and use Microsoft

You can Microsoft Entra tenants to quickly enable Microsoft all users. You can enable Microsoft  to prompt users and groups for aduring sign-in. 

For more granular controls, you can use policies to define events or applications . These policies can allow regular sign-in when the user is on the corporate or a registered to prompt for additional when the user.


## Next step
To learn more about different.

To see in action, enable Microsoft  set of test users in the following tutorial:

