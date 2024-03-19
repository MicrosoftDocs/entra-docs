---
title: Native authentication MSAL mobile SDK attribute builder
description: Learn how to use native authentication MSAL mobile SDK attribute builder for built-in and custom attributes 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn how to use native authentication MSAL Android and iOS SDK attribute builder to build attribute variables for both built-in and custom attributes, so that I can use them in my app.
---

# Native authentication MSAL mobile SDK attribute builder

In native authentication, the information you collect from the user during sign-up is configured in the user flow in the Microsoft Entra admin center. The name of the user attribute as it appears in the Microsoft Entra admin center is different from the variable name that you use when you reference it in your app. 

Fortunately, the MSAL mobile SDK enables you to build the user attributes and assign values to them.

## Build user attributes

To build user attributes in the Android MSAL SDK, use the utility class `UserAttribute.Builder` that the SDK provides. The `UserAttributes.Builder` class contains methods whose parameter is the value that you collect from the user.

Determine the user attributes that you want to build, then use the following code snippet to build them:

```Kotlin
    //built the user attributes, both built-in and custom attributes
    val userAttributes = UserAttributes.Builder
        .country(country)
        .city(city)
        .displayName(displayName)
        .givenName(givenName)
        .jobTitle(jobTitle)
        .postalCode(postalCode)
        .state(state)
        .streetAddress(streetAddress)
        .surname(surname)
        .build() 
        
    CoroutineScope(Dispatchers.Main).launch {
        //use the userAttributes variable in your signUp method 
        val actionResult = authClient.signUp(
            username = emailAddress,
            attributes = userAttributes
        )
    }  
```

To build [custom attributes](concept-user-attributes.md#custom-user-attributes), use `UserAttribute.Builder` class's `customAttribute()` method. The method accepts the custom attributes programmable name, and the value of the attribute:

 ```kotlin
    val userAttributes = UserAttributes.Builder
        .customAttribute("loyaltyNumber", loyaltyNumber)
        .build() 

    CoroutineScope(Dispatchers.Main).launch {
        //use the userAttributes variable in your signUp method 
        val actionResult = authClient.signUp(
            username = emailAddress,
            attributes = userAttributes
        )
    }  
 ```

To learn more about the programmable names of user profile attributes, see the [User profile attributes](concept-user-attributes.md) article.


## Related content

- [Native authentication challenge types](concept-native-authentication-challenge-types.md).
- [iOS native authentication tutorials](tutorial-native-authentication-prepare-ios-app.md).
- [Android native authentication tutorials](tutorial-native-authentication-prepare-android-app.md).
 