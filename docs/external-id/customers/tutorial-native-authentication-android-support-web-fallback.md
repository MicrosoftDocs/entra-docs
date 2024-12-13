---
title: Support web fallback in Android app
description: Learn how to implement support web fallback in Android app.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 04/29/2024
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

Use [web fallback mechanism](concept-native-authentication-web-fallback.md) for scenarios where native authentication isn't sufficient to complete the user authentication flow. 
 
When you initialize the Android SDK, you specify the challenge types your mobile application supports, such as *oob* and *password*. 

If your client app can't support a challenge type that Microsoft Entra requires, Microsoft Entra's response indicates that the client app needs to continue with the authentication flow in the browser. For example, you initialize the SDK with *oob* challenge type, but in the Microsoft Entra admin center you configure the app with an email with password authentication method. 

In this case, the utility method `isBrowserRequired()` returns true.
 
## Sample flow 
  
Let's look at an example flow that returns `isBrowserRequired()`, and how you can handle it: 

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
      "client_id" : "{Enter_the_Application_Id_Here}",
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
 
1. Start a sign-up flow by using the SDK's `signUp(username)` method. You get a `SignUpError` that passes the `isBrowserRequired()` check as Microsoft Entra expects *password* and *oob* challenge type, but you configured your SDK with only *oob*.  

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
 
## Handle isBrowserRequired() error
 
To handle this error, the client app need to launch a browser and restart the authentication flow. You can accomplish by using Microsoft Authentication Library (MSAL) `acquireToken()` method.  
 
To do so, use the following steps:

<!--We'll update these instructions once we author the Android tutorials for the browser-delegated authentication flow --> 

1. To add a redirect URI to the app that you registered earlier, use the steps in [Add a platform redirect URL](sample-mobile-app-android-kotlin-sign-in.md#add-a-platform-redirect-url).

1. To update your client app's configuration file, use the steps in [Configure the redirect URI in SDK's configuration](sample-mobile-app-android-kotlin-sign-in.md#configure-the-sample-android-mobile-application).
  
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

Security tokens, that's ID token, access token and refresh token, you get through native authentication flow are same as the token you get via browser-delegated flow.

## Related content 

- Learn [How to run the iOS sample app](how-to-run-native-authentication-sample-ios-app.md)
- Explore [Native authentication API reference with email one-time passcode](../../identity-platform/reference-native-authentication-email-otp.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).
- Learn about [challenge types](concept-native-authentication-challenge-types.md).