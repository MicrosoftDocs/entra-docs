---
title: Sign in users in an Android app by using Microsoft identity platform
description: Set up an Android app project that signs in users into customer facing app by in an external tenant or employees in a workforce tenant

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 01/27/2025
ms.custom: developer

#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID
---

# Tutorial: Set up an Android app to sign in users by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


This is the second tutorial in the tutorial series that demonstrates how to add Microsoft Authentication Library (MSAL) for Android to your Android app. MSAL enables Android applications to authenticate users with Microsoft Entra.

In this tutorial you'll;

> [!div class="checklist"]
>
> - Add MSAL dependency
> - Add configuration
> - Create MSAL SDK instance

## Prerequisites

- [Quickstart: Sign in users in a sample mobile app](quickstart-mobile-app-sign-in.md?pivots=external&tabs=java-external).
- An Android project. If you don't have an Android project, create it.

## Add MSAL dependency and relevant libraries to your project

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

#### [Workforce tenant configuration](#tab/android-workforce)

1. In Android Studio's project pane, navigate to **app\src\main\res**.
1. Right-click **res** and choose **New** > **Directory**. Enter `raw` as the new directory name and select **OK**.
1. In **app** > **src** > **main** > **res** > **raw**, create a new JSON file called `auth_config_single_account.json` and paste the MSAL Configuration that you saved earlier.

   Below the redirect URI, paste:

   ```json
     "account_mode" : "SINGLE",
   ```

   Your config file should resemble this example:

   ```json
   {
     "client_id": "00001111-aaaa-bbbb-3333-cccc4444",
     "authorization_user_agent": "WEBVIEW",
     "redirect_uri": "msauth://com.azuresamples.msalandroidapp/00001111%cccc4444%3D",
     "broker_redirect_uri_registered": true,
     "account_mode": "SINGLE",
     "authorities": [
       {
         "type": "AAD",
         "audience": {
           "type": "AzureADandPersonalMicrosoftAccount",
           "tenant_id": "common"
         }
       }
     ]
   }
   ```

   As this tutorial only demonstrates how to configure an app in Single Account mode, see [single vs. multiple account mode](./single-multi-account.md) and [configuring your app](./msal-configuration.md) for more information

1. We recommend using 'WEBVIEW'. In case you want to configure  "authorization_user_agent" as 'BROWSER' in your app, you need make the following updates.
a) Update auth_config_single_account.json with  "authorization_user_agent": "Browser". 
b) Update AndroidManifest.xml. In the app go to **app** > **src** > **main** > **AndroidManifest.xml**, add the `BrowserTabActivity` activity as a child of the `<application>` element. This entry allows Microsoft Entra ID to call back to your application after it completes the authentication:

   ```xml
   <!--Intent filter to capture System Browser or Authenticator calling back to our app after sign-in-->
   <activity
       android:name="com.microsoft.identity.client.BrowserTabActivity"
       android:exported="true">
       <intent-filter>
           <action android:name="android.intent.action.VIEW" />
           <category android:name="android.intent.category.DEFAULT" />
           <category android:name="android.intent.category.BROWSABLE" />
           <data android:scheme="msauth"
               android:host="Enter_the_Package_Name"
               android:path="/Enter_the_Signature_Hash" />
       </intent-filter>
   </activity>
   ```

   - Use the **Package name** to replace `android:host=.` value. It should look like `com.azuresamples.msalandroidapp`.
   - Use the **Signature Hash** to replace `android:path=` value. Ensure that there's a leading `/` at the beginning of your Signature Hash. It should look like `/aB1cD2eF3gH4+iJ5kL6-mN7oP8q=`.

   You can find these values in the Authentication blade of your app registration as well.


#### [External tenant configuration](#tab/android-external)


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
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

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

[!INCLUDE [external-id-custom-domain](../external-id/customers/includes/use-custom-domain-url-android.md)]

---

## Create MSAL SDK instance

To initialize MSAL SDK instance, use the following code:

#### [Workforce tenant configuration](#tab/android-workforce)

```java
PublicClientApplication.createSingleAccountPublicClientApplication(
    getContext(),
    R.raw.auth_config_single_account,
    new IPublicClientApplication.ISingleAccountApplicationCreatedListener() {
        @Override
        public void onCreated(ISingleAccountPublicClientApplication application) {
            // Initialize the single account application instance
            mSingleAccountApp = application;
            loadAccount();
        }

        @Override
        public void onError(MsalException exception) {
            // Handle any errors that occur during initialization
            displayError(exception);
        }
    }
);
```

This code creates a single account public client application using the configuration file auth_config_single_account.json. When the application is successfully created, it assigns the instance to mSingleAccountApp and calls the loadAccount() method. If an error occurs during the creation, it handles the error by calling the displayError(exception) method.


#### [External tenant configuration](#tab/android-external)

```kotlin
private suspend fun initClient(): ISingleAccountPublicClientApplication = withContext(Dispatchers.IO) {
    return@withContext PublicClientApplication.createSingleAccountPublicClientApplication(
        this@MainActivity,
        R.raw.auth_config_ciam_auth
    )
}
```

The code initializes a single account public client application asynchronously. It uses the provided authentication configuration file and runs on the I/O dispatcher.

---

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Add add sign-in in your Android app](tutorial-web-app-node-sign-in-sign-out.md).
