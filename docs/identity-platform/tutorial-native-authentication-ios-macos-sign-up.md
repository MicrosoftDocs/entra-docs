---
title: Add sign-up in an iOS/macOS app by using native authentication
description: Learn how to sign up users with email one-time passcode or email and password, and collect user attributes including a username (alias), in an iOS/macOS app by using native authentication.
manager: pmwongera
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 06/17/2026

#Customer intent: As a developer, I want to add sign-up with email one-time passcode or email and password, and collect user attributes including a username (alias), in my iOS/macOS app by using native authentication so that users can create accounts with flexible identity options.
---

# Tutorial: Add sign-up in an iOS/macOS app by using native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to sign up a user by using email one-time passcode or username (email) and password in your iOS/macOS app by using native authentication. You also learn how to collect user attributes during sign-up, including a username (alias), and handle errors.

In this tutorial, you:

> [!div class="checklist"]
>
> - Sign up a user by using email one-time passcode or username (email) and password.
> - Collect user attributes during sign-up, including a username (alias). 
> - Handle sign-up errors.

## Prerequisites 

- Complete the steps in [Tutorial: Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).
- If you want to collect user attributes during sign-up, configure the user attributes when you [create your sign-up and sign-in user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).
- To collect a username (alias) during sign-up, enable the **Username** built-in user attribute in your tenant's sign-up user flow.

## Sign up a user

To sign up a user by using the email one-time passcode or username (email) and password, you collect an email from the user, then send an email containing an email one-time passcode to the user. The user enters a valid email one-time passcode to validate their username.

To sign up a user, you need to: 

1. Create a user interface (UI) to: 

   - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid email address.
   - Collect a password if you sign up with username (email) and password.
   - Collect a username (alias) if your app supports alias-based sign-in.
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
    
        let parameters = MSALNativeAuthSignUpParameters(username: email)
        nativeAuth.signUp(parameters: parameters, delegate: self)
    }
    ```

    - To sign up a user using **Email one-time-passcode**, use the library's `signUp(parameters:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. The following line of code initiates the user sign-up process:
    
        ```swift
        nativeAuth.signUp(parameters: parameters, delegate: self)
        ```
    
       In the `signUp(parameters:delegate)` method, pass a `MSALNativeAuthSignUpParameters` instance containing the user's email address from the submission form alongside the delegate (a class that implements the `SignUpStartDelegate` protocol).
    
    - To sign up a user using **Email with password**, use the following code snippets:

        ```swift
        @IBAction func signUpPressed(_: Any) {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
               resultTextView.text = "Email or password not set"
               return
            }
    
            let parameters = MSALNativeAuthSignUpParameters(username: email)
            parameters.password = password
            nativeAuth.signUp(parameters: parameters, delegate: self)
        }
        ```
        
        The library's `signUp(parameters:delegate)` method responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignUpStartDelegate` protocol. The following line of code initiates the user sign-up process:
        

        ```swift
        nativeAuth.signUp(parameters: parameters, delegate: self)
        ```
    
        In the `signUp(parameters:delegate)` method, pass a `MSALNativeAuthSignUpParameters` instance containing the user's email address and their password alongside the delegate (a class that implements the `SignUpStartDelegate` protocol).

    - To implement the `SignUpStartDelegate` protocol as an extension to your class, use:

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

        The call to `signUp(parameters:delegate)` results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods. The `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignUpCodeRequiredState`, which gives you access to two new methods: 

        - `submitCode(code:delegate)`
        - `resendCode(delegate)`

        To submit the code that the user supplied, use: 
        
        ```swift
        newState.submitCode(code: userSuppliedCode, delegate: self)
        ```
        
        - To implement the `SignUpVerifyCodeDelegate` protocol as an extension to your class, use: 
        
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
    
            The `submitCode(code:delegate)` accepts a delegate parameter and you must implement the required methods in the `SignUpVerifyCodeDelegate` protocol. In the most common scenario, you receive a call to `onSignUpCompleted(newState)` indicating that the user has been signed up and the flow is complete.

## Collect user attributes during sign-up

Whether you sign up a user using email one-time passcode or username (email) and password, you can collect user attributes before a user's account is created.  The `signUp(parameters:delegate)` method can be called using a `MSALNativeAuthSignUpParameters` which has an attributes property.

1. To collect user attributes, use the following code snippet:

    ```swift
    let attributes = [
        "country": "United States",
        "city": "Redmond"
    ]
    
    let parameters = MSALNativeAuthSignUpParameters(username: email)
    parameters.password = password
    parameters.attributes = attributes
    nativeAuth.signUp(parameters: parameters, delegate: self)
    ```

    The `signUp(parameters:delegate)`results in a call to either `onSignUpCodeRequired()` or `onSignUpStartError()` delegate methods, or in a call to `onSignUpAttributesInvalid(attributeNames: [String])` if it's implemented in the delegate.

1. To implement the `SignUpStartDelegate` protocol as an extension to your class, use the following code snippet:
    
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
    
    If the attributes are invalid, the method `onSignUpAttributesInvalid(attributeNames: [String])` is called. In this case, display the list of invalid attributes to the user. Otherwise, the `onSignUpCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Apart from details such as the recipient of the code, and number of digits of the code, this delegate method has a `newState` parameter of type `SignUpCodeRequiredState`, which gives you access to two new methods:

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

### User attributes across one or more pages 

To spread the attributes across one or more pages, set the attributes you intend to collect across different pages as mandatory in the customer identity and access management (CIAM) tenant configuration. 

Call `signUp(parameters:delegate)` without passing any attributes in the `MSALNativeAuthSignUpParameters` instance. The next step is to call `newState.submitCode(code: userSuppliedCode, delegate: self)` to verify the user's email. 

Implement the `SignUpVerifyCodeDelegate` protocol as an extension to your class as before, but this time you must implement the optional method `onSignUpAttributesRequired(attributes:newState)` in addition to the required methods:

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

This delegate method has a `newState` parameter of type `SignUpAttributesRequiredState`, which gives you access to a new method: 

- `submitAttributes(attributes:delegate)` 

To submit the attributes that the user supplied, use the following code snippet: 

```swift
let attributes = [
    "country": "United States",
    "city": "Redmond"
]

newState.submitAttributes(attributes: attributes, delegate: self)
```

Also implement the `SignUpAttributesRequiredDelegate` protocol as an extension to your class: 

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
 
Both delegate methods contain a new state reference. Use the `newState` parameter to call `submitAttributes(attributes:delegate)` again with the new attributes. 


## Collect a username (alias) during sign-up

The username (alias) is a special user attribute. Like other attributes such as city or country, you collect it during sign-up. Unlike those attributes, the user can later use the alias to sign in. The alias (for example, "johndoe") gives users a shorter, friendlier way to sign in than their email address.

The username (alias) doesn't replace the username (email). During sign-up, the app must always collect the username (email) as the primary identifier, and it collects the alias as an attribute alongside the email. At sign-in, the user can then choose to sign in with either their username (email) or their username (alias).

When the **Username** built-in user attribute is enabled in your sign-up user flow, the SDK accepts it through the same attributes dictionary used for other attributes, as the `flatusername` key. You can pass the username (alias) directly in the `signUp` call so the user doesn't need to go through a separate attributes-required step.

To collect a username (alias), add an input field for the username in your sign-up UI alongside the email field, then pass the alias as an attribute in the sign-up call:

```swift
guard let email = emailTextField.text, !email.isEmpty,
      let password = passwordTextField.text, !password.isEmpty,
      let username = usernameTextField.text, !username.isEmpty else {
    showResultText("Please fill in all fields")
    return
}

let attributes: [String: Any] = [
    "flatusername": username
]

let parameters = MSALNativeAuthSignUpParameters(username: email)
parameters.password = password
parameters.attributes = attributes
nativeAuth.signUp(parameters: parameters, delegate: self)
```

For email one-time passcode flows (without password), pass the attributes without setting a password:

```swift
let parameters = MSALNativeAuthSignUpParameters(username: email)
parameters.attributes = attributes
nativeAuth.signUp(parameters: parameters, delegate: self)
```

When handling errors for username (alias) sign-up, the `error.isUserAlreadyExists` property also covers a duplicate alias, and `error.isInvalidAttributes` surfaces an invalid alias value.


## Handle sign-up errors

During sign-up, not every action succeeds. For example, the user might try to sign up with an email address that's already in use, or submit an invalid code.

In the earlier implementation of the `SignUpStartDelegate` protocol, the error was simply displayed when handling the `onSignUpStartError(error)` delegate function. 
 
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

After a successful sign-up flow, you can sign in a user without initiating a sign-in flow. If the user signed up with a username (alias), they can sign in by using either their email address or their alias. Learn more in the [Tutorial: Sign in user automatically after sign-up in an iOS/macOS app](tutorial-native-authentication-ios-macos-sign-in-user-after-sign-up.md) article.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication](tutorial-native-authentication-ios-macos-sign-in-sign-out.md)
