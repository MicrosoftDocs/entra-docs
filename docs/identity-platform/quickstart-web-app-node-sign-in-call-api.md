---
title: Quickstart - Call a web API from a sample Nodejs web app
description: Learn how to configure a Node.js web app code sample to sign in users and call an API in an external tenant.
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: identity-platform 
ms.subservice: external
ms.topic: quickstart
ms.date: 03/10/2025
ms.custom:
#Customer intent: As a dev, devops, I want to learn about how to configure a Nodejs code sample web app to sign in and sign out users with my external tenant.
---

# Quickstart - Sign in users and call a web API in sample Node.js web app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this Quickstart, you learn how to sign in users and call a web API from a Node.js web application in your external tenant. The sample application calls a .NET API. The sample web application uses [Microsoft Authentication Library (MSAL)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) for Node to handle authentication.

## Prerequisites

* Complete the steps and prerequisites in [Quickstart: Sign in users in a sample web app](quickstart-web-app-sign-in.md?pivots=external&tabs=node-external) article. This article shows you how to sign in users by using a sample Node.js web app. 
* An external tenant. To create one, choose from the following methods:
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* Register a new app for your web API in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [Node.js](https://nodejs.org).
* [.NET 7.0](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install) or later.

## Configure API scopes and roles

By registering the web API, you must configure API scopes to define the permissions that a client application can request to access the web API. Additionally, you need to set up app roles to specify the roles available for users or applications, and grant the necessary API permissions to the web app to enable it to call the web API.

### Configure API scopes

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-api-scopes.md)]

### Configure app roles

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-optional-claims-access.md)]

Use the steps in [Configure optional claims](optional-claims.md?tabs=appui) article to add *idtyp* claim to the access token:

- For the **Token type** select **Access**.
- From the optional claims list, select **idtyp**.  

### Grant API permissions to the web app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/grant-api-permission-call-api.md)]

##  Clone or download sample web application and web API

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

##  Install project dependencies 

1. Open a console window, and change to the directory that contains the Node.js/Express sample app:

    ```console
    cd 2-Authorization\4-call-api-express\App
    ```
1. Run the following commands to install web app dependencies:

    ```console
    npm install && npm update
    ```

## Configure the sample web app and API

To use your app registration in the client web app sample:

1. In your code editor, open `App\authConfig.js` file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the client app you registered earlier. The client app is one that you registered in the prerequisites.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
    - `Enter_the_Client_Secret_Here` and replace it with the app secret value you copied earlier.
    - `Enter_the_Web_Api_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied earlier as part of the prerequisites.

To use your app registration in the web API sample: 

1. In your code editor, open `API\ToDoListAPI\appsettings.json` file.

1. Find the placeholder:
    
    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied. The web API app is one that you registered earlier sa part of the prerequisites.
    - `Enter_the_Tenant_Id_Here` and replace it with the Directory (tenant) ID you copied earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).


##  Run and test sample web app and API 

1. Open a console window, then run the web API by using the following commands:

    ```console
    cd 2-Authorization\4-call-api-express\API\ToDoListAPI
    dotnet run
    ``` 

1. Run the web app client by using the following commands:

    ```console
    cd 2-Authorization\4-call-api-express\App
    npm install
    npm start
    ```

1. Open your browser, then go to http://localhost:3000. 

1. Select the **Sign In** button. You're prompted to sign in.

    :::image type="content" source="media/how-to-web-app-node-sample-sign-in-call-api/web-app-node-sign-in.png" alt-text="Screenshot of sign in into a node web app.":::

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, after filling in your email, one-time passcode, new password and more account details, you complete the whole sign-up flow. You see a page similar to the following screenshot. You see a similar page if you choose the sign-in option.

    :::image type="content" source="media/how-to-web-app-node-sample-sign-in-call-api/sign-in-call-api-view-to-do.png" alt-text="Screenshot of sign in into a node web app and call an API.":::

### Call API

1. To call the API, select the **View your todolist** link. You see a page similar to the following screenshot.
    
    :::image type="content" source="media/how-to-web-app-node-sample-sign-in-call-api/sign-in-call-api-manipulate-to-do.png" alt-text="Screenshot of manipulate API to do list.":::

1. Manipulate the to-do list by creating and removing items.

### How it works

You trigger an API call each time you view, add, or remove a task. Each time you trigger an API call, the client web app acquires an access token with the required permissions (scopes) to call an API endpoint. For example, to read a task, the client web app must acquire an access token with `ToDoList.Read` permission/scope.

The web API endpoint needs to check if the permissions or scopes in the access token, provided by the client app, are valid. If the access token is valid, the endpoint responds to the HTTP request, otherwise, it responds with a `401 Unauthorized` HTTP error. 

## Related content

- [Tutorial: Secure an ASP.NET Core web API registered in an external tenant](../external-id/customers/tutorial-protect-web-api-dotnet-core-build-app.md).