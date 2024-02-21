---
title: Sign in using username and password
description: Learn how to Sign in using username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn how to sign in using username and password.
---

# Tutorial: Sign in using username and password

This tutorial demonstrates how to sign in using username and password.

In this tutorial, you learn how to:

- Sign in using username and password.
- Handle errors

## Prerequisites

- [Register iOS application in Microsoft Entra External ID for customers tenant](how-to-run-sample-ios-app.md#register-an-application)
- [Enable public client and native authentication flows](how-to-run-sample-ios-app.md#enable-public-client-and-native-authentication-flows)
- [Grant API permissions](how-to-run-sample-ios-app.md#grant-api-permissions)
- User-flow Email with password:
  - [Create a user flow](how-to-run-sample-ios-app.md#create-a-user-flow)
  - [Associate the app with the user flow](how-to-run-sample-ios-app.md#associate-the-application-with-the-user-flow)

## Sign in using username and password

To sign in a user using username (email address) and password, will use the `signIn(username:password:delegate)` method, which will respond asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignInStartDelegate` protocol.

1. In the `signIn(username:password:delegate)` method, we pass in the email address that the user supplied us with, their password, and pass `self` for the delegate:

   ```swift
   nativeAuth.signIn(username: email, password: password, delegate: self)
   ```

1. To implement `SignInStartDelegate` protocol as an extension to our class, use the following code snippet:

   ```swift
   extension ViewController: SignInStartDelegate {
       func onSignInStartError(error: MSAL.SignInStartError) {
           resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
       }

       func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
           // User successfully signed in
       }
   }
   ```

## Handle errors

In our earlier implementation of `SignInStartDelegate` protocol, we displayed the error when we handled the `onSignInError(error)` delegate function.

We can enhance the user experience by handling the specific error type as follows:

```swift
func onSignInStartError(error: MSAL.SignInStartError) {
    if error.isInvalidUsername || error.isInvalidCredentials {
        resultTextView.text = "Invalid username or password"
    } else {
        resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
    }
}
```

## Next steps

- [Tutorial: Sign in user after sign up](tutorial-native-auth-ios-sign-in-user-after-sign-up.md)

