---
title: Sign in user automatically after sign-up in iOS/macOS app
description: Learn how to automatically sign-in a user after sign-up in an iOS/macOS app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 06/21/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to automatically sign-in a user after sign-up in an iOS/macOS app by using native authentication.
---

# Tutorial: Sign in user automatically after sign-up in an iOS/macOS app

[!INCLUDE [applies-to-ios-macOS](../includes/applies-to-ios-macos.md)]

This tutorial demonstrates how to sign in user automatically after sign-up in an iOS/macOS app by using native authentication. 

In this tutorial, you learn how to:  

> [!div class="checklist"]
>
> - Sign in after sign-up. 
> - Handle errors. 

## Prerequisites 

- [Sign in users in a sample native iOS mobile application](how-to-run-native-authentication-sample-ios-app.md) 
- [Tutorial: Add built-in attributes to sign up with email one-time passcode](tutorial-native-authentication-ios-sign-up-with-email-one-time-passcode.md) 

## Sign in after sign-up 

The `Sign in after sign up` is an enhancement functionality of the sign in user flows, which has the effect of automatically signing in after successfully signing up. The SDK provides developers the ability to sign in a user after signing up, without having to supply the username, or to verify the email address through a one-time passcode. 

To sign in a user after successful sign-up use the `signIn(delegate)` method from the new state `SignInAfterSignUpState` returned in the `onSignUpCompleted(newState)`: 

```swift
extension ViewController: SignUpVerifyCodeDelegate {
    func onSignUpVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignUpCodeRequiredState?) {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }

    func onSignUpCompleted(newState: SignInAfterSignUpState) {
        resultTextView.text = "Signed up successfully!"
        newState.signIn(delegate: self)
    }
}
```

The `signIn(delegate)` accepts a delegate parameter and we must implement the required methods in the `SignInAfterSignUpDelegate` protocol. 

In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

```swift
extension ViewController: SignInAfterSignUpDelegate {
    func onSignInAfterSignUpError(error: SignInAfterSignUpError) {
        resultTextView.text = "Error signing in after sign up"
    }

    func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
        // User successfully signed in
        result.getAccessToken(delegate: self)
    }
}
```

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

[!INCLUDE [Custom claims provider](../customers/includes/native-auth/support-custom-claims-provider.md)]

## Next step 

> [!div class="nextstepaction"]
> [Tutorial: Self-service password reset](tutorial-native-authentication-ios-self-service-password-reset.md) 
