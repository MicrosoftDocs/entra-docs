---
title: Native authentication web fallback
description: Learn how you can use web fallback to improve the resilience of your customer apps that use native authentication 
author: kengaderdus
manager: celestedg
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date:  03/27/2024
ms.author: cmulligan

#Customer intent: As a developer, devops, I want to learn more native authentication web fallback, so that I can enable it in my client apps.
---

# Native authentication web fallback

Web fallback allows a client app that uses native authentication to use browser-delegated authentication as a fallback mechanism to improve resilience. This scenario happens when native authentication isn't sufficient to complete the authentication flow such as when the authorization server requires capabilities that the client can't provide.

All client apps that use native authentications needs to support web fallback.

## Web fallback flow 

This flow shows how web fallback can happen: 
 
- The client app collects collects initial information from the user and starts the authentication flow by making a request to the authorization server, in this case Microsoft Entra. 
- The authorization server, returns a success or error response. A success response indicates that the client app can continue making requests to the authorization server. An error message may indicate client can continue to prompt the user for more information, continue to make requests to the authorization server, or indicate client needs to use browser-delegated authentication.
-  If the error indicates client needs to use browser-delegated authentication, the client continues the authentication flow in the browser.

### Example scenario

In the Microsoft Entra Admin center, an administrator configures an app to use email with password authentication method. This configuration means that the authorization server requires the client app to have the ability to collect an email (username) and password from user, and to validate the email by submitting a one-time passcode that the server sends to the email. If the client app indicates that it's unable to fulfil this requirement, the server returns and error that indicates client needs to use browser-delegated authentication. 

The client app uses challenge types to indicate it's capabilities. Learn more about challenge types in [Native authentication challenge types](concept-native-authentication-challenge-types.md) article.  

## Support web fallback 

If Microsoft Entra's response indicates that the client app needs to fall back to the browser-delegated authentication, we recommend that you use a [Microsoft-built and supported authentication library](../../reference-v2-libraries.md).

## Related content

- [Native authentication challenge types](concept-native-authentication-challenge-types.md)
- [Tutorial: Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md)
