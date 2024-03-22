---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 03/20/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
Once your app acquires an ID token, you can retrieve the claims associated with the current account. To do so, use the following code snippet.

```kotlin
val preferredUsername = accountState.getClaims()?.get("preferred_username")
val city = accountState.getClaims()?.get("city")
val givenName = accountState.getClaims()?.get("givenName")
//custom attribute
val loyaltyNumber = accountState.getClaims()?.get("loyaltyNumber")
```

The key you use to access the claim value is the programmable name of the user attribute. To learn more about the programmable names of user profile attributes, see the [User profile attributes](../../concept-user-attributes.md) article.