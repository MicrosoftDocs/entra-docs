---
title: Sign in user automatically after sign-up in Android by using native authentication
description: Learn how to automatically sign-in a user after sign-up in an Android app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 03/20/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to automatically sign in user after a sign-up flow by using native authentication so that I don't start a fresh sign-in flow.
---

# Tutorial: Sign in user automatically after sign-up in an Android app
 
This tutorial demonstrates how to sign in user automatically after sign-up in an Android app by using native authentication. 
 
In this tutorial, you learn how to:  

> [!div class="checklist"]
>
> - Sign in after sign-up. 
> - Handle errors. 
 
## Prerequisites  
 
- Complete the steps [Sign in users in a sample native Android mobile application](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings.  
- [Tutorial: Add sign-up in an Android mobile app using native authentication](tutorial-native-authentication-android-sign-up.md). The steps in this tutorial should work whether you sign up with email and password or email one-time passcode.
 
## Sign in after sign-up
 
After a successful sign-up flow, you can automatically sign in your users without initiating a fresh sign-in flow. 
 
The `SignUpResult.Complete` returns `SignInContinuationState` object. The `SignInContinuationState` object provides access to `signIn()` method.  
 
To sign up a user with email and password, then automatically sign them in, use the following code snippet:  
 
```kotlin 
CoroutineScope(Dispatchers.Main).launch { 
    val signUpActionResult = authClient.signUp( 
        username = emailAddress, 
        password = password 
    ) 
    if (SignUpActionResult is SignUpResult.CodeRequired) { 
        val nextState = signUpActionResult.nextState 
        val submitCodeActionResult = nextState.submitCode( 
            code = code 
        ) 
        if (submitCodeActionResult is SignUpResult.Complete) { 
            // Handle sign up success 
            val signInContinuationState = actionResult.nextState 
            val signInActionResult = signInContinuationState.signIn() 
            if (signInActionResult is SignInResult.Complete) { 
                // Handle sign in success
                val accountState = signInActionResult.resultValue
                val accessTokenResult = accountState.getAccessToken()
                if (accessTokenResult is GetAccessTokenResult.Complete) {
                    val accessToken = accessTokenResult.resultValue.accessToken
                    val idToken = accountState.getIdToken()
                }
            } 
        } 
    } 
}
``` 

To retrieve ID token claims after sign-in, use the steps in [Read ID token claims](tutorial-native-authentication-android-sign-in-user-with-username-password.md#read-id-token-claims).
 
## Handle sign-in errors 

The `SignInContinuationState.signIn()` method returns `SignInResult.Complete` after a successful sign-in. It can also return an error. 
 
To handle errors in `SignInContinuationState.signIn()`, use the following code snippet:  
 
```kotlin 
val signInContinuationState = actionResult.nextState 
val signInActionResult = signInContinuationState.signIn() 

when (signInActionResult) {
    is SignInResult.Complete -> {
        // Handle sign in success
         displayAccount(accountState = actionResult.resultValue)
    }
    is SignInContinuationError -> {
        // Handle unexpected error
    }
    else -> {
        // Handle unexpected error
    }
}

private fun displayAccount(accountState: AccountState) {
    CoroutineScope(Dispatchers.Main).launch {
        val accessTokenResult = accountState.getAccessToken()
        if (accessTokenResult is GetAccessTokenResult.Complete) {
            val accessToken = accessTokenResult.resultValue.accessToken
            val idToken = accountState.getIdToken()
        }
    }
}
``` 
 
## Next steps

- [Tutorial: Self-service password reset](tutorial-native-authentication-android-self-service-password-reset.md)