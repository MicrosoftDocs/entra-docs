---
title: Sign up user with username and password, and collect user attributes
description: Learn how to sign up user with username, password, and user attributes in an Android mobile app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to sign up user with username, password and user attributes in an Android mobile app by using native authentication.
---

# Tutorial: Sign up user with username and password, and collect user attributes  
 
This tutorial demonstrates how to sign up a user with a username (email address), password, and user attributes. It uses one-time passcode to validate the user's email address.
 
In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Sign up using username, password, and user attributes.  
> - Handle errors.  
 
## Prerequisites  
 
- An Android project. If you don't have an Android project, create it.
- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings. When you create your user flow, make sure you select **Email with password** option in the **Identity providers** section. Under the **User attributes** section, specify the information you want to collect from the user by selecting **Country/Region** and **City**. 
- Complete the steps in [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md). This article shows you how to prepare your Android project or app for native authentication. 

## Update configuration file

[!INCLUDE [update-auth-config-native-auth-file-add-password-challenge-type](./includes/native-auth/update-auth-config-native-auth-file-android-kotlin.md)]
 
## Sign up user using username, password, and user attributes
 
To sign up user using username (email address), password, and user attributes, we verify the user's email address through email OTP. Also, the password that the app collects from the user need to meet [Microsoft Entra's password policies](/entra/identity/authentication/concept-password-ban-bad-combined-policy). 
 
The Android SDK provides a utility class `UserAttribute.Builder` to prepare the user attributes.  

Use these steps to initiate the sign-up flow:
 
1. To include the attributes that you collect from the user, use the Android SDK's utility class, `UserAttribute.Builder` as shown in the following code snippet:  
 
    ```kotlin 
    val userAttributes = UserAttributes.Builder 
        .country(country) 
        .city(city) 
        .build() 
    ``` 
     
    The method names in the `UserAttribute.Builder` class are same as the the programmable names of the user attributes that they build. Learn more about [Android SDK attribute builder](concept-native-authentication-user-attribute-builder.md?tabs=android-kotlin).
        

1. To start the sign-up flow, use the following code snippet: 
 
    ```kotlin 
    CoroutineScope(Dispatchers.Main).launch { 
        val actionResult = authClient.signUp( 
            username = emailAddress, 
            password = password, 
            attributes = userAttributes 
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
     
    - The `signUp()` method takes the user attributes, username (email address) and password as parameters.
    
    - In most common scenario, the `signUp(username,password,attributes)` returns a result, `SignUpResult.CodeRequired`, which indicates that app should submit the email one-time passcode sent to the user's emails address.
    
    - The `SignUpResult.CodeRequired` object contains a new state reference, which we can retrieve through `actionResult.nextState`.
    
    - The new state gives us access to two new methods:
        - `submitCode(code)` submits the email one-time passcode that the app collects from the user.
        - `resendCode()` resends the email one-time passcode if the user doesn't receive the code. 
    
    - The `signUp()` method can also return `SignUpResult.AttributesRequired` to indicate that the app needs to submit one or more required attributes before Microsoft Entra creates an account. These are the attributes that the administrator configured as mandatory in the Microsoft Entra admin center. The `signUp()` method can't return `SignUpResult.AttributesRequired` if the administrator doesn't specify a mandatory user attribute. Microsoft Entra doesn't explicitly request for optional user attributes. 
    
    - The `SignUpResult.AttributesRequired` result contains a `requiredAttributes` parameter. `requiredAttributes` is a list of `RequiredUserAttribute` objects that contains details about the user attributes that the app needs to submit. To handle `actionResult is SignUpResult.AttributesRequired`, use the following code snippet: 

        ```kotlin
        val actionResult = authClient.signUp(
            username = email,
            attributes = attributes
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
 
- If `actionResult is SignUpError`, the Android SDK provides utility methods to enable you analyze the specific errors further: 
    - `isUserAlreadyExists()`
    - `isInvalidAttributes()`
    - `isInvalidPassword()`
    - `isInvalidUsername()`
    - `isBrowserRequired()`
    - `isAuthNotSupported()`

- These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available.

- The utility method `isInvalidAttributes()` indicates that one or more attributes that the app submitted failed validation. It contains an `invalidAttributes` parameter, which is a list of all attributes that the apps submitted, but failed validation. To handle the error of invalid attributes, use the following code snippet:  
 
    ```kotlin 
        val actionResult = authClient.signUp(
            username = email,
            attributes = attributes
        )
        if (actionResult is SignUpError && actionResult.isInvalidAttributes()) {
            val invalidAttributes = actionResult.invalidAttributes
            // Handle "invalid attributes" error
            authClient.signUp(
                username = emailAddress,
                attributes = resubmittedAttributes
            )
        } 
        //...
    ``` 
  
## Next steps  
  
[Tutorial: Sign up user with username and password](tutorial-native-authentication-android-sign-up-user-with-username-password.md) 