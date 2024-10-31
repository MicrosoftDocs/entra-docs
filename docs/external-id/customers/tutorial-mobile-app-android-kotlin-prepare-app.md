---
title: Prepare your Android (Kotlin) app for authentication
description: The tutorials provide a step-by-step guide on how to prepare your Android (Kotlin) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 06/27/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to prepare Android (Kotlin) app for authentication using Microsoft Entra External ID.
---

# Tutorial: Prepare your Android (Kotlin) app for authentication

This is the second tutorial in the tutorial series that demonstrates how to add Microsoft Authentication Library (MSAL) for Android to your Android (Kotlin) app. MSAL enables Android applications to authenticate users with Microsoft Entra.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Add MSAL dependencies.
> - Add Configuration.

## Prerequisites

- [Android Studio](https://developer.android.com/studio)
- If you haven't already, follow the instructions in [Tutorial: Register and configure Android (Kotlin) mobile app](tutorial-mobile-app-android-kotlin-prepare-tenant.md) and register an app in your external tenant.
- An Android project. If you don't have an Android project, create it.


## Add MSAL dependencies

To add MSAL dependencies in your Android project, follow these steps:

1. Open your project in Android Studio or create a new project.
1. Open your application's `build.gradle` and add the following dependencies:

    ```gradle
    allprojects {
    repositories {
        //Needed for com.microsoft.device.display:display-mask library
        maven {
            url 'https://pkgs.dev.azure.com/MicrosoftDeviceSDK/DuoSDK-Public/_packaging/Duo-SDK-Feed/maven/v1'
            name 'Duo-SDK-Feed'
        }
        mavenCentral()
        google()
        }
    }
    //...
    
    dependencies { 
        implementation 'com.microsoft.identity.client:msal:5.+'
        //...
    }
    ```
   
    
    In the `build.gradle` configuration, repositories are defined for project dependencies. It includes a Maven repository URL for the `com.microsoft.device.display:display-mask` library from Azure DevOps. Additionally, it utilizes Maven Central and Google repositories. The dependencies section specifies the implementation of the MSAL version 5 and potentially other dependencies. 

1. In Android Studio, select **File** > **Sync Project with Gradle Files**.

## Add configuration

You pass the required tenant identifiers, such as the application (client) ID, to the MSAL SDK through a JSON configuration setting.
 
Use these steps to create configuration file:  
 
1. In Android Studio's project pane, navigate to *app\src\main\res*.  
1. Right-click **res** and select **New** > **Directory**. Enter `raw` as the new directory name and select **OK**.  
1. In *app\src\main\res\raw*, create a new JSON file called `auth_config_ciam_auth.json`.  
1. In the `auth_config_ciam_auth.json` file, add the following MSAL configurations:

    ```json
    {
      "client_id" : "Enter_the_Application_Id_Here",
      "authorization_user_agent" : "DEFAULT",
      "redirect_uri" : "Enter_the_Redirect_Uri_Here",
      "account_mode" : "SINGLE",
      "authorities" : [
        {
          "type": "CIAM",
          "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/"
        }
      ]
    }
    ```

    The JSON configuration file specifies various settings for an Android application. It includes the client ID, authorization user agent, redirect URI, and account mode. Additionally, it defines an authority for authentication, specifying the type and authority URL.    

    Replace the following placeholders with your tenant values that you obtained from the Microsoft Entra admin center:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
    - `Enter_the_Redirect_Uri_Here` and replace it with the value of *redirect_uri* in the Microsoft Authentication Library (MSAL) configuration file you downloaded earlier when you added the platform redirect URL.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Open */app/src/main/AndroidManifest.xml* file.
1. In *AndroidManifest.xml*, add the following data specification to an intent filter:

    ```xml
    <data
        android:host="ENTER_YOUR_PROJECT_PACKAGE_NAME_HERE"
        android:path="/ENTER_YOUR_SIGNATURE_HASH_HERE"
        android:scheme="msauth" />
    ```
    
    Find the placeholder:
    
    - *ENTER_YOUR_PROJECT_PACKAGE_NAME_HERE* and replace it with your Android's project package name.
    - *ENTER_YOUR_SIGNATURE_HASH_HERE* and replace it with the Signature Hash that you generated earlier when you added the platform redirect URL.

[!INCLUDE [external-id-custom-domain](./includes/use-custom-domain-url-android.md)]

## Create MSAL SDK instance

To initialize MSAL SDK instance, use the following code:

```kotlin
private suspend fun initClient(): ISingleAccountPublicClientApplication = withContext(Dispatchers.IO) {
    return@withContext PublicClientApplication.createSingleAccountPublicClientApplication(
        this@MainActivity,
        R.raw.auth_config_ciam_auth
    )
}
```

The code initializes a single account public client application asynchronously. It uses the provided authentication configuration file and runs on the I/O dispatcher.

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

## Next steps

[Tutorial: Sign in users in Android (Kotlin) mobile app](tutorial-mobile-app-android-kotlin-sign-in.md)
