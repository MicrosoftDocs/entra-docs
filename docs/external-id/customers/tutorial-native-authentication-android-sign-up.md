---
title: Add sign-up in an Android app using native authentication
description: Learn how to add sign-up using email one-time passcode or email and password, and collect user attributes in an Android mobile app using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 08/01/2024
ms.custom: developer

#Customer intent: As a dev, devops, I want to add sign-up with email one-time passcode or email and password, and collect user attributes in your Android mobile app using native authentication.
---

# Tutorial: Add sign-up in an Android mobile app using native authentication

This tutorial demonstrates how to sign up a user using email one-time passcode or username (email) and password, and collect user attributes in your Android mobile app using native authentication. 

In this tutorial, you learn how to: 


> [!div class="checklist"]
>
> - Sign up a user by using email one-time passcode or username (email) and password.
> - Collect user attributes during sign-up. 
> - Handle sign-up errors.

## Prerequisites
 
- Complete the steps in [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md) article.
- If you want to collect user attributes during sign-up, configure the user attributes when you [create your sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
 
## Sign up a user

To sign up a user using the email one-time passcode or username (email) and password, you collect an email from the user, then send an email containing an email one-time passcode to the user. The user enters a valid email one-time passcode to validate their username.

To sign up a user, you need to: 

1. Create a user interface (UI) to: 

   - Collect an email from the user. Add validation to your inputs to make sure the user enters a valid emails address.
   - Collect a password if you sign up with username (email) and password.
   - Collect an email one-time passcode from the user.
   - If needed, collect user attributes.
   - Resend one-time passcode (recommended).
   - Start sign-up flow.

1. In your app, add a button, whose select event triggers the following code snippet: 

   ```kotlin
   CoroutineScope(Dispatchers.Main).launch {
       val actionResult = authClient.signUp(
           username = emailAddress
           //password = password, Pass 'password' param if you sign up with username (email) and password
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

    - Use the SDK's instance method, `signUp(username)` to start the sign-up flow.
        - To sign up using username (email address) and password, pass your password parameter to the `signUp` function, `signUp(username, password)`. 
    - The method's parameter, `username`, is then email address you collect from the user. 
    - In most common scenario, the `signUp(username)` or `signUp(username, password)` returns a result, `SignUpResult.CodeRequired`, which indicates that the SDK expects the app to submit the email one-time passcode sent to the user's emails address.
    - The `SignUpResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`. 
    - The new state gives us access to two new methods: 
        - `submitCode()` submits the email one-time passcode that the app collects from the user. 
        - `resendCode()` resends the email one-time passcode if the user doesn't receive the code. 
    - The `submitCode()` returns `SignUpResult.Complete`, which indicates that the flow is complete and the user has been signed up.
    - The `signUp(username)` or `signUp(username, password)` can also return `SignUpError` to denote that an error has occurred. 

### Collect user attributes during sign-up

Whether you sign up a user using email one-time passcode or username (email) and password, you can collect user attributes before a user's account is created:

- The `signUp()` method accepts an `attributes` parameter, as `signUp(username, attributes)`:
    
    ```kotlin
        CoroutineScope(Dispatchers.Main).launch {
            val actionResult = authClient.signUp(
                username = emailAddress,
                attributes = userAttributes
                //password = password, Pass 'password' param if you sign up with username (email) and password
            )
            //...
        }
    ```

- The Android SDK provides a utility class `UserAttribute.Builder` that you use to create user attributes. For example, to submit *city* and *country* user attributes, use the following code snippet to build the `userAttributes` variable: 

    ```kotlin
         val userAttributes = UserAttributes.Builder ()
        .country(country) 
        .city(city) 
        .build()   
    ```
    
    The method names in the `UserAttribute.Builder` class are same as the programmable names of the user attributes that they build. Learn more about [Android SDK attribute builder](concept-native-authentication-user-attribute-builder.md?tabs=android-kotlin).

- The `signUp(username, attributes)` or `signUp(username, attributes, password)`method can return `SignUpResult.AttributesRequired` to indicate that the app needs to submit one or more required attributes before Microsoft Entra creates an account. These attributes are configured by the administrator as mandatory in the Microsoft Entra admin center. Microsoft Entra doesn't explicitly request for optional user attributes. 

- The `SignUpResult.AttributesRequired` result contains a `requiredAttributes` parameter. `requiredAttributes` is a list of `RequiredUserAttribute` objects that contains details about the user attributes that the app needs to submit. To handle `actionResult is SignUpResult.AttributesRequired`, use the following code snippet:

    ```kotlin
    val actionResult = authClient.signUp(
        username = email,
        attributes = attributes
        //password = password, Pass 'password' param if you sign up with username (email) and password
    )
    if (actionResult is SignUpResult.AttributesRequired) {
            val requiredAttributes = actionResult.requiredAttributes 
            // Handle "attributes required" result 
            val nextState = actionResult.nextState
            nextState.submitAttributes(
                attributes = moreAttributes
            )
    }
    ```

## Handle sign-up errors

During sign-up, not all actions succeed. For instance, the user might attempt to sign up with an already used email address or submit an invalid email one-time passcode. 

### Handle start sign-up error


To handle errors for the `signUp()` method, use the following code snippet: 

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

   - `signUp(username, attributes)` or `signUp(username, password, attributes)` can return `SignUpError`. 
   - `SignUpError` indicates an unsuccessful action result returned by `signUp()` and won't include a reference to the new state.
   - If  `actionResult is SignUpError`, MSAL Android SDK provides utility methods to enable you to analyze the specific errors further:
        - The  method `isUserAlreadyExists()` checks whether the username has already been used to create an account.  
        - `isInvalidAttributes()` checks whether one or more attributes that the app submitted failed validation, such as wrong data type. It contains an `invalidAttributes` parameter,  which is a list of all attributes that the apps submitted, but failed validation. 
        - `isInvalidPassword()` check the password is invalid, such as when the password doesn't meet all password complexity requirements. [Learn more about Microsoft Entra's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md)  
        - `isInvalidUsername()` check the username is invalid, such as when the user email is invalid.
        - `isBrowserRequired()` checks the need for a browser (web fallback), to complete authentication flow. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For examples, an admin configures email and password as the authentication method, but the app fails to send *password* as a challenge type or simply doesn't support it. Use the steps in [Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md) to handle scenario when it happens.
        - `isAuthNotSupported()` checks whether the app sends a challenge type that Microsoft Entra doesn't support, that's a challenge type value other than *oob* or *password*. Learn more about [challenge types](concept-native-authentication-challenge-types.md).
   
        Notify the user that the email is already in use or some attributes are invalid by using a friendly message in the app's UI. 
  
- To handle the error of invalid attributes, use the following code snippet:

    ```kotlin 
    val actionResult = authClient.signUp(
        username = email,
        attributes = attributes
        //password = password, Pass 'password' param if you sign up with username (email) and password
    )
    if (actionResult is SignUpError && actionResult.isInvalidAttributes()) {
        val invalidAttributes = actionResult.invalidAttributes
        // Handle "invalid attributes" error, this time submit valid attributes
        authClient.signUp(
            username = emailAddress,
            attributes = resubmittedAttributes
            //password = password, Pass 'password' param if you sign up with username (email) and password
        )
    } 
    //...
    ``` 

### Handle submit email one-time passcode error

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
   - To retrieve a new email one-time passcode, use the following code snippet: 

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

You've completed all the necessary steps to successfully sign up a user into your app. Build and run your application. If all good, you should be able to successfully sign up the user by using email one-time passcode or email and password. 

## Optional: Sign in after a sign-up flow

After a successful sign-up flow, you can sign-in a user without initiating a sign-in flow. Learn more in the [Tutorial: Sign in user after sign-up in Android](tutorial-native-authentication-android-sign-in-after-sign-up.md) article.


## Next steps 

[Tutorial: Add sign in and sign out with email one-time passcode in Android app](tutorial-native-authentication-android-sign-in-sign-out.md). 