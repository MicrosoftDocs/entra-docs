---
title: Authenticator App same-device number matching improvements 
description: Learn about improvements to number matching for Microsoft Authenticator.
ms.service: entra-id
ms.subservice: authentication
ms.topic: article
ms.date: 11/06/2025
ms.author: justinha
author: justinha
# Customer intent: As an identity administrator, I want to explain how number matching in MFA push notifications from Authenticator in Microsoft Entra ID works in different use cases.
---

# Authenticator App same-device number matching improvements 

When a user signs in for MFA or phone sign-in with number match to Microsoft mobile apps like Teams and Outlook on the same device as their Authenticator app, they can reply Yes/No when prompted rather than enter the number. Users who sign in with Microsoft Edge, Chrome, or Safari web browsers continue to enter the number to sign in. 

This greatly improves the experience for users who sign in with number matching on the same device where they run Authenticator. There's no increased risk for users by switching to Yes/No because the prompt only shows on the device that initiated the sign in. 

Platform-specific scenario details are provided in this topic.

>[!Note] 
>In the following scenarios, the user signs in on the same device as Authenticator. There's no experience change when users complete number matching on a different device.

## How to prepare 

Administrators don't need to configure anything to prepare. Users only need to run the latest version of Microsoft Authenticator. 

## [**iOS**](#tab/iOS)

### Changes to the user experience

Scenario | Experience change?
---------|--------------------------
User signs in to Authenticator to upgrade the account they use for multifactor authentication (MFA). | Yes. The user sees a notification with the number match request on the sign-in screen. In Microsoft mobile apps like Authenticator, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams without a single sign-on (SSO) extension. | Yes. The user sees a notification with the number match request on the sign-in screen. In Microsoft mobile apps like Outlook or Teams, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams with an SSO extension. | Yes. The user sees the Yes/No prompt but they need to open the Authenticator app to complete the sign-in.
User signs in to a browser like Edge or Chrome. | No. The user sees a notification with the number match request on the sign-in screen. In a browser, they need to tap the notification to enter the number and approve the sign-in.

## [**Android**](#tab/Android)

### Changes to the user experience when doing same-device number matching

Scenario | Experience change?
---------|--------------------------
User signs in to Authenticator to upgrade the account they use for multifactor authentication (MFA). | Yes. The user sees a notification with the number match request on the sign-in screen. In Microsoft mobile apps like Authenticator, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a Microsoft app like Outlook or Teams. | Yes. The user sees a notification with the number match request on the sign-in screen. In Microsoft mobile apps like Outlook or Teams, they can tap the notification and reply Yes/No to complete the sign-in.
User signs in to a browser like Edge or Chrome. | No. The user sees a notification with the number match request on the sign-in screen. In a browser, they need to tap the notification to enter the number and approve the sign-in. 

---

## Related content

[Authentication methods in Microsoft Entra ID - Microsoft Authenticator app](concept-authentication-authenticator-app.md)