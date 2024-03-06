---
title: Call web API in Android sample app
description: Learn how to call web API in Android sample app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 03/06/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to call web API in Android sample app.
---

# Tutorial: Call a web API in Android sample app 

This tutorial demonstrates how to configure Android sample application to call an ASP.NET Core web API.

In this tutorial, you learn how to: 

- Add permissions to access your web API
- Configure sample Android mobile app to call web API
- Run and test sample Android mobile application 

## Prerequisites

- [How to run the Android sample app](how-to-run-native-authentication-sample-android-app.md).

### Register a web API application

[!INCLUDE [register-api-app](./includes/register-app/register-api-app.md)]

### Configure API scopes

This API needs to expose permissions, which a client needs to acquire for calling the API:

[!INCLUDE [add-api-scopes](./includes/register-app/add-api-scopes.md)]

### Configure app roles

[!INCLUDE [add-app-role](./includes/register-app/add-app-role.md)]

### Configure optional claims

[!INCLUDE [add-optional-claims-access](./includes/register-app/add-optional-claims-access.md)]

## Grant API permissions to the Android sample app

You grant a client app access to your own web API, both of which you should have registered as part of the prerequisites. If you don't yet have both a client app and a web API registered, complete the steps in the two [Prerequisites](#prerequisites) articles.

Once you've registered both your client app and web API and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

[!INCLUDE [grant-api-permission-call-api-common](./includes/register-app/grant-api-permission-call-api-common.md)]

## Clone or download sample web API

To get the web API sample code, [download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip) or clone the sample web application from GitHub by running the following command:

```bash
git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
```

If you choose to download the .zip file, extract the sample app file to a folder where the total length of the path is 260 or fewer characters.

## Configure and run sample web API

1. In your code editor, open `2-Authorization/1-call-own-api-aspnet-core-mvc/ToDoListAPI/appsettings.json` file.
1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the web API you copied earlier. 
    - `Enter_the_Tenant_Id_Here` and replace it with the **Directory (tenant) ID** you copied earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Open a console window, then run the web API by using the following command:

    ```bash
    cd /2-Authorization/1-call-own-api-aspnet-core-mvc/ToDoListAPI

    dotnet run
    ```
    

## Configure sample Android mobile app to call web API

1. In your Android Studio, open `/app/src/main/java/com/azuresamples/msalnativeauthandroidkotlinsampleapp/AccessApiFragment.kt` file.
1. Find property named `WEB_API_BASE_URL` and set the URL to your web API.

    ```kotlin
    private const val WEB_API_BASE_URL = "" // Developers should set the respective URL of their web API here
    ```
    
1. Find property named `scopes` and set the scopes recorded in [Add permissions to access your web API](#add-permissions-to-access-your-web-api).

    ```kotlin
    private val scopes = listOf<String>() // Developers should set the respective scopes of their web API here. For example, private val scopes = listOf<String>("api://{clientId}/{ToDoList.Read}", "api://{clientId}/{ToDoList.ReadWrite}")
    ```
    
## Run and test sample Android mobile application  
 
To build and run your app, follow these steps:
 
1. In the toolbar, select your app from the run configurations menu.
1. In the target device menu, select the device that you want to run your app on.
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical device.
 
1. Select **Run** button. The app opens on the email and one-time passcode screen. 
1. Select the API tab for testing the API call.

## Next steps

- [Tutorial: Self-service password reset](tutorial-native-authentication-android-self-service-password-reset.md)
