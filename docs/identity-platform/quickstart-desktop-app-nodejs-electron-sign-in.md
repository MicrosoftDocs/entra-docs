---
title: "Quickstart: Sign in users and call Microsoft Graph from a Node.js desktop app"
description: In this quickstart, you learn how a Node.js Electron desktop application can sign-in users and get an access token to call an API protected by a Microsoft identity platform endpoint
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: mode-api, devx-track-js
ms.date: 04/09/2024
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to learn how my Node.js Electron desktop application can get an access token and call an API that's protected by a Microsoft identity platform endpoint.
---

# Quickstart: Sign in users and call Microsoft Graph from a Node.js desktop app

In this quickstart, you download and run a code sample that demonstrates how an Electron desktop application can sign in users and acquire access tokens to call the Microsoft Graph API.

This quickstart uses the [Microsoft Authentication Library for Node.js (MSAL Node)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) with the [authorization code flow with PKCE](v2-oauth2-auth-code-flow.md).

## Prerequisites

* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor


## Register and download the sample application

Follow the steps below to get started.

#### Step 1: Register the application

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To register your application and add the app's registration information to your solution manually, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Enter a **Name** for your application, for example `msal-node-desktop`. Users of your app might see this name, and you can change it later.
1. Select **Register** to create the application.
1. Under **Manage**, select **Authentication**.
1. Select **Add a platform** > **Mobile and desktop applications**.
1. In the **Redirect URIs** section, enter `http://localhost`.
1. Select **Configure**.

#### Step 2: Download the Electron sample project


[Download the code sample](https://github.com/azure-samples/ms-identity-javascript-nodejs-desktop/archive/main.zip)

#### Step 3: Configure the Electron sample project

*Extract the project, open the *ms-identity-JavaScript-nodejs-desktop-main* folder, and then open *.authConfig.js* file. Replace the value as follows:

| Variable  |  Description | Example(s) |
|-----------|--------------|------------|
| `Enter_the_Cloud_Instance_Id_Here` | The Azure cloud instance in which your application is registered | `https://login.microsoftonline.com/` (include the trailing forward-slash)|
| `Enter_the_Tenant_Id_Here` | Tenant ID or Primary domain | `contoso.microsoft.com` or `aaaabbbb-0000-cccc-1111-dddd2222eeee` |
| `Enter_the_Application_Id_Here` | Client ID of the application you registered | `00001111-aaaa-2222-bbbb-3333cccc4444` |
| `Enter_the_Redirect_Uri_Here` | Redirect Uri of the application you registered | `msal00001111-aaaa-2222-bbbb-3333cccc4444://auth` |
| `Enter_the_Graph_Endpoint_Here` | The Microsoft Graph API cloud instance that your app will call | `https://graph.microsoft.com/`  (include the trailing forward-slash)|

Your file should look similar to below:

   ```javascript   
   const AAD_ENDPOINT_HOST = "https://login.microsoftonline.com/"; // include the trailing slash

   const msalConfig = {
       auth: {
           clientId: "00001111-aaaa-2222-bbbb-3333cccc4444",
           authority: `${AAD_ENDPOINT_HOST}/aaaabbbb-0000-cccc-1111-dddd2222eeee`,
       },
       system: {
           loggerOptions: {
               loggerCallback(loglevel, message, containsPii) {
                    console.log(message);
                },
                piiLoggingEnabled: false,
                logLevel: LogLevel.Verbose,
           }
       }
   }

   const GRAPH_ENDPOINT_HOST = "https://graph.microsoft.com/"; // include the trailing slash

   const protectedResources = {
        graphMe: {
            endpoint: `${GRAPH_ENDPOINT_HOST}v1.0/me`,
            scopes: ["User.Read"],
        }
   };

   module.exports = {
        msalConfig: msalConfig,
        protectedResources: protectedResources,
    };

   ```

#### Step 4: Run the application

1. You'll need to install the dependencies of this sample once:

    ```console
    cd ms-identity-javascript-nodejs-desktop-main
    npm install
    ```

1. Then, run the application via command prompt or console:

    ```console
    npm start
    ```

1. Select **Sign in** to start the sign-in process.

    The first time you sign in, you're prompted to provide your consent to allow the application to sign you in and access your profile. After you're signed in successfully, you'll be redirected back to the application.

## More information

### How the sample works

When a user selects the **Sign In** button for the first time, `acquireTokenInteractive` method of MSAL Node is called. This method redirects the user to sign-in with the *Microsoft identity platform endpoint*, obtains an **authorization code**, and then exchanges it for an access token.

### MSAL Node

[MSAL Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) is the library used to sign in users and request tokens used to access an API protected by Microsoft identity platform. For more information on how to use MSAL Node with desktop apps, see [this article](scenario-desktop-app-registration.md).

You can install MSAL Node by running the following npm command.

```console
npm install @azure/msal-node --save
```
## Next steps

To learn more about Electron desktop app development with MSAL Node, see the tutorial:

> [!div class="nextstepaction"]
> [Tutorial: Sign in users and call the Microsoft Graph API in an Electron desktop app](tutorial-v2-nodejs-desktop.md)
