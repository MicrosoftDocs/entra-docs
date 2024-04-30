---
title: Sign up using username and password
description: Learn how to sign up using username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/12/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about sign up using username and password.
---

# Tutorial: Sign up using username and password 

This tutorial demonstrates how to sign up using username and password. 

In this tutorial, you learn how to: 

- Sign up using username, and password. 
- Handle errors. 

## Prerequisites 

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](how-to-run-native-authentication-sample-ios-app.md). Ensure that when creating the user flow, you select **Email with password** in the **Identity providers** section, and choose **Country/Region** and **City** under **User attributes**.
- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).

## Sign up using username and password 

To sign up user using username (email address) and password, we need to verify the email through email one-time passcode (OTP). 

We use the `signUp(username:password:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. 

1. In the `signUp(username:password:delegate)` method, we pass in the email address that the user supplied us with, their password, and pass `self` for the delegate: 

    ```swift
    nativeAuth.signUp(username: email, password: password, delegate: self)
    ```

1. To implement `SignUpStartDelegate` protocol as an extension to our class, use: 

   ```swift
   extension ViewController: SignUpStartDelegate {
       func onSignUpStartError(error: SignUpStartError) {
           resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
       }

        func onSignUpCodeRequired(
            newState: SignUpCodeRequiredState,
            sentTo: String,
            channelTargetType: MSALNativeAuthChannelType,
            codeLength: Int
        ) {
            resultTextView.text = "Verification code sent to \(sentTo)"
        }
   }
   ```

   The call to `signUp(username:password:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods. 

   The `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods: 

   - `submitCode(code:delegate)`
   - `resendCode(delegate)`

   To submit the code that the user supplied us with, use: 

   ```swift
   newState.submitCode(code: userSuppliedCode, delegate: self)
   ```

1. To implement `SignUpVerifyCodeDelegate` protocol as an extension to our class, use: 

   ```swift
   extension ViewController: SignUpVerifyCodeDelegate {
       func onSignUpVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignUpCodeRequiredState?) {
           resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
       }

       func onSignUpCompleted(newState: SignInAfterSignUpState) {
           resultTextView.text = "Signed up successfully!"
       }
   }
   ```

   The `submitCode(code:delegate)` accepts a delegate parameter and we must implement the required methods in the `SignUpVerifyCodeDelegate` protocol. In the most common scenario, we'll receive a call to `onSignUpCompleted(newState)` indicating that the user has been signed up and the flow is complete. 

## Handle errors 

In our earlier implementation of `SignUpStartDelegate` protocol, we displayed the error when we handled the `onSignUpStartError(error)` delegate function. 

We can enhance the user experience by handling the specific error type as follows: 

```swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isUserAlreadyExists {
        resultTextView.text = "Unable to sign up: User already exists"
    } else if error.isInvalidPassword {
        resultTextView.text = "Unable to sign up: The password is invalid"
    } else if error.isInvalidUsername {
        resultTextView.text = "Unable to sign up: The username is invalid"
    } else {
        resultTextView.text = "Unexpected error signing up: \(error.errorDescription ?? "no description")"
    }
}
```

## Next steps

- [Tutorial: Sign in using username and password](tutorial-native-authentication-ios-sign-in-with-username-password.md) 


