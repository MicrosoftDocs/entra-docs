---
title: Quickstart - Sign in users and call a web API in sample app
description: Quickstart for configuring a sample mobile app to sign in users and call web API with Microsoft identity platform.
author: henrymbuguakiarie
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 10/30/2024
ms.author: henrymbugua

#Customer intent: As a developer, I want to configure a sample mobile app so that I can sign in my users and call web API by using Microsoft identity platform.
---

# Quickstart: Sign in users and call a web API in a sample mobile app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

This guide demonstrates how to configure a sample mobile application to sign in users, and call an ASP.NET Core web API.

#### [Android](#tab/android-external)

In this article, you do the following tasks: 
 
- Add a platform redirect URL to a web application.
- Enable public client flows.   
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample Android mobile application.
- Call a protected web API.

#### [iOS/macOS](#tab/ios-macos-external)

In this article, you do the following tasks: 

- Add a platform redirect URL to a web application.
- Enable public client flows to an application.   
- Update the iOS configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample iOS mobile application. 

---

## Prerequisites

#### [Android](#tab/android-external)

* <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
* An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
* Register a new client web app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in any organizational directory and personal Microsoft accounts*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* A web API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](../external-id/customers/sample-native-authentication-android-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Configure API scopes
    - Configure app roles
    - Configure optional claims
    - Clone or download sample web API
    - Configure and run sample web API

#### [iOS/macOS](#tab/ios-macos-external)

* <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
* An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.
* Register a new client web app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in any organizational directory and personal Microsoft accounts*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID*
* An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample iOS mobile app](../external-id/customers/sample-native-authentication-ios-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Configure API scopes.
    - Configure app roles.
    - Configure optional claims.
    - Clone or download sample web API.
    - Configure and run sample web API.

---

## Add a platform redirect URL

#### [Android](#tab/android-external)

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/add-platform-redirect-url-android.md)]

#### [iOS/macOS](#tab/ios-macos-external)

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/add-platform-redirect-url-ios.md)]

---

## Enable public client flow

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/enable-public-client-flow.md)]

## Grant web API permissions to the sample app

Once you've registered both your client app, web API, and you've exposed the API by creating scopes, you can configure the client's permissions to the API by following these steps:

[!INCLUDE [grant-api-permission-call-api-common](../external-id/customers/includes/register-app/grant-api-permission-call-api-common.md)]


## Clone sample mobile application

#### [Android](#tab/android-external)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:
 
   ```console 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-android-sample
   ```

#### [iOS/macOS](#tab/ios-macos-external)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

   ```console 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-ios-sample.git
   ```
---

## Configure the sample Android mobile application

#### [Android](#tab/android-external)

To enable authentication and access to web API resources, configure the sample by following these steps:
 
1. In Android Studio, open the project that you cloned. 
 
1. Open */app/src/main/res/raw/auth_config_ciam.json* file. 
1. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
   - `Enter_the_Redirect_Uri_Here` and replace it with the value of *redirect_uri* in the Microsoft Authentication Library (MSAL) configuration file you downloaded earlier when you added the platform redirect URL.
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
1. Open */app/src/main/AndroidManifest.xml* file.
1. Find the placeholder:

    - `ENTER_YOUR_SIGNATURE_HASH_HERE` and replace it with the **Signature Hash** that you generated earlier when you added the platform redirect URL.

1. Open */app/src/main/java/com/azuresamples/msaldelegatedandroidkotlinsampleapp/MainActivity.kt* file.
1. Find property named `WEB_API_BASE_URL` and set the URL to your web API.
1. Find property named `scopes` and set the scopes recorded in [Grant web API permissions to the Android sample app](#grant-web-api-permissions-to-the-sample-app).

    ```kotlin
    private const val scopes = "" // Developers should set the respective scopes of their web API here. For example, private const val scopes = "api://{clientId}/{ToDoList.Read} api://{clientId}/{ToDoList.ReadWrite}"
    ```
   
You've configured the app and it's ready to run. 

#### [iOS/macOS](#tab/ios-macos-external)

To enable authentication and access to web API resources, configure the sample by following these steps:

1. In Xcode, open the project that you cloned.
1. Open */MSALiOS/Configuration.swift* file.
1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
    - `Enter_the_Redirect_URI_Here` and replace it with the value of *kRedirectUri* in the Microsoft Authentication Library (MSAL) configuration file you downloaded earlier when you added the platform redirect URL.
    - `Enter_the_Protected_API_Full_URL_Here` and replace it with the URL to your web API. The *Enter_the_Protected_API_Full_URL_Here* should include the base URL (the deployed web API URL) and the endpoint (/api/todolist) for our ASP.NET web API.
    - `Enter_the_Protected_API_Scopes_Here` and replace it with the scopes recorded in [Grant web API permissions to the iOS sample app](#grant-web-api-permissions-to-the-sample-app).
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

You've configured the app and it's ready to run.

---

## Run sample app and call web API

#### [Android](#tab/android-external)

To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button.
1. Select **Acquire Token Interactively** to request an access token.
1. Select **API - Perform GET** to call the previously set up ASP.NET Core web API. A successful call to the web API returns HTTP 200, while HTTP 403 signifies unauthorized access.

#### [iOS/macOS](#tab/ios-macos-external)

To build and run your app, follow these steps:
 
1. To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator.
1. Select **Acquire Token Interactively** to request an access token.
1. Select **API - Perform GET** to call the previously set up ASP.NET Core web API. A successful call to the web API returns HTTP `200`, while HTTP `403` signifies unauthorized access.

---

## Related content

#### [Android](#tab/android-external)

- [Sign in users in sample Android (Kotlin) mobile app by using native authentication](../external-id/customers/how-to-run-native-authentication-sample-android-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).
- [Configure sign-in with Google](../external-id/customers/how-to-google-federation-customers.md).

#### [iOS/macOS](#tab/ios-macos-external)

- [Sign in users in sample iOS (Swift) mobile app by using native authentication](../external-id/customers/how-to-run-native-authentication-sample-ios-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).
- [Configure sign-in with Google](../external-id/customers/how-to-google-federation-customers.md).

---
