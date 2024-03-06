---
title: Call web API in iOS sample app
description: Learn how to call web API in iOS sample app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to call web API in iOS sample app.
---

# Tutorial: Call a web API in iOS sample app 

This tutorial demonstrates how to configure iOS sample application to call an ASP.NET Core web API.

In this tutorial, you learn how to: 

- Add permissions to access your web API
- Configure sample iOS mobile app to call web API
- Run and test sample iOS mobile application 

## Prerequisites

- [How to run the iOS sample app](how-to-run-native-authentication-sample-ios-app.md).
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

## Configure sample iOS mobile app to call web API

1. In your Xcode, open `/NativeAuthSampleApp/ProtectedAPIViewController.swift` file.
1. Find `Enter_the_Protected_API_Full_URL_Here` and replace this value with your web API URL.

    ```swift
    let protectedAPIUrl = "Enter_the_Protected_API_Full_URL_Here" // Developers should set the respective URL of their web API here
    ```
    
1. Find `Enter_the_Protected_API_Scopes_Here` and set the scopes recorded in [Add permissions to access your web API](#add-permissions-to-access-your-web-api).

    ```swift
    let protectedAPIScopes = ["Enter_the_Protected_API_Scopes_Here"] // Developers should set the respective scopes of their web API here.For example, let protectedAPIScopes = ["pi://{clientId}/{ToDoList.Read}","api://{clientId}/{ToDoList.ReadWrite}"]
    ```
    
## Run and test sample iOS mobile application  
 
To build and run your app, follow these steps:
 
1. To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 

## Next steps

- [Tutorial: Self-service password reset](tutorial-native-authentication-ios-self-service-password-reset.md) 
