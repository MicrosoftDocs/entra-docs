---
title: Authenticate applications and users with Microsoft Entra ID
description: How applications can use Microsoft Entra ID to authenticate users and applications.
customer-intent: I'm an independent software developer, and I want to learn how to use Microsoft Entra ID to authenticate users and applications.
author: jricketts
manager: martinco
ms.service: entra
ms.topic: article
ms.date: 03/14/2024
ms.author: jricketts
---
# Authenticate applications and users with Microsoft Entra ID

A primary Microsoft Entra ID function for apps is authentication, the process in which users declare their identity with a personal identifier, like a username or email address. Proof of the identity is provided. The proof could be a password, multifactor authentication artifact, a biometric, or passwordless consent.

This article describes how applications use Microsoft Entra ID to authenticate users and applications. It's the third in a series of articles on how Independent Software Developers (ISV) can build and optimize their applications for Microsoft Entra ID. In this series, you can learn more about these topics:

- [Microsoft Entra ID for Independent Software Developers](guide-for-independent-software-developers.md) describes how to use this cloud-based identity and access management service to enable employees to access resources with your application.
- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph Application Programming Interface (API) to register apps in a Microsoft Entra ID tenant.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) discusses authorization when an individual human interacts with and directs an application, when APIs act for a user. In addition, when applications or services work independently.
- [Customize tokens](customize-tokens.md) helps you to build security into applications with ID tokens and access tokens from Microsoft Entra ID. It describes the information that you can receive in Microsoft Entra ID tokens and how you can customize them.

## Request tokens

Applications request a token from Microsoft Entra ID. After apps receive the token, they can use the information in that token to identify the user. When you build on Microsoft Entra ID, users can authenticate many applications with a single registered Microsoft Entra ID account (SSO). The SSO authentication method allows users to sign in to multiple independent software systems using one set of credentials.

Protocols that developers can use to request a token from Microsoft Entra ID use a browser to connect the user to the Microsoft Entra ID website. This website enables the user to have a private conversation with Microsoft Entra ID. An application isn't a participant in that private conversation. Apps launch the Microsoft Entra ID website where the user initiates the authentication process. After the authentication process is complete, Microsoft Entra ID redirects the user back to the application, with or without a token.

It's important that users seldom need to go through the authentication process. The more frequently users must do so, the more they become susceptible to exploits like phishing attacks.

## Reduce sign-in prompts

SSO can reduce or eliminate sign-in prompts. Developers play a vital role in reducing and eliminating sign-in prompts. All apps must share the browser that accesses the Microsoft Entra ID website where the users perform the authentication process. If your app is a browser-based single page application (SPA) or web app, then there are no developer steps required. All apps in the browser share the browser. For native applications that run on desktops and mobile devices, developers must proactively reduce or eliminate sign-in prompts.

The best method to reduce or eliminate sign-in prompts is to use Microsoft Authentication Libraries (MSAL), or a library built on MSAL, and broker authentications. This method minimizes sign-in prompts and provides the most seamless experience. If building on MSAL isn't possible, then your application should use the system browser to minimize sign-in prompts.

For apps running in iOS or Android, mobile platform providers have some functionality to make this experience more seamless. Google has guidance for Android applications with [Chrome Custom Tabs](https://developer.chrome.com/multidevice/android/customtabs). Apple has guidance for [Authenticate a User Through a Web Service](https://developer.apple.com/documentation/authenticationservices/authenticating_a_user_through_a_web_service) in iOS applications. Avoid using embedded WebViews as they might not allow sharing across apps or with the system browser.

The two protocols for user authentication are [Security Assertion Markup Language (SAML)](auth-saml.md) 2.0 and [OpenID Connect (OIDC)](auth-oidc.md). Microsoft Entra ID fully supports apps using both protocols, so developers can choose either one based on their requirements.

These references detail Microsoft Entra ID SAML support.

- [Microsoft identity platform uses the SAML protocol](~/identity-platform/saml-protocol-reference.md) is the starting point for Microsoft Entra ID SAML documentation for developers.
- [Single sign-on SAML protocol](~/identity-platform/single-sign-on-saml-protocol.md) is the reference for the SAML 2.0 authentication requests and responses that Microsoft Entra ID supports.
- [Microsoft Entra federation metadata](~/identity-platform/federation-metadata.md) describes the Federation metadata and metadata endpoints for tenant-specific and tenant-independent metadata. It covers metadata for SAML and the older WS-Federation standards. While fully supported, we don't recommend WS-Federation for new applications.
- [SAML 2.0 token claims reference](~/identity-platform/reference-saml-tokens.md) is the documentation for Microsoft Entra ID SAML tokens (assertions).

There are some limitations in Microsoft Entra ID SAML support. Specifically, you can't migrate apps that require these protocol capabilities: support for the WS-Trust ActAs pattern and SAML artifact resolution.

While Microsoft Entra ID fully supports SAML for apps built on the SAML protocol, the Microsoft identity platform doesn't provide libraries or other development tools for developing applications with SAML. For new application development, we recommend using OpenID Connect (OIDC) for authentication.

Microsoft Entra ID fully supports OpenID Connect. Microsoft provides MSAL, Microsoft Identity Web, and Azure SDK libraries to ease OIDC application development. [OpenID Connect (OIDC) on the Microsoft identity platform](~/identity-platform/v2-protocols-oidc.md) details Microsoft Entra ID OIDC support. MSAL automatically supports OIDC. MSAL always requests an OIDC ID token with each token request, including authorization requests for an app to access a resource.

## Token lifetime

MSAL caches ID tokens and access tokens based on the access token's expiration time. As Microsoft Entra ID differently sets the lifetime on ID tokens and access tokens, you may receive an expired ID token from an expired MSAL cache while the access token is still within its valid lifetime.

MSAL doesn't automatically renew ID tokens. MSAL renews access tokens at, or near, the end-of-life for the access token when an application requests the token. At that point, MSAL requests a new ID token. To implement OIDC, use the `exp` (expire) claim in the ID token to schedule an ID token request using the `ForceRefresh` flag in MSAL.

When building on MSAL or a library built on MSAL isn't possible, you can use the OpenID Connect standard to authenticate the current user. Some functionality in native applications may not be possible without using MSAL such as ensuring the native app is running on a managed device. Review [Increase the resilience of authentication and authorization in client applications you develop](resilience-client-app.md) for guidance when you aren't building on MSAL.

Microsoft Entra ID implements a [*UserInfo*](~/identity-platform/userinfo.md) endpoint as part of Microsoft Entra ID OIDC standards support with a specific Microsoft Graph path (`https://graph.microsoft.com/oidc/userinfo`). It isn't possible to add or customize the information that the `UserInfo` endpoint returns. Because the information in the ID token is a superset of the information returned by calling the `UserInfo` endpoint, we recommend using the ID token instead of calling the `UserInfo` endpoint.

## Authenticate users

Applications interact with Microsoft Entra ID tenants to authenticate users. To authenticate a user, an application directs a browser to `https://login.microsoftonline.com/{tenant}/v2.0`, where `{tenant}` is the ID or domain of the tenant. However, we recommend that ISVs use Microsoft Entra ID to build multitenant applications that can support the widest range of customers. For a multitenant application, an app may not know what tenant a user is from until after the user authenticates, so it isn't possible to use a specific tenant endpoint.

To enable multitenant apps, Microsoft Entra ID provides two tenant-independent OIDC/OAuth 2.0 endpoints:

- `https://login.microsoftonline.com/common/v2.0` allows users to authenticate an app when they're from any Microsoft Entra ID tenant or who have a consumer Microsoft Account from sites like outlook.com, skype.com, xbox.com, live.com, or Hotmail.com.
- `https://login.microsoftonline.com/organizations/v2.0` allows users to authenticate an app when they're from any Microsoft Entra ID tenant.

These endpoints allow any user from any Microsoft Entra ID tenant to authenticate your application. If you want to allow only users from specific tenants, implement the logic to allow only users from those tenants to access your app. The normal implementation is to filter users based on the `iss` (issuer) or `tid` (tenant ID) claim in the token to an allowlist of tenants that you maintain.

Microsoft Entra ID tenants support users that can be regular members of the tenant or that can be guest users of the tenant. By default, there's limited capabilities for guest users in a tenant. For example, guest users can't see the full profile of other users in the tenant. Guest users, sometimes called Business to Business (B2B) users, enable different organizations to collaborate with tools and services that Microsoft Entra ID protects. An example scenario is inviting a user from outside your organization to access a SharePoint file in your tenant. Typically, a B2B user uses their email address as their `userid`. However, they may use that same address as the `userid` in their home tenant. By default, Microsoft Entra ID signs the user into their home tenant when they enter their `userid`.

To sign in a user as a B2B user, an application must use the specific tenant endpoint where the user is a guest. While it's possible for a user to specify a tenant that they want to access when an application uses the `https://login.microsoftonline.com/organizations/v2.0` endpoint, users may find that capability difficult to discover.

## Next steps

- [Microsoft Entra ID for Independent Software Developers](guide-for-independent-software-developers.md) describes how to use this cloud-based identity and access management service to enable employees to access resources with your application.
- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph API to register apps in a Microsoft Entra ID tenant.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) discusses authorization when an individual human interacts with and directs an application, when APIs act for a user, and when applications or services work independently.
- [Customize tokens](customize-tokens.md) helps you to build security into applications with ID tokens and access tokens from Microsoft Entra ID. It describes the information that you can receive in Microsoft Entra ID tokens and how you can customize them.
