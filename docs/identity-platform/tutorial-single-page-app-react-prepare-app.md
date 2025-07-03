---
title: "Tutorial: Prepare a React single-page application for authentication"
description: Learn how to prepare a React single-page app (SPA) for authentication using the Microsoft identity platform.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 05/25/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As a React developer, I want to know how to create a new React project in an IDE and add authentication.
---

# Tutorial: Create a React single-page application and prepare it for authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll build a React single-page application (SPA) and prepare it for authentication using the Microsoft identity platform. This tutorial demonstrates how to create a React SPA using `npm`, create files needed for authentication and authorization and add your tenant details to the source code. The application can be used for employees in a workforce tenant or for customers using an external tenant.

In this tutorial, you:

> [!div class="checklist"]
> * Create a new React project
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

## Create a new React project

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
        └─── styles
        │   └─── App.css
        │   └─── index.css
        ├─── utils
        │   └─── claimUtils.js
        ├─── components
        │   └─── DataDisplay.jsx
        │   └─── NavigationBar.jsx
        │   └─── PageLayout.jsx
        └── App.jsx
        └── authConfig.js
        └── index.js
    ```
---

## Install identity and bootstrap packages

Identity related **npm** packages must be installed in the project to enable user authentication. For project styling, **Bootstrap** will be used.

1. In the **Terminal** bar, select the **+** icon to create a new terminal. A separate terminal window will open with the previous node terminal continuing to run in the background.
1. Ensure that the correct directory is selected (*reactspalocal*) then enter the following into the terminal to install the relevant `msal` and `bootstrap` packages.

    ```console
    npm install @azure/msal-browser @azure/msal-react
    npm install react-bootstrap bootstrap
    ```
---

## Add your tenant details to the MSAL configuration

The *authConfig.js* file contains the configuration settings for the authentication flow and is used to configure **MSAL.js** with the required settings for authentication.

### [Workforce tenant](#tab/workforce-tenant)

1. In the *src* folder, open *authConfig.js* and add the following code snippet:

   ```javascript

    import { LogLevel } from '@azure/msal-browser';

    /**
    * Configuration object to be passed to MSAL instance on creation. 
    * For a full list of MSAL.js configuration parameters, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md 
    */

    export const msalConfig = {
        auth: {
            clientId: 'Enter_the_Application_Id_Here', // This is the ONLY mandatory field that you need to supply.
            authority: 'https://login.microsoftonline.com/Enter_the_Tenant_Info_Here', // Replace the placeholder with your tenant info
            redirectUri: 'http://localhost:3000/redirect', // Points to window.location.origin. You must register this URI on Microsoft Entra admin center/App Registration.
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
    * https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-permissions-and-consent#openid-connect-scopes
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

1. Replace the following values with the values from the Microsoft Entra admin center.
    - `clientId` - The identifier of the application, also referred to as the client. Replace `Enter_the_Application_Id_Here` with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    - `authority` - This is composed of two parts:
        - The *Instance* is endpoint of the cloud provider. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
        - The *Tenant ID* is the identifier of the tenant where the application is registered. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
1. Save the file.

### [External tenant](#tab/external-tenant)

1. In the *src* folder, open *authConfig.js* and add the following code snippet:

    ```javascript
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

1. Replace the following values with the values from the Entra admin center:
     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID in the Microsoft Entra admin center.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
1. Save the file.

[!INCLUDE [external-id-custom-domain](../external-id/customers/includes/use-custom-domain-url.md)]

---

## Add the authentication provider

The `msal` packages are used to provide authentication in the application. The `msal-browser` package is used to handle the authentication flow and the `msal-react` package is used to integrate `msal-browser` with React. `addEventCallback` is used to listen for events that occur during the authentication process, such as when a user successfully logs in. The `setActiveAccount` method is used to set the active account for the application, which is used to determine which user's information to display.

1. In the *src* folder, open *index.js* and replace the contents of the file with the following code snippet to use the `msal` packages and bootstrap styling:

    ```javascript
    import React from 'react';
    import { createRoot } from 'react-dom/client';
    import App from './App';
    import { PublicClientApplication, EventType } from '@azure/msal-browser';
    import { msalConfig } from './authConfig';

    import 'bootstrap/dist/css/bootstrap.min.css';
    import './styles/index.css';

    /**
    * MSAL should be instantiated outside of the component tree to prevent it from being re-instantiated on re-renders.
    * For more, visit: https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/getting-started.md
    */
    const msalInstance = new PublicClientApplication(msalConfig);

    // Default to using the first account if no account is active on page load
    if (!msalInstance.getActiveAccount() && msalInstance.getAllAccounts().length > 0) {
        // Account selection logic is app dependent. Adjust as needed for different use cases.
        msalInstance.setActiveAccount(msalInstance.getAllAccounts()[0]);
    }

    // Listen for sign-in event and set active account
    msalInstance.addEventCallback((event) => {
        if (event.eventType === EventType.LOGIN_SUCCESS && event.payload.account) {
            const account = event.payload.account;
            msalInstance.setActiveAccount(account);
        }
    });

    const root = createRoot(document.getElementById('root'));
    root.render(
        <App instance={msalInstance}/>
    );
    ```

1. Save the file.

To learn more about these packages refer to the documentation in [`msal-browser`](/javascript/api/@azure/msal-browser) and [`msal-react`](/javascript/api/@azure/msal-react).

## Add the main application component

All parts of the app that require authentication must be wrapped in the [`MsalProvider`](/javascript/api/@azure/msal-react/#@azure-msal-react-msalprovider) component. You set a an `instance` variable that calls the `useMsal` hook to get the [`PublicClientApplication`](/javascript/api/@azure/msal-browser/publicclientapplication) instance, and then pass it to `MsalProvider`. The `MsalProvider` component makes the `PublicClientApplication` instance available throughout your app via React's Context API. All components underneath `MsalProvider` will have access to the `PublicClientApplication` instance via context as well as all hooks and components provided by `msal-react`.

1. In the *src* folder, open *App.jsx* and replace the contents of the file with the following code snippet:

    ```javascript
    import { MsalProvider, AuthenticatedTemplate, useMsal, UnauthenticatedTemplate } from '@azure/msal-react';
    import { Container, Button } from 'react-bootstrap';
    import { PageLayout } from './components/PageLayout';
    import { IdTokenData } from './components/DataDisplay';
    import { loginRequest } from './authConfig';

    import './styles/App.css';

    /**
    * Most applications will need to conditionally render certain components based on whether a user is signed in or not. 
    * msal-react provides 2 easy ways to do this. AuthenticatedTemplate and UnauthenticatedTemplate components will 
    * only render their children if a user is authenticated or unauthenticated, respectively. For more, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/getting-started.md
    */
    const MainContent = () => {
        /**
        * useMsal is hook that returns the PublicClientApplication instance,
        * that tells you what msal is currently doing. For more, visit:
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/hooks.md
        */
        const { instance } = useMsal();
        const activeAccount = instance.getActiveAccount();

        const handleRedirect = () => {
            instance
                .loginRedirect({
                    ...loginRequest,
                    prompt: 'create',
                })
                .catch((error) => console.log(error));
        };
        return (
            <div className="App">
                <AuthenticatedTemplate>
                    {activeAccount ? (
                        <Container>
                            <IdTokenData idTokenClaims={activeAccount.idTokenClaims} />
                        </Container>
                    ) : null}
                </AuthenticatedTemplate>
                <UnauthenticatedTemplate>
                    <Button className="signInButton" onClick={handleRedirect} variant="primary">
                        Sign up
                    </Button>
                </UnauthenticatedTemplate>
            </div>
        );
    };


    /**
    * msal-react is built on the React context API and all parts of your app that require authentication must be 
    * wrapped in the MsalProvider component. You will first need to initialize an instance of PublicClientApplication 
    * then pass this to MsalProvider as a prop. All components underneath MsalProvider will have access to the 
    * PublicClientApplication instance via context as well as all hooks and components provided by msal-react. For more, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/getting-started.md
    */
    const App = ({ instance }) => {
        return (
            <MsalProvider instance={instance}>
                <PageLayout>
                    <MainContent />
                </PageLayout>
            </MsalProvider>
        );
    };

    export default App;
    ```

1. Save the file.

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Create components for sign in and sign out in a React single-page app](tutorial-single-page-app-react-configure-authentication.md)
