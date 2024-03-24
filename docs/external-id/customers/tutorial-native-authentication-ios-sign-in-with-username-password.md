---
title: Sign in using username and password
description: Learn how to Sign in using username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn how to sign in using username and password.
---

# Tutorial: Sign in using username and password 

This tutorial demonstrates how to sign in using username and password. 

In this tutorial, you learn how to: 

- Sign in using username and password. 
- Handle errors 

## Prerequisites 

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](how-to-run-native-authentication-sample-ios-app.md). Ensure that when creating the user flow, you select **Email with password** in the **Identity providers** section, and choose **Country/Region** and **City** under **User attributes**.
- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).

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

    In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

    The `getAccessToken(delegate)` accepts a delegate parameter and we must implement the required methods in the `CredentialsDelegate` protocol.

    In the most common scenario, we receive a call to `onAccessTokenRetrieveCompleted(result)` indicating that the user obtained an `access token`.

    ```swift
    extension ViewController: CredentialsDelegate {
        func onAccessTokenRetrieveError(error: MSAL.RetrieveAccessTokenError) {
            resultTextView.text = "Error retrieving access token"
        }

        func onAccessTokenRetrieveCompleted(result: MSALNativeAuthTokenResult) {
            resultTextView.text = "Signed in. Access Token: \(result.accessToken)"
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

- [Tutorial: Sign in user after sign up](tutorial-native-authentication-ios-sign-in-user-after-sign-up.md) 

