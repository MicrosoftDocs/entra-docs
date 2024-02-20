---
author: kengaderdus
ms.service: active-directory
ms.subservice: ciam
ms.topic: include
ms.date: 02/29/2024
ms.author: kengaderdus
---

This API reference article describes details required only when you manually make raw HTTP requests to execute the flow. However, we don't recommend this approach. So, when possible, use a Microsoft-built and supported authentication library. For more information on how to use the libraries, see [Android native SDK](https://github.com/AzureAD/msal-android-native-auth-sample-app-preview) and [Prepare your iOS app for native authentication](../../../external-id/customers/tutorial-native-auth-prepare-ios-app.md), to get security tokens. 

When a call to the API endpoints is successful, you receive both an [ID token](../../id-tokens.md) for user identification and an [access token](../../access-tokens.md) to call protected APIs. All responses from the API are in a JSON format.