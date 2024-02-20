---
title: Add sign-up, sign in and sign out in native iOS app
description: Learn how to add sign-up, sign in and sign out with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about Add sign-up, sign in and sign out with email one-time passcode.
---

# Tutorial: Add sign up, sign in and sign out with email one-time passcode

This tutorial demonstrates how to sign up, sign in and sign out a user using email one-time passcode (OTP) in your native auth iOS Swift app.

In this tutorial, you learn how to:

- Sign up user.
- Sign in user.
- Sign out user.

## Prerequisites

- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-auth-prepare-ios-app.md)

## Sign up user

To sign up a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them up and displays a notification to inform the user.

To sign up user using **Email one-time-passcode**, you need to:

1. Create your user interface that includes:

    1. A form to submit an Email.
    1. A form to submit one-time passcode.

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
    submitCode(code: userSuppliedCode, delegate: self)
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

## Sign in user

To sign in a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in and displays the account details.

To  sign in user using **Email one-time-passcode** you need to:

1. Create your user interface that includes:

    1. A form to submit an Email.
    1. A form to submit one-time passcode.
    1. A page to display the account details.

1. To sign in user, we're going to use `signIn(username:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, which must implement the `SignInStartDelegate` protocol. To implement the `signIn(username:delegate)`, use the following code snippet:

    ```swift
    nativeAuth.signIn(username: email, delegate: self)
    ```

    We pass the email address that the user provides in the email submission form and pass `self` as the delegate.

1. To implement `SignInStartDelegate` protocol as an extension to your class, use the following code snippet:

    ```swift
    extension ViewController: SignInStartDelegate {
        func onSignInStartError(error: MSAL.SignInStartError) {
            resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
        }
    
        func onSignInCodeRequired(
            newState: MSAL.SignInCodeRequiredState,
            sentTo: String,
            channelTargetType: MSAL.MSALNativeAuthChannelType,
            codeLength: Int
        ) {
            resultTextView.text = "Verification code sent to \(sentTo)"
        }
    }
    ```

    The `signIn(username:delegate)` results in a call to delegate methods. In the most common scenario, `onSignInCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignInCodeRequiredState`, which gives us access to the following two new methods:

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`

1. To use `submitCode(code:delegate)` to submit the one-time passcode that user supplies in one-time passcode form, use the following code snippet:

    ```swift
    submitCode(code: userSuppliedCode, delegate: self)
    ```

    The `submitCode(code:delegate)` accepts the one-time passcode and delegate parameter. After submitting the code, you must verify the one-time passcode by implementing the `SignInVerifyCodeDelegate` protocol.

1. To implement `SignInVerifyCodeDelegate` protocol as an extension to your class, use the following code snippet:

    ```swift
    extension ViewController: SignInVerifyCodeDelegate {
        func onSignInVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignInCodeRequiredState?) {
            resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
        }
    
        func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
            resultTextView.text = "Signed in successfully."
        }
    }
    ```

    In the most common scenario, we receive a call to `onSignInCompleted(newState)` indicating that the user has signed in and the flow is complete.

### Handle errors during sign in

During sign in, not every action succeeds. For example, the user might try to sign in with an email address that doesn't exist, or submit an invalid code.

In our earlier implementation of `SignInStartDelegate` protocol, we simply displayed the error when we handled the `onSignInStartError(error)` delegate function.

To enhance the user experience by managing the particular error type, use the following code snippet:

```swift
func onSignInStartError(error: MSAL.SignInStartError) {
    if error.isUserNotFound || error.isInvalidUsername {
        resultTextView.text = "Invalid username"
    } else {
        resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
    }
}
```

If the user enters an incorrect email verification code, the error handler includes a reference to a `SignInCodeRequiredState` that can be used to submit an updated code. In our earlier implementation of `SignInVerifyCodeDelegate` protocol, we simply displayed the error when we handled the `onSignInVerifyCodeError(error:newState)` delegate function.

For a better user experience when an incorrect one-time passcode is entered, use the following code snippet to prompt for the correct code and request resubmission:

```swift
func onSignInVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignInCodeRequiredState?) {
    if error.isInvalidCode {
        // Inform the user that the submitted code was incorrect and ask for a new code to be supplied
        let userSuppliedCode = retrieveNewCode()
        newState?.submitCode(code: userSuppliedCode, delegate: self)
    } else {
        resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
    }
}
```

Well, you have done everything that is required to successfully sign in a user on your app. Build and run your application. If all good, you should be able to provide an email ID, receive a code on the email, and use that to successfully sign in user.

## Sign out user

To sign out a user, use the reference to the `MSALNativeAuthUserAccountResult` that you received in the `onSignInCompleted` callback, or use `getNativeAuthUserAccount()` to get any signed in account from the cache and store a reference in the `accountResult` member variable.

1. Configure the keychain group for your project as described [here](../../identity-platform/tutorial-v2-ios.md#configure-xcode-project-settings).

1. Add a new member variable to your `ViewController` class: `var accountResult: MSALNativeAuthUserAccountResult?`.

1. Update `viewDidLoad` to retrieve any cached account by adding this line after `nativeAuth` is initialized successfully: `accountResult = nativeAuth.getNativeAuthUserAccount()`.

1. Update the `signInCompleted` handler to store the account result:

    ```swift
    func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
        resultTextView.text = "Signed in successfully"
    
        accountResult = result
    }
    ```

1. Add a Sign Out button and use the following code to sign out user:

    ```swift
    @IBAction func signOutPressed(_: Any) {
        guard let accountResult = accountResult else {
            print("Not currently signed in")
            return
        }
    
        accountResult.signOut()
    
        self.accountResult = nil
    
        resultTextView.text = "Signed out"
    }
    ```

You have successfully completed all the necessary steps to sign out a user on your app. Build and run your application. If all good, you should be able to select sign out button to successfully sign out.

## Next Steps

[Tutorial: Add built-in attributes to your native iOS authentication.](tutorial-native-auth-ios-sign-up-with-email-one-time-passcode.md)
