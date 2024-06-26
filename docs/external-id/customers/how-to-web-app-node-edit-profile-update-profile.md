---
title: Edit profile in a Node.js web app
description: Learn how to edit profile with multifactor authentication protection in your external-facing Node.js web app
manager: mwongerapz
author: kengaderdus
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 07/01/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to add edit profile to a Node.js web app so that customer users can update their profile after a successful sign-in to external-facing app.
---

# Edit profile in a Node.js web app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article is part 3 of a series that demonstrates how to add the profile editing logic in an Node.js web app. In [part 2 of this series](how-to-web-app-node-edit-profile-prepare-app.md), you prepared your app for profile editing by adding the required user interface components.

In this how-to guide, you learn how to acquire an access token to call Microsoft Graph API for profile editing.

## Prerequisites

- Complete the steps in the second part of this guide series, [Prepare a Node.js web application for profile editing](how-to-web-app-node-edit-profile-prepare-app.md).

## Update authConfig.js file

1. In your code editor, open *authConfig.js* file, then add three new variable, `GRAPH_API_ENDPOINT`, `GRAPH_ME_ENDPOINT` and `mfaProtectedResourceScope`. Make sure to export the three variables:

    ```JavaScript
        //...
        const GRAPH_API_ENDPOINT = process.env.GRAPH_API_ENDPOINT || "https://graph.microsoft.com/";
        // https://learn.microsoft.com/en-us/graph/api/user-update?view=graph-rest-1.0&tabs=http
        const GRAPH_ME_ENDPOINT = GRAPH_API_ENDPOINT + "v1.0/me";
        const mfaProtectedResourceScope = process.env.MFA_PROTECTED_SCOPE || 'api://{clientId}/User.MFA';
        
        module.exports = {
            //...
            mfaProtectedResourceScope,
            GRAPH_API_ENDPOINT,
            GRAPH_ME_ENDPOINT,
            //...
        };
    ```

    - The `mfaProtectedResourceScope` variable represents MFA protected resource, that's the MFA web API.

    - The `GRAPH_ME_ENDPOINT` is the Microsoft Graph API endpoint. 
    
1. Replace the placeholder `{clientId}` with the Application (client) ID of the MFA web API that you registered earlier.

## Acquire access token

In your code editor, open *auth/AuthProvider.js* file, then update the `getToken` method in the `AuthProvider` class:

```javascript
    const axios = require('axios');
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
    //...
```

The `getToken` method uses specified scope to acquire a token.

## Update the users.js file

In your code editor, open the *routes/users.js* file, add the following routes:

```JavaScript
    //...
    
    var { fetch } = require("../fetch");
    const { GRAPH_ME_ENDPOINT, mfaProtectedResourceScope } = require('../authConfig');
    //...
    
    router.get(
        '/gatedUpdateProfile',
        isAuthenticated, // check if user is authenticated
        authProvider.getToken(["User.ReadWrite"]),
        async function (req, res, next) {
            const graphResponse = await fetch(
                GRAPH_ME_ENDPOINT,
                req.session.accessToken
              );
            res.render("gatedUpdateProfile", {
                profile: graphResponse,
              });
        }
    );
    
    router.get(
      '/updateProfile',
      isAuthenticated, // check if user is authenticated
      authProvider.getToken(["User.ReadWrite", mfaProtectedResourceScope], 
                            "http://localhost:3000/users/updateProfile"),
      async function (req, res, next) {
          const graphResponse = await fetch(
              GRAPH_ME_ENDPOINT,
              req.session.accessToken
            );
          res.render("updateProfile", {
              profile: graphResponse,
            });
      }
    );
    
    router.post(
        '/update',
        isAuthenticated, // check if user is authenticated
        async function (req, res, next) {
            try {
                if (!!req.body) {
                  let body = req.body;
                  const graphEndpoint = GRAPH_ME_ENDPOINT;
                  // API that calls for a single singed in user.
                  // more infromation for this endpoint found here
                  // https://learn.microsoft.com/en-us/graph/api/user-update?view=graph-rest-1.0&tabs=http
                  fetch(graphEndpoint, req.session.accessToken, "PATCH", {
                    displayName: body.displayName,
                    givenName: body.givenName,
                    surname: body.surname,
                    mail: body.mail,
                  })
                    .then((response) => {
                      if (response.status === 204) {
                        return res.redirect("/");
                      } else {
                        next("Not updated");
                      }
                    })
                    .catch((error) => {
                      next(error);
                    });
                } else {
                  throw { error: "empty request" };
                }
              } catch (error) {
                next(error);
              }
        }
    );
    //...
```

- You trigger the `/gatedUpdateProfile` route when the customer user selects the **Edit profile** link. The app:
    1. Acquires an access token with the *User.ReadWriter* permission.
    1. Makes a call to Microsoft Graph API to read the signed-in user's profile.
    1. Displays the user details in the *gatedUpdateProfile.hbs* UI.

- You trigger the `/updateProfile` route when the user wants to update their display name, that's, they select the *Edit* button. The app:
    1. Acquires an access token with the *User.ReadWrite* and *mfaProtectedResourceScope* permissions. By including the *mfaProtectedResourceScope* permission, the user must complete an MFA challenge if they've not already done so.
    1. Makes a call to Microsoft Graph API to read the signed-in user's profile.
    1. Displays the user details in the *updateProfile.hbs* UI.
- `/update`



