---
title: Call web API in Android sample app
description: Learn how to call web API in Android sample app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/23/2024
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
- [Tutorial: Secure an ASP.NET Core web API registered in a customer tenant](tutorial-protect-web-api-dotnet-core-build-app.md)


## Add permissions to access your web API

You grant a client app access to your own web API, both of which you should have registered as part of the prerequisites. If you don't yet have both a client app and a web API registered, complete the steps in the two [Prerequisites](#prerequisites) articles.

Once you've registered both your client app and web API and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your customer tenant from the **Directories + subscriptions** menu. 
1. Browse to **Identity** >**Applications** > **App registrations**, and then select your client application (not your web API).
1. Select **API permissions** > **Add a permission** > **APIs my organization uses**.
1. Select the web API you registered as part of the prerequisites (ciam-ToDoList-api).
1. Select **Delegated permissions**.
1. Under **Select permissions**, expand the resource whose scopes you defined for your web API, and select the permissions the client app should have on behalf of the signed-in user.

    If you used the scope names specified in the prerequisites, you should see **ToDoList.Read** and **ToDoList.ReadWrite**. Select **ToDoList.Read** and **ToDoList.ReadWrite**

1. Select **Add permissions** to complete the process.
1. At this point, you've assigned the permissions correctly. However, since the tenant is a customer's tenant, the consumer users themselves can't consent to these permissions. You as the admin must consent to these permissions on behalf of all the users in the tenant: 
 
   1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**. 
   1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes. 
 
    :::image type="content" source="media/common/web-api-permissions.png" alt-text="Screenshot showing configured permission in Microsoft Entra admin center." lightbox="media/common/web-api-permissions.png"::: 

1. From the **Configured permissions** list, select the **ToDoList.Read** and **ToDoList.ReadWrite** permissions, one at a time, and then copy the permission's full URI for later use. The full permission URI looks something similar to `api://{clientId}/{ToDoList.Read}` or `api://{clientId}/{ToDoList.ReadWrite}`.

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
