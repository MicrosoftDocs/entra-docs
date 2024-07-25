---
title: Sign in users and call a web API in sample Android app 
description: Learn how to authenticate users in an external tenant using a sample Android (Kotlin) app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 04/04/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users and call a protected web API from a sample Android mobile app so that I can experience how Microsoft Entra External ID works.
---

# Sign in users and call a protected web API in sample Android (Kotlin) app

This guide demonstrates how to configure a sample Android mobile application to sign in users, and call an ASP.NET Core web API.
  
In this article, you do the following tasks: 
 
- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample Android mobile application.
- Call a protected web API.
 
## Prerequisites  

- <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](sample-native-authentication-android-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

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

## Grant admin consent
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Grant web API permissions to the Android sample app

Once you've registered both your client app and web API and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

[!INCLUDE [grant-api-permission-call-api-common](../customers/includes/register-app/grant-api-permission-call-api-common.md)]

## Clone sample Android mobile application  

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:
 
   ```console 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-android-sample
   ```
 
## Configure the sample Android mobile application

To enable authentication and access to web API resources, configure the sample by following these steps:
 
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
1. Find property named `WEB_API_BASE_URL` and set the URL to your web API.
1. Find property named `scopes` and set the scopes recorded in [Grant web API permissions to the Android sample app](#grant-web-api-permissions-to-the-android-sample-app).

    ```kotlin
    private const val scopes = "" // Developers should set the respective scopes of their web API here. For example, private const val scopes = "api://{clientId}/{ToDoList.Read} api://{clientId}/{ToDoList.ReadWrite}"
    ```
   
You've configured the app and it's ready to run. 

## Run and test the sample Android mobile application 
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button.
1. Select **Acquire Token Interactively** to request an access token.
1. Select **API - Perform GET** to call the previously set up ASP.NET Core web API. A successful call to the web API returns HTTP 200, while HTTP 403 signifies unauthorized access.

## Related content

- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).
