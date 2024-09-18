---
title: Self-service password reset
description: Learn how to implement self-service password reset (SSPR) to my iOS/macOS app using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 08/19/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to implement self-service password reset (SSPR) to my iOS/macOS app using native authentication.
---

# Tutorial: Self-service password reset in iOS/macOS app

[!INCLUDE [applies-to-ios-macOS](../includes/applies-to-ios-macos.md)]

This tutorial demonstrates how to give users the ability to change or reset their password, with no administrator or help desk involvement. 

In this tutorial, you learn how to: 

> [!div class="checklist"]
>
> - Add self-service password reset.  
> - Handle errors. 

## Prerequisites

- [Enable self-service password reset](how-to-enable-password-reset-customers.md) 

## Reset password 

To reset the password of an existing user, we need to validate the email address using a one-time-passcode (OTP). 

1. To validate the email, we call the `resetPassword(username:delegate)` method from the SDK instance using the following code snippet: 

   ```swift
   nativeAuth.resetPassword(username: email, delegate: self)
   ```

1. To implement the `ResetPasswordStartDelegate` protocol as an extension to our class, use the following code snippet: 

   ```swift
   extension ViewController: ResetPasswordStartDelegate {
       func onResetPasswordCodeRequired(
           newState: MSAL.ResetPasswordCodeRequiredState,
           sentTo: String,
           channelTargetType: MSALNativeAuthChannelType,
           codeLength: Int
       ) {
           resultTextView.text = "Verification code sent to \(sentTo)"
       }

       func onResetPasswordStartError(error: MSAL.ResetPasswordStartError) {
           resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
       }
   }
   ```

   The call to `resetPassword(username:delegate)` results in a call to either `onResetPasswordCodeRequired()` or `onResetPasswordStartError()` delegate methods. 

   In the most common scenario `onResetPasswordCodeRequired(newState:sentTo:channelTargetType:codeLength)` will be called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `ResetPasswordCodeRequiredState`, which gives us access to two new methods: 

   - `submitCode(code:delegate)`
   - `resendCode(delegate)`

   To submit the code that the user supplied us with, use: 

   ```swift
   newState.submitCode(code: userSuppliedCode, delegate: self)
   ```

1. To verify the submitted code, start by implementing the `ResetPasswordVerifyCodeDelegate` protocol as an extension to your class using the following code snippet: 

   ```swift
   extension ViewController: ResetPasswordVerifyCodeDelegate {

       func onResetPasswordVerifyCodeError(
           error: MSAL.VerifyCodeError,
           newState: MSAL.ResetPasswordCodeRequiredState?
       ) {
           resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
       }

       func onPasswordRequired(newState: MSAL.ResetPasswordRequiredState) {
           // use newState instance to submit the new password
       }
   }
   ```

   In the most common scenario, we receive a call to `onPasswordRequired(newState)` indicating that we can provide the new password using the `newState` instance. 

   ```swift
   newState.submitPassword(password: newPassword, delegate: self)
   ```

1. To implement the `ResetPasswordRequiredDelegate` protocol as an extension to our class, use the following code snippet: 

   ```swift
   extension ViewController: ResetPasswordRequiredDelegate {

       func onResetPasswordRequiredError(
           error: MSAL.PasswordRequiredError,
           newState: MSAL.ResetPasswordRequiredState?
       ) {
           resultTextView.text = "Error submitting new password: \(error.errorDescription ?? "no description")"
       }

       func onResetPasswordCompleted(newState: SignInAfterResetPasswordState) {
           resultTextView.text = "Password reset completed"
       }
   }
   ```

   In the most common scenario, we receive a call to `onResetPasswordCompleted(newState)` indicating that the password reset flow has completed. 
 
## Handle errors 

In our earlier implementation of `ResetPasswordStartDelegate` protocol, we displayed the error when we handled the `onResetPasswordStartError(error)` delegate function. 

We can enhance the user experience by handling the specific error type as follows: 

```swift
func onResetPasswordStartError(error: MSAL.ResetPasswordStartError) {
    if error.isInvalidUsername {
        resultTextView.text = "Invalid username"
    } else if error.isUserNotFound {
        resultTextView.text = "User not found"
    } else if error.isUserDoesNotHavePassword {
        resultTextView.text = "User is not registered with a password"
    } else {
        resultTextView.text = "Error during reset password flow in: \(error.errorDescription ?? "no description")"
    }
}
```

### Handle errors with states 

Some errors include a reference to a new state. For example, if the user enters an incorrect email verification code, the error handler includes a reference to a `ResetPasswordCodeRequiredState` that can be used to submit a new verification code. 

In our previous implementation of `ResetPasswordVerifyCodeDelegate` protocol, we simply displayed the error when we handled the `onResetPasswordError(error:newState)` delegate function. 

We can improve the user experience by asking the user to enter the correct code and resubmitting it as follows: 

```swift
func onResetPasswordVerifyCodeError(
    error: MSAL.VerifyCodeError,
    newState: MSAL.ResetPasswordCodeRequiredState?
) {
    if error.isInvalidCode {
        // Inform the user that the submitted code was incorrect and ask for a new code to be supplied.
        // Request a new code calling `newState.resendCode(delegate)`
        let userSuppliedCode = retrieveNewCode(newState)
        newState?.submitCode(code: userSuppliedCode, delegate: self)
    } else {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }
}
```

Another example where the error handler includes a reference to a new state is when the user enters an invalid password. In this case, the error handler includes a reference to a `ResetPasswordRequiredState` that can be used to submit a new password. Here's an example: 

```swift
func onResetPasswordRequiredError(
    error: MSAL.PasswordRequiredError,
    newState: MSAL.ResetPasswordRequiredState?
) {
    if error.isInvalidPassword {
        // Inform the user that the submitted password was invalid and ask for a new password to be supplied.
        let newPassword = retrieveNewPassword()
        newState?.submitPassword(password: newPassword, delegate: self)
    } else {
        resultTextView.text = "Error submitting password: \(error.errorDescription ?? "no description")"
    }
}
```

### Sign in after password reset 

The SDK provides developers the ability to sign in a user after resetting their password without having to supply the username, or to verify the email address through a one-time passcode. 

To sign in a user after successful password reset use the `signIn(delegate)` method from the new state `SignInAfterResetPasswordState` returned in the `onResetPasswordCompleted(newState)` function: 

```swift
extension ViewController: ResetPasswordRequiredDelegate {

    func onResetPasswordRequiredError(
        error: MSAL.PasswordRequiredError,
        newState: MSAL.ResetPasswordRequiredState?
    ) {
        resultTextView.text = "Error submitting new password: \(error.errorDescription ?? "no description")"
    }

    func onResetPasswordCompleted() {
        resultTextView.text = "Password reset completed"
        newState.signIn(delegate: self)
    }
}
```

The `signIn(delegate)` accepts a delegate parameter and we must implement the required methods in the `SignInAfterResetPasswordDelegate` protocol. 

In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

```swift
extension ViewController: SignInAfterSignUpDelegate {
    func onSignInAfterSignUpError(error: SignInAfterSignUpError) {
        resultTextView.text = "Error signing in after password reset"
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

## Next step
 
> [!div class="nextstepaction"]
> [Tutorial: Support web fallback](tutorial-native-authentication-ios-macos-support-web-fallback.md) 
