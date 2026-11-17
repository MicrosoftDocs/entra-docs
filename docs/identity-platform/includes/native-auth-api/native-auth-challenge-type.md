---
manager: dougeby
ms.service: identity-platform 
ms.subservice: external
ms.topic: include
ms.date: 11/11/2026
ms.custom: msecd-doc-authoring-1030
---

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| *password*              | This challenge type indicates that the app supports collecting a password credential from the user.                   |
| *oob*   | This challenge type indicates that the application supports using one-time password or passcode (OTP) codes sent to the user using a secondary channel. Currently, the API supports only email and SMS OTP.|
| *redirect*  | This challenge type indicates that the application supports falling back to the browser-delegated authentication, also known as web fallback. All native authentication compliant apps must support this capability. This requirement means that in every call the app makes to the Native Authentication API, it must include this challenge type. If the client app fails to include this challenge type, the request fails. |
