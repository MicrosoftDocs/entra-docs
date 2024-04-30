---
title: "Tutorial: Create a Node.js CLI app for authentication"
description: Learn how to build a Node.js CLI app that signs in users in an external tenant
 
author: Dickson-Mwendia
manager: mwongerapk

ms.author: dmwendia
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: tutorial
ms.date: 08/04/2023
ms.custom: developer, devx-track-js

#Customer intent: As a dev, devops, I want to learn how to build a Node.js CLI application that signs in users in an external tenant.
---

# Tutorial: Prepare a Node.js CLI application for authentication

This tutorial is part 2 of a series that demonstrates building a Node.js command line interface (CLI) app and preparing it for authentication using the Microsoft Entra admin center. In [part 1 of this series](./tutorial-cli-app-node-sign-in-prepare-tenant.md), you registered an application and configured user flows in your external tenant. The client application you build uses the [OAuth 2.0 Authorization Code Flow](~/identity-platform/v2-oauth2-auth-code-flow.md) with Proof Key for Code Exchange (PKCE) for secure user authentication.

In this tutorial: 

> [!div class="checklist"]
>
> - Create a new Node.js application project
> - Install app dependencies
> - Create the MSAL configuration object

## Prerequisites

- [Tutorial: Prepare your external tenant to sign in users in a Node.js CLI app](tutorial-cli-app-node-sign-in-prepare-tenant.md)
- Although any integrated development environment (IDE) that supports React applications can be used, this tutorial uses [Visual Studio Code](https://visualstudio.microsoft.com/downloads/).
- [Node.js](https://nodejs.org).

## Create a new Node.js application project

Here, you build a new Node.js CLI app from scratch. If you prefer using a completed code sample for learning, download the [sample Node.js CLI application](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip) from GitHub.

To build the Node.js CLI application from scratch, follow these steps:

1. Create a folder to host your application and give it a name, such as *ciam-sign-in-node-cli-app*.

1. In your terminal, navigate to your project directory, such as `cd ciam-sign-in-node-cli-app` and initialize your project using `npm init`. 
 This creates a *package.json* file in your project folder, which contains references to all npm packages. 

1. In your project root directory, create two files, then name them *authConfig.js* and *index.js*. The *authConfig.js* file contains the authentication configuration parameters while *index.js* holds the app's authentication logic. 

 After you create the files, you should achieve the following project structure:

 ```
ciam-sign-in-node-cli-app/
    ├── authConfig.js
    └── index.js
    └── package.json
 ```

## Install app dependencies

The application you build uses MSAL Node to sign in users. To install the MSAL Node package as a dependency in your project, open the terminal in your project directory and run the following command. 

```powershell
npm install @azure/msal-node   
```

You'll also install the `open` package that allows your Node.js app to open URLs in the web browser. 

```powershell
npm install open
```

## Create the MSAL configuration object

In your code editor, open *authConfig.js*, which holds the MSAL object configuration parameters, and add the following code:

```javascript

const { LogLevel } = require('@azure/msal-node');

const msalConfig = {
    auth: {
        clientId: 'Enter_the_Application_Id_Here', 
        authority: `https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/`, 
    },
    system: {
        loggerOptions: {
            loggerCallback(loglevel, message, containsPii) {
                // console.log(message);
            },
            piiLoggingEnabled: false,
            logLevel: LogLevel.Verbose,
        },
    },
};
```
The `msalConfig` object contains a set of configuration options that can be used to customize the behavior of your authentication flows. This configuration object is passed into the instance of our public client application upon creation. In your *authConfig.js* file, find the placeholders:

- `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.

- `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For instance, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant domain name, [learn how to read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

In the configuration object, you also add `LoggerOptions`, which contains two options:

- `loggerCallback` - A callback function that handles the logging of MSAL statements
- `piiLoggingEnabled` - A config option that when set to true, enables logging of personally identifiable information (PII). For our app, we set this option to false. 

After creating the `msalConfig` object, add a `loginRequest` object that contains the scopes our application requires. Scopes define the level of access that the application has to user resources. Although the scopes array in the example snippet has no values, MSAL by default adds the OIDC scopes (openid, profile, email) to any login request. Users are asked to consent to these scopes during sign in. To create the `loginRequest` object, add the following code in *authConfig.js*.

```javascript
const loginRequest = {
    scopes: [],
};
```

In *authcConfig.js*, export the `msalConfig` and `loginRequest` objects to make them accessible when required by adding the following code:

```javascript
module.exports = {
    msalConfig: msalConfig,
    loginRequest: loginRequest,
};
```

## Next step

Learn how to add sign-in support to a Node.js CLI application:

> [!div class="nextstepaction"]
> [Part 3: Tutorial: Authenticate users in a Node.js CLI app](tutorial-cli-app-node-sign-in-sign-out.md)
