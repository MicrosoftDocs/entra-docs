---
title: Acquire an access token in your Node.js web app
description: Learn how to acquire an access token for calling an API in your own Node.js web application.
 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: how-to
ms.date: 11/26/2023
ms.custom: developer, devx-track-js
---

# Acquire an access token in your Node.js web app

In this article, you update your code, to enable it acquire an access token. You use [Microsoft Authentication Library (MSAL) for Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) to simplify adding authentication and authorization to your node web application.

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

The `todolistReadScope` and `todolistReadWriteScope` variables hold the web API full scope URLs that you set in your customer tenant. Make sure you export the `protectedResources` object.

## Acquire access token

In your code editor, open *auth/AuthProvider.js* file, then update then add the `getToken` method in the `AuthProvider` class: 

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

## Next step

> [!div class="nextstepaction"]
> [Call an API >](how-to-web-app-node-sign-in-call-api-call-api.md)