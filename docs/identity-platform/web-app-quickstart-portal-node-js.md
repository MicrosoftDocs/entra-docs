---
title: "Quickstart: Add authentication to a Node.js web app with MSAL Node"
description: In this quickstart, you learn how to implement authentication with a Node.js web app and the Microsoft Authentication Library (MSAL) for Node.js.
ROBOTS: NOINDEX
author: Dickson-Mwendia
manager: celested
ms.author: dmwendia
ms.custom: scenarios:getting-started, "languages:js", devx-track-js, mode-api
ms.date: 08/16/2022
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to know how to set up authentication in a web application built using Node.js and MSAL Node.
---
# Quickstart: Sign in users and get an access token in a Node.js web app using the authorization code flow

> [!div renderon="docs"]
> Welcome! This probably isn't the page you were expecting. While we work on a fix, this link should take you to the right article:
>
> > [Quickstart: Add authentication to a Node.js web app with MSAL Node](quickstart-web-app-nodejs-msal-sign-in.md)
> 
> We apologize for the inconvenience and appreciate your patience while we work to get this resolved.

> [!div renderon="portal" id="display-on-portal" class="sxs-lookup"]
> # Quickstart: Sign in users and get an access token in a Node.js web app using the authorization code flow
>
> In this quickstart, you download and run a code sample that demonstrates how a Node.js web app can sign in users by using the authorization code flow. The code sample also demonstrates how to get an access token to call Microsoft Graph API.
> 
> See [How the sample works](#how-the-sample-works) for an illustration.
> 
> This quickstart uses the Microsoft Authentication Library for Node.js (MSAL Node) with the authorization code flow.
> 
> ## Prerequisites
> 
> * An Azure subscription. [Create an Azure subscription for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
> * [Node.js](https://nodejs.org/en/download/)
> * [Visual Studio Code](https://code.visualstudio.com/download) or another code editor
> 
> #### Step 1: Configure the application in the Microsoft Entra admin center
> For the code sample for this quickstart to work, you need to create a client secret and add the following reply URL: `http:/> /localhost:3000/redirect`.
> 
> <button id="makechanges" class="nextstepaction configure-app-button"> Make these changes for me </button>
> 
> > [!div id="appconfigured" class="alert alert-info"]
> > ![Already configured](media/quickstart-v2-windows-desktop/green-check.png) Your application is configured with these > attributes.
> 
> #### Step 2: Download the project
> 
> Run the project with a web server by using Node.js.
> 
> > [!div class="nextstepaction"]
> > <button id="downloadsample" class="download-sample-button">Download the code sample</button>
> 
> #### Step 3: Your app is configured and ready to run
> 
> Run the project by using Node.js.
> 
> 1. To start the server, run the following commands from within the project directory:
> 
>     ```console
>     npm install
>     npm start
>     ```
> 
> 1. Go to `http://localhost:3000/`.
> 
> 1. Select **Sign In** to start the sign-in process.
> 
>     The first time you sign in, you're prompted to provide your consent to allow the application to access your profile and sign you in. After you're signed in successfully, you will see a log message in the command line.
> 
> ## More information
> 
> ### How the sample works
> 
> The sample hosts a web server on localhost, port 3000. When a web browser accesses this site, the sample immediately redirects the user to a Microsoft authentication page. Because of this, the sample does not contain any HTML or display elements. Authentication success displays the message "OK".
> 
> ### MSAL Node
> 
> The MSAL Node library signs in users and requests the tokens that are used to access an API that's protected by Microsoft identity platform. You can download the latest version by using the Node.js Package Manager (npm):
> 
> ```console
> npm install @azure/msal-node
> ```
> 
> ## Next steps
> 
> > [!div class="nextstepaction"]
> > [Adding Auth to an existing web app - GitHub code sample >](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/samples/msal-node-samples/auth-code)
