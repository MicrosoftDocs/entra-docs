---
title: Add sign-up in native iOS app
description: Learn how to add sign-up with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about Add sign-up with email one-time passcode.
---

# Tutorial: Add sign up with email one-time passcode 

This tutorial demonstrates how to sign up a user using email one-time passcode (OTP) in your native auth iOS Swift app. 

In this tutorial, you learn how to: 

- Sign up user. 

## Prerequisites 

- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md) 

## Sign up user 

To sign up a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them up and displays a notification to inform the user. 

To sign up user using **Email one-time-passcode**, you need to: 

1. Create your user interface that includes: 

    - A form to submit an Email. 
    - A form to submit one-time passcode. 

1. To sign up the user, we're going to use the library's `signUp(username:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. To implement the `signUp(username:delegate)`, use the following code snippet: 

    ```swift
    nativeAuth.signUp(username: email, delegate: self)
    ```

    In the `signUp(username:delegate)` method, we pass the email address that the user provides in the email submission form and pass `self` as the delegate.

1. To implement `SignUpStartDelegate` protocol as an extension to our class, use the following code snippet: 

    ```swift
    extension ViewController: SignUpStartDelegate {
        func onSignUpStartError(error: MSAL.SignUpStartError) {
            resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
        }
    
        func onSignUpCodeRequired(
            newState: MSAL.SignUpCodeRequiredState,
            sentTo: String,
            channelTargetType: MSAL.MSALNativeAuthChannelType,
            codeLength: Int
        ) {
            resultTextView.text = "Verification code sent to \(sentTo)"
        }
    }
    ```

    The call to `signUp(username:delegate)` results to a call to delegate methods. In the most common scenario `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignUpCodeRequiredState`, which gives us access to the following two new methods: 
 
    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

1. To use `submitCode(code:delegate)` to submit the one-time passcode that user supplies in one-time passcode form, use the following code snippet: 

    ```swift
    newState.submitCode(code: userSuppliedCode, delegate: self)
    ```

    The `submitCode(code:delegate)` accepts delegate parameter and we must implement the required methods in the `SignUpVerifyCodeDelegate` protocol. 

1. To implement `SignUpVerifyCodeDelegate` protocol as an extension to your class, use the following code snippet: 

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

    In the most common scenario, we receive a call to `onSignUpCompleted(newState)` indicating that the user is signed up and the flow is complete. 

### Handle errors during sign-up 

During sign-up, not every action succeeds. For example, the user might try to sign up with an email address that's already in use, or submit an invalid code. 

In our earlier implementation of `SignUpStartDelegate` protocol, we simply displayed the error when we handled the `onSignUpStartError(error)` delegate function. 
 
To enhance the user experience by managing the particular error type, use the following code snippet: 

```swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isUserAlreadyExists {
        resultTextView.text = "A user already exists with this username"
    } else {
        resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
    }
}
```

You've successfully completed all the necessary steps to sign up a user on your app. Build and run your application. If all good, you should be able to provide an email ID, receive a code on the email, and use that to successfully sign-up user. 

## Next steps

[Add sign in and sign out with email one-time passcode](tutorial-native-authentication-ios-sign-in-sign-out.md). 
