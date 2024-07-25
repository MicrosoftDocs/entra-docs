---
title: Authenticate users in an external tenant using a sample Node.js CLI app
description: Learn how to authenticate users in an external tenant using a sample Node.js CLI application.

author: Dickson-Mwendia
manager: mwongerapk

ms.author: dmwendia
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 08/04/2023
ms.custom: developer, devx-track-js
#Customer intent: As a dev, devops, I want to learn how to authenticate users in an external tenant using a sample Node.js CLI application
---

# Sign in users in a sample Node.js CLI application. 

This guide uses a sample Node Command Line Interface (CLI) application to sign in users in an external tenant. The sample application uses the [Microsoft Authentication Library for Node](/javascript/api/%40azure/msal-node/) (MSAL Node) to handle authentication.

In this article, you complete the following tasks:

- Register and configure a client Node.js CLI application in the Microsoft Entra admin center.

- Create a sign-up and sign-in user flow in the Microsoft Entra admin center, and then associate the CLI application with it.

- Update the sample CLI application to use your external tenant details.

- Run and test the sample CLI application. 

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [Node.js](https://nodejs.org).
* An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register the Node.js CLI app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)] 

## Add platform configurations

[!INCLUDE [active-directory-b2c-app-integration-add-platform-configurations](./includes/register-app/add-platform-redirect-url-node-cli.md)]

[!INCLUDE [active-directory-b2c-enable-public-client-flow](./includes/register-app/enable-public-client-flow.md)]  

## Grant admin consent

Since this app signs in users, add delegated permissions. These permissions allow the app to act on behalf of a signed-in user and access resources that the user has permissions to access. 

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)] 

## Create a user flow 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 

## Associate the Node.js CLI application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]


## Clone or download the sample Node.js CLI application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


## Configure the sample Node.js CLI application 

To configure the client application (Node.js CLI app) to use your Microsoft Entra app registration details, open the project in your IDE and follow these steps:

1. Open the *App\authConfig.js* file.
1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace the existing value with the application ID (clientId) of `node-cli-app` application copied from the Microsoft Entra admin center.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details)

## Run and test the sample Node.js CLI application

You can now test the sample Node.js CLI application.

1. In your terminal, run the following command:

    ```console
    cd 1-Authentication\6-sign-in-node-cli-app\App
    npm start
    ```

1. The browser opens up automatically and you should see a page similar to the following:

     :::image type="content" source="media/tutorial-node-cli-app-sign-in/node-cli-app-sign-in-page.png" alt-text="Screenshot of the sign in page in a node CLI application.":::

1. On the sign-in page, type your **Email address**. If you don't have an account, select **No account? Create one**, which starts the sign-up flow.

1. If you choose the sign-up option, after filling in your email, one-time passcode, new password, and more account details, you complete the whole sign-up flow. After completing the sign up flow and signing in, you see a page similar to the following screenshot:

     :::image type="content" source="media/tutorial-node-cli-app-sign-in/node-cli-app-signed-in-user.png" alt-text="Screenshot showing a signed-in user in a node CLI application.":::

1. Move back to the terminal and see your authentication information including the ID token claims.

## Related content

- [Sign in users in your own Node.js CLI application](tutorial-cli-app-node-sign-in-prepare-tenant.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).
