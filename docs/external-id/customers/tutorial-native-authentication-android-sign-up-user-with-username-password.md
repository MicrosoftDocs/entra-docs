---
title: Sign up user with username and password
description: Learn how to Sign up user with username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to sign up user with username and password in my Android app by using native authentication
---

# Tutorial: Sign up user with username and password in Android app by using native authentication  
 
This tutorial demonstrates how to sign up a user with a username (email) and password in an Android app by using native authentication. It uses one-time passcode to validate the user's email address.
 
In this tutorial, you learn how to:  
 
> [!div class="checklist"]
>
> - Sign up user with username and password.  
> - Handle errors. 
  
## Prerequisites  
  
- An Android project. If you don't have an Android project, create it.
- Complete the steps in [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings. When you create your user flow, make sure you select **Email with password** option in the **Identity providers** section.
- Complete the steps in [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md). This article shows you how to prepare your Android project or app for native authentication. 

## Update configuration file

[!INCLUDE [update-auth-config-native-auth-file-add-password-challenge-type](./includes/native-auth/update-auth-config-native-auth-file-android-kotlin.md)]
 
 
## Add sign-up with username and password  
 
- To sign up using username (email address) and password, we need to verify the user's email through email OTP. Also, the password that the app collects from the user need to meet [Microsoft Entra's password policies](/entra/identity/authentication/concept-password-ban-bad-combined-policy).
 
- We use the `signUp(username, password)` method, which in the most common scenario returns `SignUpResult.CodeRequired`. This response indicates that Microsoft Entra expects that the app submits the email one-time passcode sent to the user's email address for verification.
 
- To implement the `signUp(username, password)`, use the following code snippet:  
 
    ```kotlin 
    CoroutineScope(Dispatchers.Main).launch { 
        val actionResult = authClient.signUp( 
            username = email, 
            password = password 
        ) 
        if (actionResult is SignUpResult.CodeRequired) { 
            // Show "code required" UI 
        } 
    } 
    ``` 
 
- The `SignUpResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`. The new state gives us access to two new methods:
    - `submitCode()` 
    - `resendCode()` 
 
- To submit the email one-time passcode that the app collected from the user, use the following code snippet:  
 
    ```kotlin 
    val nextState = actionResult.nextState 
    nextState.submitCode( 
        code = code 
    ) 
    ``` 
 
- The `submitCode()` returns `SignUpResult.Complete`, which indicates that the flow is complete and the user has been signed up.  

- The full flow implementation should look similar to the following code snippet
 
    ```kotlin 
    CoroutineScope(Dispatchers.Main).launch { 
        val actionResult = authClient.signUp( 
            username = email, 
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
 
## Handle sign-up errors  
 
If `actionResult is SignUpError`, the SDK provides utility method for further analyzing the specific type of error returned: 

- If `actionResult is SignUpError`, MSAL Android SDK provides utility methods to enable you to analyze the specific errors further: 
    - `isUserAlreadyExists()`
    - `isInvalidPassword()`
    - `isInvalidAttributes()`
    - `isInvalidUsername()`
    - `isBrowserRequired()`
    - `isAuthNotSupported()`

    These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available.

- To handle these errors, use the following code snippet: 
 
    ```kotlin 
    val actionResult = authClient.signUp(
        username = email
        password = password
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

    - `isBrowserRequired()` checks the need for a browser (web fallback), to complete authentication flow. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For examples, an admin configures email and password as the authentication method, but the app fails to send *password* as a challenge type or simply doesn't support it. Use the steps in [Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md) to handle scenario when it happens.
    - `isAuthNotSupported()` checks whether the app sends a challenge type that Microsoft Entra doesn't support, that's a challenge type value other than *oob* or *password*. Learn more about [challenge types](concept-native-authentication-challenge-types.md).
 
- Use the following code snippet to check for errors when a user inputs an invalid email one-time passcode:  
 
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
 
- If a user enters an invalid email one-time passcode, use the following code snippet to ask the user to reenter the correct email one-time passcode:  
 
    ```kotlin 
    val submitCodeActionResult = nextState.submitCode( 
        code = code 
    ) 
    if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) { 
        // Inform the user that the submitted email one-time passcode is incorrect or invalid and ask them to reenter a correct email one-time passcode 
        val newCode = retrieveNewCode() 
        nextState.submitCode( 
            code = newCode 
        ) 
    } 
    ``` 
 
## Next steps  
 
[Tutorial: Sign in user with username and password](tutorial-native-authentication-android-sign-in-user-with-username-password.md) 
