---
title: Sign up using username, password, and user attributes
description: Learn how to sign up using username, password, and user attributes.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about sign up using username, password and user attributes.
---

# Tutorial: Sign up using username, password, and user attributes 

This tutorial demonstrates how to sign up using username, password, and user attributes. 

In this tutorial, you learn how to: 

- Sign up using username, password, and custom attributes. 
- Handle errors. 
- Use user attributes across one or more pages. 

## Prerequisites 

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](how-to-run-native-authentication-sample-ios-app.md). Ensure that when creating the user flow, you select **Email with password** in the **Identity providers** section, and choose **Country/Region** and **City** under **User attributes**.
- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).
- [Collect user attributes during sign-up](how-to-define-custom-attributes.md).

## Sign up user 

To sign up user using username (email address), password, and user attributes, we need to verify the email through email one-time passcode (OTP). 

We use the `signUp(username:password:attributes:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. 

1. In the `signUp(username:password:attributes:delegate)` method, we pass in the user's email address, chosen password, attributes, and pass `self` as the delegate: 

    ```swift
    let attributes = [
        "country": "United States",
        "city": "Redmond"
    ]
    
    nativeAuth.signUp(username: email, password: password, attributes: attributes, delegate: self)
    ```

   The call to `signUp(username:attributes:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods, or in a call to `onSignUpAttributesInvalid(attributeNames: [String])` if it's implemented in the delegate. 

1. To implement the `SignUpStartDelegate` protocol as an extension to our class, use the following code snippet: 

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

   To submit the code that the user supplied us with, use: 

   ```swift
   newState.submitCode(code: userSuppliedCode, delegate: self)
   ```

   The `submitCode(code:delegate)` method accepts a delegate parameter and the delegate must implement the required methods in the `SignUpVerifyCodeDelegate` protocol. 

1.  To implement the `SignUpVerifyCodeDelegate` protocol as an extension to our class, use:  

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

   In the most common scenario, we receive a call to `onSignUpCompleted(newState)`, which indicates that the user has been signed up and the flow is complete. 

## Handle errors 

In our earlier implementation of `SignUpStartDelegate` protocol, we displayed the error when we handled the `onSignUpStartError` delegate function. 

We can enhance the user experience by handling the specific error type as follows: 

```swift
func onSignUpStartError(error: MSAL.SignUpStartError) {
    if error.isUserAlreadyExists {
        resultTextView.text = "Unable to sign up: User already exists"
    } else if error.isInvalidPassword {
        resultTextView.text = "Unable to sign up: Invalid password"
    } else {
        resultTextView.text = "Error signing up: \(error.errorDescription ?? "no description")"
    }
}
```

## User attributes across one or more pages 

To spread the attributes across one or more pages, we must set the attributes we intend to collect across different pages as mandatory in the customer identity and access management (CIAM) tenant configuration. 

We call `signUp(username:password:delegate)` without passing any attributes. The next step will be to call `newState.submitCode(code: userSuppliedCode, delegate: self)` to verify user's email. 

We implement the `SignUpVerifyCodeDelegate` protocol as an extension to our class as before, but this time we must implement the optional method `onSignUpAttributesRequired(attributes:newState)` in addition to the  required methods:

```swift
extension ViewController: SignUpVerifyCodeDelegate {
    func onSignUpAttributesRequired(newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes required"
    }

    func onSignUpVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignUpCodeRequiredState?) {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }

    func onSignUpCompleted(newState: SignInAfterSignUpState) {
        resultTextView.text = "Signed up successfully!"
    }
}
```

This delegate method has a `newState` parameter of type `SignUpAttributesRequiredState`, which gives us access to a new method: 

- `submitAttributes(attributes:delegate)` 

To submit the attributes that the user supplied us with, use the following code snippet: 

```swift
let attributes = [
    "country": "United States",
    "city": "Redmond"
]

newState.submitAttributes(attributes: attributes, delegate: self)
```

We'll also implement the `SignUpAttributesRequiredDelegate` protocol as an extension to our class: 

```swift
extension ViewController: SignUpAttributesRequiredDelegate {
    func onSignUpAttributesRequiredError(error: AttributesRequiredError) {
        resultTextView.text = "Error submitting attributes: \(error.errorDescription ?? "no description")"
    }

    func onSignUpAttributesRequired(attributes: [MSALNativeAuthRequiredAttribute], newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes required"
    }

    func onSignUpAttributesInvalid(attributeNames: [String], newState: SignUpAttributesRequiredState) {
        resultTextView.text = "Attributes invalid"
    }

    func onSignUpCompleted(newState: SignInAfterSignUpState) {
        resultTextView.text = "Signed up successfully!"
    }
}
```

When the user doesn't provide all the required attributes, or the attributes are invalid, these delegate methods are called: 

- onSignUpAttributesInvalid: indicates that one or more attributes that were sent failed input validation. This error contains an attributeNames parameter, which is a list of all attributes that were sent by the developer that failed input validation. 
- onSignUpAttributesRequired: indicates that the server requires one or more attributes to be sent, before the user account can be created. This happens when one or more attributes is set as mandatory in the tenant configuration. This result contains attributes parameter, which is a list of `MSALNativeAuthRequiredAttribute` objects, which outline details about the user attributes that the API requires. 
 
Both delegate methods contain a new state reference. We'll use the `newState` parameter to call `submitAttributes(attributes:delegate)` again with the new attributes. 
 
## Next steps 

- [Tutorial: Sign up using username and password](tutorial-native-authentication-ios-sign-up-with-username-password.md) 

