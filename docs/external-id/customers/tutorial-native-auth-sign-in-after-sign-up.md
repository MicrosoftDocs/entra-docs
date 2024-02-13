---
title: Sign in user after sign up
description: Learn how to implement sign in user after sign up.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn how to sign in user after sign up.
---

# Tutorial: Sign in user after sign up 
 
This tutorial demonstrates how to sign in user after sign up. 
 
In this tutorial, you learn how to: 
 
- Sign in after sign up. 
- Handle errors 
 
## Prerequisites 
 
- Reference to SDK doc 
- [Sign in users in a sample native Android mobile application](how-to-run-sample-android-app.md) 
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md) 
 
## Sign in after sign up 
 
This is an advanced version of the sign in flows [earlier described](tutorial-native-auth-sign-in-user-with-username-password.md), which has the added benefit of automatically signing in after successfully signing up. 

The following wire frame shows a high-level view of the sign in after sign up  flow:

:::image type="content" source="media/native-auth/android/android_sign_in_after_sign_up-flow.png" alt-text="A mock-up image illustrates how to sign in user after sign up":::
 
The `SignUpResult.Complete` will return `SignInContinuationState` object. And `SignInContinuationState` provides access to `signIn()` method. 
 
To sign up a user with email and password and then sign them in, you can use the following code snippet: 
 
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
                val accountState = result.resultValue 
            } 
        } 
    } 
} 
``` 
 
## Handle errors

The `SignInContinuationState.signIn()` method can return `SignInResult.Complete` after successfully signing in, or in case of an error.
 
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
        val accessTokenState = accountState.getAccessToken()
        if (accessTokenState is GetAccessTokenResult.Complete) {
            val accessToken = accessTokenState.resultValue.accessToken
            val idToken = accountState.getIdToken()
        }
    }
}
``` 
 
## Next Steps 
 
[Tutorial: Reset password of a user](tutorial-native-auth-self-service-password-reset.md) 
