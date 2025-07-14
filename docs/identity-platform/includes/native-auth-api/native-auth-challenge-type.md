---
author: kengaderdus
ms.service: entra-external-id 
ms.subservice: external
ms.topic: include
ms.date: 03/12/2024
ms.author: kengaderdus
---

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| *password*              | This challenge type indicates that the app supports the collection of a password credential from the user.                   |
| *oob*   | This challenge type indicates that the application supports the use of one-time password or passcode (OTP) codes sent to the user using a secondary channel. Currently, the API supports only email OTP.|
| *redirect*  | This challenge type indicates that the application supports a fallback to the browser-delegated authentication, also known as web fallback. All native authentication compliant apps must support this authentication method. This requirement means that in every call the app makes to Microsoft Entra, it must include this challenge type. If the client app fails to include this challenge type, the request fails. |