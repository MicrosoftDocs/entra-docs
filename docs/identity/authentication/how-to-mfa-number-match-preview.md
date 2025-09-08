---
title: How number matching works in MFA push notifications for Authenticator
description: Learn how to use number matching in multifactor authentication notifications for Microsoft Authenticator.
ms.service: entra-id
ms.subservice: authentication
ms.topic: article
ms.date: 09/08/2025
ms.author: justinha
author: justinha
# Customer intent: As an identity administrator, I want to explain how number matching in MFA push notifications from Authenticator in Microsoft Entra ID works in different use cases.
---

# Authenticator App Same Device Number Matching Enhancements 
Welcome to the launch of the preview of same device Authenticator app number matching enhancements! We’re excited to have you participate and look forward to learning from your feedback. 
   
Expectations for participating in this preview  
•	You will need to actively test this feature with a few test accounts in a test tenant leveraging a test mobile device. [RC1.1]Please provide feedback by 9/12.
•	Please take notes of your feedback throughout your testing. For any broken scenario, please provide Authenticator app logs [RC2.1]and as much detailed notes as possible. Video/screen recordings go a long way as well. 
•	For any breaking changes, you can reach out immediately to Ramiro Calderon (ramical@microsoft.com) and Mayur Santani (mayurs@microsoft.com).
 
   
What can you do with this preview?   
When a user signs in with number match to Microsoft mobile apps like Teams and Outlook on the same device as their Authenticator app, they can reply Yes/No when prompted rather than enter the number. Users who sign in with Microsoft Edge, Chrome, or Safari web browsers continue to see today’s number matching experience. Platform-specific scenario details are provided below.

>[!Note] 
>In the following scenarios, the user signs in on the same device as Authenticator. There is no experience change when users complete number matching on a different device.

## [**Android**](#tab/Android)

Scenario | Experience change or not?
---------|--------------------------
User signs in to Authenticator to upgrade the account they use for multifactor authentication (MFA). | Yes. The user sees a notification with the number match request on the sign-in in screen. In Microsoft mobile apps like Authenticator, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams. | Yes. The user sees a notification with the number match request on the sign-in in screen. In Microsoft mobile apps like like Outlook or Teams, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a browser like Edge or Chrome. | No. The user sees a notification with the number match request on the sign-in in screen. In a browser, they need to tap the notification to enter the number and approve the sign-in. 

To install the preview on Android:

1. Open the Play Store and install or update Authenticator.
1. To remove the preview, uninstall the app and download the latest version of the app from the Play Store.
---

## [**iOS**](#tab/iOS)

Scenario | Experience change or not?
---------|--------------------------
User signs in to Authenticator to upgrade the account they use for multifactor authentication (MFA). | Yes. The user sees a notification with the number match request on the sign-in in screen. In Microsoft mobile apps like Authenticator, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams without a single sign-on (SSO) extension. | Yes. The user sees a notification with the number match request on the sign-in in screen. In Microsoft mobile apps like like Outlook or Teams, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams with an SSO extension. | Yes. The user sees the Yes/No prompt but they need to open the Authenticator app to complete the sign-in.
User signs in to a browser like Edge or Chrome. | No. The user sees a notification with the number match request on the sign-in in screen. In a browser, they need to tap the notification to enter the number and approve the sign-in.

To install the preview on iOS:

1. Open this link in your iOS device and follow the instructions to join the Test Flight: https://testflight.apple.com/join/3PFeH9dV
1. To remove the preview, uninstall the app and download the latest version of the app from the App Store.

---