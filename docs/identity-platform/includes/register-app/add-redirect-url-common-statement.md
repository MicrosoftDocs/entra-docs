---
author: kengaderdus
ms.service: identity-platform
ms.topic: include
ms.date: 11/20/2024
ms.author: kengaderdus
---

A platform specifies the type of application that you want to integrate. A redirect URI is the location where the identity platform authentication server sends the user once they have successfully authorized and been granted security tokens.

To sign in a user, your application must send a sign-in request with a redirect URI specified as a parameter, and it must match any of the redirect URIs you have added in your app registration.  