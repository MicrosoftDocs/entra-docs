---
title: Add sign up with email one-time passcode in Android app
description: Learn how to add sign up with email one-time passcode.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about Add sign up with email one-time passcode.
---

# Tutorial: Add sign up with email one-time passcode in Android app 

This tutorial demonstrates how to sign up a user using email one-time passcode in your native authentication Android app. 

In this tutorial, you learn how to: 

- Sign up a user. 

## Prerequisites
 
- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md) 
 
## Sign up a user

To sign up a user using the **Email one-time passcode** flow, capture the email and send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them up and displays a toast message to notify the user about the operation. 

To sign up user using **Email one-time-passcode**, you need to: 

1. Create your user interface that includes: 

   - A UI to submit an Email.
   - A UI to submit one-time passcode.

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

### Handle errors during sign-up

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid code. 

1. To handle errors in library's `signUp(username)` method, use the following code snippet: 

   ```kotlin
   val actionResult = authClient.signUp(
       username = email
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

   `signUp(username)` can return SignUpError. `SignUpError` indicates an unsuccessful action result returned by `signUp()` and won't include a reference to the new state, while the utility method `isUserAlreadyExists()` checks for the specific error type of `SignUpError`: the username provided has been used. You should notify the user that the email is already in use. 

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

   `submitCode()` can return `SignUpError`. The utility method `isInvalidCode()` checks for the specific error type of `SignUpError`: the submitted code is invalid. In this case, the previous state reference must be used to reperform the action. To retrieve a new one-time passcode, use the following code snippet: 

    ```kotlin
    val submitCodeActionResult = nextState.submitCode(
        code = code
    )
    if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) {
        // Inform the user that the submitted code was incorrect or invalid and ask for a new code to be supplied
        val newCode = retrieveNewCode()
        nextState.submitCode(
            code = newCode
        )
    }
    ```

Don't forget to add the import statements, Android Studio does that for you automatically (on Mac or Windows select Alt + Enter on each error detected by the code editor). 

You've completed all the necessary steps to successfully sign up a user on your app. Build and run your application. If all good, you should be able to provide an email ID, receive a code on the email and use that to successfully sign up user. 

## Next steps 

[Tutorial: Add sign in and sign out with email one-time passcode in Android app](tutorial-native-authentication-android-sign-in-sign-out.md). 
