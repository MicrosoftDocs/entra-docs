---
title: Add sign-up with email one-time passcode in an Android app
description: Learn how to add sign up with email one-time passcode (OTP) in an Android mobile app using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer, devx-track-dotnet

#Customer intent: As a dev, devops, I want to add sign-up with email one-time passcode (OTP) in my Android mobile app using native authentication.
---

# Tutorial: Add sign up with email one-time passcode in Android mobile app

This tutorial demonstrates how to sign up a user using email one-time passcode (OTP) in your Android mobile app using native authentication. 

In this tutorial, you learn how to: 


> [!div class="checklist"]
> 
> - Sign up a user. 

## Prerequisites
 
- Complete the steps in [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md).
 
## Sign up a user

To sign up a user using the email OTP authentication method, collect an email from the user, then send an email containing an OTP code to the user. Once the user enters a valid OTP code, the app completes the signs-up flow.

To sign up a user by using email OTP, you need to: 

1. Create your user interface (UI) that includes: 

   - A UI to collect an email from the user. Add validation to your UI to make sure the user enters a valid emails address.
   - A UI to collect an OTP code from the user.

1. In your app, add a button, whose select event triggers the following code snippet: 

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

    - Use the MSAL SDK's instance  method, `signUp(username)` to start the sign-up flow.
    - The method's parameter, `username` is then email address you collect from the user. 
    - In most common scenario, the `signUp(username)` returns a result, `SignUpResult.CodeRequired`, which indicates that the SDK expects the app to submit the OTP codes sent to the user's emails address.
    - The `SignUpResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`. 
    - The new state gives us access to two new methods: 
        - `submitCode()` submits the OTP code that the app collects from the user. 
        - `resendCode()` re-sends the OTP code if the user doesn't receive the code. 

## Handle errors during sign-up

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid OTP code. 

### Handle sign-up error


To handle errors for the `signUp(username)` method, use the following code snippet: 

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

   - `signUp(username)` can return `SignUpError`. 
   - `SignUpError` indicates an unsuccessful action result returned by `signUp()` and won't include a reference to the new state, while the method `isUserAlreadyExists()` checks for the specific error. 
   - You should notify the user that the email is already in use by using a friendly message in the app's UI. 
   

### Handle submit OTP code error

To handle errors for the  `submitCode()` method, use the following code snippet:

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

   - `submitCode()` can return `SubmitCodeError`. 
   - Use the `isInvalidCode()` method to check for the specific error, such as, the submitted code is invalid. In this case, the previous state reference must be used to reperform the action. 
   - To retrieve a new OTP code, use the following code snippet: 

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

Make sure you include the import statements. Android Studio should include the import statements for you automatically. 

You've completed all the necessary steps to successfully sign up a user into your app. Build and run your application. If all good, you should be able to collect an email from a user, and collect the OTP code that the user receives in their email address and use it to successfully sign up the user. 

## Optional: Sign in after a sign-up flow

After a successful sign-up flow, you can sign-in a user without initiating a sign-in flow. Learn more in the [Tutorial: Sign in user after sign-up in Android](tutorial-native-authentication-android-sign-in-after-sign-up.md) article.


## Next steps 

[Tutorial: Add sign in and sign out with email one-time passcode in Android app](tutorial-native-authentication-android-sign-in-sign-out.md). 