---
title: Microsoft Entra ID Guide for independent software developers
description: How independent software developers (ISVs) can build and optimize applications for Microsoft Entra ID
customer-intent: As an independent software developer, I want to learn how to build and optimize my applications to use Microsoft Entra ID.
author: jricketts
manager: martinco
ms.service: entra
ms.topic: article
ms.date: 03/14/2024
ms.author: jricketts
---
# Microsoft Entra ID Guide for independent software developers

[Microsoft Entra ID](~/fundamentals/whatis.md) is a cloud-based identity and access management service that enables employees to access resources. Industry analysts consistently recognize Microsoft Entra ID as a leader. It's a seven-time Leader in the [Gartner Magic Quadrant for Access Management](https://go.microsoft.com/fwlink/p/?linkid=2215126). [KuppingerCole rates Microsoft Entra ID](https://www.kuppingercole.com/reprints/62c08b4d46f70b1c19245b8f09011f5e) as positive across all dimensions in access management. Frost & Sullivan named Microsoft the [2022 Company of the Year](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE58dFV) for the Global Identity and Access Management industry. [Read stories](https://customers.microsoft.com/search?sq=%22Entra%20ID%22&ff=language%26%3EEnglish&p=6&so=story_publish_date%20desc) about some of more than 300,000 organizations that use Microsoft Entra ID.

This article is the first in a series on how independent software developers (ISVs) can build and optimize applications for Microsoft Entra ID. In this series, you can learn more about these topics:

- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph Application Programming Interface (API) to register apps in a Microsoft Entra ID tenant.
- [Authenticate applications and users](authenticate-applications-and-users.md) describes how applications use Microsoft Entra ID to authenticate users and applications.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) illustrates authorization when a human interacts with and directs an application. In this scenario, APIs act for a user, and when applications or services work independently.
- [Customize tokens](customize-tokens.md) helps you to build security into applications with ID tokens and access tokens from Microsoft Entra ID. It describes the information that you can receive in Microsoft Entra ID tokens and how you can customize them.

## Develop with the Microsoft identity platform

Applications are core to Microsoft Entra ID. When a user accesses a resource, they access that resource with an application. The [Microsoft identity platform](~/identity-platform/v2-overview.md) comprises the tools and services that enable developers to build on Microsoft Entra ID. The Microsoft identity platform starts with Microsoft Entra ID, the cloud service that provides operations like sign in, sign out, and application registration that an application requires. The Microsoft identity platform incorporates open-source [Microsoft Authentication Libraries (MSAL)](~/identity-platform/msal-overview.md) in various languages and frameworks and Microsoft Graph that provides APIs to access data and operations in Microsoft Entra ID.

For developers, the Microsoft identity platform includes the following features.

- Authenticate a user, authorize an app, generate API tokens.
- Simplify security feature integration directly with Microsoft Authentication Library (MSAL), or through a higher-level API such as [Microsoft.Identity.Web](~/identity-platform/reference-v2-libraries.md), or Azure.Identity.
- Instead of implementing OAuth 2.0 from scratch, use MSALs to abstract away complexity with robust APIs that remove developer toil.
- Ensure that applications follow best practices for security in compliance with industry standards and protocols such as OAuth 2.0.
- Unify authentication stories across applications and experiences with single sign-on (SSO) support.
- Streamline social identity integration with Microsoft External ID.
- Secure data and assets with minimal plumbing code and native support for Microsoft Entra ID capabilities such as [Conditional Access](~/identity/conditional-access/overview.md) (CA), [Continuous Access Evaluation (CAE)](~/identity/conditional-access/concept-continuous-access-evaluation.md), [Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md), and [device management](~/identity/devices/overview.md).
- Build applications that securely protect authentication tokens while ensuring device and policy compliance enforcement. Rely on support for authentication with modern brokers such as Microsoft Authenticator or built-in operating system components such as Web Account Manager (WAM) on Windows.

## Integrate applications with Microsoft Entra ID

Applications that integrate with Microsoft Entra ID user, service, or group identities interact with a Microsoft Entra ID tenant. A tenant is a dedicated instance of Microsoft Entra ID that usually represents an organization or a group within a larger company. The tenant holds the organization's directory, storing objects like work or school accounts, or invited partner accounts. Groups, applications, devices, and other objects are also stored. The tenant provides the web endpoints that applications use to perform operations, such as authentication.

An application makes requests to a tenant endpoint to get tokens that identify users or that resource APIs can use to authorize resource access. Application identities within Microsoft Entra ID allow applications to request tokens from a Microsoft Entra ID tenant while providing users the right level of context about who is trying to authenticate them.

While most enterprises require only one Microsoft Entra ID tenant, scenarios may require organizations to have multiple tenants to meet their business goals. A large enterprise may include multiple independent business units that could require coordination and collaboration across the whole enterprise. Cities in a region or schools in a district may have similar requirements. In these scenarios, each unit could have its own tenant with its own configuration and policies. Because Microsoft Entra ID cloud hosts tenants, organizations can set up [cross-tenant collaboration](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml) with minimal friction.

Microsoft Entra ID supports the following among a [wide range of protocols](auth-sync-overview.md).

- [OAuth 2.0](auth-oauth2.md) is the industry standard for authorization. Applications request an access token with the OAuth 2.0 protocol to get authorization for an application to access a protected resource.
- [OpenID Connect (OIDC)](auth-oidc.md) is an interoperable authentication standard built on top of OAuth 2.0. Applications request an ID token with the OIDC protocol to authenticate the current user.
- [Security Assertion Markup Language (SAML)](auth-saml.md) 2.0 is an authentication standard. Applications request a SAML assertion, also referred to as a SAML token, from Microsoft Entra ID to exchange authentication and authorization data between an app and Microsoft Entra ID. Applications use SAML to authenticate the current user.
- [System for Cross-Domain Identity Management (SCIM)](sync-scim.md) isn't for authentication and authorization. SCIM is a provisioning protocol that automates user and group information synchronization between Microsoft Entra ID and connecting applications. The synchronization provisions users and groups to an application.

The core operations that applications perform with Microsoft Entra ID are requesting and processing tokens. In the past, having the user identify themselves with a username and a password were often sufficient for an identity provider like Microsoft Entra ID to issue a token to an app. This token answered the question, "Who is the user and what can the app access?" Today, a more secure approach to verify identity accounts for more signals is:

* Who is the user?
* What can the app access?
  * From what device?
  * With what strength of credentials?
  * From what network locations?

Microsoft Entra ID customers can use features such as [Conditional Access](~/identity/conditional-access/overview.md) to determine which questions or conditions they want to evaluate to ensure secure resource access.

Developers who build applications that require user identity handling don't need to write code to account for this complexity in issuing tokens. Built-in MSAL capabilities enable authentication request processing. With Conditional Access enabled, when an application requests a token, Microsoft Entra ID ensures policy enforcement. It verifies requests against policies such as the user location (for example, whether they reside within the corporate network) or evaluating risk signals for the user. User risk evaluation may require more user interaction like multifactor authentication (MFA). After Microsoft Entra ID verifies compliance with policy constraints, it issues a token. When it can't verify compliance, Microsoft Entra ID doesn't issue a token to the app and provides the user with context as to why they can't access a resource.

As Conditional Access policies are now  more sophisticated. There's a broad set of signals that determines whether a user or service should receive a token. For example, it might be important to determine if a mobile device uses [Mobile Application Management (MAM)](/mem/intune/apps/app-management#mobile-application-management-mam-basics), whether [Intune manages](/mem/intune/apps/app-protection-policy) a Windows PC from within a desktop app. Or, you might need to protect tokens by binding them to a request's originating device. This diligence helps to ensure compliance and security with minimal friction to the developer. Microsoft libraries offer the necessary scaffolding while maintaining flexibility in responding to specific policy requirements.

## Authenticate and authorize with Microsoft Entra ID

Microsoft Entra ID supports authentication and authorization flows inside browsers to secure web-based assets (such as websites and APIs) and on client platforms like Windows, macOS, Linux, iOS, and Android. Technology providers across the ecosystem engage with Microsoft to ensure that customers, their organizations, and partners have seamless credential-handling experiences. Microsoft Edge works directly with Microsoft Entra ID to support device wide SSO to authenticate users on their Windows devices. [Google Chrome (version 111)](https://chromeenterprise.google/policies/#CloudAPAuthEnabled) and [Firefox (version 91)](https://support.mozilla.org/kb/windows-sso#firefox) have this functionality. Web applications that use Microsoft Entra ID identities automatically use these features in their browser-based apps to offer a seamless sign-in experience for customers.

To enable native applications to provide this unified SSO experience, Microsoft Entra introduced authentication brokers, applications that run on a user's device to manage authentication handshakes and maintain tokens for connected accounts. The following table lists authentication brokers for common operating systems.

|Operating System|Authentication Broker|
|---|---|
|iOS|Microsoft Authenticator app|
|Android|Microsoft Authenticator app or Intune Company Portal app|
|Windows|[Web Account Manager](/windows/uwp/security/web-account-manager) built-in operating system component available in Windows 10, Windows Server 2019 and later, Windows 11|

With authentication brokers, native application developers can use new Microsoft Entra ID capabilities such as device-based Conditional Access policies, without having to rewrite code as new features become available in the cloud. Applications that don't use an authentication broker may see limited app adoption by Microsoft Entra ID customers that require those features.

## Delegate identity and access management to Microsoft Entra ID

You can build applications that delegate identity and access management to Microsoft Entra ID using any developer tool, library, or framework that implements OAuth 2.0, OIDC, or SAML with the previously discussed caveats. Many [OIDC implementations](https://openid.net/developers/certified-openid-connect-implementations/) with OpenID Certification for one or more certification profiles, including authentication profiles, require minimal extra configuration to work with Microsoft Entra ID. To ease development for the Microsoft Entra ID platform, several optimized Microsoft libraries work with Microsoft services and capabilities.

- When you build web apps, APIs, or other workloads (such as daemons or services on ASP.NET Core or ASP.NET), use [Microsoft Identity Web](~/identity-platform/scenario-protected-web-api-app-configuration.md).
- If you build on Microsoft Azure, use [Azure SDKs](https://azure.microsoft.com/downloads/) that include the Azure Identity client libraries.
- When you can't use one of these libraries, use an [MSAL](~/identity-platform/msal-overview.md) for your development environment as shown in the following table.

|Library|Supported platforms and frameworks|
|----------|-----------|
|[MSAL for Android](https://github.com/AzureAD/microsoft-authentication-library-for-android)|Android|
|[MSAL Angular](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-angular)|Single-page apps with Angular and Angular.js frameworks|
|[MSAL Objective-C](https://github.com/AzureAD/microsoft-authentication-library-for-objc)|iOS, iPadOS, macOS|
|[MSAL Go](https://github.com/AzureAD/microsoft-authentication-library-for-go)|Windows, macOS, Linux|
|[MSAL Java](https://github.com/AzureAD/microsoft-authentication-library-for-java)|Windows, macOS, Linux|
|[MSAL.js](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser)|JavaScript/TypeScript frameworks such as Vue.js, Ember.js, or Durandal.js|
|[MSAL.NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet)|.NET, .NET Framework, .NET for Android, .NET for tvOS|
|[MSAL Node](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node)|Web apps with Express, desktop apps with Electron, Cross-platform console apps|
|[MSAL Python](https://github.com/AzureAD/microsoft-authentication-library-for-python)|Windows, macOS, Linux|
|[MSAL React](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-react)|Single-page apps with React and React-based libraries (Next.js, Gatsby.js)|

The MSAL family of libraries provides core token acquisition and caching functionality. Built on MSAL, Microsoft Identity Web, and Azure Identity clients, simplify token acquisition with authentication library capabilities.

Whenever possible, we advise ISVs [build on MSAL](resilience-client-app.md) or a library built on top of MSAL. MSAL supports brokered authentication, Conditional Access scenarios, token protection, [Microsoft Intune app protection policies](/mem/intune/apps/app-protection-policy) and [Mobile App Management](/mem/intune/apps/app-management#mobile-application-management-mam-basics), [Microsoft Continuous Access Evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md), and more.

Across all available platforms, the unified MSAL authentication framework seamlessly integrates with the Microsoft identity platform for consistent and secure user authentication. Because MSAL abstracts away complexity around proactive token renewal, caching, and revocation, developers can ensure that authentication flows are secure, robust, and reliable.

## Access other resources

Applications often need more than authentication and authorization (such as access to the tenant's directory data). Access may include getting attributes of the user, groups, group members, applications, and governance.

[Microsoft Graph](https://developer.microsoft.com/graph) provides access to the tenant's [identity and access](/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0), [users](/graph/api/resources/users?view=graph-rest-1.0&preserve-view=true), [groups](/graph/api/resources/groups-overview?view=graph-rest-1.0&tabs=http&preserve-view=true), and [applications](/graph/api/resources/application?view=graph-rest-1.0&preserve-view=true). Microsoft Graph is the gateway to data and intelligence in Microsoft 365. You can use its unified programmability model to access the tremendous amount of data in Microsoft 365, Windows, and Enterprise Mobility + Security (EMS).

## Next steps

- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph API to register apps in a Microsoft Entra ID tenant.
- [Authenticate applications and users](authenticate-applications-and-users.md) describes how applications use Microsoft Entra ID to authenticate users and applications.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) discusses authorization when an individual human interacts with and directs an application, when APIs act on behalf of a user, and when applications or services work independently.
- [Customize tokens](customize-tokens.md) helps you to build security into applications with ID tokens and access tokens from Microsoft Entra ID. It describes the information that you can receive in Microsoft Entra ID tokens and how you can customize them.
