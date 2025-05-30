---
title: Acquire an access token in your Node.js web app
description: Learn how to acquire an access token for calling an API in your own Node.js web application.
 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: how-to
ms.date: 03/16/2025
ms.custom: 
#Customer intent: As a developer, I want to learn about how to acquire an access token in my Node.js client web app, so that I can call a web API that's protected by Microsoft Entra External ID.
---

# Acquire an access token in your Node.js web app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this article, you update your code, to enable your web app to acquire an access token. You use [Microsoft Authentication Library (MSAL) for Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) to simplify adding authentication and authorization to your node web application. This article is the third part of a four-part guide series.

## Prerequisites

- Complete the steps in the first part of this guide series, [Prepare external tenant to call an API in a Node.js web application](how-to-web-app-node-sign-in-call-api-prepare-tenant.md).
- Complete the steps in the second part of this guide series, [Prepare app to call an API in a Node.js web application](how-to-web-app-node-sign-in-call-api-prepare-app.md).

## Update MSAL configuration object

In your code editor, open *authConfig.js* file, then update the code by adding the `protectedResources` object:

```javascript
    //..   
    const toDoListReadScope = process.env.TODOLIST_READ || 'api://Enter_the_Web_Api_Application_Id_Here/ToDoList.Read';
    const toDoListReadWriteScope = process.env.TODOLIST_READWRITE || 'api://Enter_the_Web_Api_Application_Id_Here/ToDoList.ReadWrite';
    
    const protectedResources = {
        toDoListAPI: {
            endpoint: 'https://localhost:44351/api/todolist',
            scopes: {
                read: [toDoListReadScope],
                write: [toDoListReadWriteScope],
            },
        },
    };    
    module.exports = {
        //..
        protectedResources,
        //..
    };
```

In your *authConfig.js* file, replace `Enter_the_Web_Api_Application_Id_Here` with the Application (client) ID of the web API app that you registered in your customer's tenant.

The `todolistReadScope` and `todolistReadWriteScope` variables hold the web API full scope URLs that you set in your external tenant. Make sure you export the `protectedResources` object.

## Acquire access token

In your code editor, open *auth/AuthProvider.js* file, then update the `getToken` method in the `AuthProvider` class:

```javascript
    const axios = require('axios');
    class AuthProvider {
    //...
        getToken(scopes) {
            return  async function (req, res, next) {
                const msalInstance = authProvider.getMsalInstance(authProvider.config.msalConfig);
                try {
                    msalInstance.getTokenCache().deserialize(req.session.tokenCache);
    
                    const silentRequest = {
                        account: req.session.account,
                        scopes: scopes,
                    };
    
                    const tokenResponse = await msalInstance.acquireTokenSilent(silentRequest);
    
                    req.session.tokenCache = msalInstance.getTokenCache().serialize();
                    req.session.accessToken = tokenResponse.accessToken;
                    next();
                } catch (error) {
                    if (error instanceof msal.InteractionRequiredAuthError) {
                        req.session.csrfToken = authProvider.cryptoProvider.createNewGuid();
    
                        const state = authProvider.cryptoProvider.base64Encode(
                            JSON.stringify({
                                redirectTo: 'http://localhost:3000/todos',
                                csrfToken: req.session.csrfToken,
                            })
                        );
                        
                        const authCodeUrlRequestParams = {
                            state: state,
                            scopes: scopes,
                        };
    
                        const authCodeRequestParams = {
                            state: state,
                            scopes: scopes,
                        };
    
                        authProvider.redirectToAuthCodeUrl(
                            req,
                            res,
                            next,
                            authCodeUrlRequestParams,
                            authCodeRequestParams,
                            msalInstance
                        );
                    }
    
                    next(error);
                }
            };
        }
    //...
    }
```

- First, the function attempts to acquire an access token silently (without prompting the user for credentials):

    ```javascript
    const silentRequest = {
        account: req.session.account,
        scopes: scopes,
    };

    const tokenResponse = await msalInstance.acquireTokenSilent(silentRequest);
    ```

- If you successfully acquire a token silently, store it in a session. You retrieve the token from the session when you call an API.

    ```javascript
    req.session.accessToken = tokenResponse.accessToken;
    ```

- If you fail to acquire the token silently (such as with `InteractionRequiredAuthError` exception), request an access token afresh.

> [!NOTE]
> Once your client application receives an access token, it should treat it as an opaque string. The access token is intended for the API, not for the client application. Therefore, the client application should not attempt to read or process the access token. Instead, it should include the access token as-is in the *Authorization* header of its requests to the API. The API is responsible for interpreting the access token and using it to authenticate and authorize the client application’s requests.

## Next step

> [!div class="nextstepaction"]
> [Call an API](how-to-web-app-node-sign-in-call-api-call-api.md)