---
title: "Quickstart: Sign in to a SPA & call an API - JavaScript"
description: In this quickstart, learn how a JavaScript single-page application (SPA) can sign in users of personal accounts, work accounts, and school accounts by using the authorization code flow.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: scenarios:getting-started, languages:JavaScript, devx-track-js
ms.date: 03/05/2024
ms.reviewer: OwenRichards1
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an app developer, I want to learn how to get access tokens and refresh tokens by using the Microsoft identity platform so that my JavaScript app can sign in users of personal accounts, work accounts, and school accounts.
---

# Quickstart: Sign in users in a single-page app (SPA) and call the Microsoft Graph API using JavaScript

This quickstart uses a sample JavaScript (JS) single-page app (SPA) to show you how to sign in users by using the [authorization code flow](./v2-oauth2-auth-code-flow.md) with Proof Key for Code Exchange (PKCE) and call the Microsoft Graph API. The sample uses the [Microsoft Authentication Library for JavaScript](/javascript/api/%40azure/msal-react/) to handle authentication.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

## Register the application and record identifiers

[!INCLUDE [Register a single-page application](./includes/register-app/spa-common/register-application-spa-common.md)]

## Add a platform redirect URI

[!INCLUDE [Add a platform redirect URI](./includes/register-app/spa-common/add-platform-redirect-spa-port-3000.md)]

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-javascript.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Configure the project

1. In your IDE, open the project folder, *ms-identity-docs-code-javascript*, containing the sample.
1. Open *vanillajs-spa/App/public/authConfig.js* and update the following values with the information recorded earlier in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/vanillajs-spa/App/public/authConfig.js":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

## Run the application and sign in

Run the project with a web server by using Node.js:

1. To start the server, run the following commands from within the project directory:

    ```console
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png":::

## Sign out from the application

1. Find the **Sign out** button in the top right corner of the page, and select it.
1. You'll be prompted to pick an account to sign out from. Select the account you used to sign in.

A message appears indicating that you have signed out. You can now close the browser window.

## Related content

- [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).

- Learn more by building a React SPA that signs in users in the following multi-part [tutorial series](./tutorial-single-page-app-react-register-app.md).