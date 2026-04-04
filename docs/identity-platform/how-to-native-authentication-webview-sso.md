---
title: Implement Single Sign-On from Native Apps to Embedded Web Views
description: Learn how to implement SSO between a native mobile app and a web resource in an embedded web view using Microsoft Entra External ID native authentication.
author: henrymbuguakiarie
ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: how-to
ms.custom: msecd-doc-authoring-105
ms.date: 04/04/2026
ai-usage: ai-assisted

#customer intent: As a mobile developer, I want to implement single sign-on between my native app and an embedded web view so that users can access web resources without encountering a second login prompt.
---

# Implement single sign-on from native apps to embedded web views

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

When your mobile app includes web-based features like a profile update page or rewards dashboard, users expect a seamless single sign-on experience. They shouldn't encounter a second login prompt after already signing in through the native app.

This article shows you how to implement single sign-on (SSO) between a native mobile application and a web resource hosted in an embedded web view (for example, `WKWebView` on iOS or `WebView` on Android). Unlike system browsers, embedded web views allow you to manipulate network requests before they're sent. This capability enables your app to inject the user's authentication state directly into request headers.

The recommended flow works as follows:

1. The user signs in through the mobile app's native UI via the Native Auth SDK.
1. Before loading the web view, the app retrieves a valid access token from the SDK.
1. The app loads the web view with a custom request that includes the access token in the `Authorization: Bearer <access_token>` header.
1. The web resource validates the token and grants access immediately.

The following diagram shows the interaction between the web resource, mobile app, SDK, and the identity service (ESTS):

:::image type="content" source="./media/native-authentication/common/native-application-sign-in-with-web-view-authentication.png" alt-text="Sequence diagram showing the SSO flow where the mobile app signs in via SDK, receives tokens, and loads the web view with the access token in the Authorization header.":::

## Prerequisites

- A mobile app with native authentication configured using the Native Auth SDK. If you haven't set up your app yet, see [Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md) or [Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).
- A completed sign-in flow in your native app. For guidance, see [Sign in users in an Android mobile app](quickstart-native-authentication-android-sign-in.md) or [Sign in users in an iOS mobile app](quickstart-native-authentication-ios-sign-in.md).
- A web resource served over HTTPS (TLS). Don't send tokens over HTTP.
- A shared client identity (application ID) between the mobile app and the web resource. For details, see [Limitations and configuration requirements](#limitations-and-configuration-requirements).

## Sign in with native authentication

Complete the standard sign-in flow using the Native Auth SDK. When sign-in succeeds, the SDK caches the access token, ID token, and refresh token securely.

For detailed sign-in implementation steps, see:

- **Android**: [Sign in users in an Android (Kotlin) mobile app](tutorial-native-authentication-android-sign-in-sign-out.md)
- **iOS/macOS**: [Sign in users in an iOS (Swift) mobile app](tutorial-native-authentication-ios-macos-sign-in-sign-out.md)

## Retrieve the access token

When the user triggers the action to open the web view, request a token silently from the SDK. A silent token request ensures the app has a valid, unexpired token before loading the web resource.

The Native Auth SDK provides a `getAccessToken()` method that retrieves a valid token from the cache or silently refreshes it. For details on acquiring access tokens with specific scopes, see:

- **Android**: [Acquire multiple access tokens](tutorial-native-authentication-android-sign-in-call-api.md)
- **iOS/macOS**: [Acquire multiple access tokens](tutorial-native-authentication-ios-sign-in-call-api.md)

Request the token with the exact scopes required by the web resource. For scope requirements, see [Limitations and configuration requirements](#limitations-and-configuration-requirements).

## Load the web view with authentication

There are two methods to pass the authentication state to the web view. The recommended approach uses authorization headers. A cookie-based fallback is available for legacy scenarios but is discouraged.

### Option A: Use a bearer token via HTTP header (recommended)

Inject the access token directly into the `Authorization` header of the initial HTTP request used to load the web view. This is the most secure and robust method.

This approach is preferred because it:

- **Is stateless**: It doesn't rely on persistent cookies on the client side.
- **Isolates the token**: It strictly limits the token to this specific request flow.
- **Avoids web-based attack vectors**: It sidesteps common security issues associated with browser-managed sessions.

To load the web view with header-based authentication:

1. Construct the URL for the web resource. Ensure it uses HTTPS.
1. Create a custom network request object.
1. Add the header `Authorization: Bearer <access_token>` to the request.
1. Load the request into the web view component (for example, `WKWebView` on iOS or `WebView` on Android).

<!-- TODO: Add platform-specific code examples for iOS (WKWebView) and Android (WebView). Use approved fake GUIDs from the SFI sensitive identifiers list for any sample values. -->

### Option B: Use cookies (fallback only)

If the target web resource can't handle header-based authentication (for example, certain legacy single-page applications), you can inject the token as a cookie. This approach is generally discouraged because of security risks.

Injecting cookies into a web view entrusts the authentication state to a browser-managed mechanism. This makes the session "ambient" (automatically attached to requests), which exposes the app to standard web attack classes:

- **XSS (cross-site scripting)**: The session is vulnerable to hijacking if the web content is compromised.
- **CSRF (cross-site request forgery)**: There's a risk of unintended authenticated requests.
- **Session fixation**: An attacker might control the session state.
- **Compliance**: This approach conflicts with security best practices (for example, MASTG-KNOW-0018) regarding persisting sensitive state in web view cookie jars.

> [!WARNING]
> The cookie-based approach is conditionally approved and generally discouraged. Use it only when the target web resource can't support header-based authentication.

If you use the cookie-based approach, these requirements apply:

- Use server-issued session cookies where possible.
- Avoid placing raw access tokens directly into cookies.
- Set cookies with the `HttpOnly`, `Secure`, and appropriate `SameSite` attributes.
- Enforce strict CSRF protection on the server side.

## Validate and persist the token on the backend

When the request reaches the web resource, the backend processes the token to establish the session.

### Validate the token

The web server intercepts incoming requests and verifies the token's signature and claims. For ASP.NET Core backends, use `Microsoft.Identity.Web` (MISE) to handle validation automatically.

Ensure the token's audience (`aud`) claim matches the web API's identifier and the issuer (`iss`) claim matches the expected authority.

<!-- TODO: Add link to token validation guidance -->
<!-- TODO: When adding code examples, use approved fake GUIDs from the SFI sensitive identifiers list for any client IDs, tenant IDs, or token values -->

### Persist the session

The web view doesn't persist custom headers on subsequent navigation events (for example, when the user selects a link). To maintain the authenticated state after the initial request, the server issues a standard session cookie (`Set-Cookie`) upon successful validation of the initial bearer token.

Configure the session cookie with the following attributes:

- `HttpOnly`
- `Secure`
- An appropriate `SameSite` policy

## Limitations and configuration requirements

To ensure the token issued to the mobile app is accepted by the web resource, keep the following configurations in mind:

- **Shared client identity**: The mobile app and web app should share the same client ID (application ID). If they have different IDs, the backend rejects the mobile app's token as an audience mismatch.
- **Scope alignment**: The mobile app requests the access token with the exact scopes required by the web resource (for example, `Profile.Read`, `Orders.Write`).

> [!NOTE]
> This solution is tailored specifically for the web view scenario. A more generic solution that extends SSO capabilities to system browsers and other complex scenarios is planned for a future release.

## Related content

- [Native authentication in Microsoft Entra External ID](concept-native-authentication.md)
- [Native authentication web fallback](concept-native-authentication-web-fallback.md)
- [Native authentication API reference](reference-native-authentication-api.md)
