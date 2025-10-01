---
title: Quickstart - Sign in users in a sample Node.js CLI app
description: Learn how to authenticate users in a sample Node.js Command Line Interface (CLI) application in your external tenant 
author: Dickson-Mwendia
manager: dougeby
ms.author: dmwendia
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.custom:
#Customer intent: As a dev, devops, I want to learn how to authenticate users in a sample Node.js Command Line Interface (CLI) application in your external tenant
---

# Quickstart: Sign in users in a sample Node.js CLI application 

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this quickstart, you use a sample Node Command Line Interface (CLI) application to sign in users in your external tenant. The sample application uses the [Microsoft Authentication Library for Node](/javascript/api/%40azure/msal-node/) (MSAL Node) to handle authentication.  

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [Node.js](https://nodejs.org).
* An external tenant. To create one, choose from the following methods:
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Mobile and desktop applications** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Custom redirect URIs**: `http://localhost` 
* Associate your app with a user flow in the Microsoft Entra admin center. This user flow can be used across multiple applications. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).


## Enable public client flows

[!INCLUDE [active-directory-b2c-enable-public-client-flow](../external-id/customers/includes/register-app/enable-public-client-flow.md)]  

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
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details)

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

1. Go back to the terminal and see your authentication information including the ID token claims.

## Related content

- [Sign in users in your own Node.js CLI application](./tutorial-cli-app-node-sign-in-prepare-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).