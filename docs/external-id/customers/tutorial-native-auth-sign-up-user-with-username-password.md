---
title: Sign up user with username and password
description: Learn how to Sign up user with username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn how to sign up user with username and password.
---

# Tutorial: Sign up user with username and password 
 
This tutorial demonstrates how to sign up a user with a username and password, and use one-time passcode for validation of the user's email address. 
 
In this tutorial, you learn how to: 
 
- Sign up user with username and password. 
- Handle errors. 
 
## Prerequisites 
 
- An Android project. 
- User-flow with an **Email with password**: 
  - [Register application in Microsoft Entra External ID for customers tenant](how-to-run-sample-android-app.md#register-an-application) 
  - [Enable public client and native authentication flows](how-to-run-sample-android-app.md#enable-public-client-and-native-authentication-flows) 
  - [Grant API permissions](how-to-run-sample-android-app.md#grant-api-permissions) 
  - [Create a user flow](how-to-run-sample-android-app.md#create-a-user-flow) 
  - [Associate the Android app with the user flow](how-to-run-sample-android-app.md#associate-the--app-with-the-user-flow) 
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md) 
 
## Sign up user with username and password 
 
To sign up user using username (email address) and password, we need to verify the email through email one-time passcode (OTP). 

The following wire frame shows a high-level view of the sign up user with username and password flow:

:::image type="content" source="media/native-auth/android/signup-email-password.png" alt-text="A mock-up image illustrates registering a user with a username and password.":::
 
We will use the `signUp(username, password)` method, which in most common scenario will respond with `SignUpResult.CodeRequired`, which indicates that the API expects a code to be sent back to verify the email address. 
 
To implement the `signUp(username, password)`, use the following code snippet: 
 
```kotlin 
CoroutineScope(Dispatchers.Main).launch { 
    val actionResult = authClient.signUp( 
        username = emailAddress, 
        password = password 
    ) 
    if (actionResult is SignUpResult.CodeRequired) { 
        // Show "code required" UI 
    } 
} 
``` 
 
The `SignUpCodeRequiredState` state gives us access to two methods: 
 
- `submitCode()` 
- `resendCode()` 
 
To submit the code that the user supplied us with, use: 
 
```kotlin 
val nextState = actionResult.nextState 
nextState.submitCode( 
    code = code 
) 
``` 
 
The `submitCode()` will return `SignUpResult.Complete`, which indicates that the flow is complete and the user has been signed up. 
 
To implement the full flow, use: 
 
```kotlin 
CoroutineScope(Dispatchers.Main).launch { 
    val actionResult = authClient.signUp( 
        username = emailAddress, 
        password = password 
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
 
## Handle errors 
 
The `signUp()` action return results denoted by a dedicated results class `SignUpResult`. These can be of type:
- `SignUpResult.Complete`
- `SignUpResult.CodeRequired`
- `SignUpResult.AttributesRequired`
- `SignUpError`

In the case of `SignUpError`, the SDK provides utility methods  for further analyzing the specific type of error returned:
- `isUserAlreadyExists()`
- `isInvalidAttributes()`
- `isInvalidUsername()`
- `isBrowserRequired()`

Errors such as these indicate that the previous operation was unsuccessful, and because of that they don't include a reference to a new state.

To check the errors such as a user using a registered email, invalid password, or invalid email address, use the following code snippet:
 
```kotlin 
val actionResult = authClient.signUp(
    username = emailAddress
)
if (actionResult is SignUpResult.CodeRequired) {
    // Next step: submit code
} else if (actionResult is SignUpError) {
    when {
            actionResult.isInvalidUsername() || actionResult.isInvalidPassword() || 
            actionResult.isUserAlreadyExists() || actionResult.isAuthNotSupported() || 
            actionResult.isInvalidAttributes() -> {
                // Handle specific errors
            }
            else -> {
                // Handle unexpected error
            }
        }
}
```
 
Use the following code snippet to check for errors when a user is using invalid one-time passcode: 
 
```kotlin 
val submitCodeActionResult = nextState.submitCode( 
    code = code 
) 
if (submitCodeActionResult is SignUpResult.Complete) { 
    // Sign up flow complete, handle success state. 
} else if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) { 
    // Handle "invalid code" error 
} 
``` 
 
When a user enters invalid one-time passcode, you can use the following code snippet to ask the user to enter the correct one-time passcode: 
 
```kotlin 
val submitCodeActionResult = nextState.submitCode( 
    code = code 
) 
if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode) { 
    // Inform the user that the submitted code was incorrect and ask for a new code to be supplied 
    val newCode = retrieveNewCode() 
    nextState.submitCode( 
        code = newCode 
    ) 
} 
``` 
 
## Next Steps 
 
[Tutorial: Sign in user with username and password](tutorial-native-auth-sign-up-user-with-username-password.md)
