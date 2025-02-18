---
title: "Tutorial: Prepare a React single-page application for authentication"
description: Learn how to prepare a React single-page app (SPA) for authentication using the Microsoft identity platform.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 02/17/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As a React developer, I want to know how to create a new React project in an IDE and add authentication.
---

# Tutorial: Create a React single-page application and prepare it for authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll build a React single-page application (SPA) and prepare it for authentication using the Microsoft identity platform. This tutorial demonstrates how to create a React SPA using `npm`, create files needed for authentication and authorization and add your tenant details to the source code. The application can be used for employees in a workforce tenant or for customers using an external tenant.

In this tutorial, you'll:

> [!div class="checklist"]
> * Create a new React project
> * Install packages required for authentication
> * Create your file structure and add code to the server file
> * Add your tenant details to the authentication configuration file

## Prerequisites

### [Workforce tenant](#tab/workforce-tenant)

* A workforce tenant. You can use your [Default Directory](quickstart-create-new-tenant.md) or set up a new tenant.
* Register a new app in the Microsoft Entra admin center with the following configuration. For more information, see [Register an application](quickstart-register-app.md).
    * **Name**: identity-client-spa
    * **Supported account types**: *Accounts in this organizational directory only (Single tenant).*
    * **Platform configuration**: Single-page application (SPA).
    * **Redirect URI**: `http://localhost:3000/`.

### [External tenant](#tab/external-tenant)

* An external tenant. To create one, choose from the following methods:
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details) in the Microsoft Entra admin center.
* Register a new app in the Microsoft Entra admin center with the following configuration. For more information, see [Register an application](quickstart-register-app.md).
    * **Name**: identity-client-spa
    * **Supported account types**: *Accounts in this organizational directory only (Single tenant).*
    * **Platform configuration**: Single-page application (SPA).
    * **Redirect URI**: `http://localhost:3000/`.
* Associate your app with a user flow in the Microsoft Entra admin center. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

---

* [Node.js](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.


## Create a new React project

Use the following tabs to create a React project within the IDE.

### [Visual Studio](#tab/visual-studio)

1. Open Visual Studio, and then select **Create a new project**.
1. Search for and choose the **Standalone JavaScript React Project** template, and then select **Next**.
1. Enter a name for the project, such as *reactspalocal*.
1. Choose a location for the project or accept the default option, and then select **Next**.
1. In **Additional information**, select **Create**.
1. From the toolbar, select **Start Without Debugging** to launch the application. A web browser will open with the address `http://localhost:3000/` by default. The browser remains open and re-renders for every saved change.
1. Create additional folders and files to achieve the following folder structure:

    ```javascript
    ├─── public
    │   └─── index.html
    └───src
        ├─── components
        │   └─── PageLayout.jsx
        │   └─── ProfileData.jsx
        │   └─── SignInButton.jsx
        │   └─── SignOutButton.jsx
        └── App.css
        └── App.jsx
        └── authConfig.js
        └── graph.js
        └── index.css
        └── index.js
    ```

### [Visual Studio Code](#tab/visual-studio-code)

1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following commands to create a new React project with the name *reactspalocal*, change to the new directory and start the React project. A web browser will open with the address `http://localhost:3000/` by default. The browser remains open and re-renders for every saved change.

    ```console
    npx create-react-app reactspalocal
    cd reactspalocal
    npm start
    ```

1. Create additional folders and files to achieve the following folder structure:

    ```javascript
    ├─── public
    │   └─── index.html
    └───src
        ├─── components
        │   └─── PageLayout.jsx
        │   └─── ProfileData.jsx
        │   └─── SignInButton.jsx
        │   └─── SignOutButton.jsx
        └── App.css
        └── App.jsx
        └── authConfig.js
        └── graph.js
        └── index.css
        └── index.js
    ```
---

## Install identity and bootstrap packages

Identity related **npm** packages must be installed in the project to enable user authentication. For project styling, **Bootstrap** will be used.

### [Visual Studio](#tab/visual-studio)

1. In the **Solution Explorer**, right-click the **npm** option and select **Install new npm packages**.
1. Search for **@azure/MSAL-browser**, then select **Install Package**. Repeat for **@azure/MSAL-react**.
1. Search for and install **react-bootstrap**.
1. Select **Close**.

### [Visual Studio Code](#tab/visual-studio-code)

1. In the **Terminal** bar, select the **+** icon to create a new terminal. A separate terminal window will open with the previous node terminal continuing to run in the background.
1. Ensure that the correct directory is selected (*reactspalocal*) then enter the following into the terminal to install the relevant `msal` and `bootstrap` packages.

    ```console
    npm install @azure/msal-browser @azure/msal-react
    npm install react-bootstrap bootstrap
    ```
---

To learn more about these packages refer to the documentation in [`msal-browser`](/javascript/api/@azure/msal-browser) and [`msal-react`](/javascript/api/@azure/msal-react).

## Modify *index.js* to include the authentication provider

All parts of the app that require authentication must be wrapped in the [`MsalProvider`](/javascript/api/@azure/msal-react/#@azure-msal-react-msalprovider) component. You instantiate a [PublicClientApplication](/javascript/api/@azure/msal-browser/publicclientapplication) then pass it to `MsalProvider`.

1. In the *src* folder, open *index.js* and replace the contents of the file with the following code snippet to use the `msal` packages and bootstrap styling:

    :::code language="javascript" source="~/../ms-identity-docs-code-javascript/react-spa/src/index.js" :::

1. Save the file.

## Add your tenant details to the MSAL configuration

The **authConfig.js** file contains the configuration settings for the authentication flow and is used to configure **MSAL.js** with the required settings for authentication.

### [Workforce tenant](#tab/workforce-tenant)

1. In the *src* folder, open *authConfig.js* and add the following code snippet:

   :::code language="javascript" source="~/../ms-identity-docs-code-javascript/react-spa/src/authConfig.js" :::

1. Replace the following values with the values from the Microsoft Entra admin center.
    - `clientId` - The identifier of the application, also referred to as the client. Replace `Enter_the_Application_Id_Here` with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    - `authority` - This is composed of two parts:
        - The *Instance* is endpoint of the cloud provider. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
        - The *Tenant ID* is the identifier of the tenant where the application is registered. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
1. Save the file.

### [External tenant](#tab/external-tenant)

1. In the *src* folder, open *authConfig.js* and add the following code snippet:

    ```javascript
    /*
     * Copyright (c) Microsoft Corporation. All rights reserved.
     * Licensed under the MIT License.
     */

    import { LogLevel } from '@azure/msal-browser';

    /**
     * Configuration object to be passed to MSAL instance on creation.
     * For a full list of MSAL.js configuration parameters, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md 
     */

    export const msalConfig = {
        auth: {
            clientId: 'Enter_the_Application_Id_Here', // This is the ONLY mandatory field that you need to supply.
            authority: 'https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/', // Replace the placeholder with your tenant subdomain 
            redirectUri: '/', // Points to window.location.origin. You must register this URI on Azure Portal/App Registration.
            postLogoutRedirectUri: '/', // Indicates the page to navigate after logout.
            navigateToLoginRequestUrl: false, // If "true", will navigate back to the original request location before processing the auth code response.
        },
        cache: {
            cacheLocation: 'sessionStorage', // Configures cache location. "sessionStorage" is more secure, but "localStorage" gives you SSO between tabs.
            storeAuthStateInCookie: false, // Set this to "true" if you are having issues on IE11 or Edge
        },
        system: {
            loggerOptions: {
                loggerCallback: (level, message, containsPii) => {
                    if (containsPii) {
                        return;
                    }
                    switch (level) {
                        case LogLevel.Error:
                            console.error(message);
                            return;
                        case LogLevel.Info:
                            console.info(message);
                            return;
                        case LogLevel.Verbose:
                            console.debug(message);
                            return;
                        case LogLevel.Warning:
                            console.warn(message);
                            return;
                        default:
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
     * https://docs.microsoft.com/azure/active-directory/develop/v2-permissions-and-consent#openid-connect-scopes
     */
    export const loginRequest = {
        scopes: [],
    };

    /**
     * An optional silentRequest object can be used to achieve silent SSO
     * between applications by providing a "login_hint" property.
     */
    // export const silentRequest = {
    //     scopes: ["openid", "profile"],
    //     loginHint: "example@domain.net"
    // };
    ```

1. Replace the following values with the values from the Azure portal:
    - Find the `Enter_the_Application_Id_Here` value and replace it with the **Application ID (clientId)** of the app you registered in the Microsoft Entra admin center.
    - In **Authority**, find `Enter_the_Tenant_Subdomain_Here` and replace it with the subdomain of your tenant. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, [learn how to read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
1. Save the file.

[!INCLUDE [external-id-custom-domain](./includes/use-custom-domain-url.md)]

--- 

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Create components for sign in and sign out in a React single-page app](tutorial-single-page-app-react-configure-authentication.md)
