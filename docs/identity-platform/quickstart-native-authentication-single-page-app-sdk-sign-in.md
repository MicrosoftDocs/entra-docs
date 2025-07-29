---
title: Sign in users in a single-page app by using native authentication SDK
description: Configure a React single-page app with native authentication SDK to let users sign up, sign in, sign out, and reset passwords. Start with this quickstart.
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: quickstart
ms.date: 06/30/2025
#Customer intent: As a developer, I want to configure a sample single-page application using native authentication react SDK so that I can authenticate users, including sign-up, sign-in, sign-out, and password reset flows.
---

# Quickstart: Sign in users in a single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this Quickstart, you use a single-page application (SPA) to demonstrate how to authenticate users by using native authentication SDK. The sample app demonstrates user sign-up, sign-in, and sign-out for both email with password and email one-time passcode authentication flows.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
* An external tenant. To create one, choose from the following methods:
  * Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code. *(Recommended)*
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* A user flow. For more information, see [create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md). Under **Identity providers**, select your preferred method of authentication, that's, **Email with password** or **Email one-time passcode**. For this code sample, you can include the following user attributes in your user flow as the app submit these attributes:
  * **Given Name**
  * **Surname**
  * **Job Tittle**
  * **Country**
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

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

## Install project dependencies

#### [React](#tab/react)

1. Open a terminal window and navigate to the directory that contains the React sample app:

    ```console
        cd typescript/native-auth/react-nextjs-sample
    ```
1. Run the following command to install app dependencies:

    ```console
    npm install
    ```

#### [Angular](#tab/angular)

1. Open a terminal window and navigate to the directory that contains the React sample app:

    ```console
        cd typescript/native-auth/angular-sample
    ```
1. Run the following command to install app dependencies:

    ```console
    npm install
    ```

---


## Configure the sample React app

#### [React](#tab/react)

1. Open *src/config/auth-config.ts* and replace the following placeholders with the values obtained from the Microsoft Entra admin center:

    * Find the placeholder `Enter_the_Application_Id_Here` then  replace it with the Application (client) ID of the app you registered earlier.
    * Find the placeholder `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

1. Save the changes.

#### [Angular](#tab/angular)


1. Open *src/app/config/auth-config.ts* and replace the following placeholders with the values obtained from the Microsoft Entra admin center:

    * Find the placeholder `Enter_the_Application_Id_Here` then  replace it with the Application (client) ID of the app you registered earlier.
    * Find the placeholder `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.

1. Save the changes.

---


## Configure CORS proxy server

The native authentication API doesn't support [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/docs/Web/HTTP/CORS) so you must set up a proxy server between your SPA app and the APIs.

This code sample includes a CORS proxy server that forwards requests to native authentication API URL endpoints. The CORS proxy server is a Node.js server that listens on port 3001.

To configure the proxy server, open the *proxy.config.js* file, then the find the placeholder:

- `tenantSubdomain` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
- `tenantId` and replace it with the Directory (tenant) ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

## Run and test your app

You've now configured the sample app and it's ready to run.

#### [React](#tab/react)

1. From your terminal window, run the following commands to start the CORS proxy server:

    ```console
    cd typescript/native-auth/react-nextjs-sample/
    npm run cors
    ```

1. To start your React app, open another terminal window, then run the following commands:

    ```console
    cd typescript/native-auth/react-nextjs-sample/
    npm run dev
    ```

1. Open a web browser and go to `http://localhost:3000/`.

1. To sign up for an account, select **Sign Up**, then follow the prompts.

1. After you sign up, test sign-in and password reset by selecting **Sign In** and **Reset Password** buttorespectively.

#### [Angular](#tab/angular)

1. From your terminal window, run the following commands to start the CORS proxy server:

    ```console
    cd typescript/native-auth/angular-sample/
    npm run cors
    ```

1. To start your React app, open another terminal window, then run the following commands:

    ```console
    cd typescript/native-auth/angular-sample/
    npm run start
    ```

1. Open a web browser and go to `http://localhost:4200`.

1. To sign up for an account, select **Sign Up**, then follow the prompts.

1. After you sign up, test sign-in and password reset by selecting **Sign In** and **Reset Password** buttorespectively.

---

## Related content

- [Build a React single-page app that uses native authentication SDK to authenticate users](tutorial-native-authentication-single-page-app-react-sdk-sign-up.md).
- [Build your Angular single-page app that uses native authentication SDK to authenticate users](tutorial-native-authentication-single-page-app-angular-sign-up.md).