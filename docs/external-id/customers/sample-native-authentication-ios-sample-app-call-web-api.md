---
title: Sign in users and call an API in sample iOS mobile app by using native authentication
description: Learn how sign in users and call an API in sample iOS mobile app by using native authentication

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: sample
ms.date: 08/21/2024
ms.custom: developer
#Customer intent: As a developer, I aim to learn registering a web API, configuring API scopes, roles, optional claims, and calling a web API in an iOS sample app.
---

# Sign in users and call an API in sample iOS mobile app by using native authentication

This sample demonstrates how to configure iOS sample application to call an ASP.NET Core web API.

## Prerequisites

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](how-to-run-native-authentication-sample-ios-app.md).

### Register a web API application

[!INCLUDE [register-api-app](./includes/register-app/register-api-app.md)]

### Configure API scopes

[!INCLUDE [add-api-scopes](./includes/register-app/add-api-scopes.md)]

### Configure app roles

[!INCLUDE [add-app-role](./includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [add-optional-claims-access](./includes/register-app/add-optional-claims-access.md)]

## Grant API permissions to the iOS sample app

Once you've registered both your client app and web API and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

[!INCLUDE [grant-api-permission-call-api-common](./includes/register-app/grant-api-permission-call-api-common.md)]

## Clone or download sample web API

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Configure and run sample web API

1. In your code editor, open `2-Authorization/1-call-own-api-aspnet-core-mvc/ToDoListAPI/appsettings.json` file.
1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the web API you copied earlier. 
    - `Enter_the_Tenant_Id_Here` and replace it with the **Directory (tenant) ID** you copied earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

You need to host your web API for the iOS sample app to call it. Follow [Quickstart: Deploy an ASP.NET web app](/azure/app-service/quickstart-dotnetcore) to deploy your web API.

## Configure sample iOS mobile app to call web API

The sample allows you to configure multiple Web API URL endpoints and sets of scopes. In this case, you configure only one Web API URL endpoint and its associated scopes.

1. In your Xcode, open `/NativeAuthSampleApp/ProtectedAPIViewController.swift` file. If you're using macOS, here's a sample [ProtectedAPIViewController.swift](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/blob/main/NativeAuthSampleApp/ProtectedAPIViewController.swift) code file.
1. Find `protectedAPIUrl1` and enter your web API URL as its value.

    ```swift
    let protectedAPIUrl1: String? = nil // Developers should set the respective URL of their web API here. For example let protectedAPIUrl1: String? = "https://api.example.com/v1/resource"
    ```
    
1. Find `protectedAPIScopes1` and set the scopes recorded in [Grant API permissions to the iOS sample app](#grant-api-permissions-to-the-ios-sample-app).

    ```swift
    let protectedAPIScopes1: [String] = [] // Developers should set the respective scopes of their web API here.For example, let protectedAPIScopes = ["api://{clientId}/{ToDoList.Read}","api://{clientId}/{ToDoList.ReadWrite}"]
    ```
    
## Run iOS sample app and call web API 
 
To build and run your app, follow these steps:
 
1. To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 
1. Select the API tab to test the API call. A successful call to the web API returns HTTP `200`, while HTTP `403` signifies unauthorized access.

## Next steps

- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).
