---
title: Use MSAL.js with Azure AD B2C
description: The Microsoft Authentication Library for JavaScript (MSAL.js) enables applications to work with Azure AD B2C and acquire tokens to call secured web APIs. These web APIs can be Microsoft Graph, other Microsoft APIs, web APIs from others, or your own web API.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: devx-track-js
ms.date: 03/07/2023
ms.reviewer: negoe
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to learn how MSAL.js can be used with Azure AD B2C for authentication and authorization in my organization's web apps and web APIs that my customers log in to and use.
---

# Use the Microsoft Authentication Library for JavaScript to work with Azure AD B2C

The [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) enables JavaScript developers to authenticate users with social and local identities using [Azure Active Directory B2C](/azure/active-directory-b2c/overview) (Azure AD B2C).

By using Azure AD B2C as an identity management service, you can customize and control how your customers sign up, sign in, and manage their profiles when they use your applications.

Azure AD B2C also enables you to brand and customize the UI that your application displays during the authentication process.

## Supported app types and scenarios

MSAL.js enables [single-page applications](/azure/active-directory-b2c/application-types#single-page-applications) to sign-in users with Azure AD B2C using the [authorization code flow with PKCE](/azure/active-directory-b2c/authorization-code-flow) grant. With MSAL.js and Azure AD B2C:

- Users **can** authenticate with their social and local identities.
- Users **can** be authorized to access Azure AD B2C protected resources (but not Microsoft Entra protected resources).
- Users **cannot** obtain tokens for Microsoft APIs (for example, MS Graph API) using [delegated permissions](./permissions-consent-overview.md#types-of-permissions).
- Users with administrator privileges **can** obtain tokens for Microsoft APIs (for example, MS Graph API) using [delegated permissions](./permissions-consent-overview.md#types-of-permissions).

For more information, see: [Working with Azure AD B2C](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/working-with-b2c.md)

## Next steps

Follow the tutorial on how to:

- [Sign in users with Azure AD B2C in a single-page application](/azure/active-directory-b2c/configure-authentication-sample-spa-app)
- [Call an Azure AD B2C protected web API](/azure/active-directory-b2c/enable-authentication-web-api)
