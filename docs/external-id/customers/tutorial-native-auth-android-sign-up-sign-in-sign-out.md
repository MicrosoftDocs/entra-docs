---
title: Add sign up, sign in and sign out in native iOS app
description: Learn how to add sign-up, sign in and sign out with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about Add sign up, sign in and sign out with email one-time passcode.
---

# Tutorial: Add sign up, sign in and sign out with email one-time passcode

This tutorial demonstrates how to sign up, sign in and sign out a user using email one-time passcode (OTP) in your native auth Android app.

In this tutorial, you learn how to:

- Sign up a user.
- Sign in a user.
- Sign out a user.

## Prerequisites

- [Tutorial: Prepare your Android app for native authentication](tutorial-native-auth-prepare-android-app.md)

## Sign up a user

To sign up a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them up and displays a toast message to notify the user about the operation.

To sign up user using **Email one-time-passcode**, you need to:

1. Create your user interface that includes:

   1. A form to submit an Email.
   1. A form to submit one-time passcode.

1. To sign up the user, we're going to use the library's `signUp(username)` method, which is going to return a result that can be interpreted as an `actionResult`. Add a button to the application that calls the following code snippet when selected:

   ```kotlin
   CoroutineScope(Dispatchers.Main).launch {
       val actionResult = authClient.signUp(
           username = emailAddress
       )
       if (actionResult is SignUpResult.CodeRequired) {
           val nextState = actionResult.nextState
           val submitCodeActionResult = nextState.submitCode(
               code = code
           )
           if (submitCodeActionResult is SignUpResult.Complete) {
               // Handle sign up success
           }
       }
   }
   ```

    > [!NOTE]
    > You should add user inputs to your app to collect user email and one time passcode.

   In the library's `signUp(username)` method, we pass in the email address that user supplied us in the email submit form. In most common scenario, the `actionResult` is of type `SignUpResult.CodeRequired`, which indicates that the API expects a code to be sent, in this case to verify the email address. The `SignUpResult.CodeRequired` contains a new state reference, which we can retrieve through `actionResult.nextState`. This new state is of type `SignUpCodeRequiredState`, which gives us access to two new methods:

   - `submitCode()` is used to submit the code that user supplies in the form to submit one-time passcode.
   - `resendCode()` is used to resend the one-time passcode if the user doesn't receive the code.

### Handle errors during sign up

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid code.

1. To handle errors in library's `signUp(username)` method, use the following code snippet:

   ```kotlin
   val actionResult = authClient.signUp(
       username = emailAddress
   )
   if (actionResult is SignUpResult.CodeRequired) {
       // Next step: submit code
   } else if (actionResult is SignUpError) {
        when {
            actionResult.isUserAlreadyExists() -> {
                // Handle "user already exists" error
            }
            else -> {
                // Handle other errors
            }
        }
   }
   ```

   `signUp(username)` can return SignUpError. We have provided utility methods to determine the type of error, such as `isUserAlreadyExists()`. Errors of this kind indicate an unsuccessful action and won't include a reference to the new state. You should notify the user that the email is already in use.

1. To handle errors in `submitCode()`, use the following code snippet:

   ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignUpResult.Complete) {
       // Sign up flow complete, handle success state.
   } else if (submitCodeActionResult is SubmitCodeError) {
       // Handle errors under SubmitCodeError
        when {
            submitCodeActionResult.isInvalidCode() -> {
                // Handle "code invalid" error
            }
            else -> {
                // Handle other errors
            }
        }
   }
   ```

   `submitCode()` can return `SignUpError`. We have provided utility methods to determine the type of error, such as `isInvalidCode()`. Errors of this kind indicate an unsuccessful action and won't include a reference to the new state. In this case, the previous state reference must be used to reperform the action. To retrieve a new one-time passcode, use the following code snippet:

    ```kotlin
    val submitCodeActionResult = nextState.submitCode(
        code = code
    )
    if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
        // Inform the user that the submitted code was incorrect and ask for a new code to be supplied
        val newCode = retrieveNewCode()
        nextState.submitCode(
            code = newCode
        )
    }
    ```

Don't forget to add the import statements, Android Studio does that for you automatically (on Mac select on Alt + Enter on each error detected by the code editor).

You have successfully completed all the necessary steps to sign up a user on your app. Build and run your application. If all good, you should be able to provide an email ID, receive a code on the email, and use that to successfully sign up user.

## Sign in a user

To sign in a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in.

To sign in user using **Email one-time-passcode**, you need to:

1. Create your user interface that includes:

   1. A form to submit an Email.
   1. A form to submit one-time passcode.
   1. A page to display the account details.

1. To sign in the user, we are going to use the library's `signIn(username)` method, which is going to return a result that can be interpreted as an `actionResult`. Add a button to the application that calls the following code snippet when selected:

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
           if (submitCodeActionResult is SignInResult.Complete) -> {
               // Handle sign in success
               val accountResult = result.resultValue
               val accessToken = accountResult.getTokens().getAccessToken()
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
       // Handle "invalid code" situation
   }
   ```

  The `SubmitCodeError` error indicates an unsuccessful action result returned by `submitCode()` and won't include a reference to the new state, while the utility method `isInvalidCode()` checks for the specific error type of `SubmitCodeError`. In this case, the previous state reference must be used to reperform the action. To retrieve a new one-time passcode, use the following code snippet:

   ```kotlin
   val submitCodeActionResult = nextState.submitCode(
       code = code
   )
   if (submitCodeActionResult is SignInError && submitCodeActionResult.isInvalidCode) {
       // Inform the user that the submitted code was incorrect and ask for a new code to be supplied
       val newCode = retrieveNewCode()
       nextState.submitCode(
           code = newCode
       )
   }
   ```

You have completed all the necessary steps to successfully sign in a user on your app. Build and run your application. If everything is working properly, you should be able to input an email ID, receive a code via email, and use that to sign in the user successfully.

## Sign out a user

To sign out a user using the **Email one-time passcode** flow, you need to have a `Sign out` button, which a user can select to remove the currently stored account from the cache. The user will only be signed out of the local app, not from any other app they're logged in to.

To sign out user using **Email one-time-passcode** you need to:

1. Create your custom user interface that includes:

   - A `Sign out` button that user select to send logout request.

1. To sign out a user, use the following code:

   ```kotlin
   private fun getAccountState() {
       CoroutineScope(Dispatchers.Main).launch {
            val accountResult = authClient.getCurrentAccount()
            when (accountResult) {
                is GetAccountResult.AccountFound -> {
                    displaySignedInState(accountResult.resultValue)
                }
                is GetAccountResult.NoAccountFound -> {
                    displaySignedOutState(accountResult)
                }
            }
        }
   }

   private fun displaySignedInState(accountState: AccountState) {
       signOutButton.setOnClickListener {
           performSignOut(accountState)
       }
   }

   private fun performSignOut(accountState: AccountState) {
        CoroutineScope(Dispatchers.Main).launch {
                val signOutResult = accountState.resultValue.signOut()
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

Don't forget to add the import statements, Android Studio does that for you automatically (on Mac select on Alt + Enter on each error detected by the code editor).

Well, you have done everything that is required to successfully sign out a user on your app. Build and run your application. If all good, you should be able to select sign out button to successfully sign out.

## Next Steps

[Tutorial: Sign up user with username and user attributes](tutorial-native-auth-sign-up-user-with-username-user-attributes.md).
