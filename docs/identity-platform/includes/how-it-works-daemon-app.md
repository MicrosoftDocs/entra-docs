---
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform
ms.topic: include
---

This app uses the client secret as its credentials to acquires an access token that's scoped for the Microsoft Graph API. It then uses the access token to read all users in the tenant through Microsoft Graph API. The app can request any resource from Microsoft Graph API as long as the access token has the right permissions. In this case, we granted the app **User.Read.All** app permission so it read all users' full profiles.

The sample demonstrates how an unattended job or Windows service can run with an application identity, instead of a user's identity.