---
title: "Quickstart: Sign in users in JavaScript React single-page apps (SPA) with auth code and call Microsoft Graph"
description: In this quickstart, learn how a JavaScript React single-page application (SPA) can sign in users of personal accounts, work accounts, and school accounts by using the authorization code flow and call Microsoft Graph.
ROBOTS: NOINDEX
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom:
ms.date: 02/27/2024
ms.reviewer: 
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an app developer, I want to learn how to login, logout, conditionally render components to authenticated users, and acquire an access token for a protected resource such as Microsoft Graph by using the Microsoft identity platform so that my JavaScript React app can sign in users of personal accounts, work accounts, and school accounts.
---
> # Quickstart: Sign in and get an access token in a React SPA using the auth code flow


> [!div renderon="docs"]
> Welcome! This probably isn't the page you were expecting. While we work on a fix, this link should take you to the right article:
>
> > [Quickstart: Sign in users in single-page apps (SPA) via the authorization code flow with Proof Key for Code Exchange (PKCE) using React](quickstart-single-page-app-react-sign-in.md)
> 
> We apologize for the inconvenience and appreciate your patience while we work to get this resolved.

> [!div renderon="portal" class="sxs-lookup"]
> In this quickstart, you download and run a code sample that demonstrates how a JavaScript React single-page application (SPA) can sign in users and call Microsoft Graph using the authorization code flow. The code sample demonstrates how to get an access token to call the Microsoft Graph API or any web API.
> 
> See [How the sample works](#how-the-sample-works) for an illustration.
> 
> ## Prerequisites
> 
> * Azure subscription - [Create an Azure subscription for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F)
> * [Node.js](https://nodejs.org/en/download/)
> * [Visual Studio Code](https://code.visualstudio.com/download) or another code editor
> 
> #### Step 1: Configure your application in the Azure portal
> 
> This code samples requires a **Redirect URI** of `http://localhost:3000/`.
> > [!div class="nextstepaction"]
> > [Make these changes for me]()
> 
> > [!div class="alert alert-info"]
> > ![Already configured](media/quickstart-v2-javascript/green-check.png) Your application is configured with these attributes.
> 
> #### Step 2: Download the project
> 
> Run the project with a web server by using Node.js
> 
> > [Download the code sample](https://github.com/Azure-Samples/ms-identity-javascript-v2/archive/refs/heads/master.zip)
> 
> > [!div class="sxs-lookup"]
> > > [!NOTE]
> > > `Enter_the_Supported_Account_Info_Here`
> 
> 
> #### Step 3: Your app is configured and ready to run
> We have configured your project with values of your app's properties.
> 
> #### Step 4: Run the project
> 
> Run the project with a web server by using Node.js:
> 
> 1. To start the server, run the following commands from within the project directory:
>     ```console
>     npm install
>     npm start
>     ```
> 1. Browse to `http://localhost:3000/`.
> 
> 1. Select **Sign In** to start the sign-in process and then call the Microsoft Graph API.
> 
>     The first time you sign in, you're prompted to provide your consent to allow the application to access your profile and sign you in. After you're signed in successfully, click on the **Request Profile Information** to display your profile information on the page.
> 
> ## More information
> 
> ### How the sample works
> 
> ![Diagram showing the authorization code flow for a single-page application.](media/quickstart-v2-javascript-auth-code/diagram-01-auth-code-flow.png)
> 
> ### msal.js
> 
> The MSAL.js library signs in users and requests the tokens that are used to access an API that's protected by the Microsoft identity platform.
> 
> If you have Node.js installed, you can download the latest version by using the Node.js Package Manager (npm):
> 
> ```console
> npm install @azure/msal-browser @azure/msal-react
> ```
> 
> ## Next steps
> 
> For a detailed step-by-step guide on building the auth code flow application using React, see the following tutorial:
> 
> > [!div class="nextstepaction"]
> > [Tutorial: React single-page app (SPA) sign in users](./tutorial-single-page-app-react-prepare-app.md)
