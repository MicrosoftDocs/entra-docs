---
title: Add sign in and sign out in native iOS/macOS app
description: Learn how to add sign-in and sign-out with email one-time passcode or username and password in iOS/macOS app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 08/19/2024
ms.custom:
#Customer intent: As a dev, devops, I want to learn how to add sign-in and sign-out with email one-time passcode or username and password in iOS/macOS app by using native authentication.
---

# Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to sign-in and sign-out a user with email one-time passcode or username and password in your iOS/macOS app by using native authentication. 

In this tutorial, you: 

> [!div class="checklist"]
> 
> - Sign in a user using email one-time passcode or username (email) and password.
> - Sign out a user.
> - Handle sign-in error

## Prerequisites 

- [Tutorial: Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).
- If you want to sign in using **Email with password**, configure your user flow to use **Email with password** when you [create your sign-up and sign-in user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).

## Sign in user

To sign in a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in. 

To sign in a user using the **Email with password** flow, capture the email and password. If the username and password are valid, the app signs in the user.

To sign in a user, you need to: 

1. Create a user interface (UI) to:

    - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
    - Collect a password if you sign in with username (email) and password.
    - Collect an email one-time passcode from the user if you sign in with email one-time passcode.
    - Add a button to let the user resend one-time passcode if you sign in with email one-time passcode.

1. In your UI, add a button, whose select event starts a sign-in as shown in the following code snippet:

    ```swift
        @IBAction func signInPressed(_: Any) {
        guard let email = emailTextField.text else {
            resultTextView.text = "email not set"
            return
        }

        let parameters = MSALNativeAuthSignInParameters(username: email)
        nativeAuth.signIn(parameters: parameters, delegate: self)
    }
    ```

    To sign in a user using **Email one-time passcode** flow, we use the following code snippet:

    ```swift
    nativeAuth.signIn(parameters: parameters, delegate: self)
    ```

    The `signIn(parameters:delegate)` method, which responds asynchronously by calling one of the methods on the passed delegate object, must implement the `SignInStartDelegate` protocol. We pass an instance of `MSALNativeAuthSignInParameters` which contains the email address that the user provides in the email submission form and pass `self` as the delegate.

    To sign in a user using **Email with password** flow, we use the following code snippet:

    ```swift
    let parameters = MSALNativeAuthSignInParameters(username: email)
    parameters.password = password
    nativeAuth.signIn(parameters: parameters, delegate: self)
    ```
    
    In the `signIn(parameters:delegate)` method, you pass an instance of `MSALNativeAuthSignInParameters` which contains the email address that the user supplied us with and their password, alongside with the delegate object that conforms to the `SignInStartDelegate` protocol. For this example, we pass `self`.

1. To implement `SignInStartDelegate` protocol when you use **Email one-time passcode** flow, use the following code snippet:

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

    The `signIn(parameters:delegate)` results in a call to delegate methods. In the most common scenario, `onSignInCodeRequired(newState:sentTo:channelTargetType:codeLength)` is called to indicate that a code has been sent to verify the user's email address. Along with some details of where the code has been sent, and how many digits it contains, this delegate method also has a `newState` parameter of type `SignInCodeRequiredState`, which gives us access to the following two new methods: 

    - `submitCode(code:delegate)`
    - `resendCode(delegate)`
    
    Use `submitCode(code:delegate)` to submit the one-time passcode that user supplies in one-time passcode form, use the following code snippet: 

    ```swift
    newState.submitCode(code: userSuppliedCode, delegate: self)
    ```

    The `submitCode(code:delegate)` accepts the one-time passcode and delegate parameter. After submitting the code, you must verify the one-time passcode by implementing the `SignInVerifyCodeDelegate` protocol.

    To implement `SignInVerifyCodeDelegate` protocol as an extension to your class, use the following code snippet: 

    ```swift
    extension ViewController: SignInVerifyCodeDelegate {
        func onSignInVerifyCodeError(error: MSAL.VerifyCodeError, newState: MSAL.SignInCodeRequiredState?) {
            resultTextView.text = "Error verifying code: \(error.errorDescription ?? "no description")"
        }
    
        func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
            resultTextView.text = "Signed in successfully."
            let parameters = MSALNativeAuthGetAccessTokenParameters()
            result.getAccessToken(parameters: parameters, delegate: self)
        }
    }
    ```

    In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

    The `getAccessToken(parameters:delegate)` accepts a `MSALNativeAuthGetAccessTokenParameters` instance and a delegate parameter and we must implement the required methods in the `CredentialsDelegate` protocol.

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

1. To implement `SignInStartDelegate` protocol when you use **Email with password** flow, use the following code snippet:

    ```swift
    extension ViewController: SignInStartDelegate {
        func onSignInStartError(error: MSAL.SignInStartError) {
            resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
        }
    
        func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
            // User successfully signed in
        }
    }
    ```

    In the most common scenario, we receive a call to `onSignInCompleted(result)` indicating that the user has signed in. The result can be used to retrieve the `access token`.

    The `getAccessToken(parameters:delegate)` accepts a `MSALNativeAuthGetAccessTokenParameters` instance and a delegate parameter and we must implement the required methods in the `CredentialsDelegate` protocol.

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

### Handle sign-in errors

During sign in, not every action succeeds. For example, the user might try to sign in with an email address that doesn't exist, or submit an invalid code.

1. To handle errors in the `signIn(parameters:delegate)` method, use the following code snippet:

    ```swift
    func onSignInStartError(error: MSAL.SignInStartError) {
        if error.isUserNotFound || error.isInvalidUsername {
            resultTextView.text = "Invalid username"
        } else {
            resultTextView.text = "Error signing in: \(error.errorDescription ?? "no description")"
        }
    }
    ```

1. To handle errors in `submitCode()` method, use the following code snippet:

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

    If the user enters an incorrect email verification code, the error handler includes a reference to a `SignInCodeRequiredState` that can be used to submit an updated code. In our earlier implementation of `SignInVerifyCodeDelegate` protocol, we simply displayed the error when we handled the `onSignInVerifyCodeError(error:newState)` delegate function. 

### Read ID token claims

Once your app acquires an ID token, you can retrieve the claims associated with the current account. To do so, use the following code snippet:

```swift
func onSignInCompleted(result: MSAL.MSALNativeAuthUserAccountResult) {
   let claims = result.account.accountClaims
   let preferredUsername = claims?["preferred_username"] as? String
}
```

The key you use to access the claim value is the name that you specify when you add the user attribute as a token claim.

Learn how to add built-in and custom attributes as token claims in the [Add user attributes to token claims](../external-id/customers/how-to-add-attributes-to-token.md) article.

## Sign out user 

To sign out a user, use the reference to the `MSALNativeAuthUserAccountResult` that you received in the `onSignInCompleted` callback, or use `getNativeAuthUserAccount()` to get any signed in account from the cache and store a reference in the `accountResult` member variable. 
 
1. Configure the keychain group for your project as described [here](tutorial-mobile-app-ios-swift-prepare-app.md?pivots=workforce#configure-xcode-project-settings). 

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


[!INCLUDE [Custom claims provider](../external-id/customers/includes/native-auth/support-custom-claims-provider.md)]

## Related content

- [Configure a custom claim provider](/entra/identity-platform/custom-extension-tokenissuancestart-configuration?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).
