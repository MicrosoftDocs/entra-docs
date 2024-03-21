---
title: Support web fallback in Android app
description: Learn how to implement support web fallback in Android app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to support web fallback in my Android app's native authentication flow so that I can ensure stability of my app's authentication flow.
---

# Tutorial: Support web fallback in Android app 
 
This tutorial demonstrates how `isBrowserRequired()` error happens and how you can resolve it. The utility method `isBrowserRequired()` checks the need for a fallback mechanism for various scenarios where native authentication isn't sufficient to complete the authentication flow in functional and safe manner. 
 
In this tutorial, you learn how to:  

> [!div class="checklist"]
>
> - Check `isBrowserRequired()` 
> - Handle `isBrowserRequired()` 
 
## Prerequisites 

- Complete the steps in [Sign in users in a sample native Android mobile application](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings.  
- Complete the steps in [Tutorial: Add sign in and sign out with email one-time passcode](tutorial-native-authentication-android-sign-in-sign-out.md).  
 
## Web fallback

Use web fallback mechanism for scenarios where native authentication isn't sufficient to complete the user authentication flow. 
 
When you initialize the Android SDK, you specify the challenge types your mobile application supports, such as *oob* and *password*. 

If your client app can't support a challenge type that Microsoft Entra requires, Microsoft Entra indicates that it requires capabilities that the client can't provide. For example, you initialize the SDK with just *oob* challenge type, but in the Microsoft Entra admin center you configure the app with an email with password user flow. 

In this case, the utility method `isBrowserRequired()` returns true.
 
## Sample flow  
  
Let's model an example flow that returns `isBrowserRequired()`, and how you can handle it. 

1. In the JSON configuration file, which you pass to the SDK during initialization, add only the *oob* challenge type as shown the following code snippet: 
 
    ```kotlin 
    PublicClientApplication.createNativeAuthPublicClientApplication( 
        requireContext(), 
        R.raw.native_auth_config  // JSON configuration file 
    ) 
    ``` 
     
    The `native_auth_config.json` configuration has the following code snippet: 
     
    ```json 
    {
      "client_id" : "{CLIENT_ID}",
       "authorities" : [
        {
          "type": "CIAM",
          "authority_url": "https://{Enter_the_Tenant_Subdomain_Here}.ciamlogin.com/{Enter_the_Tenant_Subdomain_Here}.onmicrosoft.com/"
        }
      ],
      "challenge_types" : ["oob"],
      "logging": {
        "pii_enabled": false,
        "log_level": "INFO",
        "logcat_enabled": true
      }
    } 
    ``` 
 
1. In the Microsoft Entra admin center, [configure your user flow](how-to-user-flow-sign-up-sign-in-customers.md) to use **Email with password** as the authentication method.    
 
1. Start a sign-up flow by using the SDK's `signUp(username)` method. You get a `SignUpError` that passes the `isBrowserRequired()` check as Microsoft Entra requires different challenge type, *password* in this case, but not the one you configure in the client, *oob* in this case.  

1. To check and handle the `isBrowserRequired()`, use the following code snippet: 
 
    ```kotlin 
    val actionResult = authClient.signUp( 
        username = email 
    ) 
    if (actionResult is SignUpError && actionResult.isBrowserRequired()) { 
        // Handle "browser required" error
    } 
    ``` 
 
    The code indicates that the authentication flow can't be completed through native authentication, and that a browser has to be used.  
 
## Handle isBrowserRequired()
 
To handle this error, the client app need to launch a browser and restart the authentication flow. You can accomplish by using Microsoft Authentication Library (MSAL) `acquireToken()` method.  
 
To do so, use the following steps:

<!--We'll update these instructions once we author the Android tutorials for the browser-delegated authentication flow --> 

1. Use the steps in [Register a redirect URI in Microsoft Entra admin center](../../identity-platform/tutorial-v2-android.md#register-your-application-with-microsoft-entra-id) to add a redirect URIto the app that you registered earlier. 

1. Use the steps in [Configure the redirect URI in SDK's configuration](../../identity-platform/tutorial-v2-android.md#configure-your-application) to update your client app's configuration file. 
  
1. Use the following code snippet to acquire a token by using the `acquireToken()` method:

    ```kotlin 
    val actionResult = authClient.signUp(
        username = email
    )
    if (actionResult is SignUpError && actionResult.isBrowserRequired()) {
        authClient.acquireToken(
            AcquireTokenParameters(
                AcquireTokenParameters.Builder()
                    .startAuthorizationFromActivity(requireActivity())
                    .withScopes(getScopes())
                    .withCallback(getAuthInteractiveCallback())
            )
            // Result will contain account and tokens retrieved through the browser.
        )
    } 
    ```

Tokens you obtain through native authentication flow are similar to those that you obtain through browser-delegated flows.

## Related content 

- [How to run the iOS sample app](how-to-run-native-authentication-sample-ios-app.md)
- [Native authentication API reference with email one-time passcode](../../identity-platform/reference-native-authentication-email-otp.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).
- Learn about [challenge types](concept-native-authentication-challenge-types.md).