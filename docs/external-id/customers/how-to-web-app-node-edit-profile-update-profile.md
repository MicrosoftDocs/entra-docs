---
title: Edit profile in a Node.js web app
description: Learn how to edit profile with multifactor authentication protection in your external-facing Node.js web app
manager: mwongerapz
author: kengaderdus
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 09/02/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to add edit profile to a Node.js web app so that customer users can update their profile after a successful sign-in to external-facing app.
---

# Edit profile in a Node.js web app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article is part 3 of a series that demonstrates how to add the profile editing logic in a Node.js web app. In [part 2 of this series](how-to-web-app-node-edit-profile-prepare-app.md), you set up your app for profile editing by adding the required user interface components.

In this how-to guide, you learn how to call Microsoft Graph API for profile editing.

## Prerequisites

- Complete the steps in the second part of this guide series, [Set-up a Node.js web application for profile editing](how-to-web-app-node-edit-profile-prepare-app.md).

## Update authConfig.js file

1. In your code editor, open *authConfig.js* file, then add three new variables, `GRAPH_API_ENDPOINT`, `GRAPH_ME_ENDPOINT` and `editProfileScope`. Make sure to export the three variables:

    ```JavaScript
    //...
    const GRAPH_API_ENDPOINT = process.env.GRAPH_API_ENDPOINT || "https://graph.microsoft.com/";
    // https://learn.microsoft.com/graph/api/user-update?view=graph-rest-1.0&tabs=http
    const GRAPH_ME_ENDPOINT = GRAPH_API_ENDPOINT + "v1.0/me";
    const editProfileScope = process.env.EDIT_PROFILE_FOR_CLIENT_WEB_APP || 'api://{clientId}/EditProfileService.ReadWrite';
    
    module.exports = {
        //...
        editProfileScope,
        GRAPH_API_ENDPOINT,
        GRAPH_ME_ENDPOINT,
        //...
    };
    ```

    - The `editProfileScope` variable represents MFA protected resource, that's the edit profile service app.

    - The `GRAPH_ME_ENDPOINT` is the Microsoft Graph API endpoint. 
    
1. Replace the placeholder `{clientId}` with the Application (client) ID of the edit profile service app that you registered earlier.

## Acquire access token

In your code editor, open *auth/AuthProvider.js* file, then update the `getToken` method in the `AuthProvider` class:

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
    //...
```

The `getToken` method uses specified scope to acquire a token. The `redirectUri` parameter is the redirect URL after the app acquires an access token. 

## Update the users.js file

In your code editor, open the *routes/users.js* file, add the following routes:

```JavaScript
    //...
    
    var { fetch } = require("../fetch");
    const { GRAPH_ME_ENDPOINT, editProfileScope } = require('../authConfig');
    //...
    
    router.get(
        '/gatedUpdateProfile',
        isAuthenticated, // check if user is authenticated
        authProvider.getToken(["User.Read"]),
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
      authProvider.getToken(["User.ReadWrite", editProfileScope], 
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
                  // Finf more information for this endpoint found here
                  // https://learn.microsoft.com/graph/api/user-update?view=graph-rest-1.0&tabs=http
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
    1. Acquires an access token with the *User.Read* permission.
    1. Makes a call to Microsoft Graph API to read the signed-in user's profile.
    1. Displays the user details in the *gatedUpdateProfile.hbs* UI.

- You trigger the `/updateProfile` route when the user wants to update their display name, that's, they select the **Edit** button. The app:
    1. Makes a call to edit profile service using *editProfileScope* permission. By making a call to the edit profile service, the user must complete an MFA challenge if they've not already done so. 
    1. The edit profile service makes a call to MicroSoft Graph API on behalf of the client web app using the *User.ReadWrite* permission and updates the signed-in user's profile.
    1. Displays the user details in the *updateProfile.hbs* UI.

- You trigger the `/update` route when the user selects the **Save** button in either *gatedUpdateProfile.hbs* or *updateProfile.hbs*. The app:
    1. Retrieves the access token for app session.
    1. Collects all user details.
    1. Makes a call to Microsoft Graph API to update the user's profile.


## Update the fetch.js file

The app uses the *fetch.js* file to make the actual API call. 

In your code editor, open *fetch.js* file, then add the PATCH operation option. After you update the file, the resulting file should looks similar to the following code:

```JavaScript
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

    switch (method) {
        case 'GET':
            const response = await axios.get(endpoint, options);
            return await response.data;
        case 'POST':
            return await axios.post(endpoint, data, options);
        case 'DELETE':
            return await axios.delete(endpoint + `/${data}`, options);
        case 'PATCH': 
            return await axios.patch(endpoint, ReqBody = data, options);
        default:
            return null;
    }
};

module.exports = { fetch };
```

## Test your app

Use these steps to test your app:

1. In your terminal, make sure you're in the project folder that contains the *package.json*, then run the following command:

    ```console
    npm start
    ```

1. Open your browser, then go to http://localhost:3000. If you experience SSL certificate errors, create a `.env` file, then add the following configuration:

    ```Console
    # Use this variable only in the development environment. 
    # Remove the variable when you move the app to the production environment.
    NODE_TLS_REJECT_UNAUTHORIZED='0'
    ```

1. Select the **Sign In** button, then sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. To update profile, select the **Edit profile** link. You see a page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-edit-profile-update-profile/edit-user-profile.png" alt-text="Screenshot of update user profile."::: 

1. To edit the user's **Display Name**, select the **Edit** button. If you haven't already done so, the app prompts you to complete an MFA challenge. 
 
## Related content

- [Add multifactor authentication to an app](how-to-multifactor-authentication-customers.md).