---
title: "Sign in users in a React single-page app (SPA) by using native authentication"
description: Learn how to configure a sample React single-page app (SPA) that uses native authentication API to sign up users.
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: quickstart
ms.date: 02/07/2025
#Customer intent: As a developer, I want to configure a sample React single-page application using native authentication so that I can authenticate users, including sign-up, sign-in, sign-out, and password reset flows.
---

# Quickstart: Sign in users in a React single-page app by using native authentication (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this quickstart, you use a React single-page application (SPA) to demonstrate how to authenticate users by using [native authentication API](reference-native-authentication-api.md). The sample app demonstrates user sign-up, sign-in, sign-out and password reset with an email and a password.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
* An external tenant. To create one, choose from the following methods:
  * Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code. *(Recommended)*
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* A user flow. For more information, refer to [create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md). Ensure that the user flow includes the following user attributes:
  * **Given Name**
  * **Surname**
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* [Add your application to the user flow](/entra/external-id/customers/how-to-user-flow-add-application)
* [Node.js](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../external-id/customers/includes/native-auth/enable-native-authentication.md)]

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

```console
git clone https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples.git
```

Alternatively, [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/archive/refs/heads/main.zip), then extract it to a file path where the length of the name is fewer than 260 characters.

## Install project dependencies

1. Open a terminal window and navigate to the directory that contains the React sample app:

    ```console
    cd API\React\ReactAuthSimple
    ```

1. Run the following command to install app dependencies:

    ```console
    npm install
    ```

## Configure the sample React app

1. In your code editor, open *src\config.ts* file.

1. Find the placeholder `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.

1. Save the changes.

## Configure CORS proxy server

The native authentication APIs don't support [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/docs/Web/HTTP/CORS) so you must set up a proxy server between your SPA app and the APIs.

This code sample includes a CORS proxy server that forwards requests to native authentication API URL endpoints. The CORS proxy server is a Node.js server that listens on port 3001.

To configure the proxy server, open the *proxy.config.js* file, then the find the placeholder:

- `tenantSubdomain` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
- `tenantId` and replace it with the Directory (tenant) ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

## Run and test your app

You've now configured the sample app and it's ready to run.

1. From your terminal window, run the following commands to start the CORS proxy server:

    ```console
    cd API\React\ReactAuthSimple
    npm run cors
    ```

1. To start your React app, open another terminal window, then run the following commands:

    ```console
    cd API\React\ReactAuthSimple
    npm start
    ```

1. Open a web browser and go to `http://localhost:3000/`.

1. To sign up for an account, select **Sign Up**, then follow the prompts.

1. After you sign up, test sign-in and password reset by selecting **Sign In** and **Reset Password** respectively.

## Related content

- [Set up a reverse proxy for a single-page app that uses native authentication API by using Azure Function App](how-to-native-authentication-cors-solution-test-environment.md).
- [Use Azure Front Door as a reverse proxy in production environment for a single-page app that uses native authentication](how-to-native-authentication-cors-solution-production-environment.md).
- [Build a React single-page app that uses native authentication API from scratch](tutorial-native-authentication-single-page-app-react-sign-up.md).