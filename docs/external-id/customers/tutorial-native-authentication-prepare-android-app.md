---
title: Prepare your Android mobile app for native authentication 
description: Learn how to add Microsoft Authentication Library (MSAL) native auth SDK framework to your Android app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 05/30/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to add Microsoft Authentication Library (MSAL) native authentication SDK to my Android mobile app so that I can sign-in users.
---

# Tutorial: Prepare your Android mobile app for native authentication  

This tutorial demonstrates how to add Microsoft Authentication Library (MSAL) native authentication SDK to an Android mobile app.   
 
In this tutorial, you learn how to: 

> [!div class="checklist"]
> 
> - Add MSAL dependencies. 
> - Create a configuration file.  
> - Create MSAL SDK instance.  
 
## Prerequisites  
 
- If you haven't already, follow the instructions in [Sign in users in sample Android (Kotlin) mobile app by using native authentication](how-to-run-native-authentication-sample-android-app.md) and register an app in your external tenant. Make sure you complete the following steps:
    - Register an application.
    - Enable public client and native authentication flows.
    - Grant API permissions.
    - Create a user flow.
    - Associate the app with the user flow.
- An Android project. If you don't have an Android project, create it. 
 
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
    //...
    
    dependencies { 
        implementation 'com.microsoft.identity.client:msal:5.+'
        //...
    }
    ```
 
1. In Android Studio, select **File** > **Sync Project with Gradle Files**.  
 
## Create a configuration file 
 
You pass the required tenant identifiers, such as the application (client) ID, to the MSAL SDK through a JSON configuration setting.
 
Use these steps to create configuration file:  
 
1. In Android Studio's project pane, navigate to *app\src\main\res*.  
1. Right-click **res** and select **New** > **Directory**. Enter `raw` as the new directory name and select **OK**.  
1. In *app\src\main\res\raw*, create a new JSON file called `auth_config_native_auth.json`.  
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
    //...
   ``` 
 
1. Replace the following placeholders with your tenant values that you obtained from the Microsoft Entra admin center:  

   - Replace the `Enter_the_Application_Id_Here` placeholder with the application (client) ID of the app you registered earlier.   
   - Replace the `Enter_the_Tenant_Subdomain_Here` with the directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

    The challenge types are a list of values, which the app uses to notify Microsoft Entra about the authentication method that it supports. 
    
    - For sign-up and sign-in flows with email one-time passcode, use `["oob"]`.
    - For sign-up and sign-in flows with email and password, use `["oob","password"]`.
    - For self-service password reset (SSPR), use `["oob"]`.
  

    Learn more [challenge types](concept-native-authentication-challenge-types.md). 

### Optional: Logging configuration 

Turn on logging at app creation by creating a logging callback, so the SDK can output logs. 

```kotlin 
import com.microsoft.identity.client.Logger

fun initialize(context: Context) {
        Logger.getInstance().setExternalLogger { tag, logLevel, message, containsPII ->
            Logs.append("$tag $logLevel $message")
        }
    }
```
To configure the logger, you need to add a section in the configuration file, `auth_config_native_auth.json`: 

```json 
    //...
   { 
     "logging": { 
       "pii_enabled": false, 
       "log_level": "INFO", 
       "logcat_enabled": true 
     } 
   } 
    //...
   ``` 

1. **logcat_enabled**: Enables the logging functionality of the library. 
2. **pii_enabled**: Specifies whether messages containing personal data, or organizational data are logged. When set to false, logs won't contain personal data. When set to true, the logs might contain personal data. 
3. **log_level**: Use it to decide which level of logging to enable. Android supports the following log levels: 
   1. ERROR 
   2. WARNING
   3. INFO
   4. VERBOSE
   
For more information on MSAL logging, see [Logging in MSAL for Android](/entra/identity-platform/msal-logging-android).  
 
## Create native authentication MSAL SDK instance
 
In the `onCreate()` method, create an MSAL instance so the app can perform authentication with your tenant through native authentication. The `createNativeAuthPublicClientApplication()` method returns an instance called `authClient`. Pass the JSON configuration file that you created earlier as a parameter.

```kotlin
    //...
    authClient = PublicClientApplication.createNativeAuthPublicClientApplication( 
        this, 
        R.raw.auth_config_native_auth 
    )
    //...
```
  
 
Your code should look something similar to the following snippet:  
 
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
 
        private fun displaySignedInState(accountState: AccountState) { 
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

- Retrieve the cached account by using the `getCurrentAccount()`, which returns an object, `accountResult`. 
- If an account is found in persistence, use `GetAccountResult.AccountFound` to display a signed-in state.
- Otherwise, use `GetAccountResult.NoAccountFound` to display a signed-out state.
 
Make sure you include the import statements. Android Studio should include the import statements for you automatically.
 
## Next step 

> [!div class="nextstepaction"]
>  [Tutorial: Add sign-up in an Android mobile app using native authentication](tutorial-native-authentication-android-sign-up.md)
