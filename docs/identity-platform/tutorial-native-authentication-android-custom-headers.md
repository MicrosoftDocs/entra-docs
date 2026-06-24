---
title: Add custom headers to native authentication requests in Android (Kotlin)
description: Learn how to attach custom x-* headers to native authentication network requests in an Android (Kotlin) app to integrate fraud-detection SDKs with Microsoft Entra External ID.
author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform

ms.subservice: external
ms.topic: tutorial
ms.custom: msecd-doc-authoring-105
ms.date: 05/15/2026
ai-usage: ai-assisted
#Customer intent: As an Android developer, I want to attach custom headers to native authentication network requests so that I can integrate fraud and bot-detection SDKs with my Microsoft Entra External ID app.
---

# Tutorial: Add custom headers to native authentication network requests in Android (Kotlin)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to attach custom `x-*` headers to native authentication network requests in your Android (Kotlin) app using the Microsoft Authentication Library (MSAL) `NativeAuthRequestInterceptor` interface, enabling integration with third-party fraud and bot-detection SDKs.

In this tutorial, you:

> [!div class="checklist"]
>
> - Understand the header naming rules enforced by MSAL.
> - Implement the `NativeAuthRequestInterceptor` interface.
> - Register the interceptor with your app configuration.

## Prerequisites

- An Android (Kotlin) app that uses MSAL native authentication. If you don't have one, complete [Tutorial: Add sign-in in Android (Kotlin) app using native authentication](tutorial-native-authentication-android-sign-in-sign-out.md).
- Your app is initialized with an `INativeAuthPublicClientApplication` instance. The steps in this tutorial show you how to update your existing app initialization code to register the interceptor.

## Understand header naming rules

MSAL applies the following rules when evaluating the headers you provide:

- Headers **must** start with `x-` (case-insensitive). Headers that don't start with `x-` are ignored.
- Headers that start with any of the following reserved prefixes are ignored:
  - `x-client-`
  - `x-ms-`
  - `x-broker-`
  - `x-app-`
- Valid headers are normalized to lowercase before being added to the request.
- MSAL adds headers that pass both rules to the network request. If a header you provide has the same name as one of MSAL's own internal headers, your value takes precedence.

Use these rules to verify your vendor-required header names before implementing the interceptor.

## Implement the request interceptor

The `NativeAuthRequestInterceptor` interface declares a single method that MSAL calls synchronously before it sends each network request. Your implementation receives the request URL and returns a map of headers to add, or `null` if no headers are needed for that request.

> [!IMPORTANT]
> The `additionalHeaders` method executes synchronously on the thread performing the request (typically a background/network thread). Implementations must be thread-safe and return quickly. Any exception thrown from this method propagates to the caller and fails the request.

Create a class that implements `NativeAuthRequestInterceptor`:

```kotlin
import com.microsoft.identity.common.java.nativeauth.providers.NativeAuthRequestInterceptor
import java.net.URL

class CustomHeaderInterceptor : NativeAuthRequestInterceptor {

    override fun additionalHeaders(requestUrl: URL): Map<String, String>? {
        // Scope headers to specific endpoints only.
        if (requestUrl.path.contains("oauth2/v2.0/initiate")) {
            return mapOf(
                "value_1" to "customer_header_1",          // Ignored: doesn't start with "x-"
                "x-client-header" to "customer_header_2",  // Ignored: starts with reserved prefix "x-client-"
                "X-my-custom-header" to "my data"          // Added to the network request (lowercased to "x-my-custom-header").
            )
        }

        // Return null for all other requests to avoid over-sending signals.
        return null
    }
}
```

The method receives the full URL of the outgoing request in `requestUrl`. Use this URL to scope your headers to the specific endpoints your fraud or bot-detection vendor requires, such as sign-in or sign-up initiation endpoints. Sending headers to unrelated endpoints can degrade signal quality and increase false positives.

> [!NOTE]
> Always return a value from `additionalHeaders`. Return `null` or an empty map if no extra headers are needed for that request.

## Register the interceptor

After implementing the interface, set the `requestInterceptor` property on your app's `NativeAuthPublicClientApplicationConfiguration`. If your app initializes the auth client with a JSON configuration file (such as *app/src/main/res/raw/native_auth_sample_app_config.json*), set the interceptor on the configuration after creating the client:

```kotlin
import com.microsoft.identity.client.PublicClientApplication
import com.microsoft.identity.nativeauth.INativeAuthPublicClientApplication
import com.microsoft.identity.nativeauth.NativeAuthPublicClientApplicationConfiguration

val authClient: INativeAuthPublicClientApplication =
    PublicClientApplication.createNativeAuthPublicClientApplication(
        context,
        R.raw.native_auth_sample_app_config
    )

(authClient as? PublicClientApplication)?.let { app ->
    (app.configuration as? NativeAuthPublicClientApplicationConfiguration)?.requestInterceptor =
        CustomHeaderInterceptor()
}
```

If your app uses programmatic configuration, set the `requestInterceptor` property on your `NativeAuthPublicClientApplicationParameters` instance before creating the application:

```kotlin
import com.microsoft.identity.client.PublicClientApplication
import com.microsoft.identity.nativeauth.INativeAuthPublicClientApplication
import com.microsoft.identity.nativeauth.NativeAuthPublicClientApplicationParameters

val parameters = NativeAuthPublicClientApplicationParameters(
    clientId = "Enter_the_Application_Id_Here",
    authorityUrl = "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/",
    challengeTypes = listOf("oob", "password")
)
parameters.requestInterceptor = CustomHeaderInterceptor()

val authClient: INativeAuthPublicClientApplication =
    PublicClientApplication.createNativeAuthPublicClientApplication(
        context,
        parameters
    )
```

## Verify headers are applied

To confirm that your headers reach the intended endpoints, inspect the outgoing network traffic using a network proxy tool such as Charles Proxy or the Android Studio Network Inspector. Check that:

- Headers starting with `x-` and without reserved prefixes appear in the request.
- Headers with reserved prefixes (`x-client-`, `x-ms-`, `x-broker-`, `x-app-`) don't appear in the request.
- Headers are sent only to the endpoints you scoped them to.
- Valid header names are lowercased in the outgoing request.

> [!NOTE]
> Logging inside the interceptor won't show you the final request headers. The interceptor is invoked before MSAL evaluates and applies the naming rules, so it reflects only the headers you provide, not what is ultimately sent.

## Related content

- [Native authentication overview](concept-native-authentication.md)
- [Tutorial: Add sign-in in Android (Kotlin) app using native authentication](tutorial-native-authentication-android-sign-in-sign-out.md)
- [Tutorial: Add custom headers to native auth network requests in iOS (Swift)](tutorial-native-authentication-ios-swift-custom-headers.md)
