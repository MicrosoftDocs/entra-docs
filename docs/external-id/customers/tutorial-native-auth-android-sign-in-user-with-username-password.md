---
title: Sign in user with username and password
description: Learn how to sign in user with username and password.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
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
- User-flow with an **Email with password**:
  - [Register application in Microsoft Entra External ID for customers tenant](how-to-run-sample-android-app.md#register-an-application).
  - [Enable public client and native authentication flows](how-to-run-sample-android-app.md#enable-public-client-and-native-authentication-flows).
  - [Grant API permissions](how-to-run-sample-android-app.md#grant-api-permissions).
  - [Create a user flow](how-to-run-sample-android-app.md#create-a-user-flow).
  - [Associate the Android app with the user flow](how-to-run-sample-android-app.md#associate-the--app-with-the-user-flow).
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md).

## Sign in user with username and password

The following wire frame shows a high-level view of the sign in user with username and password flow:

:::image type="content" source="media/native-auth/android/signin-email-password.png" alt-text="A mock-up image illustrates sign in a user with a username and password.":::

To sign in the sign user using username and password, use the following code snippet:

```kotlin
CoroutineScope(Dispatchers.Main).launch {
    val actionResult = authClient.signIn(
        username = emailAddress,
        password = password
    )
    if (submitCodeActionResult is SignInResult.Complete) -> {
        // Handle sign in success
        val accountResult = result.resultValue
        val accessToken = accountResult.getTokens().getAccessToken()
    }
}
```

In most common scenario `signIn(username, password)` returns `SignInResult.Complete`, which indicates that the flow is complete and the user has been signed in. This object contains a reference to the `AccountState`, accessible through the resultValue field. `AccountState` can be used to retrieve account details and access tokens.

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
    val accessToken = accountResult.getTokens().getAccessToken()
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

## Next Steps

[Tutorial: Sign in user after sign up](tutorial-native-auth-sign-in-after-sign-up.md)