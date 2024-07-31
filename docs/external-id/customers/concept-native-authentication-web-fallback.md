---
title: Native authentication web fallback
description: Learn how you can use web fallback to improve the resilience of your customer apps that use native authentication. 
author: kengaderdus
manager: mwongerapk
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date:  04/27/2024
ms.author: kengaderdus

#Customer intent: As a developer, devops, I want to learn more native authentication web fallback, so that I can enable it in my client apps.
---

# Native authentication web fallback

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Web fallback allows a client app that uses native authentication to use browser-delegated authentication as a fallback mechanism to improve resilience. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For example, if the authorization server requires capabilities that the client can't provide.

All client apps that use native authentications needs to support web fallback.

## Web fallback flow

This flow shows how web fallback can happen: 
 
- The client app collects initial information from the user and starts the authentication flow by making a request to Microsoft Entra. 
- Microsoft Entra returns a success or error response. A success response indicates the client app can continue making requests Microsoft Entra. An error response can indicate the client can continue to prompt the user for more information and continue to make requests to Microsoft Entra. The error response can also indicate the client needs to use browser-delegated authentication.
- If the error response indicates the client needs to use browser-delegated authentication, the client continues the authentication flow in the browser.

### Example scenario

Let's look at an example when it's possible for Microsoft Entra to indicate that the client needs to use browser-delegated authentication:

- In the Microsoft Entra admin center, an administrator configures an app to use email with password authentication method. 
- This configuration means Microsoft Entra requires the client app to have the ability to collect an email (username) and password from user. The client app communicates this ability to Microsoft Entra by sending *password* challenge type. Learn more about challenge types in [Native authentication challenge types](concept-native-authentication-challenge-types.md) article.
- The client app should also validate the email by submitting a one-time passcode that the server sends to the user's email. The client app communicates this ability to Microsoft Entra by sending *oob* challenge type. Learn more about challenge types in [Native authentication challenge types](concept-native-authentication-challenge-types.md) article  
- If the client app doesn't send both *oob* and *password* challenge types, Microsoft Entra interprets it as the client app's inability to fulfill the set requirement. In this case, Microsoft Entra returns an error that indicates the client needs to use browser-delegated authentication.

## Support web fallback 

If Microsoft Entra's response indicates that the client app needs to fall back to the browser-delegated authentication, we recommend you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md). 

Learn how to support web fallback in [native Android apps](tutorial-native-authentication-android-support-web-fallback.md) and [native iOS/macOS apps](tutorial-native-authentication-ios-macos-support-web-fallback.md).

## Related content

- [Native authentication challenge types](concept-native-authentication-challenge-types.md)
- [Tutorial: Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md)
- [Tutorial: Support web fallback in iOS/macOS app](tutorial-native-authentication-ios-macos-support-web-fallback.md)
