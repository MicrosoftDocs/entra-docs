---
title: Add user attributes to sign up with email one-time passcode
description: Learn how to add user attributes to sign up with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about add user attributes to sign up with email one-time passcode.
---

# Tutorial: Add user attributes to sign up with email one-time passcode 

This tutorial demonstrates how to sign up user with user attributes. 

In this tutorial, you learn how to: 

- Sign up using username, and user attributes. 
- Handle errors. 

## Prerequisites 

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](how-to-run-native-authentication-sample-ios-app.md). Ensure that when creating the user flow, you select **Email one-time passcode** in the **Identity providers** section, and choose **Country/Region** and **City** under **User attributes**.
- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).
- [Collect user attributes during sign-up](how-to-define-custom-attributes.md).

## Sign up using username and user attributes  
 
To sign up user using username (email address) and user attributes, we need to verify the email by using the email one-time passcode (OTP).  

We use the `signUp(username:attributes:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. 

1. In the `signUp(username:attributes:delegate)` method, we pass in the user's email address, attributes, and pass `self` as the delegate: 

   ```swift
   let attributes = [
       "country": "United States",
       "city": "Redmond"
   ]

   nativeAuth.signUp(username: email, attributes: attributes, delegate: self)
   ```

   The call to `signUp(username:attributes:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods, or in a call to `onSignUpAttributesInvalid(attributeNames: [String])` if it's implemented in the delegate. 

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

    If the attributes are invalid, the method `onSignUpAttributesInvalid(attributeNames: [String])` is called. In this case, we display the list of invalid attributes to the user. Otherwise, the `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Apart from details such as the recipient of the code, and number of digits of the code, this delegate method has a *newState* parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods:  

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

    To submit the code that the user input, use: 

    ```swift
    newState.submitCode(code: userSuppliedCode, delegate: self)
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

In our earlier implementation of `SignUpStartDelegate` protocol, we display the error when we handle the `onSignUpStartError` delegate function.   

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

## Next steps 

- [Tutorial: Sign up using username, password, and user attributes](tutorial-native-authentication-ios-sign-up-with-username-password-user-attributes.md) 
