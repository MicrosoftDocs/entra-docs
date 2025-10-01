---
title: Build single-page app calling a web API
description: Learn how to build a single-page application that calls a web API
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: 
ms.date: 05/12/2025
ms.service: identity-platform
ms.subservice: workforce
ms.topic: how-to
#Customer intent: As an application developer, I want to know how to write a single-page application by using the Microsoft identity platform.
---

# Single-page application: Call a web API

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

We recommend that you call the `acquireTokenSilent` method to acquire or renew an access token before calling a web API. After you have a token, you can call a protected web API.

## Call a web API

# [JavaScript](#tab/javascript)

Use the acquired access token as a bearer in an HTTP request to call any web API, such as Microsoft Graph API. For example:

```javascript
    var headers = new Headers();
    var bearer = "Bearer " + access_token;
    headers.append("Authorization", bearer);
    var options = {
         method: "GET",
         headers: headers
    };
    var graphEndpoint = "https://graph.microsoft.com/v1.0/me";

    fetch(graphEndpoint, options)
        .then(function (response) {
             //do something with response
        })
```

# [Angular](#tab/angular)

The MSAL Angular wrapper takes advantage of the HTTP interceptor to automatically acquire access tokens silently and attach them to the HTTP requests to APIs. For more information, see [Acquire a token to call an API](scenario-spa-acquire-token.md).

---

## Next steps

- Learn more by building a React Single-page application (SPA) that signs in users in the following multi-part [tutorial series](tutorial-single-page-app-react-prepare-app.md).
- Explore Microsoft identity platform [single-page application code samples](sample-v2-code.md#single-page-applications) 
