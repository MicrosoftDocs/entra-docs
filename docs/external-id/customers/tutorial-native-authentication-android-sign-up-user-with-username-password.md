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
 
This tutorial demonstrates how to sign up a user with a username (email) and password in an Android app by using native authentication. One-time passcode (OTP) is used to validate the user's email address. 
 
In this tutorial, you learn how to:  
 
> [!div class="checklist"]
>
> - Sign up user with username and password.  
> - Handle errors. 
  
## Prerequisites  
  
- Create an Android project.
- Complete the steps in [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings. When you create your user flow, make sure you select **Email with password** option.
- [Tutorial: Add sign in and sign out with email one-time passcode](tutorial-native-authentication-android-sign-in-sign-out.md). This tutorial shows you how to add sign-in to an Android app. 

## Update configuration file

1. Locate, then open `auth_config_native_auth.json`.
1. In the JSON object, locate the `challenge_types` setting, then add *password* challenge type. Your JSON object should look similar to the following:

    ```json
        { 
          "client_id": "Enter_the_Application_Id_Here", 
          "authorities": [ 
            { 
              "type": "CIAM", 
              "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/" 
            } 
          ], 
          "challenge_types": ["oob","password"], 
          "logging": { 
            ...
          } 
        }
    ```

    The challenge types is a list of values, which the app uses to notify Microsoft Entra about the authentication method that it supports. Learn more [challenge types](concept-native-authentication-challenge-types.md).
 
 
## Add sign-up with username and password  
 
- To sign up using username (email address) and password, we need to verify the user's email through email OTP.
 
- We use the `signUp(username, password)` method, which in the most common scenario returns `SignUpResult.CodeRequired`. This response indicates that Microsoft Entra expects that the app submits the OTP code sent to the user's email address for verification.
 
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
 
- To submit the OTP code that the app collected from the user, use the following code snippet:  
 
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
- `isAuthNotSupported()`

Errors such as these indicate that the previous operation was unsuccessful, and because of that they don't include a reference to a new state. 

To check the errors such as a user using a registered email, invalid password, or invalid email address, use the following code snippet: 
 
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
if (submitCodeActionResult is SubmitCodeError && submitCodeActionResult.isInvalidCode()) { 
    // Inform the user that the submitted code was incorrect or invalid and ask for a new code to be supplied 
    val newCode = retrieveNewCode() 
    nextState.submitCode( 
        code = newCode 
    ) 
} 
``` 
 
## Next steps  
 
[Tutorial: Sign in user with username and password](tutorial-native-authentication-android-sign-in-user-with-username-password.md) 
