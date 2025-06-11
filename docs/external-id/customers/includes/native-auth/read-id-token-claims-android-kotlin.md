---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 04/28/2024
ms.author: kengaderdus
ms.manager: dougeby
---
Once your app acquires an ID token, you can retrieve the claims associated with the current account. To do so, use the following code snippet.

```kotlin
val preferredUsername = accountState.getClaims()?.get("preferred_username")
val city = accountState.getClaims()?.get("City")
val givenName = accountState.getClaims()?.get("given_name")
//custom attribute
val loyaltyNumber = accountState.getClaims()?.get("loyaltyNumber")
```

The key you use to access the claim value is the name that you specify when you add the user attribute as a token claim. 

To learn how to add built-in and custom attributes to as token claims in the [Add user attributes to token claims](../../how-to-add-attributes-to-token.md) article.