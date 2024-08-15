---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 03/19/2024
ms.author: kengaderdus
---

This API reference article describes details required only when you manually make raw HTTP requests to execute the flow. However, we don't recommend this approach. So, when possible, use a Microsoft-built and supported authentication SDK. For more information on how to use the SDK, see [Tutorial: Prepare your Android mobile app for native authentication](../../../external-id/customers/tutorial-native-authentication-prepare-android-app.md) and [Tutorial: Prepare your iOS/macOS mobile app for native authentication](../../../external-id/customers/tutorial-native-authentication-prepare-ios-macos-app.md). 

When a call to the API endpoints is successful, you receive both an [ID token](../../id-tokens.md) for user identification and an [access token](../../access-tokens.md) to call protected APIs. All responses from the API are in a JSON format.