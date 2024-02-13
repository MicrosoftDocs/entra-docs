---
title: Sign up user with username and user attributes
description: Learn how to sign up user with username and user attributes.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about sign up user with username and user attributes.
---

# Tutorial: Sign up user with username and user attributes 
 
This tutorial aims to demonstrate how to sign up a user with a username and user attributes (**City and Country/Region**), and use one-time passcode for validation of the user's email address. 
 
In this tutorial, you learn how to: 
 
- Sign up using username and attributes. 
- Handle errors. 
 
## Prerequisites 
 
- An Android project. 
- User-flow with an **Email one-time passcode**: 
  - [Register application in Microsoft Entra External ID for customers tenant](how-to-run-sample-android-app.md#register-an-application) 
  - [Enable public client and native authentication flows](how-to-run-sample-android-app.md#enable-public-client-and-native-authentication-flows) 
  - [Grant API permissions](how-to-run-sample-android-app.md#grant-api-permissions) 
  - [Create a user flow](how-to-run-sample-android-app.md#create-a-user-flow) 
    - In the **User attributes**, select **Country/Region** and **City** in the user flow. 
  - [Associate the Android app with the user flow](how-to-run-sample-android-app.md#associate-the--app-with-the-user-flow). 
- [Android Microsoft Authentication Library (MSAL) configuration file](how-to-run-sample-android-app.md#configure-the-sample-android-mobile-application). 
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md). 
 
## Sign up user using username and user attributes 
 
To sign up user using username (email address) and user attributes, we need to verify the email through email one-time passcode (OTP). 
 
The MSAL Android SDK provides a utility class `UserAttribute.Builder` to create user attributes. 
 
To include a user attribute, use the `UserAttribute.Builder` utility class as shown in the following code snippet: 
 
```kotlin 
    val userAttributes = UserAttributes.Builder
        .country(country)
        .city(city)
        .build() 
        
    CoroutineScope(Dispatchers.Main).launch {
        val actionResult = authClient.signUp(
            username = emailAddress,
            attributes = userAttributes
        )
    }  
``` 
 
In the most common scenario `signUp()` will return `SignUpResult.CodeRequired`, which will provide access to `submitCode()` and `resendCode()`. To complete the flow, you can use `submitCode()` to submit the OTP using the following code snippet: 
 
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
 
## Handle errors 

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

Errors such as these indicate that the previous operation was unsuccessful, and because of that they don't include a reference to a new state.
 
The utility method `isInvalidAttributes()` returns true when one or more attributes that were sent failed input validation. It will contain an `invalidAttributes` parameter which is a list of all attributes that were sent by the developer that failed input validation. 
 
The result `SignUpResult.AttributesRequired` indicates that the server requires one or more attributes to be sent, before the user account can be created. This happens when one or more attributes is set as mandatory in the tenant configuration. This result will contain a `requiredAttributes` parameter which is a list of `RequiredUserAttribute` objects, which outline details about the user attributes that the API requires. 
 
To handle `isInvalidAttributes()` and `AttributesRequired`, use the following code snippet: 
 
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
    } else if (actionResult is SignUpResult.AttributesRequired) {
        val requiredAttributes = actionResult.requiredAttributes 
        // Handle "attributes required" result 
        val nextState = actionResult.nextState
        nextState.submitAttributes(
            attributes = moreAttributes
        )
    }
``` 
 
## Next Steps 
 
Tutorial: Sign up user with username, password and user attributes

