---
title: Sign in user with username and password in Android
description: Learn how to sign in user with username and password in an Android app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to sign in user with username and password in an Android app by using native authentication.
---

# Tutorial: Sign in user with username and password

This tutorial demonstrates how to sign in a user with a username and password in an Android app by using native authentication.

In this tutorial, you learn how to: 

> [!div class="checklist"]
>
> - Sign in user with username and password. 
> - Handle errors. 

## Prerequisites 

- An Android project. If you don't have an Android project, create it.
- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings. When you create your user flow, make sure you select **Email with password** option in the **Identity providers** section.
- Complete the steps in [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md). This article shows you how to prepare your Android project or app for native authentication. 

## Update configuration file

[!INCLUDE [update-auth-config-native-auth-file-add-password-challenge-type](./includes/native-auth/update-auth-config-native-auth-file-android-kotlin.md)]


## Sign in user with username and password 

To sign in the sign user using username and password, use the `signIn(username, password)` method as shown in the following code snippet: 

```kotlin
CoroutineScope(Dispatchers.Main).launch {
    val actionResult = authClient.signIn(
        username = emailAddress,
        password = password
    )
    if (actionResult is SignInResult.Complete) -> {
        // Handle sign in success
        val accountState = actionResult.resultValue
        val accessTokenResult = accountState.getAccessToken()
        if (accessTokenResult is GetAccessTokenResult.Complete) {
                val accessToken = accessTokenResult.resultValue.accessToken
                val idToken = accountState.getIdToken()
            }
    }
}
```

- In most common scenario `signIn(username, password)` returns `SignInResult.Complete`, which indicates that the flow is complete and the user has been signed in. 
- This object contains a reference to the `AccountState`, accessible through the `resultValue` field. You can use `AccountState` to retrieve security tokens. 

## Read ID token claims

[!INCLUDE [read-od-token-claims](./includes/native-auth/read-id-token-claims-android-kotlin.md)]

## Handle sign-in errors 

- The `signIn()` action return results denoted by a dedicated results class `SignInResult`. These can be of type: 
    - `SigInResult.Complete`
    - `SignInResult.CodeRequired`
    - `SignInError`

- If `actionResult is SignUpError`, Android SDK provides utility methods to enable you to analyze the specific errors further: 
    - `isInvalidCredentials()`
    - `isUserNotFound()`
    - `isBrowserRequired()`

- These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available.

- To handle the errors such as for invalid credentials or unregistered username, use the following code snippet: 

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

## Sign out a user

Sign out for users who sign in using username (email address) and password is similar to when users sign in using email one-time passcode. 

Use the steps in [Sign out a user](tutorial-native-authentication-android-sign-in-sign-out.md#sign-out-a-user) article to sign out a user.

## Next steps 

- [Sign in user after sign-up in Android](tutorial-native-authentication-android-sign-in-after-sign-up.md).
- [Add user attributes to token claims](how-to-add-attributes-to-token.md).