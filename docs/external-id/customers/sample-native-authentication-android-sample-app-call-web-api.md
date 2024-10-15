---
title: Call a web API in a sample Android mobile app
description: Learn how to call web API in Android sample app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: quickstart
ms.date: 08/21/2024
ms.custom: developer
#Customer intent: As a developer, I want to call a web API from a sample Android mobile app so that I can experience how Microsoft Entra's native authentication works.
---

# Sign in users and call an API in a sample Android mobile app by using native authentication

This article demonstrates how to configure a sample Android mobile application to call an ASP.NET Core web API.

## Prerequisites

- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md).

### Register a web API application

[!INCLUDE [register-api-app](./includes/register-app/register-api-app.md)]

### Configure API scopes

[!INCLUDE [add-api-scopes](./includes/register-app/add-api-scopes.md)]

### Configure app roles

[!INCLUDE [add-app-role](./includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [add-optional-claims-access](./includes/register-app/add-optional-claims-access.md)]

## Grant API permissions to the Android sample app

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


You need to host your web API for the Android sample app to call it. Follow [Quickstart: Deploy an ASP.NET web app](/azure/app-service/quickstart-dotnetcore) to deploy your web API.

## Configure sample Android mobile app to call web API

The sample allows you to configure multiple Web API URL endpoints and sets of scopes. In this case, you configure only one Web API URL endpoint and its associated scopes.

1. In your Android Studio, open `/app/src/main/java/com/azuresamples/msalnativeauthandroidkotlinsampleapp/AccessApiFragment.kt` file.
1. Find property named `WEB_API_URL_1` and set the URL to your web API.

    ```kotlin
    private const val WEB_API_URL_1 = "" // Developers should set the respective URL of their web API here
    ```
    
1. Find property named `scopesForAPI1` and set the scopes recorded in [Grant API permissions to the Android sample app](#grant-api-permissions-to-the-android-sample-app).

    ```kotlin
    private val scopesForAPI1 = listOf<String>() // Developers should set the respective scopes of their web API here. For example, private val scopes = listOf<String>("api://{clientId}/{ToDoList.Read}", "api://{clientId}/{ToDoList.ReadWrite}")
    ```
    
## Run Android sample app and call web API
 
To build and run your app, follow these steps:
 
1. In the toolbar, select your app from the run configurations menu.
1. In the target device menu, select the device that you want to run your app on.
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical device.
 
1. Select **Run** button. The app opens on the email and one-time passcode screen. 
1. Select the API tab to test the API call. A successful call to the web API returns HTTP `200`, while HTTP `403` signifies unauthorized access.

## Next steps

- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md).
