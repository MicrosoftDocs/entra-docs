---
title: Sign in users in a sample Angular single-page application.
description: Learn how to configure a sample Angular Single Page Application (SPA) using Microsoft Entra External ID.
 
author: garrodonnell
manager: celestedg
ms.author: godonnell
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 04/10/2024
ms.custom: developer

#Customer intent: As a dev, devops, I want to learn about how to configure a sample Angular Single-page application to sign in and sign out users with my external tenant
---

# Sign in users in a sample Angular single-page application 

This how-to guide uses a sample Angular single-page application (SPA) to demonstrate how to add authentication users into a SPA. The SPA enables users to sign in and sign out by using your external tenant. The sample uses the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) to handle authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the SPA in the Microsoft Entra admin center

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-angular.md)]

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
    cd 1-Authentication\2-sign-in-angular\SPA
    ```

1. Install the project dependencies:

    ```console
    npm install
    ```

## Configure the sample SPA

1. Open `SPA/src/app/auth-config.ts` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Save the file.

## Run your project and sign in

All the required code snippets have been added, so the application can now be called and tested in a web browser.

1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following command to start your web server.

    ```console
    cd 1-Authentication\2-sign-in-angular\SPA
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:4200/`.

1. Sign-in with an account registered to the external tenant.

1. Once you successfully sign-in, the display name is shown next to the **Sign out** button.

## Related content

- [Use our multi-part tutorial series to build this Angular SPA from scratch](tutorial-single-page-app-angular-sign-in-prepare-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).