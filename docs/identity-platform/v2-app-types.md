---
title: Application types for the Microsoft identity platform
description: The types of apps and scenarios supported by the Microsoft identity platform.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: fasttrack-edit
ms.date: 11/13/2024
ms.reviewer: saeeda, jmprieur
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As a developer or admin in the Microsoft identity platform, I want to understand the different types of applications supported by the Microsoft identity platform, so that I can choose the right type of application for my scenario.
---

# Application types for the Microsoft identity platform

The Microsoft identity platform supports authentication for various modern app architectures, all of them based on industry-standard protocols [OAuth 2.0 or OpenID Connect](./v2-protocols.md). This article describes the types of apps that you can build by using Microsoft identity platform, regardless of your preferred language or platform. The information is designed to help you understand high-level scenarios before you start working with the code in the [application scenarios](authentication-flows-app-scenarios.md#application-types).

## The basics

You must register each app that uses the Microsoft identity platform in the Microsoft Entra admin center [App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM). The app registration process collects and assigns these values for your app:

* An **Application (client) ID** that uniquely identifies your app
* A **Redirect URI** that you can use to direct responses back to your app
* A few other scenario-specific values such as supported account types

For details, learn how to [register an app](quickstart-register-app.md).

After the app is registered, the app communicates with the Microsoft identity platform by sending requests to the endpoint. We provide open-source frameworks and libraries that handle the details of these requests. You also have the option to implement the authentication logic yourself by creating requests to these endpoints:

```HTTP
https://login.microsoftonline.com/common/oauth2/v2.0/authorize
https://login.microsoftonline.com/common/oauth2/v2.0/token
```

The app types supported by the Microsoft identity platform are;

- Single-page app (SPA)
- Web app
- Web API
- Mobile and native apps
- Service, daemon, script

## Single-page apps

Many modern apps have a single-page app (SPA) front end written primarily in JavaScript, often with a framework like Angular, React, or Vue. The Microsoft identity platform supports these apps by using the [OpenID Connect](v2-protocols-oidc.md) protocol for authentication and one of two types of authorization grants defined by OAuth 2.0. Use the [authorization code flow with Proof Key for Code Exchange (PKCE)](https://devblogs.microsoft.com/identity/migrate-to-auth-code-flow/) when developing SPAs. This flow is more secure than the implicit flow, which is no longer recommended. For more information, see [prefer the auth code flow](v2-oauth2-implicit-grant-flow.md#prefer-the-auth-code-flow).

The flow diagram demonstrates the OAuth 2.0 authorization code grant flow (with details around PKCE omitted), where the app receives a code from the Microsoft identity platform `authorize` endpoint, and redeems it for an access token and a refresh token using cross-site web requests. For SPAs, the access token is valid for 1 hour, and once expired, must request another code using the refresh token. In addition to the access token, an `id_token` that represents the signed-in user to the client application is typically also requested through the same flow and/or a separate OpenID Connect request (not shown here).

:::image type="content" source="media/v2-oauth-auth-code-spa/oauth-code-spa.svg" alt-text="Diagram showing the OAuth 2.0 authorization code flow between a single-page app and the security token service endpoint." border="false":::

To see this in action, refer to the [Quickstart: Sign in users in a single-page app (SPA) and call the Microsoft Graph API using JavaScript](./quickstart-single-page-app-javascript-sign-in.md).

## Web apps

For web apps (.NET, PHP, Java, Ruby, Python, Node) that the user accesses through a browser, you can use [OpenID Connect](./v2-protocols.md) for user sign-in. In OpenID Connect, the web app receives an ID token. An ID token is a security token that verifies the user's identity and provides information about the user in the form of claims:

```JSON
// Partial raw ID token
abC1dEf2Ghi3jkL4mNo5Pqr6stU7vWx8Yza9...

// Partial content of a decoded ID token
{
    "name": "Casey Jensen",
    "email": "casey.jensen@onmicrosoft.com",
    "oid": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    ...
}
```

Further details of different types of tokens used in the Microsoft identity platform are available in the [access token](access-tokens.md) reference and [id_token](id-tokens.md) reference.

In web server apps, the sign-in authentication flow takes these high-level steps:

![Shows the web app authentication flow](./media/v2-app-types/convergence-scenarios-webapp.svg)

You can ensure the user's identity by validating the ID token with a public signing key that is received from the Microsoft identity platform. A session cookie is set, which can be used to identify the user on subsequent page requests.

Learn more by building an [ASP.NET Core web app to sign in users and call the Microsoft Graph API](./quickstart-web-app-dotnet-core-sign-in.md)

In addition to simple sign-in, a web server app might need to access another web service, such as a [Representational State Transfer (REST) API](/rest/api/azure/). In this case, the web server app engages in a combined OpenID Connect and OAuth 2.0 flow, by using the [OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md). For more information about this scenario, see our code [sample](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-1-Call-MSGraph/README.md).

## Web APIs

You can use the Microsoft identity platform to secure web services, such as your app's RESTful web API. Web APIs can be implemented in numerous platforms and languages. They can also be implemented using HTTP Triggers in Azure Functions. Instead of ID tokens and session cookies, a web API uses an OAuth 2.0 access token to secure its data and to authenticate incoming requests. 

The caller of a web API appends an access token in the authorization header of an HTTP request, like this:

```HTTP
GET /api/items HTTP/1.1
Host: www.mywebapi.com
Authorization: Bearer abC1dEf2Ghi3jkL4mNo5Pqr6stU7vWx8Yza9...
Accept: application/json
...
```

The web API uses the access token to verify the API caller's identity and to extract information about the caller from claims that are encoded in the access token. Further details of different types of tokens used in the Microsoft identity platform are available in the [access token](access-tokens.md) reference and [ID token](id-tokens.md) reference.

A web API can give users the power to opt in or opt out of specific functionality or data by exposing permissions, also known as [scopes](./permissions-consent-overview.md). For a calling app to acquire permission to a scope, the user must consent to the scope during a flow. The Microsoft identity platform asks the user for permission, and then records permissions in all access tokens that the web API receives. The web API validates the access tokens it receives on each call and performs authorization checks.

A web API can receive access tokens from all types of apps, including web server apps, desktop and mobile apps, single-page apps, server-side daemons, and even other web APIs. The high-level flow for a web API looks like this:

![Shows the web API authentication flow](./media/v2-app-types/convergence-scenarios-webapi.svg)

To learn how to secure a web API by using OAuth2 access tokens, check out the web API code samples in the [protected web API tutorial](tutorial-web-api-dotnet-register-app.md).

In many cases, web APIs also need to make outbound requests to other downstream web APIs secured by Microsoft identity platform. To do so, web APIs can take advantage of the **On-Behalf-Of (OBO)** flow, which allows the web API to exchange an incoming access token for another access token to be used in outbound requests. For more info, see the [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](v2-oauth2-on-behalf-of-flow.md).

## Mobile and native apps

Device-installed apps, such as mobile and desktop apps, often need to access back-end services or web APIs that store data and perform functions on behalf of a user. These apps can add sign-in and authorization to back-end services by using the [OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md).

In this flow, the app receives an authorization code from the Microsoft identity platform when the user signs in. The authorization code represents the app's permission to call back-end services on behalf of the user who is signed in. The app can exchange the authorization code in the background for an OAuth 2.0 access token and a refresh token. The app can use the access token to authenticate to web APIs in HTTP requests, and use the refresh token to get new access tokens when older access tokens expire.

![Shows the native app authentication flow](./media/v2-app-types/convergence-scenarios-native.svg)

> [!NOTE]
> If the application uses the default system webview, check the information about "Confirm My Sign-In" functionality and error code `AADSTS50199` in [Microsoft Entra authentication and authorization error codes](reference-error-codes.md).

## Server, daemons, and scripts

Apps that have long-running processes or that operate without interaction with a user also need a way to access secured resources, such as web APIs. These apps can authenticate and get tokens by using the app's identity, rather than a user's delegated identity, with the OAuth 2.0 client credentials flow. You can prove the app's identity using a client secret or certificate. For more info, see [.NET daemon console application using Microsoft identity platform](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2).

In this flow, the app interacts directly with the `/token` endpoint to obtain access:

![Shows the daemon app authentication flow](./media/v2-app-types/convergence-scenarios-daemon.svg)

To build a daemon app, see the [client credentials documentation](v2-oauth2-client-creds-grant-flow.md), or try a [.NET sample app](https://github.com/Azure-Samples/active-directory-dotnet-daemon-v2).

## See also

- Learn about [OAuth 2.0 and OpenID Connect](./v2-protocols.md)
- [Register an application](./quickstart-register-app.md)
