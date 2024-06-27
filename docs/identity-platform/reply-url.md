---
title: Redirect URI (reply URL) best practices and limitations
description: A description of the best practices and limitations of redirect URIs in the Microsoft identity platform.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.date: 06/25/2024
ms.reviewer:
ms.service: identity-platform

ms.topic: reference
#Customer intent:As a developer registering an application with the Microsoft identity platform, I want to understand the restrictions and limitations of redirect URIs, so that I can correctly configure the redirect URI for successful authorization and token retrieval.
---

# Redirect URI (reply URL) outline and restrictions

To sign in a user, your application must send a login request to the Microsoft Entra authorization endpoint, with a redirect URI specified as a parameter. The redirect URI is a critical security feature that ensures the Microsoft Entra authentication server only sends authorization codes and access tokens to the intended recipient. This article outlines the features and restrictions of redirect URIs in the Microsoft identity platform.

## What is a redirect URI?

A redirect URI, or reply URL, is the location where the Microsoft Entra authentication server sends the user once they have successfully authorized and been granted an access token. To sign in a user, your application must send a login request with a redirect URI specified as a parameter, so after the user has successfully signed in, the authentication server will redirect the user and issue an access token to the redirect URI specified in the login request.

## Why do redirect URI(s) need to be added to an app registration?

For security reasons, the authentication server won't redirect users or send tokens to a URI that isn't added to the app registration. Microsoft Entra login servers only redirect users and send tokens to redirect URIs that have been added to an app registration. If the redirect URI specified in the login request doesn’t match any of the redirect URIs you have added in your application, you receive an error message such as `AADSTS50011: The reply URL specified in the request does not match the reply URLs configured for the application`. 

For more information on error codes, see [Microsoft Entra authentication and authorization error codes](reference-error-codes.md).

## Should I add a redirect URI to an app registration?

Whether you should add a redirect URI to your app registration depends on the authorization protocol your application uses. You must add appropriate redirect URIs to your app registration if your application is using the following authorization protocols:

-	[OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md)
-	[OAuth 2.0 client credentials flow](v2-oauth2-client-creds-grant-flow.md)
-	[OAuth 2.0 implicit grant flow](v2-oauth2-implicit-grant-flow.md)
-	[OpenID Connect](v2-protocols-oidc.md)
-	[Single sign-on SAML protocol](single-sign-on-saml-protocol.md)

You don’t need to add redirect URIs to your app registration if your application is using the following authorization protocols or features.

-	[Native Authentication](../external-id/customers/concept-native-authentication.md)
-	[OAuth 2.0 device code flow](v2-oauth2-device-code.md)
-	[OAuth 2.0 On-Behalf-Of flow](v2-oauth2-on-behalf-of-flow.md)
-	[OAuth 2.0 Resource owner password credential flow](v2-oauth-ropc.md)
-	[Windows Integrated Auth Flow](/entra/msal/dotnet/acquiring-tokens/desktop-mobile/integrated-windows-authentication)
-	[SAML 2.0 Identity Provider (IdP) for Single Sign On ](../identity/hybrid/connect/how-to-connect-fed-saml-idp.md)

### What platform should I add my redirect URI(s) to?

If the application you're building contains one or multiple redirect URIs in your app registration, you need to enable a [public client flow configuration](msal-client-applications.md). The following tables provide guidance on the type of redirect URI you should or shouldn't add based on the platform you're building your application on.

#### Web application redirect URI configuration

| Type of your application | Typical languages/Frameworks | Platform to add redirect URI in App Registration |
|--------------------------|------------------------------|--------------------------------------------------|
| A traditional web application where most of the application logic is performed on the server | Node.js, web, ASP.NET, Python, Java, ASP.NET Core, PHP, Ruby, Blazor Server | Web |
| A single-page application where most of the user interface logic is performed in a web browser communicating with the web server primarily using web APIs | JavaScript, Angular, React, Blazor WebAssembly, Vue.js | Single-page application (SPA) |

#### Mobile and desktop application redirect URI configuration

| Type of your application | Typical languages/Frameworks | Platform to add redirect URI in App Registration |
|--------------------------|------------------------------|--------------------------------------------------|
| An iOS or macOS app excluding the scenarios listed below this table | Swift, Objective-C, Xamarin | IOS/macOS |
| An Android app | Java, Kotlin, Xamarin | Android |
| An app that runs natively on a mobile device or desktop machine | Node.js electron, Windows desktop, UWP, React Native, Xamarin, Android, iOS/macOS | Mobile and desktop applications |

If you're building an iOS app using one of the following methods, use the **Mobile and desktop applications** platform to add a redirect URI:

 - iOS apps using legacy SDKs (ADAL) 
 - iOS apps using open source SDKs (AppAuth) 
 - iOS apps using cross-plat tech we don't support (Flutter) 
 - iOS apps implementing our OAuth protocols directly 
 - macOS apps using cross-plat tech we don't support (Electron)

#### Applications that don't require a redirect URI

| Type of application | Examples/notes | Associated OAuth flow |
|---------------------|----------------|-----------------------|
| Applications running on devices that have no keyboard | Applications running on smart TV, IoT device or a printer | Device code flow [learn more](v2-oauth2-device-code.md) |
| Applications that handle passwords users enter directly, instead of redirecting users to Entra hosted login website and letting Entra handle user password in a secure manner. | You should only use this flow when other more secure flows such as Authorization code flow aren't viable because it isn't as secure. | Resource owner password credential flow [learn more](v2-oauth2-client-creds-grant-flow.md) |
| Desktop or mobile applications running on Windows or on a machine connected to a Windows domain (AD or Azure AD joined) using Windows Integrated Auth Flow instead of Web account manager | A desktop or mobile application that should be automatically signed in after the user has signed into the windows PC system with an Entra credential | Windows Integrated Auth Flow [learn more](v2-oauth2-auth-code-flow.md) |

## What are the restrictions of redirect URIs for Microsoft Entra applications?

The Microsoft Entra application model specifies the following restrictions to redirect URIs:

* Redirect URIs must begin with the scheme `https`, with [exceptions for some localhost](#localhost-exceptions) redirect URIs.
* Redirect URIs are case-sensitive and must match the case of the URL path of your running application. 

    *Examples*:
    
    * If your application includes as part of its path `.../abc/response-oidc`, don't specify `.../ABC/response-oidc` in the redirect URI. Because the web browser treats paths as case-sensitive, cookies associated with `.../abc/response-oidc` may be excluded if redirected to the case-mismatched `.../ABC/response-oidc` URL.

* Redirect URIs *not* configured with a path segment are returned with a trailing slash ('`/`') in the response. This applies only when the response mode is `query` or `fragment`.

    *Examples*:

    * `https://contoso.com` is returned as `https://contoso.com/`
    * `http://localhost:7071` is returned as `http://localhost:7071/`

* Redirect URIs that contain a path segment are *not* appended with a trailing slash in the response.

    *Examples*:

    * `https://contoso.com/abc` is returned as `https://contoso.com/abc`
    * `https://contoso.com/abc/response-oidc` is returned as `https://contoso.com/abc/response-oidc`

* Redirect URIs *don't* support special characters - `! $ ' ( ) , ;`

### Maximum number of redirect URIs and URI length

The maximum number of redirect URIs can't be raised for [security reasons](#restrictions-on-wildcards-in-redirect-uris). If your scenario requires more redirect URIs than the maximum limit allowed, consider the following [state parameter approach](#use-a-state-parameter) as the solution. The following table shows the maximum number of redirect URIs you can add to an app registration in the Microsoft identity platform.

| Accounts being signed in | Maximum number of redirect URIs | Description |
|--------------------------|---------------------------------|-------------|
| Microsoft work or school accounts in any organization's Microsoft Entra tenant | 256 | `signInAudience` field in the application manifest is set to either *AzureADMyOrg* or *AzureADMultipleOrgs* |
| Personal Microsoft accounts and work and school accounts | 100 | `signInAudience` field in the application manifest is set to *AzureADandPersonalMicrosoftAccount* |

You can use a maximum of 256 characters for each redirect URI you add to an app registration.

### Redirect URIs in application vs. service principal objects

* *Always* add redirect URIs to the application object only.
* *Never* add redirect URI values to a service principal because these values could be removed when the service principal object syncs with the application object. This could happen due to any update operation that triggers a sync between the two objects.

### Query parameter support in redirect URIs

Query parameters *are allowed* in redirect URIs for applications that *only* sign in users with work or school accounts.

Query parameters *are not allowed* in redirect URIs for any app registration configured to sign in users with personal Microsoft accounts such as  Outlook.com (Hotmail), Messenger, OneDrive, MSN, Xbox Live, or Microsoft 365.

| App registration sign-in audience | Supports query parameters in redirect URI |
|-----------------------------------|-------------------------------------------|
| Accounts in this organizational directory only (Contoso only - Single tenant) | :::image type="icon" source="media/common/yes.png" border="false"::: |
| Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant) |:::image type="icon" source="media/common/yes.png" border="false"::: |
| Accounts in any organizational directory (Any Microsoft Entra directory - Multitenant) and personal Microsoft accounts (such as Skype and Xbox) | :::image type="icon" source="media/common/no.png" border="false":::  |
| Personal Microsoft accounts only | :::image type="icon" source="media/common/no.png" border="false"::: |

## Supported schemes

**HTTPS**: The HTTPS scheme (`https://`) is supported for all HTTP-based redirect URIs.

**HTTP**: The HTTP scheme (`http://`) is supported *only* for *localhost* URIs and should be used only during active local application development and testing.

| Example redirect URI                    | Validity |
|-----------------------------------------|----------|
| `https://contoso.com`                   | Valid    |
| `https://contoso.com/abc/response-oidc` | Valid    |
| `https://localhost`                     | Valid    |
| `http://contoso.com/abc/response-oidc`  | Invalid  |
| `http://localhost`                      | Valid    |
| `http://localhost/abc`                  | Valid    |

### Localhost exceptions

Per [RFC 8252 sections 8.3](https://tools.ietf.org/html/rfc8252#section-8.3) and [7.3](https://tools.ietf.org/html/rfc8252#section-7.3), "loopback" or "localhost" redirect URIs come with two special considerations:

1. `http` URI schemes are acceptable because the redirect never leaves the device. As such, both of these URIs are acceptable:
    - `http://localhost/myApp`
    - `https://localhost/myApp`
1. Due to ephemeral port ranges often required by native applications, the port component (for example, `:5001` or `:443`) is ignored for the purposes of matching a redirect URI. As a result, all of these URIs are considered equivalent:
    - `http://localhost/MyApp`
    - `http://localhost:1234/MyApp`
    - `http://localhost:5000/MyApp`
    - `http://localhost:8080/MyApp`

From a development standpoint, this means a few things:

* Do not register multiple redirect URIs where only the port differs. The login server picks one arbitrarily and uses the behavior associated with that redirect URI (for example, whether it's a `web`-, `native`-, or `spa`-type redirect).

    This is especially important when you want to use different authentication flows in the same application registration, for example both the authorization code grant and implicit flow. To associate the correct response behavior with each redirect URI, the login server must be able to distinguish between the redirect URIs and can't do so when only the port differs.
* To register multiple redirect URIs on localhost to test different flows during development, differentiate them using the *path* component of the URI. For example, `http://localhost/MyWebApp` doesn't match `http://localhost/MyNativeApp`.
* The IPv6 loopback address (`[::1]`) isn't currently supported.

#### Prefer 127.0.0.1 over localhost

To prevent your app from breaking due to misconfigured firewalls or renamed network interfaces, use the IP literal loopback address `127.0.0.1` in your redirect URI instead of `localhost`. For example, `https://127.0.0.1`.

You can't, however, use the **Redirect URIs** text box in the Azure portal to add a loopback-based redirect URI that uses the `http` scheme:

:::image type="content" source="media/reply-url/portal-01-no-http-loopback-redirect-uri.png" alt-text="Error dialog in Azure portal showing disallowed http-based loopback redirect URI":::

To add a redirect URI that uses the `http` scheme with the `127.0.0.1` loopback address, you must currently modify the [replyUrlsWithType attribute in the application manifest](reference-app-manifest.md#replyurlswithtype-attribute).

## Restrictions on wildcards in redirect URIs

Wildcard URIs like `https://*.contoso.com` may seem convenient, but should be avoided due to security implications. According to the OAuth 2.0 specification ([section 3.1.2 of RFC 6749](https://tools.ietf.org/html/rfc6749#section-3.1.2)), a redirection endpoint URI must be an absolute URI. As such, when a configured wildcard URI matches a redirect URI, query strings and fragments in the redirect URI are stripped.

Wildcard URIs are currently unsupported in app registrations configured to sign in personal Microsoft accounts and work or school accounts. Wildcard URIs are allowed, however, for apps that are configured to sign in only work or school accounts in an organization's Microsoft Entra tenant.

To add redirect URIs with wildcards to app registrations that sign in work or school accounts, use the application manifest editor in **App registrations** in the Azure portal. Though it's possible to set a redirect URI with a wildcard by using the manifest editor, we *strongly* recommend you adhere to section 3.1.2 of RFC 6749. and use only absolute URIs.

If your scenario requires more redirect URIs than the maximum limit allowed, consider the following state parameter approach instead of adding a wildcard redirect URI.

### Use a state parameter

If you have several subdomains and your scenario requires that, upon successful authentication, you redirect users to the same page from which they started, using a state parameter might be helpful.

In this approach:

1. Create a "shared" redirect URI per application to process the security tokens you receive from the authorization endpoint.
1. Your application can send application-specific parameters (such as subdomain URL where the user originated or anything like branding information) in the state parameter. When using a state parameter, guard against CSRF protection as specified in [section 10.12 of RFC 6749](https://tools.ietf.org/html/rfc6749#section-10.12).
1. The application-specific parameters include all the information needed for the application to render the correct experience for the user, that is, construct the appropriate application state. The Microsoft Entra authorization endpoint strips HTML from the state parameter so make sure you aren't passing HTML content in this parameter.
1. When Microsoft Entra ID sends a response to the "shared" redirect URI, it sends the state parameter back to the application.
1. The application can then use the value in the state parameter to determine which URL to further send the user to. Make sure you validate for CSRF protection.

> [!WARNING]
> This approach allows a compromised client to modify the additional parameters sent in the state parameter, thereby redirecting the user to a different URL, which is the [open redirector threat](https://tools.ietf.org/html/rfc6819#section-4.2.4) described in RFC 6819. Therefore, the client must protect these parameters by encrypting the state or verifying it by some other means, like validating the domain name in the redirect URI against the token.

## Next steps

Learn about the app registration [Application manifest](reference-app-manifest.md).
