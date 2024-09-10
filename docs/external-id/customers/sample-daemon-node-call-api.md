---
title: Call an API in a sample Node.js daemon application
description: Learn how to configure a sample Node.js daemon application that calls an API protected by an external tenant.

author: kengaderdus
manager: mwongerapk

ms.author: kengaderdus
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 07/29/2024
ms.custom: developer, devx-track-js
#Customer intent: As a dev, devops, I want to configure a sample Node.js daemon application that calls an API protected using my external tenant details.
---

# Call an API in a sample Node.js daemon application 

This guide uses a sample Node.js daemon application to show you how a daemon app acquires an access token to call a web API.

A daemon application acquires a token on behalf of itself (not on behalf of a user). Users can't interact with a daemon application because it requires its own identity. This type of application requests an access token by using its application identity and presenting its application ID, credential (password or certificate), and application ID URI to External ID.

A daemon app uses the standard [OAuth 2.0 client credentials grant](~/identity-platform/v2-oauth2-client-creds-grant-flow.md). To simplify the process of acquiring the token, the sample we use in this article uses [Microsoft Authentication Library for Node (MSAL Node)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node).

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [Node.js](https://nodejs.org).
* [.NET 7.0](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install) or later. 
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register a daemon application and a web API

In this step, you create the daemon and the web API application registrations, and you specify the scopes of your web API.

### Register a web API application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/register-api-app.md)]

### Configure app roles

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-optional-claims-access.md)]

### Register the daemon app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

### Create a client secret

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-client-secret.md)]

### Grant API permissions to the daemon app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-app-permissions.md)]

## Clone or download sample daemon application and web API

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- Alternatively, [download the samples .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip), then extract it to a file path where the length of the name is fewer than 260 characters.

##  Install project dependencies

1. Open a console window, and change to the directory that contains the Node.js sample app:

    ```console
    cd 2-Authorization\3-call-api-node-daemon\App
    ```
1. Run the following commands to install app dependencies:

    ```console
    npm install && npm update
    ```

## Configure the sample daemon app and API

To use your app registration in the client web app sample:

1. In your code editor, open `App\authConfig.js` file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the daemon app you registered earlier.
     
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    
    - `Enter_the_Client_Secret_Here` and replace it with the daemon app secret value you copied earlier.
    
    - `Enter_the_Web_Api_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied earlier.

To use your app registration in the web API sample: 

1. In your code editor, open `API\ToDoListAPI\appsettings.json` file.

1. Find the placeholder:
    
    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied. 
    
    - `Enter_the_Tenant_Id_Here` and replace it with the Directory (tenant) ID you copied earlier.
    
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

##  Run and test sample daemon app and API 

1. Open a console window, then run the web API by using the following commands:

    ```console
    cd 2-Authorization\3-call-api-node-daemon\API\ToDoListAPI
    dotnet run
    ``` 
1. Run the web app client by using the following commands:

    ```console
    2-Authorization\3-call-api-node-daemon\App
    node . --op getToDos
    ```

 - If your daemon app and web API successfully run, you should see something similar to the following JSON array in your console window

    ```json
    {
        "id": 1,
        "owner": "3e8....-db63-43a2-a767-5d7db...",
        "description": "Pick up grocery"
    },
    {
        "id": 2,
        "owner": "c3cc....-c4ec-4531-a197-cb919ed.....",
        "description": "Finish invoice report"
    },
    {
        "id": 3,
        "owner": "a35e....-3b8a-4632-8c4f-ffb840d.....",
        "description": "Water plants"
    }
    ```

### How it works

The Node.js app uses [OAuth 2.0 client credentials grant](~/identity-platform/v2-oauth2-client-creds-grant-flow.md) to acquire an access token for itself and not for the user. The access token that the app requests contains the permissions represented as roles. The client credential flow uses this set of permissions in place of user scopes for application tokens. You [exposed these application permissions](#configure-app-roles) in the web API earlier, then [granted them to the daemon app](#grant-api-permissions-to-the-daemon-app).

On the API side, the web API must verify that the access token has the required permissions (application permissions). The web API can't accept an access token that doesn't have the required permissions. 

### Access to data

A Web API endpoint should be prepared to accept calls from both users and applications. Therefore, it should have a way to respond to each request accordingly. For example, a call from a user via delegated permissions/scopes receives the user's data to-do list. On the other hand, a call from an application via application permissions/roles may receive the entire to-do list. However, in this article, we're only making an application call, so we didn't need to configure delegated permissions/scopes.

## Related content

- [Acquire an access token, then call a web API in your own Node.js daemon app](tutorial-daemon-node-call-api-prepare-tenant.md).
- [Use a client certificate instead of a secret for authentication in your Node.js confidential app](how-to-web-app-node-use-certificate.md).