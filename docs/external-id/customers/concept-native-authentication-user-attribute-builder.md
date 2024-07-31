---
title: Native authentication SDK attribute builder
description: Learn how to use native authentication SDK attribute builder for built-in and custom attributes. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: concept-article
ms.date: 05/11/2024

#Customer intent: As a dev, devops, I want to learn how to use native authentication SDK attribute builder to build attribute variables for both built-in and custom attributes, so that I can use them in my app.
---

# Native authentication SDK attribute builder

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

In native authentication, the information you collect from the user during sign-up is configured in the user flow in the Microsoft Entra admin center. The name of the user attribute as it appears in the Microsoft Entra admin center is different from the variable name that you use when you reference it in your app. 

Fortunately, the native authentication SDK enables you to build the user attributes and assign values to them before you use them in the SDKs `signUp()` method.

## Build user attributes

### [Android (Kotlin)](#tab/android-kotlin)

To build user attributes in the Android SDK:

- Use the utility class `UserAttribute.Builder` that the SDK provides. The `UserAttributes.Builder` class contains methods whose parameter is the value that you collect from the user.
- Identify the user attributes that you want to build, then use the following code snippet to build them:

    ```kotlin
        //build the user attributes, both built-in and custom attributes
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
            val actionResult = authAuthClientInstance.signUp(
                username = emailAddress,
                attributes = userAttributes
            )
        }  
    ```

- To build [custom attributes](concept-user-attributes.md#custom-user-attributes), use `UserAttribute.Builder` class `customAttribute()` method. The method accepts the custom attribute's programmable name, and the value of the attribute:

     ```kotlin
        val userAttributes = UserAttributes.Builder
            .customAttribute("extension_2588abcdwhtfeehjjeeqwertc_loyaltyNumber", loyaltyNumber)
            .build() 
    
        CoroutineScope(Dispatchers.Main).launch {
            //use the userAttributes variable in your signUp method 
            val actionResult = authAuthClientInstance.signUp(
                username = emailAddress,
                attributes = userAttributes
            )
        }  
     ```

### [iOS/macOS (Swift)](#tab/ios-macos-swift)

To build user attributes in the iOS/macOS MSAL SDK:

 - Identify the user attributes that you want to build, then create a dictionary variable, where:
    - the `key` is the programmable name of the user attribute, as a string. The programmable name can be for built-in or custom attribute. 
    - the `value` in the value of the user attribute that you collect from the user.
 - Identify the user attributes that you want to build, then use the following code snippet to build them:
 
     ```swift
        let attributes = [
            "country": "United States",
            "city": "Redmond",
            "displayName": displayName,
            "givenName": givenName,
            "jobTitle": jobTitle,
            "postalCode": postalCode,
            "state": state,
            "streetAddress": streetAddress,
            "surname": surname
        ]
        
        authAuthClientInstance.signUp(username: email, attributes: attributes, delegate: self)
     ```   
- To build [custom attributes](concept-user-attributes.md#custom-user-attributes), use `UserAttribute.Builder` class `customAttribute()` method. The method accepts the custom attribute's programmable name, and the value of the attribute:
    
    ```swift
            let attributes = [
                "country": "United States",
                "extension_2588abcdwhtfeehjjeeqwertc_loyaltyNumber", loyaltyNumber
            ]
            
            authAuthClientInstance.signUp(username: email, attributes: attributes, delegate: self)
    ```
---

To learn more about the programmable names of user profile attributes, see the [User profile attributes](concept-user-attributes.md) article.

## Related content

- [Native authentication challenge types](concept-native-authentication-challenge-types.md)
- [iOS/macOS native authentication tutorials](tutorial-native-authentication-prepare-ios-macos-app.md)
- [Android native authentication tutorials](tutorial-native-authentication-prepare-android-app.md) 
