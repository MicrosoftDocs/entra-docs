---
title: Remove accounts from the token cache on sign-out
description: Learn how to remove accounts from the token cache during global sign-out in web apps that call web APIs using the Microsoft identity platform.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 03/21/2025
ms.reviewer: jmprieur
ms.service: identity-platform
ms.subservice: workforce
ms.topic: how-to
ms.custom:
#Customer intent: As an application developer, I want to know how to write a web app that calls web APIs by using the Microsoft identity platform.
---

# A web app that calls web APIs: Remove accounts from the token cache on global sign-out

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

You learned how to add sign-in to your web app in [Web app that signs in users: Sign-in and sign-out](scenario-web-app-sign-user-sign-in.md).

Sign-out is different for a web app that calls web APIs. When the user signs out from your application, or from any application, you must remove the tokens associated with that user from the token cache.

## Intercept the callback after single sign-out

To clear the token-cache entry associated with the account that signed out, your application can intercept the after `logout` event. Web apps store access tokens for each user in a token cache. By intercepting the after `logout` callback,  your web application can remove the user from the cache.

# [ASP.NET Core](#tab/aspnetcore)

Microsoft.Identity.Web takes care of implementing sign-out for you. For details see [Microsoft.Identity.Web source code](https://github.com/AzureAD/microsoft-identity-web/blob/c29f1a7950b940208440bebf0bcb524a7d6bee22/src/Microsoft.Identity.Web/WebAppExtensions/WebAppCallsWebApiAuthenticationBuilderExtensions.cs#L168-L176)

# [ASP.NET](#tab/aspnet)

The ASP.NET sample doesn't remove accounts from the cache on global sign-out.

# [Java](#tab/java)

The Java sample doesn't remove accounts from the cache on global sign-out.

# [Node.js](#tab/nodejs)

The Node sample doesn't remove accounts from the cache on global sign-out.

# [Python](#tab/python)

The Python sample doesn't remove accounts from the cache on global sign-out.

---

## Next steps

# [ASP.NET Core](#tab/aspnetcore)

Move on to the next article in this scenario,
[Acquire a token for the web app](./scenario-web-app-call-api-acquire-token.md?tabs=aspnetcore).

# [ASP.NET](#tab/aspnet)

Move on to the next article in this scenario,
[Acquire a token for the web app](./scenario-web-app-call-api-acquire-token.md?tabs=aspnet).

# [Java](#tab/java)

Move on to the next article in this scenario,
[Acquire a token for the web app](./scenario-web-app-call-api-acquire-token.md?tabs=java).

# [Node.js](#tab/nodejs)

Move on to the next article in this scenario,
[Acquire a token for the web app](./scenario-web-app-call-api-acquire-token.md?tabs=nodejs).

# [Python](#tab/python)

Move on to the next article in this scenario,
[Acquire a token for the web app](./scenario-web-app-call-api-acquire-token.md?tabs=python).

---
