---
title: Sign in user after sign-up
description: Learn how to sign in user after sign-up.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn how to sign in user after sign-up.
---

# Tutorial: Sign in user after sign-up

This tutorial demonstrates how to sign in a user after sign-up.

In this tutorial, you learn how to:

- Sign in after sign-up.
- Handle errors.

## Prerequisites

- [Sign in users in a sample native iOS mobile application](how-to-run-sample-ios-app.md)
- [Tutorial: Add built-in attributes to sign up with email one-time passcode](tutorial-native-auth-ios-sign-up-with-email-one-time-passcode.md)

## Sign in after sign-up

The `Sign in after sign up` is an enhancement functionality of the sign in user flows, which has the effect of automatically signing in after successfully signing up. Through an internal short lived token, the SDK provides developers the ability to sign in a user after signing up, without having to supply the username, or to verify the email address through a one-time passcode.

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

In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in and the flow is complete.

```swift
extension ViewController: SignInAfterSignUpDelegate {
    func onSignInAfterSignUpError(error: SignInAfterSignUpError) {
        resultTextView.text = "Error signing in after sign up"
    }

    func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
        // User successfully signed in
    }
}
```

## Next steps

- [Tutorial: Reset password of a user](tutorial-native-auth-ios-self-service-password-reset.md)

