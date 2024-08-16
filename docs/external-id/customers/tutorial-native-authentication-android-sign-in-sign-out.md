---
title: Add sign-in in Android app by using native authentication
description: Learn how to add sign-in and sign-out with email one-time passcode or username and password in Android app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 05/30/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to add sign-in and sign-out with email one-time passcode or username (email) and password in an Android mobile app by using native authentication
---

# Tutorial: Add sign-in in Android app by using native authentication

This tutorial demonstrates how to sign-in and sign-out a user with email one-time passcode or username and password in your Android mobile app by using native authentication. 

In this tutorial, you learn how to: 

> [!div class="checklist"]
> 
> - Sign in a user using email one-time passcode or username (email) and password.
> - Sign out a user.
> - Handle sign-in error

## Prerequisites

- Complete the steps in [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-android-sign-up.md). This tutorial shows you how to prepare your Android project or app for native authentication. 

## Sign in a user

To sign in a user using the one-time passcode, collect the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in. 

To sign in a user using username (email) and password, collect the email and password from the user. If the username and password are valid, the app signs in the user.

To sign in a user, you need to: 

1. Create a user interface (UI) to:

    - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
    - Collect a password if you sign in with username (email) and password.
    - Collect an email one-time passcode from the user if you sign in with email one-time passcode.
    - Resend one-time passcode (recommended) if you sign in with email one-time passcode.

1. In your UI, add a button, whose select event starts a sign-in as shown in the following code snippet: 

   ```kotlin
    CoroutineScope(Dispatchers.Main).launch {
        val actionResult = authClient.signIn(
            username = emailAddress
            //password = password, Pass 'password' param if you sign in with username (email) and password
        )
        if (actionResult is SignInResult.CodeRequired) {
            val nextState = actionResult.nextState
            val submitCodeActionResult = nextState.submitCode(
                code = code
            )
            if (submitCodeActionResult is SignInResult.Complete){
                // Handle sign in success
                val accountState = submitCodeActionResult.resultValue
                val accessTokenResult = accountState.getAccessToken()
                if (accessTokenResult is GetAccessTokenResult.Complete) {
                    val accessToken = accessTokenResult.resultValue.accessToken
                    val idToken = accountState.getIdToken()
                }
            }
        }
    }
   ```

    If the user isn't required to submit a passcode, such as where a user signs in with email and password, use the following code snippet:

    ```kotlin
        CoroutineScope(Dispatchers.Main).launch {
            val actionResult = authClient.signIn(
                username = emailAddress,
                password = password
            )
            if (actionResult is SignInResult.Complete) -> {
                // Handle sign in success
                val accountState = actionResult.resultValue
                val accessTokenResult = accountState.getAccessToken()
                if (accessTokenResult is GetAccessTokenResult.Complete) {
                        val accessToken = accessTokenResult.resultValue.accessToken
                        val idToken = accountState.getIdToken()
                    }
            }
        }
    ```
    

    - To start the sign-in flow, use the SDK's `signIn(username)` or `signIn(username, password)` method. 
    - The method's parameter, `username` is then email address you collect from the user.
    - If the sign-in method is username (email) and password, the method's parameter, `password` is then password you collect from the user.
    - In most common scenario, the `signIn(username)` or `signIn(username, password)`returns a result, `SignInResult.CodeRequired`, which indicates that the SDK expects the app to submit the email one-time passcode sent to the user's emails address. 
    - The `SignInResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`. 
    - The new state gives us access to two new methods: 
        - `submitCode()` submits the email one-time passcode that the app collects from the user. 
        - `resendCode()` resends the email one-time passcode if the user doesn't receive the code. 

### Handle sign-in errors

During sign-in, not all actions succeed. For instance, the user might attempt to sign in with an email address that doesn't exist or submit an invalid code. 

#### Handle sign-in start errors

To handle errors in the `signIn(username)` or `signIn(username, password)` method, use the following code snippet: 

   ```Kotlin
   val actionResult = authClient.sign(
       username = emailAddress
       //password = password, Pass 'password' param if you sign in with username (email) and password
   )
   if (actionResult is SignInResult.CodeRequired) {
       // Next step: submit code
   } else if (actionResult is SignInError) {
       // Handle sign in errors
       when {
            actionResult.isUserNotFound() -> {
                // Handle "user not found" error
            }
            actionResult.isAuthNotSupported() -> {
            // Handle "authentication type not support" error
            }
            actionResult.isInvalidCredentials() -> {
                // Handle specific errors
            }
            else -> {
                // Handle other errors
            }
        }
   }
   ```

- `SignInError` indicates an unsuccessful action result returned by `signIn()`, so the action result doesn't include a reference to the new state.
- If `actionResult is SignUpError`, the Android SDK provides utility methods to enable you to analyze the specific errors further:
    - The method `isUserNotFound()` checks whether the user signs in with a username (email address) that doesn't exist.
    - The method `isBrowserRequired()` checks the need for a browser (web fallback), to complete authentication flow. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For examples, an admin configures email and password as the authentication method, but the app fails to send *password* as a challenge type or simply doesn't support it. Use the steps in [Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md) to handle scenario when it happens.
    - The method `isAuthNotSupported()` checks whether the app sends a challenge type that Microsoft Entra doesn't support, that's a challenge type value other than *oob* and *password*. Learn more about [challenge types](concept-native-authentication-challenge-types.md).
    - For username (email) and password sign-in, the method `isInvalidCredentials()` checks whether the combination of username and password is incorrect.

#### Handle submit code errors

To handle errors in `submitCode()` method, use the following code snippet: 

```Kotlin
val submitCodeActionResult = nextState.submitCode(
    code = code
)
if (submitCodeActionResult is SignInResult.Complete) {
    // Sign in flow complete, handle success state.
} else if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
    // Handle "invalid code" error
}
```

- The `SubmitCodeError` error indicates an unsuccessful action result returned by `submitCode()` and so the action result doesn't include a reference to the new state.
- The `isInvalidCode()` checks for the specific error. In this case, the previous state reference must be used to reperform the action. 

To retrieve the new email one-time passcode, use the following code snippet: 

   ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignInError && submitCodeActionResult.isInvalidCode) {
       // Inform the user that the submitted code was incorrect or invalid, then ask them to input a new email one-time passcode
       val newCode = retrieveNewCode()
       nextState.submitCode(
           code = newCode
       )
   }
   ```

You've completed all the necessary steps to successfully sign in a user on your app. Build and run your application. If all good, you should be able to provide an email, receive a code on the email, and use that to successfully sign in user. 

## Read ID token claims

[!INCLUDE [read-od-token-claims](./includes/native-auth/read-id-token-claims-android-kotlin.md)]

## Sign out a user 

To sign out a user, you need to remove the account currently stored in the cache. 

1. Create your custom user interface (UI) that includes: 

   - A sign-out button that user select to send a sign-out request. 

1. To sign out a user, use the following code: 

   ```kotlin
   private fun performSignOut(accountState: AccountState) {
        CoroutineScope(Dispatchers.Main).launch {
           val accountResult = authClient.getCurrentAccount()
            if (accountResult is GetAccountResult.AccountFound) {
                val signOutResult = accountResult.resultValue.signOut()
                if (signOutResult is SignOutResult.Complete) {
                    // Show sign out successful UI
                }
            }
        }
    }
   ```

### Handle sign-out errors 

Sign out should be error-free. If any errors occur, inspect the error result using the following code snippet: 

```kotlin
val actionResult = accountResult.signOut()
if (actionResult is SignOutResult.Complete) {
    // Show sign out successful UI
} else {
    // Handle errors
}
```

Make sure you include the import statements. Android Studio should include the import statements for you automatically. 

You have completed all the necessary steps to successfully sign out a user on your app. Build and run your application. If all good, you should be able to select sign out button to successfully sign out. 

[!INCLUDE [Custom claims provider](../customers/includes/native-auth/support-custom-claims-provider.md)]

## Related content

- [Tutorial: Sign up user with username and user attributes](tutorial-native-authentication-android-sign-up-user-with-username-user-attributes.md). 
- [Configure a custom claims provider](/entra/identity-platform/custom-extension-tokenissuancestart-configuration?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).
- [Add user attributes as token claims](how-to-add-attributes-to-token.md).