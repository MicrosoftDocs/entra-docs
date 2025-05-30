---
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform
ms.topic: include
---
A daemon application acquires a token on behalf of itself (not on behalf of a user). Users can't interact with a daemon application because it requires its own identity. This type of application requests an access token by using its application identity by presenting its application ID, credential (secret or certificate), and an application ID URI. The daemon application uses the standard [OAuth 2.0 client credentials grant flow](../v2-oauth2-client-creds-grant-flow.md) to acquire an access token.

The app acquires an access token from Microsoft identity platform. The access token is scoped for the Microsoft Graph API. The app then uses the access token to read all users in the tenant from Microsoft Graph API. The app can request any resource from Microsoft Graph API as long as the access token has the right permissions. In this case, we granted the app **User.Read.All** app permission so that it read all users' full profiles.

The sample demonstrates how an unattended job or Windows service can run with an application identity, instead of a user's identity.