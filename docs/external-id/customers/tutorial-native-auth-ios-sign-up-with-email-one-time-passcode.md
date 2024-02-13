---
title: Add user attributes to sign up with email one-time passcode
description: Learn how to add user attributes to sign up with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about add user attributes to sign up with email one-time passcode.
---

# Tutorial: Add user attributes to sign up with email one-time passcode

This tutorial demonstrates how to sign up user with user attributes.

In this tutorial, you learn how to:

- Sign up using username and user attributes.
- Handle errors

## Prerequisites

- [Register iOS application in Microsoft Entra External ID for customers tenant](how-to-run-sample-ios-app.md#register-an-application)
- [Enable public client and native authentication flows](how-to-run-sample-ios-app.md#enable-public-client-flow-and-native-authentication-flows)
- [Grant API permissions](how-to-run-sample-ios-app.md#grant-api-permissions)
- User-flow with email one-time passcode:
  - [Create a user flow](how-to-run-sample-ios-app.md#create-a-user-flow)
    - Under **User attributes**, select **Country/Region** and **City** in the user flow.
  - [Associate the app with the user flow](how-to-run-sample-ios-app.md#associate-the-application-with-the-user-flow)
- [Collect user attributes during sign-up](how-to-define-custom-attributes.md)

## Sign up using username and custom attributes 

To sign up user using username (email address) and custom attributes, we need to verify the email by using the email one-time passcode (OTP). 

We use the `signUp(username:attributes:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object which must implement the `SignUpStartDelegate` protocol.

1. In the `signUp(username:attributes:delegate)` method, we pass in the user's email address, attributes, and pass `self` as the delegate:

   ```swift
   let attributes = [
       "country": "United States",
       "city": "Redmond"
   ]

   nativeAuth.signUp(username: email, attributes: attributes, delegate: self)
   ```

   The call to `signUp(username:attributes:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods, or in a call to `onSignUpAttributesInvalid(attributeNames: [String])` if it is implemented in the delegate.

1. Implement the `SignUpStartDelegate` protocol as an extension to our class: 

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

       func onSignUpAttributesInvalid(attributeNames: [String]) {
          resultTextView.text = "Invalid attributes  \(attributeNames)"
       }
   }
   ```

    If the attributes are invalid, the method `onSignUpAttributesInvalid(attributeNames: [String])` is called. In this case, we display the list of invalid attributes to the user. Otherwise, the `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Apart from details such as the recipient of the code, and number of digits of the code, this delegate method has a _newState_ parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods: 

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

    To submit the code that the user input, use:

    ```swift
    submitCode(code: userSuppliedCode, delegate: self)
    ```

    The `submitCode(code:delegate)` method accepts a delegate parameter and the delegate must implement the required methods in the `SignUpVerifyCodeDelegate` protocol.

1. To implement the `SignUpVerifyCodeDelegate` protocol as an extension to our class, use: 

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

    In the most common scenario, we receive a call to `onSignUpCompleted(newState)` which indicates that the user has been signed up and the flow is complete.

## Handle errors

In our earlier implementation of `SignUpStartDelegate` protocol we display the error when we handle the `onSignUpStartError` delegate function.  

We can enhance the user experience by handling the specific error type as follows: 

```swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    switch error.type {
    if error.isUserAlreadyExists {
        resultTextView.text = "Unable to sign up: User already exists"
    } else {
        resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
    }
}
```

## Next Steps

- Tutorial: Sign up using username, password and user attributes

