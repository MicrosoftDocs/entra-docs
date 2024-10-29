---
title: Edit profile in a Node.js web app
description: Learn how to edit profile with multifactor authentication protection in your external-facing Node.js web app
manager: mwongerapz
author: kengaderdus
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 11/28/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to add edit profile to a Node.js web app so that customer users can update their profile after a successful sign-in to external-facing app.
---

# Edit profile in a Node.js web app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article is part 2 of a series that demonstrates how to add the profile editing logic in a Node.js web app. In [part 1 of this series](how-to-web-app-node-edit-profile-prepare-app.md), you set up your app for profile editing.

In this how-to guide, you learn how to call Microsoft Graph API for profile editing.

## Prerequisites

- Complete the steps in the second part of this guide series, [Set up a Node.js web application for profile editing](how-to-web-app-node-edit-profile-prepare-app.md).


## Complete the client web app

In this section, you add the identity related code for the client web app.

### Update authConfig.js file

Update the *authConfig.js* file for the client web app:

1. In your code editor, open *App/authConfig.js* file, then add three new variables, `GRAPH_API_ENDPOINT`, `GRAPH_ME_ENDPOINT` and `editProfileScope`. Make sure to export the three variables:

    ```JavaScript
    //...
    const GRAPH_API_ENDPOINT = process.env.GRAPH_API_ENDPOINT || "https://graph.microsoft.com/";
    // https://learn.microsoft.com/graph/api/user-update?tabs=http
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

    - The `editProfileScope` variable represents MFA protected resource, that's the mid-tier app (EditProfileService app).

    - The `GRAPH_ME_ENDPOINT` is the Microsoft Graph API endpoint. 
    
1. Replace the placeholder `{clientId}` with the Application (client) ID of the mid-tier app (EditProfileService app) that you registered earlier.

### Acquire access token in client web app

In your code editor, open *App/auth/AuthProvider.js* file, then update the `getToken` method in the `AuthProvider` class:

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

The `getToken` method uses the specified scope to acquire an access token. The `redirectUri` parameter is the redirect URL after the app acquires an access token. 

### Update the users.js file

In your code editor, open the *App/routes/users.js* file, then add the following routes:

```JavaScript
    //...
    
    var { fetch } = require("../fetch");
    const { GRAPH_ME_ENDPOINT, editProfileScope } = require('../authConfig');
    //...
    
router.get(
  "/gatedUpdateProfile",
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
        .send("Failed to fetch profile data"); 
    }
    res.render("gatedUpdateProfile", {
      profile: graphResponse,
    });
  },
);

router.get(
  "/updateProfile",
  isAuthenticated, // check if user is authenticated
  authProvider.getToken(
    ["User.Read", editProfileScope],
    "http://localhost:3000/users/updateProfile",
  ),
  async function (req, res, next) {
    const graphResponse = await fetch(
      GRAPH_ME_ENDPOINT,
      req.session.accessToken,
    );
    if (!graphResponse.id) {
      return res 
        .status(501) 
        .send("Failed to fetch profile data"); 
    }
    res.render("updateProfile", {
      profile: graphResponse,
    });
  },
);

router.post(
  "/update",
  isAuthenticated,
  authProvider.getToken([editProfileScope]),
  async function (req, res, next) {
    try {
      if (!!req.body) {
        let body = req.body;
        fetch(
          "http://localhost:3001/updateUserInfo",
          req.session.accessToken,
          "POST",
          {
            displayName: body.displayName,
            givenName: body.givenName,
            surname: body.surname,
          },
        )
          .then((response) => {
            if (response.status === 204) {
              return res.redirect("/");
            } else {
              next("Not updated");
            }
          })
          .catch((error) => {
            console.log("error,", error);
          });
      } else {
        throw { error: "empty request" };
      }
    } catch (error) {
      next(error);
    }
  },
);
    //...
```

- You trigger the `/gatedUpdateProfile` route when the customer user selects the **Profile editing** link. The app:
    1. Acquires an access token with the *User.Read* permission.
    1. Makes a call to Microsoft Graph API to read the signed-in user's profile.
    1. Displays the user details in the *gatedUpdateProfile.hbs* UI.

- You trigger the `/updateProfile` route when the user wants to update their display name, that's, they select the **Edit profile** button. The app:
    1. Makes a call to the mid-tier app (EditProfileService app) using *editProfileScope* scope. By making a call to the mid-tier app (EditProfileService app), the user must complete an MFA challenge if they've not already done so. 
    1. Displays the user details in the *updateProfile.hbs* UI.

- You trigger the `/update` route when the user selects the **Save** button in either *gatedUpdateProfile.hbs* or *updateProfile.hbs*. The app:
    1. Retrieves the access token for app session. You learn how the mid-tier app (EditProfileService app) acquires the access token in the next section.
    1. Collects all user details.
    1. Makes a call to Microsoft Graph API to update the user's profile.

### Update the fetch.js file

The app uses the *App/fetch.js* file to make the actual API calls. 

In your code editor, open *App/fetch.js* file, then add the PATCH operation option. After you update the file, the resulting file should look similar to the following code:

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

## Complete the mid-tier app

In this section, you add the identity related code for the mid-tier app (EditProfileService app).

1. In your code editor, open *Api/authConfig.js* file, then add the following code:

    ```JavaScript
    require("dotenv").config({ path: ".env.dev" });
    
    const TENANT_SUBDOMAIN =
      process.env.TENANT_SUBDOMAIN || "Enter_the_Tenant_Subdomain_Here";
    const TENANT_ID = process.env.TENANT_ID || "Enter_the_Tenant_ID_Here";
    const REDIRECT_URI =
      process.env.REDIRECT_URI || "http://localhost:3000/auth/redirect";
    const POST_LOGOUT_REDIRECT_URI =
      process.env.POST_LOGOUT_REDIRECT_URI || "http://localhost:3000";
    
    /**
     * Configuration object to be passed to MSAL instance on creation.
     * For a full list of MSAL Node configuration parameters, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/docs/configuration.md
     */
    const msalConfig = {
      auth: {
        clientId:
          process.env.CLIENT_ID ||
          "Enter_the_Edit_Profile_Service_Application_Id_Here", // 'Application (client) ID' of the Edit_Profile Service App registration in Microsoft Entra admin center - this value is a GUID
        authority:
          process.env.AUTHORITY || `https://${TENANT_SUBDOMAIN}.ciamlogin.com/`, // Replace the placeholder with your external tenant name
      },
      system: {
        loggerOptions: {
          loggerCallback(loglevel, message, containsPii) {
            console.log(message);
          },
          piiLoggingEnabled: false,
          logLevel: "Info",
        },
      },
    };
    
    const GRAPH_API_ENDPOINT = process.env.GRAPH_API_ENDPOINT || "graph_end_point";
    // Refers to the user that is single user singed in.
    // https://learn.microsoft.com/en-us/graph/api/user-update?tabs=http
    const GRAPH_ME_ENDPOINT = GRAPH_API_ENDPOINT + "v1.0/me";
    
    module.exports = {
      msalConfig,
      REDIRECT_URI,
      POST_LOGOUT_REDIRECT_URI,
      TENANT_SUBDOMAIN,
      GRAPH_API_ENDPOINT,
      GRAPH_ME_ENDPOINT,
      TENANT_ID,
    };
    ```

    Find the placeholder:
        
    - `Enter_the_Tenant_Subdomain_Here` and replace it with Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 
    - `Enter_the_Tenant_ID_Here` and replace it with Tenant ID. If you don't have your Tenant ID, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
    - `Enter_the_Edit_Profile_Service_Application_Id_Here` and replace it with is the Application (client) ID value of the [EditProfileService you registered earlier](sample-web-app-node-sign-in-edit-profile.md#register-editprofileservice-app).
    - `Enter_the_Client_Secret_Here` and replace it with the [EditProfileService app secret](sample-web-app-node-sign-in-edit-profile.md#add-app-client-secret) value you copied earlier.
    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's `https://graph.microsoft.com/`.
    
1. In your code editor, open *Api/fetch.js* file, then paste the code from *[Api/fetch.js](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/blob/main/1-Authentication/7-edit-profile-with-mfa-express/Api/fetch.js)* file. The `fetch` function uses an access token and the resource endpoint to make the actual API call. 

1. In your code editor, open *Api/index.js* file, then paste the code from *[Api/index.js](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/blob/main/1-Authentication/7-edit-profile-with-mfa-express/Api/index.js)* file.

### Acquire an access token by using acquireTokenOnBehalfOf 

In the *Api/index.js* file, the mid-tier app (EditProfileService app) acquires an access token using the [acquireTokenOnBehalfOf](/javascript/api/@azure/msal-node/confidentialclientapplication#@azure-msal-node-confidentialclientapplication-acquiretokenonbehalfof) function, which it uses to update the profile on behalf of that user.

```javascript
async function getAccessToken(tokenRequest) {
  try {
    const response = await cca.acquireTokenOnBehalfOf(tokenRequest);
    return response.accessToken;
  } catch (error) {
    console.error("Error acquiring token:", error);
    throw error;
  }
}
```

The `tokenRequest` parameter is defined as shown the following code:

```javascript
    const tokenRequest = {
      oboAssertion: req.headers.authorization.replace("Bearer ", ""),
      authority: `https://${TENANT_SUBDOMAIN}.ciamlogin.com/${TENANT_ID}`,
      scopes: ["User.ReadWrite"],
      correlationId: `${uuidv4()}`,
    };
```

In the same file, *Api/index.js*, the the mid-tier app (EditProfileService app) makes a call to Microsoft Graph API to update the users's profile:

```JavaScript
   let accessToken = await getAccessToken(tokenRequest);
    fetch(GRAPH_ME_ENDPOINT, accessToken, "PATCH", req.body)
      .then((response) => {
        if (response.status === 204) {
          res.status(response.status);
          res.json({ message: "Success" });
        } else {
          res.status(502);
          res.json({ message: "Failed, " + response.body });
        }
      })
      .catch((error) => {
        res.status(502);
        res.json({ message: "Failed, " + error });
      });

```

## Test your app

To test your app, use the following steps:

1. To run the client app, form the terminal window, navigate into the *App* directory, then run the following command:
    
    ```Console
    npm start
    ```
1. To run the client app, form the terminal window, navigate into the *Api* directory, then run the following command:

    ```Console
    npm start
    ```

1. Open your browser, then go to http://localhost:3000. If you experience SSL certificate errors, create a `.env` file, then add the following configuration:

    ```Console
    # Use this variable only in the development environment. 
    # Remove the variable when you move the app to the production environment.
    NODE_TLS_REJECT_UNAUTHORIZED='0'
    ```

1. Select the **Sign In** button, then you sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. To update profile, select the **Profile editing** link. You see a page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-edit-profile-update-profile/edit-user-profile.png" alt-text="Screenshot of user update profile."::: 

1. To edit profile, select the **Edit Profile** button. If you haven't already done so, the app prompts you to complete an MFA challenge. 

1. Make changes to any of the profile details, then select **Save** button.
 
## Related content

- Learn more about [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](../../identity-platform/v2-oauth2-on-behalf-of-flow.md).