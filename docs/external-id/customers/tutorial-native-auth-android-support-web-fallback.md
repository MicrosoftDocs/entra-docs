---
title: Support web fallback
description: Learn how to implement support web fallback.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to support web fallback.
---

# Tutorial: Support web fallback
 
This tutorial demonstrates how `isBrowserRequired()` can happen and how it can be resolved. The utility method `isBrowserRequired()` supports fallback mechanism for various scenarios where native authentication isn't sufficient to complete the flow in functional and safe manner.
 
In this tutorial, you learn how to: 
 
- Check `isBrowserRequired()`
- Handle `isBrowserRequired()`
 
## Prerequisites 

- [Sign in users in a sample native Android mobile application](how-to-run-sample-android-app.md) 
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md) 
 
## Check isBrowserRequired()
 
To ensure stability of your application and avoid interruption of the authentication flow, it's highly recommended to use the SDK's `acquireToken()` method to continue the flow in the browser.
 
When we initialize the SDK, we need to specify which challenge types our mobile application can support. Here are the list of challenge types that the SDK accepts: 
 
- `oob` (out of band): add this challenge type when your application can handle a one-time-passcode, in this case an email code. 
- `password`: add this challenge type when your application is able to handle password based authentication. 
 
The utility method `isBrowserRequired()` returns true when Microsoft Entra ID requires capabilities that the client can't provide. For example, the SDK is initialized with only challenge type `oob`, but in the Microsoft Entra admin center the application is configured with an email with password user flow. 
 
Insufficient challenge types are only one example of where `isBrowserRequired()` can be used. It's a general fallback mechanism that can happen in various scenarios. 
 
## Sample flow 
 
Let's look at an example of what can happen when `isBrowserRequired()` returns true and how it can be handled. The challenge types set for the application are specified in the JSON configuration file passed to the SDK during initialization as the following code snippet shows:
 
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
 
In this case we're specifying only the challenge type `oob`. Suppose that in the Microsoft Entra admin center, the application is configured with an **Email with password** user flow.  
 
When we call the `signUp(username)` method from the SDK instance, we'll get a `SignUpError` that passes the `isBrowserRequired()` check, because the server requires different challenge type (`password` in this case) than the one configured in the client (`oob` in this case). 

To check and handle the `isBrowserRequired()`, use the following code snippet:
 
```kotlin 
val actionResult = authClient.signUp( 
    username = email 
) 
if (actionResult is SignUpError && actionResult.isBrowserRequired()) { 
    // Handle "BrowserRequired" error 
} 
``` 
 
Insufficient challenge types can cause the API and SDK to return `SignUpError` checked by `isBrowserRequired()`. It indicates that the authentication flow can't be completed through native authentication SDK or API methods, but that a browser has to be used. 
 
## Handle isBrowserRequired()
 
To handle this error, a browser needs to be launched and the authentication flow needs to be restarted there. This can be realized by calling Microsoft Authentication Library (MSAL) `acquireToken()` method. 
 
In order to use this method, a few additional configurations need to be done: 
 
- [Register the application's redirect URI in Microsoft Entra admin center](../../identity-platform/tutorial-v2-android.md#register-your-application-with-microsoft-entra-id). 
- [Configure the redirect URI in SDK's configuration](../../identity-platform/tutorial-v2-android.md#configure-your-application). 
 
Now we can get a token and an account interactively. Here's an example of how to use `acquireToken()`: 
 
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

Tokens obtained through native authentication flows can combine with browser-based flows, and vice versa. In other words, the authentication mechanism (native or web-based) doesn't limit the functionality of the tokens acquired through it.

## Related content

[How to run the iOS sample app](https://github.com/microsoft/entra-previews/blob/native-auth-public-preview/docs/Native-Auth/Developer-guides/1-iOS-Swift/0-Run-code-sample.md)

