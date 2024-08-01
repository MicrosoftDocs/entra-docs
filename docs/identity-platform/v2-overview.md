---
title: Microsoft identity platform overview
description: Learn about the components of the Microsoft identity platform and how they can help you build identity and access management (IAM) support into your applications.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 03/20/2024
ms.reviewer: saeeda, dmwendia
ms.service: identity-platform

ms.topic: overview
#Customer intent: As an application developer, I want a quick introduction to the Microsoft identity platform so I can decide if this platform meets my application development requirements.
---

# What is the Microsoft identity platform?

The Microsoft identity platform is a cloud identity service that allows you to build applications your users and customers can sign in to using their Microsoft identities or social accounts. It authorizes access to your own APIs or Microsoft APIs like Microsoft Graph. The identity platform supports developers building single-tenant, line-of-business (LOB) applications, as well as multi-tenant software-as-a-service (SaaS) applications.

The following diagram shows the Microsoft identity platform at a high level, including the application registration experience, SDKs, endpoints, and supported identities or account types.

![Diagram showing the components of the Microsoft identity platform.](./media/v2-overview/about-microsoft-identity-platform.svg)

There are several components that make up the Microsoft identity platform:

- **OAuth 2.0 and OpenID Connect standard-compliant authentication service** enabling developers to authenticate several identity types, including:
  - Work or school accounts, provisioned through Microsoft Entra ID
  - Personal Microsoft accounts (Skype, Xbox, Outlook.com)
  - Social or local accounts, by using Azure AD B2C
  - Social or local customer accounts, by using Microsoft Entra External ID
  
- **Open-source libraries**: Microsoft Authentication Library (MSAL) and support for other standards-compliant libraries. The open source MSAL libraries are recommended as they provide built-in support for Conditional Access scenarios, single sign-on (SSO) experiences for your users, built-in token caching support, and more. MSAL supports the different authorization grants and token flows used in different application types and scenarios.
- **Microsoft identity platform endpoint** - The Microsoft identity platform endpoint is OIDC certified. It works with the Microsoft Authentication Libraries (MSAL) or any other standards-compliant library. It implements human readable scopes, in accordance with industry standards.
- **Application management portal**: A registration and configuration experience in the Microsoft Entra admin center, along with the other application management capabilities.
- **Application configuration API and PowerShell**: Programmatic configuration of your applications through the Microsoft Graph API and PowerShell so you can automate your DevOps tasks.
- **Developer content**: Technical documentation including quickstarts, tutorials, how-to guides, API reference, and code samples.

> [!VIDEO https://www.youtube.com/embed/uDU1QTSw7Ps]

For developers, the Microsoft identity platform offers integration of modern innovations in the identity and security space like passwordless authentication, step-up authentication, and Conditional Access. You don't need to implement such functionality yourself. Applications integrated with the Microsoft identity platform natively take advantage of such innovations.

With the Microsoft identity platform, you can write code once and reach any user. You can build an app once and have it work across many platforms, or build an app that functions as both a client and a resource application (API).

## Getting started

Choose your preferred [application scenario](authentication-flows-app-scenarios.md). Each of these scenario paths has an overview and links to a quickstart to help you get started:

- [React Single-page app (SPA)](quickstart-single-page-app-react-sign-in.md)
- [ASP.NET Core Web app](quickstart-web-app-dotnet-core-sign-in.md)
- [ASP.NET Core API](quickstart-web-api-aspnet-core-protect-api.md)
- [Desktop app](scenario-desktop-app-registration.md)
- [Daemon app](scenario-daemon-app-registration.md)
- [Mobile app](scenario-mobile-app-registration.md)

For a more in-depth look at building applications using the Microsoft identity platform, see our multipart tutorial series for the following applications:

- [React Single-page app (SPA)](tutorial-single-page-app-react-register-app.md)
- [ASP.NET Core Web app](tutorial-web-app-dotnet-register-app.md)
- [ASP.NET Core API](tutorial-web-api-dotnet-register-app.md)

As you work with the Microsoft identity platform to integrate authentication and authorization in your apps, you can refer to this image that outlines the most common app scenarios and their identity components. Select the image to view it full-size.

[![Metro map showing several application scenarios in Microsoft identity platform](./media/v2-overview/application-scenarios-identity-platform.png)](./media/v2-overview/application-scenarios-identity-platform.png#lightbox)

## Learn authentication concepts

Learn how core authentication and Microsoft Entra concepts apply to the Microsoft identity platform in this recommended set of articles:

- [Authentication basics](./authentication-vs-authorization.md)
- [Application and service principals](app-objects-and-service-principals.md)
- [Audiences](v2-supported-account-types.md)
- [Permissions and consent](./permissions-consent-overview.md)
- [ID tokens](id-tokens.md)
- [Access tokens](access-tokens.md)
- [Authentication flows and application scenarios](authentication-flows-app-scenarios.md)

## More identity and access management options

[Azure AD B2C](/azure/active-directory-b2c/overview) - Build customer-facing applications your users can sign in to using their social accounts like Facebook or Google, or by using an email address and password.

[Microsoft Entra B2B](~/external-id/what-is-b2b.md) - Invite external users into your Microsoft Entra tenant as "guest" users, and assign permissions for authorization while they use their existing credentials for authentication.

[Microsoft Entra External ID](~/external-id/customers/overview-customers-ciam.md) - A customer identity and access management (CIAM) solution that lets you create secure, customized sign-in experiences for your customer-facing apps and services.

## Next steps

If you have an Azure account, then you have access to a Microsoft Entra tenant. However, most Microsoft identity platform developers need their own Microsoft Entra tenant for use while developing applications, known as a *dev tenant*.

Learn how to create your own tenant for use while building your applications:

> [!div class="nextstepaction"]
> [Quickstart: Set up a Microsoft Entra tenant](quickstart-create-new-tenant.md)
