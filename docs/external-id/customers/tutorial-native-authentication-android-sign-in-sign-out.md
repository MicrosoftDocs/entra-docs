---
title: Add sign-in with email one-time passcode in Android app by using native authentication
description: Learn how to add sign-in and sign-out with email one-time passcode in Android app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to add sign-in and sign-out in an Android mobile app with email one-time passcode by using native authentication
---

# Tutorial: Add sign-in with email one-time passcode in Android app by using native authentication

This tutorial demonstrates how to sign-in and sign-out a user using email one-time passcode (OTP) in your Android mobile app by using native authentication. 

In this tutorial, you learn how to: 

> [!div class="checklist"]
> 
> - Sign in a user. 
> - Sign out a user.

## Prerequisites

- Complete the steps in [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-android-sign-up.md) 

## Sign in a user

To sign in a user using the email and OTP code authentication method, collect the email and send an email containing a OTP code for the user to verify their email. When the user enters a valid OTP code, the app signs them in. 

To sign in user using email and OTP code you need to: 

1. Create your user interface (UI) that includes: 

   - A UI to collect an email address. Add validation to your UI to make sure the user enters a valid emails address.
   - A UI to collect OTP code.

1. In your app, add a button, whose select event triggers the following code snippet: 

   ```kotlin
    CoroutineScope(Dispatchers.Main).launch {
        val actionResult = authClient.signIn(
            username = emailAddress
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

    - Use the MSAL SDK's `signIn(username)` method to start the sign-in flow. 
    - The method's parameter, `username` is then email address you collect from the user.
    -  In most common scenario, the `signIn(username)` returns a result, `SignInResult.CodeRequired`, which indicates that the SDK expects the app to submit the OTP code sent to the user's emails address.
    -  The `SignInResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`. 
    - The new state gives us access to two new methods: 
        - `submitCode()` submits the OTP code that the app collects from the user. 
        - `resendCode()` re-sends the OTP code if the user doesn't receive the code. 

### Handle errors during sign-in flow 

During sign-in, not all actions succeed. For instance, the user might attempt to sign in with an email address that doesn't exist or submit an invalid code. 

#### Handle sign-in errors

To handle errors in the `signIn(username)` method, use the following code snippet: 

   ```Kotlin
   val actionResult = authClient.sign(
       username = emailAddress
   )
   if (actionResult is SignInResult.CodeRequired) {
       // Next step: submit code
   } else if (actionResult is SignInError) {
       // Handle sign in errors
       when {
            actionResult.isUserNotFound() -> {
                // Handle "user not found" error
            }
            else -> {
                // Handle other errors
            }
        }
   }
   ```

- `SignInError` indicates an unsuccessful action result returned by `signIn()` and so the action result won't include a reference to the new state
- The method `isUserNotFound()` checks for the specific error, such as, the user used an email address that doesn't exist. 

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

- The `SubmitCodeError` error indicates an unsuccessful action result returned by `submitCode()` and so the action result won't include a reference to the new state.
- The `isInvalidCode()` checks for the specific error. In this case, the previous state reference must be used to reperform the action. 

To retrieve the new OTP code, use the following code snippet: 

   ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignInError && submitCodeActionResult.isInvalidCode) {
       // Inform the user that the submitted code was incorrect or invalid, then ask them to input a new OTP code
       val newCode = retrieveNewCode()
       nextState.submitCode(
           code = newCode
       )
   }
   ```

You've completed all the necessary steps to successfully sign in a user on your app. Build and run your application. If all good, you should be able to provide an email, receive a code on the email and use that to successfully sign in user. 

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

### Handle errors during sign out 

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

## Next steps

[Tutorial: Sign up user with username and user attributes](tutorial-native-authentication-android-sign-up-user-with-username-user-attributes.md). 