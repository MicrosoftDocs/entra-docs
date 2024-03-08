---
title: Add sign in and sign out in native Android app
description: Learn how to add sign in and sign out with email one-time passcode in Android app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about add sign in and sign out with email one-time passcode.
---

# Tutorial: Add sign in and sign out with email one-time passcode in Android app

This tutorial demonstrates how to sign in and sign out a user using email one-time passcode in your native authentication Android app. 

In this tutorial, you learn how to: 

- Sign in a user. 
- Sign out a user. 

## Prerequisites

- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-android-sign-up.md) 


## Sign in a user

To sign in a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in. 

To sign in user using **Email one-time-passcode** you need to: 

1. Create your user interface that includes: 

   - A UI to submit an Email.
   - A UI to submit one-time passcode.

1. To sign in the user, we're going to use the library's `signIn(username)` method, the function will return a result that you can assign to the `actionResult` field. The `actionResult` represents the result of the previously performed action and can take multiple states (forms). Add a button to the application that calls the following code snippet when selected: 

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

    > [!NOTE]
    > You should add user inputs to your app to collect user email and one time passcode. 

   In the library's `signIn(username)` method, we pass in the email address that user supplied us in the email submit form. In most common scenario, the `actionResult` is of type `SignInResult.CodeRequired`, which indicates that the API expects a code to be sent, in this case to verify the email address. The `SignInResult.CodeRequired` contains a new state reference, which we can retrieve through `actionResult.nextState`. This new state is of type `SignInCodeRequiredState`, which gives us access to two new methods: 

   - `submitCode()` is used to submit the code that user supplies in the form to submit one-time passcode. 
   - `resendCode()` is used to resend the one-time passcode if the user doesn't receive the code. 

### Handle errors during sign in 

During sign-in, not all actions succeed. For instance, the user might attempt to sign in with an email address that doesn't exist or submit an invalid code. 

1. To handle errors in library's `signIn(username)` method, use the following code snippet: 

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

    `SignInError` indicates an unsuccessful action result returned by `signIn()` and won't include a reference to the new state, while the utility method `isUserNotFound()` checks for the specific error type of `SignInError`: the user used an email address that doesn't exist. 

2. To handle errors in `submitCode()`, use the following code snippet: 

    ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignInResult.Complete) {
       // Sign in flow complete, handle success state.
   } else if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
       // Handle "invalid code" error
   }
   ```

    The `SubmitCodeError` error indicates an unsuccessful action result returned by `submitCode()` and won't include a reference to the new state, while the utility method `isInvalidCode()` checks for the specific error type of `SubmitCodeError`. In this case, the previous state reference must be used to reperform the action. To retrieve a new one-time passcode, use the following code snippet: 

   ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignInError && submitCodeActionResult.isInvalidCode) {
       // Inform the user that the submitted code was incorrect or invalid and ask for a new code to be supplied
       val newCode = retrieveNewCode()
       nextState.submitCode(
           code = newCode
       )
   }
   ```

You've completed all the necessary steps to successfully sign in a user on your app. Build and run your application. If all good, you should be able to provide an email ID, receive a code on the email and use that to successfully sign in user. 

## Sign out a user 

To sign out a user using the **Email one-time passcode** flow, you need to have a `Sign out` button, which a user can select to remove the currently stored account from the cache. The user will sign out only from the local app.

To sign out user using **Email one-time-passcode** you need to: 

1. Create your custom user interface that includes: 

   - A `Sign out` button that user select to send logout request. 

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

Don't forget to add the import statements, Android Studio does that for you automatically (on Mac select Alt + Enter on each error detected by the code editor). 

You have completed all the necessary steps to successfully sign out a user on your app. Build and run your application. If all good, you should be able to select sign out button to successfully sign out. 

## Next steps

[Tutorial: Sign up user with username and user attributes](tutorial-native-authentication-android-sign-up-user-with-username-user-attributes.md). 
