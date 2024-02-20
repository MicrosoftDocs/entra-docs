---
title: Prepare your Android app for native authentication 
description: Learn how to add Microsoft Authentication Library (MSAL) native auth SDK framework to your Android app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/12/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about how to add Microsoft Authentication Library (MSAL) native auth SDK framework to your Android app.
---

# Tutorial: Prepare your Android app for native authentication 

This tutorial demonstrates how to add Microsoft Authentication Library (MSAL) native auth SDK framework to your Android app.  
 
In this tutorial, you learn how to:
 
- Add MSAL dependencies.
- Create configuration file. 
- Create SDK instance. 
 
## Prerequisites 
 
- [How to run the Android sample app](how-to-run-sample-android-app.md).
- Android project.
 
## Add MSAL dependencies 
 
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
    ```

1. Open your app's `build.gradle` and add the following dependencies: 
 
   ```gradle 
   implementation 'com.microsoft.identity.client:msal:5.1.0'
   ``` 
 
1. Select **File** > **Sync Project with Gradle Files**. 
 
## Create configuration file 
 
You pass relevant tenant identifiers, such as the **Application (client) ID**, to the MSAL library through configuration settings. This is accomplished using a JSON file. 
 
Follow these steps to create configuration file: 
 
1. In Android Studio's project pane, navigate to **app\src\main\res**. 
1. Right-click **res** and choose **New** > **Directory**. Enter `raw` as the new directory name and select **OK**. 
1. In **app** > **src** > **main** > **res** > **raw**, create a new JSON file called `auth_config_native_auth.json`. 
1. In the `auth_config_native_auth.json` file, add the following MSAL configurations: 
 
   ```json 
   { 
     "client_id": "Enter_the_Application_Id_Here", 
     "authorities": [ 
       { 
         "type": "CIAM", 
         "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/" 
       } 
     ], 
     "challenge_types": ["oob"], 
     "logging": { 
       "pii_enabled": false, 
       "log_level": "INFO", 
       "logcat_enabled": true 
     } 
   } 
   ``` 
 
1. Replace the following values with the values from the Microsoft Entra admin center: 
 
   1. Find the `Enter_the_Application_Id_Here` value and replace it with the **Application (client) ID** of the app you registered earlier.  
   1. Find the `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 

### Optional: Logging configuration
Turn logging on at app creation by creating a logging callback. Without a logging method, the library won't be able to output logs.

```kotlin 
import com.microsoft.identity.client.Logger

fun initialize(context: Context) {
        Logger.getInstance().setExternalLogger { tag, logLevel, message, containsPII ->
            Logs.append("$tag $logLevel $message")
        }
    }
```
To configure the logger a logging section needs to be added in the configuration file:

```json 
   { 
     "logging": { 
       "pii_enabled": false, 
       "log_level": "INFO", 
       "logcat_enabled": true 
     } 
   } 
   ``` 

1. **logcat_enabled**: Enables the logging functionality of the library.
2. **pii_enabled**: Specifies whether messages containing personal data, or organizational data are logged. When set to false, logs won't contain personal data. When set to true, the logs might contain personal data.
3. **log_level**: Used to decide which level of logging to enable. The supported log levels are:
   1. ERROR 
   2. WARNING
   3. INFO
   4. VERBOSE
   
For more information on MSAL logging, see [Logging in MSAL for Android](/entra/identity-platform/msal-logging-android). 
 
## Create SDK instance 
 
In the `onCreate` method, create MSAL library instance so that we can perform authentication logic and interact with our tenant through native authentication APIs. The `INativeAuthPublicClientApplication` create an instance called `authClient`. The JSON configuration file that we created earlier in the tutorial is passed as a parameter. 
 
The cached account can be retrieved through `getCurrentAccount()`, which will return an `AccountResult` object if an account for this application was found in persistence or null if not. Your code should look like: 
 
```kotlin 
    class MainActivity : AppCompatActivity() { 
        private lateinit var authClient: INativeAuthPublicClientApplication 
 
        override fun onCreate(savedInstanceState: Bundle?) { 
            super.onCreate(savedInstanceState) 
            setContentView(R.layout.activity_main) 
 
            authClient = PublicClientApplication.createNativeAuthPublicClientApplication( 
                this, 
                R.raw.auth_config_native_auth 
            ) 
            getAccountState() 
        } 
 
        private fun getAccountState() {
            CoroutineScope(Dispatchers.Main).launch {
                val accountResult = authClient.getCurrentAccount()
                when (accountResult) {
                    is GetAccountResult.AccountFound -> {
                        displaySignedInState(accountResult.resultValue)
                    }
                    is GetAccountResult.NoAccountFound -> {
                        displaySignedOutState()
                    }
                }
            }
        } 
 
        private fun displaySignedInState(accountResult: AccountResult) { 
            val accountName = accountResult.getAccount().username 
            val textView: TextView = findViewById(R.id.accountText) 
            textView.text = "Cached account found: $accountName" 
        } 
 
        private fun displaySignedOutState() { 
            val textView: TextView = findViewById(R.id.accountText) 
            textView.text = "No cached account found" 
        } 
    } 
``` 
 
Don't forget to add the import statements, Android Studio does that for you automatically (on Mac select on Alt + Enter on each error detected by the code editor). 
 
## Next steps 
 
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md)
