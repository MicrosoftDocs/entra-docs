---
title: Sign in users in sample Android (Kotlin) mobile app 
description: Learn how to Authenticate users in a Microsoft Entra ID for customers tenant using a sample Android (Kotlin) application.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 03/20/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users and call a protected web API from a sample Android mobile app so that I can experience how Microsoft Entra ID for customers work.
---

# Sign in users and call web API in sample Android (Kotlin) mobile app

This guide shows how to run an Android sample application that demonstrates sign in users and call a protected web API using Microsoft Entra ID for customers. 
  
In this article, you do the following tasks: 
 
- Register a web application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.  
- Create user flow.  
- Associate your application with the user flow.  
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample native Android mobile application.  
 
## Prerequisites  

- <a href="https://developer.android.com/studio/archive" target="_blank">Android Studio Dolphin | 2021.3.1 Patch 1</a>.
- Microsoft Entra External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](sample-native-authentication-android-sample-app-call-web-api.md) to have a functional protected web API. Make sure you complete the following steps:

    - Register a web API application
    - Configure API scopes
    - Configure app roles
    - Configure optional claims
    - Clone or download sample web API
    - Configure and run sample web API

## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-android.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant API permissions
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-native-authentication-api-permission.md)]

## Grant web API permissions to the Android sample app

Once you've registered both your client app and web API and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

[!INCLUDE [grant-api-permission-call-api-common](../customers/includes/register-app/grant-api-permission-call-api-common.md)]

## Create a user flow
 
[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow.md)]
 
## Associate the app with the user flows

[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)]

## Clone sample Android mobile application  

1. Open Terminal and navigate to a directory where you want to keep the code.  
1. Clone the application from GitHub by running the following command:  
 
   ```bash 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-android-sample
   ```
 
## Configure the sample Android mobile application  
 
1. In Android Studio, open the project that you cloned. 
 
1. Open */app/src/main/res/raw/auth_config_ciam.json* file. 
1. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
   - `Enter_the_Redirect_Uri_Here` and replace it with the value of *redirect_uri* in the MSAL configuration file you downloaded earlier when you added the platform redirect URL.
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
1. Open */app/src/main/AndroidManifest.xml* file.
1. Find the placeholder:

    - `ENTER_YOUR_SIGNATURE_HASH_HERE` and replace it with the **Signature Hash** that you generated earlier when you added the platform redirect URL.

1. Open */app/src/main/java/com/azuresamples/msaldelegatedandroidkotlinsampleapp/MainActivity.kt* file.
1. Find property named `WEB_API_BASE_URL` and set the URL to your web API.
1. Find property named `scopes` and set the scopes recorded in [Grant web API permissions to the Android sample app](#grant-web-api-permissions-to-the-android-sample-app).

    ```kotlin
    private const val scopes = "" // Developers should set the respective scopes of their web API here. For example, private const val scopes = "api://{clientId}/{ToDoList.Read}"
    ```
   
You've now configured the app and it's ready to run. 

## Run and test the sample Android mobile application 
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
  
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button.

## Related content

- [How to run the Android sample app](how-to-run-native-authentication-sample-android-app.md).
