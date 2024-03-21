---
author: kengaderdus
ms.service: active-directory
ms.subservice: ciam
ms.topic: include
ms.date: 03/12/2024
ms.author: kengaderdus
---

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| *password*              | This challenge type indicates that the app supports the collection of a password credential from the user.                   |
| *oob*   | This challenge type indicates that the application supports the use of one-time password or passcode (OTP) codes sent to the user using a secondary channel. Currently, the API supports only email OTP.|
| *redirect*  | This challenge type indicates that the application supports a fallback to the browser-delegated authentication, also known as web fallback. All native authentication compliant apps must support this authentication method. In every call that the app makes, it must include this challenge type. Microsoft Entra's response can indicate that the app needs to fall back to the browser-delegated authentication. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../reference-v2-libraries.md).|