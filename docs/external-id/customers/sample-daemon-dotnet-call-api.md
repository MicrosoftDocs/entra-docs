---
title: Call an API in a sample .NET daemon application
description: Learn how to configure a sample .NET daemon application that calls an API protected with Microsoft Entra External ID.

author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
ms.subservice: customers
ms.custom: devx-track-dotnet
ms.topic: quickstart
ms.date: 07/13/2023
#Customer intent: As a dev, devops, I want to configure a sample .NET daemon application that calls an API protected by my external tenant
---

# Call an API in a sample .NET daemon application 

This guide uses a sample .NET daemon application to show you how a daemon application acquires a token to call a protected web API. Microsoft Entra protects the web API.

A daemon application acquires a token on behalf of itself (not on behalf of a user). Users can't interact with a daemon application because it requires its own identity. This type of application requests an access token by using its application identity and presenting its application ID, credential (password or certificate), and application ID URI to Microsoft Entra External ID. 

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor
* [.NET 7.0](https://dotnet.microsoft.com/download/dotnet/7.0) or later. 
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register a daemon application and a web API

In this step, you create the daemon and the web API application registrations, and you specify the scopes of your web API.

### Register a web API application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/register-api-app.md)]

### Configure application roles

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-optional-claims-access.md)]

### Register the daemon application

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

### Create a client secret

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-client-secret.md)]

### Grant API permissions to the daemon application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-app-permissions.md)]

## Clone or download sample daemon application and web API

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Configure the sample daemon application and API

To use your app registration in the client web application sample:

1. In your code editor, open *ms-identity-ciam-dotnet-tutorial/2-Authorization/3-call-own-api-dotnet-core-daemon/ToDoListClient/appsettings.json* file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the daemon application you registered earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    - `Enter_the_Client_Secret_Here` and replace it with the daemon application secret value you copied earlier.
    - `Enter_the_Web_Api_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied earlier.

To use your app registration in the web API sample: 

1. In your code editor, open *ms-identity-ciam-dotnet-tutorial/2-Authorization/3-call-own-api-dotnet-core-daemon/ToDoListAPI/appsettings.json* file.

1. Find the placeholder:
    
    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied. 
    - `Enter_the_Tenant_Id_Here` and replace it with the Directory (tenant) ID you copied earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

##  Run and test sample daemon application and API 

1. Open a console window, then run the web API by using the following commands:

    ```console
    cd 2-Authorization\3-call-own-api-dotnet-core-daemon\ToDoListAPI
    dotnet run
    ``` 
1. Run the daemon client by using the following commands:

    ```console
    cd 2-Authorization\3-call-own-api-dotnet-core-daemon\ToDoListClient
    dotnet run
    ```

If your daemon application and web API successfully run, you should see something similar to the following JSON array in your console window:

```bash
Posting a to-do...
Retrieving to-do's from server...
To-do data:
ID: 1
User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Message: Bake bread
Posting a second to-do...
Retrieving to-do's from server...
To-do data:
ID: 1
User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Message: Bake bread
ID: 2
User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Message: Butter bread
Deleting a to-do...
Retrieving to-do's from server...
To-do data:
ID: 2
User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Message: Butter bread
Editing a to-do...
Retrieving to-do's from server...
To-do data:
ID: 2
User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Message: Eat bread
Deleting remaining to-do...
Retrieving to-do's from server...
There are no to-do's in server
```

## How it works

The daemon application use [OAuth2.0 client credentials grant](~/identity-platform/v2-oauth2-client-creds-grant-flow.md) to acquire an access token for itself and not for the user. The access token that the app requests contains the permissions represented as roles. The client credential flow uses this set of permissions in place of user scopes for application tokens. You [exposed these application permissions](#configure-application-roles) in the web API earlier, then [granted them to the daemon app](#grant-api-permissions-to-the-daemon-application). The daemon app in this article uses [Microsoft Authentication Library for .NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet) to simplify the process of acquiring a token.

On the API side, the web API must verify that the access token has the required permissions (application permissions). The web API rejects access tokens that don't have the required permissions. 

## Related content

- [Use our multi-part tutorial series to build this .NET daemon app from scratch](tutorial-daemon-dotnet-call-api-prepare-tenant.md)
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).
