---
title: "Tutorial: Prepare a JavaScript single-page app (SPA) for authentication"
description: Learn how to prepare a JavaScript single-page app (SPA) for authentication using the Microsoft identity platform.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: identity-platform
ms.custom:
ms.topic: tutorial
ms.date: 05/12/2025
#Customer intent: As a developer, I want to learn how to configure JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Prepare a JavaScript single-page app for authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll build a JavaScript single-page application (SPA) and prepare it for authentication using the Microsoft identity platform. This tutorial demonstrates how to create a JavaScript SPA using `npm`, create files needed for authentication and authorization and add your tenant details to the source code. The application can be used for employees in a workforce tenant or for customers using an external tenant.

In this tutorial, you

> [!div class="checklist"]
> * Create a new JavaScript project
> * Install packages required for authentication
> * Create your file structure and add code to the server file
> * Add your tenant details to the authentication configuration file

## Prerequisites

### [Workforce tenant](#tab/workforce-tenant)

* A workforce tenant. You can use your [Default Directory](quickstart-create-new-tenant.md) or set up a new tenant.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:3000/`.

### [External tenant](#tab/external-tenant)

* An external tenant. To create one, choose from the following methods:
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:3000/`.
* Associate your app with a user flow in the Microsoft Entra admin center. This user flow can be used across multiple applications. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

---

* [Node.js](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Create a JavaScript project and install dependencies

1. Sign into the Microsoft Entra admin center as a Global Administrator.
1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following command to create a new JavaScript project:

    ```powershell
    npm init -y
    ```

1. Create additional folders and files to achieve the following project structure:

    ```javascript
    └── public
        └── authConfig.js
        └── auth.js
        └── claimUtils.js
        └── index.html
        └── signout.html
        └── styles.css
        └── ui.js    
    └── server.js
    └── package.json
    ```

1. In the **Terminal**, run the following command to install the required dependencies for the project:

    ```powershell
    npm install express morgan @azure/msal-browser
    ```

## Add code to the server file

**Express** is a web application framework for **Node.js**. It's used to create a server that hosts the application. **Morgan** is the middleware that logs HTTP requests to the console. The server file is used to host these dependencies and contains the routes for the application. Authentication and authorization are handled by the [Microsoft Authentication Library for JavaScript (MSAL.js)](/javascript/api/overview).

1. Add the following code to the *server.js* file:

    ```javascript
    const express = require('express');
    const morgan = require('morgan');
    const path = require('path');

    const DEFAULT_PORT = process.env.PORT || 3000;

    // initialize express.
    const app = express();

    // Configure morgan module to log all requests.
    app.use(morgan('dev'));

    // serve public assets.
    app.use(express.static('public'));

    // serve msal-browser module
    app.use(express.static(path.join(__dirname, "node_modules/@azure/msal-browser/lib")));

    // set up a route for signout.html
    app.get('/signout', (req, res) => {
        res.sendFile(path.join(__dirname + '/public/signout.html'));
    });

    // set up a route for redirect.html
    app.get('/redirect', (req, res) => {
        res.sendFile(path.join(__dirname + '/public/redirect.html'));
    });

    // set up a route for index.html
    app.get('/', (req, res) => {
        res.sendFile(path.join(__dirname + '/index.html'));
    });

    app.listen(DEFAULT_PORT, () => {
        console.log(`Sample app listening on port ${DEFAULT_PORT}!`);
    });

    module.exports = app;
    ```

In this code, the **app** variable is initialized with the **express** module is used to serve the public assets. [MSAL-browser](/javascript/api/@azure/msal-browser) is served as a static asset and is used to initiate the authentication flow.

## Adding your tenant details to the MSAL configuration

The **authConfig.js** file contains the configuration settings for the authentication flow and is used to configure **MSAL.js** with the required settings for authentication.

### [Workforce tenant](#tab/workforce-tenant)

1. Open *public/authConfig.js* and add the following code:

    ```javascript
    /**
    * Configuration object to be passed to MSAL instance on creation. 
    * For a full list of MSAL.js configuration parameters, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md 
    */
    const msalConfig = {
        auth: {
            clientId: "Enter_the_Application_Id_Here",
            // WORKFORCE TENANT
            authority: 'https://login.microsoftonline.com/Enter_the_Tenant_Info_Here', //  Replace the placeholder with your tenant info
            redirectUri: '/', // You must register this URI on App Registration. Defaults to window.location.href e.g. http://localhost:3000/
            navigateToLoginRequestUrl: true, // If "true", will navigate back to the original request location before processing the auth code response.
        },
        cache: {
            cacheLocation: 'sessionStorage', // Configures cache location. "sessionStorage" is more secure, but "localStorage" gives you SSO.
            storeAuthStateInCookie: false, // set this to true if you have to support IE
        },
        system: {
            loggerOptions: {
                loggerCallback: (level, message, containsPii) => {
                    if (containsPii) {
                        return;
                    }
                    switch (level) {
                        case msal.LogLevel.Error:
                            console.error(message);
                            return;
                        case msal.LogLevel.Info:
                            console.info(message);
                            return;
                        case msal.LogLevel.Verbose:
                            console.debug(message);
                            return;
                        case msal.LogLevel.Warning:
                            console.warn(message);
                            return;
                    }
                },
            },
        },
    };

    /**
    * Scopes you add here will be prompted for user consent during sign-in.
    * By default, MSAL.js will add OIDC scopes (openid, profile, email) to any login request.
    * For more information about OIDC scopes, visit: 
    * https://learn.microsoft.com/en-us/entra/identity-platform/permissions-consent-overview#openid-connect-scopes
    */
    const loginRequest = {
        scopes: ["User.Read"],
    };

    /**
    * An optional silentRequest object can be used to achieve silent SSO
    * between applications by providing a "login_hint" property.
    */

    // const silentRequest = {
    //   scopes: ["openid", "profile"],
    //   loginHint: "example@domain.net"
    // };

    // exporting config object for jest
    if (typeof exports !== 'undefined') {
        module.exports = {
            msalConfig: msalConfig,
            loginRequest: loginRequest,
        };
    }
    ```

1. Replace the following values with the values from the Microsoft Entra admin center:
    * Find the `Enter_the_Application_Id_Here` value and replace it with the **Application ID (clientId)** of the app you registered in the Microsoft Entra admin center.
    * Find the `Enter_the_Tenant_Info_Here` value and replace it with the **Tenant ID** of the workforce tenant you created in the Microsoft Entra admin center.
1. Save the file.

### [External tenant](#tab/external-tenant)

1. Open *public/authConfig.js* and add the following code snippet:

    ```javascript
    /**
    * Configuration object to be passed to MSAL instance on creation. 
    * For a full list of MSAL.js configuration parameters, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md 
    */
    const msalConfig = {
        auth: {
            clientId: "Enter_the_Application_Id_Here",
            // EXTERNAL TENANT
            authority: "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/", // Replace the placeholder with your tenant subdomain
            redirectUri: '/', // You must register this URI on App Registration. Defaults to window.location.href e.g. http://localhost:3000/
            navigateToLoginRequestUrl: true, // If "true", will navigate back to the original request location before processing the auth code response.
        },
        cache: {
            cacheLocation: 'sessionStorage', // Configures cache location. "sessionStorage" is more secure, but "localStorage" gives you SSO.
            storeAuthStateInCookie: false, // set this to true if you have to support IE
        },
        system: {
            loggerOptions: {
                loggerCallback: (level, message, containsPii) => {
                    if (containsPii) {
                        return;
                    }
                    switch (level) {
                        case msal.LogLevel.Error:
                            console.error(message);
                            return;
                        case msal.LogLevel.Info:
                            console.info(message);
                            return;
                        case msal.LogLevel.Verbose:
                            console.debug(message);
                            return;
                        case msal.LogLevel.Warning:
                            console.warn(message);
                            return;
                    }
                },
            },
        },
    };

    /**
    * Scopes you add here will be prompted for user consent during sign-in.
    * By default, MSAL.js will add OIDC scopes (openid, profile, email) to any login request.
    * For more information about OIDC scopes, visit: 
    * https://learn.microsoft.com/en-us/entra/identity-platform/permissions-consent-overview#openid-connect-scopes
    */
    const loginRequest = {
        scopes: ["User.Read"],
    };

    /**
    * An optional silentRequest object can be used to achieve silent SSO
    * between applications by providing a "login_hint" property.
    */

    // const silentRequest = {
    //   scopes: ["openid", "profile"],
    //   loginHint: "example@domain.net"
    // };

    // exporting config object for jest
    if (typeof exports !== 'undefined') {
        module.exports = {
            msalConfig: msalConfig,
            loginRequest: loginRequest,
        };
    }
     ```

1. Replace the following values with the values from the Microsoft Entra admin center:
     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID in the Microsoft Entra admin center.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
1. Save the file.
---

## Next step

> [!div class="nextstepaction"]
> [Handle authentication flows in a JavaScript SPA](tutorial-single-page-app-javascript-configure-authentication.md)