---
author: kengaderdus
manager: dougeby
ms.service: identity-platform
ms.subservice: external
ms.topic: include
ms.date: 02/27/2026
ms.author: kengaderdus
---

This API reference article describes details required only when you manually make raw HTTP requests to execute the flow. However, we don't recommend this approach. So, when possible, use a Microsoft-built and supported authentication SDK. Learn more about [native authentication SDKs](../../concept-native-authentication.md).
When a call to the API endpoints is successful, you receive both an [ID token](../../id-tokens.md) for user identification and an [access token](../../access-tokens.md) to call protected APIs. All responses from the API are in a JSON format.