---
title: 'Sign in users in a Node.js/Express web app by using Microsoft identity platform'
description: Set up node web app project that signs in users into customer facing app by in an external tenant or employees in a workforce tenant
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: tutorial
ms.date: 01/03/2025
#Customer intent: As a developer, devops, I want to learn about how to build a Node.js/Express web app that signs in users into customer facing app by in an external tenant or employees in a workforce tenant by using Microsoft identity platform'
---

# Tutorial: Set up a Node.js web app to sign in users by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you learn how to build a Node/Express.js web app that signs in users into customer facing app in an external tenant or employees in a workforce tenant. The tutorial also demonstrates how to acquire an access token for calling Microsoft Graph API.

This tutorial is part 1 of a 3-part series.

In this tutorial you'll;

> [!div class="checklist"]
>
> - Set up a Node.js project
> - Install dependencies
> - Add app views and UI components

## Prerequisites

#### [Workforce tenant](#tab/workforce-tenant)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Web** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:3000/auth/redirect`
  * **Front-channel logout URL**: `https://localhost:5001/signout-callback-oidc`
* Add a client secret to your app registration. **Do not** use client secrets in production apps. Use certificates or federated credentials instead. For more information, see [add credentials to your application](./how-to-add-credentials.md?tabs=client-secret).

#### [External tenant](#tab/external-tenant)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Web** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:3000/auth/redirect`
  * **Front-channel logout URL**: `https://localhost:5001/signout-callback-oidc`
* Add a client secret to your app registration. **Do not** use client secrets in production apps. Use certificates or federated credentials instead. For more information, see [add credentials to your application](./how-to-add-credentials.md?tabs=client-secret).
* Associate your app with a user flow in the Microsoft Entra admin center. This user flow can be used across multiple applications. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

---

* [Node.js](https://nodejs.org).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Create the Node.js project

1. In a location of choice in your computer, create a folder to host your node application, such as *ciam-sign-in-node-express-web-app*.

1. In your terminal, change directory into your Node web app folder, such as `cd ciam-sign-in-node-express-web-app`, then run the following command to create a new Node.js project:

    ```powershell
    npm init -y
    ```    
    The `init -y` command creates a default *package.json* file for your Node.js project. 

1. Create additional folders and files to achieve the following project structure:

    ```text
        ciam-sign-in-node-express-web-app/
        ├── server.js
        └── app.js
        └── authConfig.js
        └── package.json
        └── .env
        └── auth/
            └── AuthProvider.js
        └── controller/
            └── authController.js
        └── routes/
            └── auth.js
            └── index.js
            └── users.js
        └── views/
            └── layouts.hbs
            └── error.hbs
            └── id.hbs
            └── index.hbs   
        └── public/stylesheets/
            └── style.css
    ```

## Install app dependencies

To install required identity and Node.js related npm packages, run the following command in your terminal

```powershell
npm install express dotenv hbs express-session axios cookie-parser http-errors morgan @azure/msal-node   
```

## Build app UI components

1. In your code editor, open *views/index.hbs* file, then add the following code:

    ```html
        <h1>{{title}}</h1>
        {{#if isAuthenticated }}
        <p>Hi {{username}}!</p>
        <a href="/users/id">View ID token claims</a>
        <br>
        <a href="/auth/signout">Sign out</a>
        {{else}}
        <p>Welcome to {{title}}</p>
        <a href="/auth/signin">Sign in</a>
        {{/if}}
    ```
    In this view, if the user is authenticated, we show their username and links to visit `/auth/signout` and `/users/id` endpoints, otherwise, user needs to visit the `/auth/signin` endpoint to sign in. We define the express routes for these endpoints later in this article.

1. In your code editor, open *views/id.hbs* file, then add the following code:

    ```html
        <h1>Azure AD for customers</h1>
        <h3>ID Token</h3>
        <table>
            <tbody>
                {{#each idTokenClaims}}
                <tr>
                    <td>{{@key}}</td>
                    <td>{{this}}</td>
                </tr>
                {{/each}}
            </tbody>
        </table>
        <a href="/">Go back</a>
    ```
    We use this view to display ID token claims that Microsoft Entra External ID returns to this app after a user successfully signs in.  

1. In your code editor, open *views/error.hbs* file, then add the following code:

    ```html
        <h1>{{message}}</h1>
        <h2>{{error.status}}</h2>
        <pre>{{error.stack}}</pre>
    ```

    We use this view to display any errors that occur when the app runs.

1. In your code editor, open *views/layout.hbs* file, then add the following code:

    ```html
        <!DOCTYPE html>
        <html>        
            <head>
                <title>{{title}}</title>
                <link rel='stylesheet' href='/stylesheets/style.css' />
            </head>            
            <body>
                {{{content}}}
            </body>        
        </html>
    ```
    
    The `layout.hbs` file is in the layout file. It contains the HTML code that we require throughout the application view.    

1. In your code editor, open *public/stylesheets/style.css*, file, then add the following code:

    ```css
        body {
          padding: 50px;
          font: 14px "Lucida Grande", Helvetica, Arial, sans-serif;
        }
        
        a {
          color: #00B7FF;
        }
    ```

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Add add sign-in in your Node/Express.js web app](tutorial-web-app-node-sign-in-sign-out.md).