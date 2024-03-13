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
| *oob*   | This challenge type indicates that the application supports the use of one-time password or passcode (OTP) codes sent to the user using a secondary channel. Currently, the API supports only email OTPs.|
| *redirect*  | This challenge type indicates that the application supports fallback to the browser-delegated authentication. All native authentication compliant applications must support this authentication method. In every call that the app makes, it must include this challenge type. If Microsoft Entra returns this challenge type as a response, then it indicates that the app needs to fall back to the web-based authentication. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../reference-v2-libraries.md).|