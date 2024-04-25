---
title: Sign up user with username and user attributes 
description: Learn how to sign up user with username and collect user attributes from the user by using native authentication

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to sign up user with username and collect user attributes from the user by using native authentication.
---

# Tutorial: Sign up user with username and user attributes

This tutorial demonstrates how to sign up a user by using email one-time passcode and collect user attributes in your Android mobile app using native authentication. 

In this tutorial, you learn how to:  
 
> [!div class="checklist"]
> 
> - Sign up with username (email) and user attributes.  
> - Handle errors.  
 
## Prerequisites  
- An Android project. If you don't have an Android project, create it.
- Complete the steps in [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md). When you create the user flow, make sure:
    - You select **Email one-time passcode** as your email account authentication option.
    - You choose **Country/Region** and **City** under **User attributes** section to specify the information you want to collect from the user during sign-up.
 
## Sign up user using username and user attributes  
 
To sign up user using username (email address) and user attributes, we need to verify the email through email one-time passcode.  
 
The MSAL Android SDK provides a utility class `UserAttribute.Builder` to create user attributes.  

Use these steps to initiate the sign-up flow:
 
- To include a user attribute, use the `UserAttribute.Builder` utility class as shown in the following code snippet:  
 
    ```kotlin 
        val userAttributes = UserAttributes.Builder
            .country(country)
            .city(city)
            .build() 
            //... 
    ``` 
     
    The method names in the `UserAttribute.Builder` class are same as the programmable names of the user attributes that they build. Learn more about [Android SDK attribute builder](concept-native-authentication-user-attribute-builder.md?tabs=android-kotlin).

- Use `signUp(username, attributes)` method to start sign-up with username and attributes flow: 
 
    ```kotlin 
        CoroutineScope(Dispatchers.Main).launch {
            val actionResult = authClient.signUp(
                username = emailAddress,
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

- In the most common scenario, `signUp(username, attributes)` method returns `SignUpResult.CodeRequired`, which gives you access to `submitCode()` and `resendCode()` methods. 
    - To complete the sign-up flow, use `submitCode(code)` method to submit the email one-time passcode. 
    - If needed, use the `resendCode()` method to resend the email one-time passcode to the user's email address. 
- `signUp(username, attributes)` method can also return:
    - `SignUpResult.Complete` to denote that  sign-up flow is successful.
    - `SignUpResult.CodeRequired` to denote that the app needs to submit an email one-time passcode.
    - `SignUpResult.AttributesRequired` to indicate that the app needs to submit one or more required attributes before Microsoft Entra creates an account. These attributes were configured by the administrator as mandatory in the Microsoft Entra admin center. Microsoft Entra doesn't explicitly request for optional user attributes.
    - `SignUpError` to denote that an error has occurred. 

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

- If `actionResult is SignUpError`, MSAL Android SDK provides utility methods to enable you to analyze the specific errors further: 

    - `isUserAlreadyExists()`
    - `isInvalidAttributes()`
    - `isInvalidUsername()`
    - `isBrowserRequired()`
    - `isAuthNotSupported()`

- These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available. 
 
- The utility method `isInvalidAttributes()` indicates that one or more attributes that the app submitted failed validation. It contains an `invalidAttributes` parameter,  which is a list of all attributes that teh apps submitted, but failed validation. To handle the error of invalid attributes, use the following code snippet: 
 
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
 
[Tutorial: Sign up user with username, password, and user attributes](tutorial-native-authentication-android-sign-up-user-with-username-password-user-attributes.md). 