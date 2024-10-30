---
title: Sign in users in sample Android (Kotlin) mobile app 
description: Learn how to authenticate users in an external tenant using a sample Android (Kotlin) application.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: quickstart
ms.date: 04/04/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID works.
---

# Sign in users in sample Android (Kotlin) app

This guide demonstrates how to configure a sample Android mobile application to sign in users.
  
In this article, you do the following tasks: 
 
- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample Android mobile application.
 
## Prerequisites  

- <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 

## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-android.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant admin consent
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Clone sample Android mobile application  

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:
 
   ```console 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-android-sample
   ```

## Configure the sample Android mobile application

To enable authentication and access to Microsoft Graph resources, configure the sample by following these steps:
 
1. In Android Studio, open the project that you cloned. 
 
1. Open */app/src/main/res/raw/auth_config_ciam.json* file. 
1. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
   - `Enter_the_Redirect_Uri_Here` and replace it with the value of *redirect_uri* in the Microsoft Authentication Library (MSAL) configuration file you downloaded earlier when you added the platform redirect URL.
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
1. Open */app/src/main/AndroidManifest.xml* file.
1. Find the placeholder:

    - `ENTER_YOUR_SIGNATURE_HASH_HERE` and replace it with the **Signature Hash** that you generated earlier when you added the platform redirect URL.

1. Open */app/src/main/java/com/azuresamples/msaldelegatedandroidkotlinsampleapp/MainActivity.kt* file.
1. Find property named `scopes` and set the scopes recorded in [Grant admin consent](#grant-admin-consent). If you haven't recorded any scopes, you can leave this scope list empty.

    ```kotlin
    private const val scopes = "" // Developers should set the respective scopes of their Microsoft Graph resources here. For example, private const val scopes = "api://{clientId}/{ToDoList.Read} api://{clientId}/{ToDoList.ReadWrite}"
    ```
   
You've configured the app and it's ready to run. 

## Run and test the sample Android mobile application 
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
  
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button.
1. Select **Acquire Token Interactively** to request an access token.
1. If you select **API - Perform GET** to call a protected ASP.NET Core web API, you will get an error. 

For more information about calling a protected web API, see our [next steps](#next-steps) 

## Next steps

- [Sign in users and call a protected web API in sample Android (Kotlin) app](sample-mobile-app-android-kotlin-sign-in-call-api.md).
