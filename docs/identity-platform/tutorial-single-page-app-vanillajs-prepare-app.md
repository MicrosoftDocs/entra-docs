---
title: "Tutorial: Create a Vanilla JavaScript SPA for authentication in an external tenant"
description: Learn how to prepare a Vanilla JavaScript single-page app (SPA) for authentication and authorization with your external tenant.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: external
ms.custom: devx-track-js
ms.topic: tutorial
ms.date: 02/11/2024
#Customer intent: As a developer, I want to learn how to configure Vanilla JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Create a Vanilla JavaScript SPA for authentication in an external tenant

This tutorial is part 2 of a series that demonstrates building a Vanilla JavaScript (JS) single-page application (SPA) and preparing it for authentication using the Microsoft Entra admin center. This tutorial demonstrates how to create a Vanilla JavaScript SPA using `npm` and create files needed for authentication and authorization.

In this tutorial;

> [!div class="checklist"]
> - Create a Vanilla JavaScript project in Visual Studio Code
> - Install required packages
> - Add code to *server.js* to create a server

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customer/../external-id/customer/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator.
- Although any integrated development environment (IDE) that supports Vanilla JavaScript applications can be used, **Visual Studio Code** is recommended for this guide. It can be downloaded from the [Downloads](https://visualstudio.microsoft.com/downloads) page.
- [Node.js](https://nodejs.org/en/download/).

## Create a new Vanilla JavaScript project and install dependencies

1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following command to create a new Vanilla JavaScript project:

    ```powershell
    npm init -y
    ```

1. Create additional folders and files to achieve the following project structure:

    ```JavaScript
    └── public
        └── authConfig.js
        └── authPopup.js
        └── authRedirect.js
        └── claimUtils.js
        └── index.html
        └── signout.html
        └── styles.css
        └── ui.js    
        └── server.js
    ```

## Install app dependencies

1. In the **Terminal**, run the following command to install the required dependencies for the project:

    ```powershell
    npm install express morgan @azure/msal-browser
    ```

## Edit the *server.js* file

**Express** is a web application framework for **Node.js**. It's used to create a server that hosts the application. **Morgan** is the middleware that logs HTTP requests to the console. The server file is used to host these dependencies and contains the routes for the application. Authentication and authorization are handled by the [Microsoft Authentication Library for JavaScript (MSAL.js)](/javascript/api/overview).

1. Add the following code snippet to the *server.js* file:

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

    ```

In this code, the **app** variable is initialized with the **express** module and **express** is used to serve the public assets. **MSAL-browser** is served as a static asset and is used to initiate the authentication flow.

## Next step

> [!div class="nextstepaction"]
> [Part 3: Handle authentication flows in a Vanilla JavaScript SPA](tutorial-single-page-app-vanillajs-configure-authentication.md)
