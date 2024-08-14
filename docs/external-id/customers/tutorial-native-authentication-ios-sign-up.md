---
title: Add sign-up in native iOS/macOS app
description: Learn how to add sign-up using email one-time passcode or email and password, and collect user attributes in an iOS/macOS mobile app using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 06/18/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to add sign-up using email one-time passcode or email and password, and collect user attributes in an iOS/macOS mobile app using native authentication.
---

# Tutorial: Add sign-up in an iOS/macOS mobile app using native authentication

[!INCLUDE [applies-to-ios-macOS](../includes/applies-to-ios-macos.md)]

This tutorial demonstrates how to sign up a user using email one-time passcode or username (email) and password, and collects user attributes in your iOS/macOS mobile app using native authentication.

> [!div class="checklist"]
>
> - Sign up a user by using email one-time passcode or username (email) and password.
> - Collect user attributes during sign-up. 
> - Handle sign-up errors.

## Prerequisites 

- [Tutorial: Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).
- If you want to collect user attributes during sign-up, configure the user attributes when you [create your sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Sign up a user

To sign up a user using the email one-time passcode or username (email) and password, you collect an email from the user, then send an email containing an email one-time passcode to the user. The user enters a valid email one-time passcode to validate their username.

To sign up a user, you need to: 

1. Create a user interface (UI) to: 

   - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid email address.
   - Collect a password if you sign up with username (email) and password.
   - Collect an email one-time passcode from the user.
   - If needed, collect user attributes.
   - Resend one-time passcode if the user doesn't receive it.
   - Start sign-up flow.

1. In your app, add a button, whose select event triggers the following code snippet: 

    ```swift
    @IBAction func signUpPressed(_: Any) {
        guard let email = emailTextField.text else {
            resultTextView.text = "Email or password not set"
            return
        }

        nativeAuth.signUp(username: email, delegate: self)
    }
    ```

    - To sign up a user using **Email one-time-passcode**, we use the library's `signUp(username:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. The following line of code initiates the user sign-up process:
    
        ```swift
        nativeAuth.signUp(username: email, delegate: self)
        ```
    
       In the `signUp(username:delegate)` method, we pass the user's email address from the submission form and the delegate (a class that implements the `SignUpStartDelegate` protocol).
    
    - To sign up a user using **Email with password**, use the following code snippets:

        ```swift
        @IBAction func signUpPressed(_: Any) {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                resultTextView.text = "Email or password not set"
                return
            }
    
            nativeAuth.signUp(username: email,password: password,delegate: self)
        }
        ```
        
        we use the library's `signUp(username:password:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. The following line of code initiates the user sign-up process:
        

        ```swift
        nativeAuth.signUp(username: email, password: password, delegate: self)
        ```
    
        In the `signUp(username:password:delegate)` method, we pass the user's email address, their password, and the delegate (a class that implements the `SignUpStartDelegate` protocol).

    - To implement `SignUpStartDelegate` protocol as an extension to our class, use:

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

        The call to `signUp(username:password:delegate)` or `signUp(username:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods. The `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods: 

        - `submitCode(code:delegate)`
        - `resendCode(delegate)`

        To submit the code that the user supplied us with, use: 
        
        ```swift
        newState.submitCode(code: userSuppliedCode, delegate: self)
        ```
        
        - To implement `SignUpVerifyCodeDelegate` protocol as an extension to our class, use: 
        
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
    
            The `submitCode(code:delegate)` accepts a delegate parameter and we must implement the required methods in the `SignUpVerifyCodeDelegate` protocol. In the most common scenario, we receive a call to `onSignUpCompleted(newState)` indicating that the user has been signed up and the flow is complete.   

## Collect user attributes during sign-up

Whether you sign up a user using email one-time passcode or username (email) and password, you can collect user attributes before a user's account is created.  The `signUp(username:attributes:delegate)` method, accepts attributes as a parameter.

1. To collect user attributes, use the following code snippet:

    ```swift
    let attributes = [
        "country": "United States",
        "city": "Redmond"
    ]
    
    nativeAuth.signUp(username: email, attributes: attributes, delegate: self)
    ```

    The `signUp(username:attributes:delegate)` or `ignUp(username:password:attributes:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods, or in a call to `onSignUpAttributesInvalid(attributeNames: [String])` if it's implemented in the delegate.

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
    
    If the attributes are invalid, the method `onSignUpAttributesInvalid(attributeNames: [String])` is called. In this case, we display the list of invalid attributes to the user. Otherwise, the `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Apart from details such as the recipient of the code, and number of digits of the code, this delegate method has a `newState` parameter of type `SignUpCodeRequiredState`, which gives us access to two new methods:

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

### User attributes across one or more pages 

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

- `onSignUpAttributesInvalid`: indicates that one or more attributes that were sent failed input validation. This error contains an attributeNames parameter, which is a list of all attributes that were sent by the developer that failed input validation. 
- `onSignUpAttributesRequired`: indicates that the server requires one or more attributes to be sent, before the user account can be created. This happens when one or more attributes is set as mandatory in the tenant configuration. This result contains attributes parameter, which is a list of `MSALNativeAuthRequiredAttribute` objects, which outline details about the user attributes that the API requires. 
 
Both delegate methods contain a new state reference. We use the `newState` parameter to call `submitAttributes(attributes:delegate)` again with the new attributes. 


## Handle sign-up errors

During sign-up, not every action succeeds. For example, the user might try to sign up with an email address that's already in use, or submit an invalid code. 

In our earlier implementation of `SignUpStartDelegate` protocol, we simply displayed the error when we handled the `onSignUpStartError(error)` delegate function. 
 
To enhance the user experience by managing the particular error type, use the following code snippet:

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

## Optional: Sign in after a sign-up flow

After a successful sign-up flow, you can sign-in a user without initiating a sign-in flow. Learn more in the [Tutorial: Sign in user automatically after sign-up in an iOS/macOS app](tutorial-native-authentication-ios-sign-in-user-after-sign-up.md) article.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication](tutorial-native-authentication-ios-sign-in-sign-out.md). 
