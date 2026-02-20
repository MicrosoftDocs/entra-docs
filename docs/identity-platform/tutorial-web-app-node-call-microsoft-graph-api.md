---
title: Tutorial-Call Microsoft Graph API from a Express.js web app
description: Learn how to acquire an access token in a Node/Express.js web to read user's profile detail from Microsoft Graph API 
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: tutorial
ms.date: 01/03/2025
#Customer intent: As a dev, devops, I want to learn about how to acquire an access token in a Node/Express.js web app, then use it to call Microsoft Graph API so that I can read a signed-in user's profile details
---

# Tutorial: Call Microsoft Graph API from a Node/Express.js web app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you call Microsoft Graph API from a Node/Express.js web app. Once a user signs in, the app acquires an access token to call Microsoft Graph API.

This tutorial is part 3 of the 3-part tutorial series.

In this tutorial, you:

> [!div class="checklist"]
>
> - Update Node/Express.js web app to acquire an access token
> - Use the access token to call Microsoft Graph API.

## Prerequisites

- Complete the steps in [Tutorial: Add add sign-in to a Node/Express.js web app by using Microsoft identity platform](tutorial-web-app-node-sign-in-sign-out.md). 

## Add a UI components

1. In your code editor, open *views/index.hbs* file, then add an **View user profile** link by using the following code snippet:

    ```html
    <a href="/users/profile">View user profile</a>
    ```

    After you make the update, your *views/index.hbs* file should look similar to the following file:

    ```html
       <h1>{{title}}</h1>
        {{#if isAuthenticated }}
        <p>Hi {{username}}!</p>
        <a href="/users/id">View ID token claims</a>
        <br>
        <a href="/users/profile">View user profile</a>
        <br>
        <br>
        <a href="/auth/signout">Sign out</a>
        {{else}}
        <p>Welcome to {{title}}</p>
        <a href="/auth/signin">Sign in</a>
        {{/if}}
    ```

1. Create *views/profile.hbs* file, then add the following code:

    ```html
    <h1>Microsoft Graph API</h1>
    <h3>/me endpoint response</h3>
    <table>
        <tbody>
            {{#each profile}}
            <tr>
                <td>{{@key}}</td>
                <td>{{this}}</td>
            </tr>
            {{/each}}
        </tbody>
    </table>
    <br>
    <a href="/">Go back</a>
    ```

    - This page displays the user's profile details that Microsoft Graph API returns.


## Acquire an access token

In your code editor, open the *auth/AuthProvider.js* file, then add `getToken` method in the `AuthProvider` class:

```javascript
class AuthProvider {
    //...
        getToken(scopes, redirectUri = "http://localhost:3000/") {
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
                                redirectTo: redirectUri,
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
}
    //...
```

The `getToken` method uses the specified scope to acquire an access token

## Add call API route

In your code editor, open the *routes/users.js* file, then add the following route:

```javascript
router.get(
    "/profile",
    isAuthenticated,
    authProvider.getToken(["User.Read"]), // check if user is authenticated
    async function (req, res, next) {
    const graphResponse = await fetch(
        GRAPH_ME_ENDPOINT,
        req.session.accessToken,
    );
    if (!graphResponse.id) {
        return res 
        .status(501) 
        .send("Failed to fetch profile details"); 
    }
    res.render("profile", {
        profile: graphResponse,
    });
    },
);
```

- You trigger the `/profile` route when the customer user selects the **View user profile** link. The app:
    
    - Acquires an access token with the *User.Read* permission.
    - Makes a call to Microsoft Graph API to read the signed-in user's profile.
    - Displays the user details in the *profile.hbs* UI.

## Call Microsoft Graph API

Create *fetch.js* file, then add the following code:

```javascript
var axios = require('axios');
var authProvider = require("./auth/AuthProvider");

/**
 * Makes an Authorization "Bearer" request with the given accessToken to the given endpoint.
 * @param endpoint
 * @param accessToken
 * @param method
 */
const fetch = async (endpoint, accessToken, method = "GET", data = null) => {
    const options = {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    };

    console.log(`request made to ${endpoint} at: ` + new Date().toString());

    try{
        const response = await axios.get(endpoint, options);
        return await response.data;

    }catch(error){
        throw new Error(error);
    }

};

module.exports = { fetch };
```

The actual API call happens in the *fetch.js* file.

## Run and test the Node/Express.js web app

1. Use the steps in [Run and test the Node/Express.js web app](tutorial-web-app-node-sign-in-sign-out.md#run-and-test-the-nodeexpressjs-web-app) to run your web app.
1. Once you sign in, select **View user profile** link. If your app works correctly, you should see the signed-in user's profile as read from Microsoft Graph API.

## Related content

- [Edit customer user's profile in a Node.js web app](/entra/external-id/customers/how-to-web-app-node-edit-profile-update-profile)
