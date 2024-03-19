---
title: Sign in user with username and password in Android
description: Learn how to sign in user with username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to Sign in user with username and password.
---

# Tutorial: Sign in user with username and password 

This tutorial demonstrates how to sign in a user with a username and password, and uses one-time passcode for validation of the user's email address. 

In this tutorial, you learn how to: 

- Sign in user with username and password. 
- Handle errors. 

## Prerequisites 

- An Android project.
- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). Ensure that when creating the user flow, you select **Email with password**.
- [Tutorial: Add sign in and sign out with email one-time passcode](tutorial-native-authentication-android-sign-in-sign-out.md). 

## Sign in user with username and password 

To sign in the sign user using username and password, use the following code snippet: 

```kotlin
CoroutineScope(Dispatchers.Main).launch {
    val actionResult = authClient.signIn(
        username = emailAddress,
        password = password
    )
    if (actionResult is SignInResult.Complete) -> {
        // Handle sign in success
        val accountState = result.resultValue
        val accessTokenResult = accountState.getAccessToken()
        if (accessTokenResult is GetAccessTokenResult.Complete) {
                val accessToken = accessTokenResult.resultValue.accessToken
            }
    }
}
```

In most common scenario `signIn(username, password)` returns `SignInResult.Complete`, which indicates that the flow is complete and the user has been signed in. This object contains a reference to the `AccountState`, accessible through the `resultValue` field. `AccountState` can be used to retrieve account details and access tokens. 

## Handle errors 

The `signIn()` action return results denoted by a dedicated results class `SignInResult`. These can be of type: 
- `SigInResult.Complete`
- `SignInResult.CodeRequired`
- `SignInError`

In the case of `SignInError`, the SDK provides utility methods  for further analyzing the specific type of error returned: 
- `isInvalidCredentials()`
- `isUserNotFound()`
- `isBrowserRequired()`

Errors such as these indicate that the previous operation was unsuccessful, and because of that they don't include a reference to a new state. 

To check the errors such as a user using invalid credentials or unregistered username, use the following code snippet: 

```kotlin
val actionResult = authClient.signIn(
    username = emailAddress,
    password = password
)
if (actionResult is SignInResult.Complete) -> {
    // Handle sign in success
    val accountResult = result.resultValue
} else if (actionResult is SignInError) {
    when {
            actionResult.isInvalidCredentials() ||  actionResult.isUserNotFound() -> {
                // Handle specific errors
            }
            else -> {
                // Handle unexpected error
            }
        }
}
```

## Next steps 

[Tutorial: Sign in user after sign-up in Android](tutorial-native-authentication-android-sign-in-after-sign-up.md) 