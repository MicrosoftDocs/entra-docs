---
title: Support web fallback
description: Learn how to implement web fallback in an iOS/macOS application by using native authentication to ensure stability in authentication flow.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/29/2024
ms.custom: developer
#Customer intent: As a developer, I want to support web fallback in my iOS/macOS app's native authentication flow so that I can ensure stability of my app's authentication flow.
---

# Tutorial: Support web fallback 

This tutorial demonstrates how to acquire a token through a browser where native authentication isn't sufficient to complete the user flow. 

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Check BrowserRequired error. 
> - Handle BrowserRequired error. 

## Prerequisites

- [Sign in users in a sample native iOS mobile application](how-to-run-native-authentication-sample-ios-app.md) 

## Browser required 

`BrowserRequired` is a fallback mechanism for various scenarios where native authentication isn't sufficient to complete the user flow. 

To ensure stability of your application and avoid interruption of the authentication flow, it's highly recommended to use the SDK's `acquireToken()` method to continue the flow in the browser. 

When we initialize the SDK, we need to specify which challenge types our application can support. Here are the list of challenge types that the SDK accepts: 

- OOB (out of band): add this challenge type when your iOS/macOS application can handle a one-time-passcode, in this case an email code. 
- Password: add this challenge type when your application is able to handle password based authentication. 

When Microsoft Entra requires capabilities that the client can't provide the `BrowserRequired` error will be returned. For example, suppose we initialize the SDK instance specifying only the challenge type OOB, but in Microsoft Entra admin center, the application is configured with an **Email with password** user flow. When we call the **signUp(username)** method from the SDK instance, we get a `BrowserRequired` error, because Microsoft Entra requires different challenge type (password in this case) than the one configured in the SDK. 

Insufficient challenge type is only one example of when `BrowserRequired` can occur. `BrowserRequired` is a general fallback mechanism that can happen in various scenarios. 

## Sample flow 
 
In the following code snippet you can see how you can specify the challenge types during the SDK instance initialization: 

```swift
nativeAuth = try MSALNativeAuthPublicClientApplication(
    clientId: "<client id>",
    tenantSubdomain: "<tenant subdomain>",
    challengeTypes: [.OOB]
)
```

In this case we're specifying only the challenge type OOB. Suppose that in the Microsoft Entra admin center, the application is configured with an **Email with password** user flow. 

```swift
nativeAuth.signUp(username: email, delegate: self)

func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isBrowserRequired {
        // handle browser required error
    }
}
```

When we call the `signUp(username:delegate)` method from the SDK instance, we get a `BrowserRequired` error, because Microsoft Entra requires a different challenge type (password in this case) than the one configured in the SDK. 

## Handle BrowserRequired error 

To handle this kind of error, we need to launch a browser and let the user perform the authentication flow there. This can be done by calling `acquireToken()` method. In order to use this method, a few additional configurations need to be done: 

- [Configure URL schemes in our Xcode project](../../identity-platform/tutorial-v2-ios.md#for-ios-only-configure-url-schemes)
- [Configure the redirect URI in Microsoft Entra admin center](../../identity-platform/quickstart-mobile-app-ios-sign-in.md#register-your-quickstart-app)

Now we can get a token and an account interactively. Here's an example of how to do it: 

```swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isBrowserRequired {
        let webviewParams = MSALWebviewParameters(authPresentationViewController: self)
        let parameters = MSALInteractiveTokenParameters(scopes: ["User.Read"], webviewParameters: webviewParams)

        nativeAuth.acquireToken(with: parameters) { (result: MSALResult?, error: Error?) in
            // result will contain account and tokens retrieved in the browser
        }
    }
}
```

The tokens and account that are returned are identical to the ones that would be retrieved through a native auth flow. 

## Related content

- [How to run the Android sample app](how-to-run-native-authentication-sample-android-app.md).
- [Overview of native authentication API reference](../../identity-platform/reference-native-authentication-overview.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json) 
