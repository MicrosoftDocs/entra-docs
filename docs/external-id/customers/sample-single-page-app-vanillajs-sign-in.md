---
title: Sign in users in a sample vanilla JavaScript single-page application
description: Learn how to configure a sample JavaScript single-page application (SPA) to sign in and sign out users.
 
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: customers
ms.custom: devx-track-js
ms.topic: sample
ms.date: 04/10/2024
#Customer intent: As a dev, devops, I want to learn about how to configure a sample vanilla JS SPA to sign in and sign out users with my external tenant. .
---

# Sign in users in a sample vanilla JavaScript single-page application

This guide uses a sample vanilla JavaScript (JS) single-page Application (SPA) to demonstrate how to add authentication to a SPA. The SPA enables users to sign in and sign out by using your external tenant. The sample uses the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) to handle authentication.

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [Node.js](https://nodejs.org/en/download/).
* An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register the SPA in the Microsoft Entra admin center

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-vanilla-js.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the SPA with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

## Install project dependencies

1. Open a terminal window in the root directory of the sample project, and enter the following snippet to navigate to the project folder:

    ```console
    cd 1-Authentication\0-sign-in-vanillajs\App
    ```

1. Install the project dependencies:

    ```console
    npm install
    ```

## Configure the sample SPA

1. Open `App/public/authConfig.js` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
     * `redirectUri: 'http://localhost:3000/redirect'`, Remove this line to redirect to the default value `http://localhost:3000/`. Otherwise you have to configure the redirect `http://localhost:3000/redirect` in the chapter before.
`
1. Save the file.

## Run your project and sign in

1. Open a new terminal and run the following command to start your express web server.

    ```console
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:3000/`.
1. Sign-in with an account registered to the external tenant.
1. Once signed in the display name is shown next to the **Sign out** button as shown in the following screenshot.
1. The SPA will now display a button saying **Request Profile Information**. Select it to display profile data.

    :::image type="content" source="media/how-to-spa-vanillajs-sign-in-sign-in-out/display-vanillajs-welcome.png" alt-text="Screenshot of sign in into a vanilla JS SPA." lightbox="media/how-to-spa-vanillajs-sign-in-sign-in-out/display-vanillajs-welcome.png":::

## Sign out of the application

1. To sign out of the application, select **Sign out** in the navigation bar.
1. A window appears asking which account to sign out of.
1. Upon successful sign out, a final window appears advising you to close all browser windows.

## Related content

- [Use our multi-part tutorial series to build this Vanilla JS SPA from scratch](tutorial-single-page-app-vanillajs-prepare-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).
