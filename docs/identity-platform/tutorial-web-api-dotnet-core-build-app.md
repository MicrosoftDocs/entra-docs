---
title: "Tutorial: Build and secure an ASP.NET Core web API with the Microsoft identity platform"
description: Protect the endpoint of an API, then run it to ensure it's listening for HTTP requests.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 2/21/2025
ms.service: identity-platform

ms.topic: tutorial

#Customer intent: As an application developer I want to protect the endpoint of my API and run it to ensure it is listening for HTTP requests
---

# Tutorial: Build and secure an ASP.NET Core web API with the Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial series demonstrates how to protect an ASP.NET Core web API with the Microsoft identity platform to limit it's access to only authorized users and client apps.The web API you build publishes both delegated permissions (scopes) and application permissions (app roles).

In this tutorial, you'll:

> [!div class="checklist"]
>
>- Build an ASP.NET Core web API 
>- Configure the web API to use it's Microsoft Entra app registration details
>- Protect your web API endpoints
>- Run the web API to ensure it's listening to HTTP requests


## Prerequisites

- If you haven't already, complete the steps in [Quickstart: Sign in users in a sample web app](quickstart-web-app-sign-in.md?pivots=external&tabs=node-external). In the quickstart, you don't have to clone and run the the code sample.
- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet) or later.
- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Create a new ASP.NET Core web API project

To create a minimal ASP.NET Core web API, follow these steps:

1. Open your terminal on Visual Studio Code or any other code editor and navigate to the directory where you want your project to live.
1. Run the following commands on the .NET CLI or any other command line tool.

    ```dotnetcli
    dotnet new webapi -n MyProtectedApi
    cd MyProtectedApi
    ```
1. When a dialog box asks if you want to trust the authors, select Yes.

1. When a dialog box asks if you want to add required assets to the project, select Yes.

1. The preceding commands will create a new minimal web API project named *myProtectedAPI*

## Install required packages

To protect an ASP.NET Core web API, you need the `Microsoft.Identity.Web` package - a set of ASP.NET Core libraries that simplify adding authentication and authorization support to web apps and web APIs integrating with the Microsoft identity platform.

To install the package, use:

```dotnetcli
dotnet add package Microsoft.Identity.
```
## Configure app registration details

Open the *appsettings.json* file in your app folder and add in the app registration details you recorded after registering your web API.

```json
{
    "AzureAd": {
        "Instance": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/",
        "TenantId": "Enter_the_Tenant_Id_Here",
        "ClientId": "Enter_the_Application_Id_Here",
    },
    "Logging": {...},
  "AllowedHosts": "*"
}
```
Replace the following placeholders as shown:

- Replace `Enter_the_Application_Id_Here` with your application (client) ID.
- Replace `Enter_the_Tenant_Id_Here` with your Directory (tenant) ID.
- Replace `Enter_the_Tenant_Subdomain_Here` with your Directory (tenant) subdomain.

### Use custom URL domain (Optional)

---
#### [Workforce tenant](#tab/workforce-tenant)

Custom URL domains are not supported in workforce tenants.

#### [External tenant](#tab/external-tenant)

[!INCLUDE [external-id-custom-domain](./includes/use-custom-domain-url.md)] 

---

## Add app role and scope

All APIs must publish a minimum of one scope, also called delegated permission, for the client apps to obtain an access token for a user successfully. APIs should also publish a minimum of one app role for applications, also called application permission, for the client apps to obtain an access token as themselves, that is, when they aren't signing-in a user.

We specify these permissions in the *appsettings.json* file. In this tutorial, we have registered XXX permissions. *ToDoList.ReadWrite* and *ToDoList.Read* as the delegated permissions, and *ToDoList.ReadWrite.All* and *ToDoList.Read.All* as the application permissions.

```json
{
  "AzureAd": {
    "Instance": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/",
    "TenantId": "Enter_the_Tenant_Id_Here",
    "ClientId": "Enter_the_Application_Id_Here",
    "Scopes": {
      "Read": "Forecast.Read",
    },
    "AppPermissions": {
      "Read": ["Forecast.Read"],
    }
  },
  "Logging": {...},
  "AllowedHosts": "*"
}
```

## Implement authentication in the API


## 

## 

## 

## 

## 

## Run your API


## Next Steps

Test your protected ASP.NET web API
