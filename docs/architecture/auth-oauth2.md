---
title: OAuth 2.0 authorization with Microsoft Entra ID
description: Architectural guidance on achieving OAuth 2.0 authorization with Microsoft Entra ID.
author: janicericketts
manager: martinco

ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 01/10/2023
ms.author: jricketts
ms.reviewer: ajburnle
---

# OAuth 2.0 authorization with Microsoft Entra ID

The Open Authorization (OAuth) 2.0 is the industry protocol for authorization. It allows a user to grant limited access to its protected resources. Designed to work specifically with Hypertext Transfer Protocol (HTTP), OAuth separates the role of the client from the resource owner. The client requests access to the resources controlled by the resource owner and hosted by the resource server. The resource server issues access tokens with the approval of the resource owner. The client uses the access tokens to access the protected resources hosted by the resource server.

OAuth 2.0 is directly related to OpenID Connect (OIDC). Since OIDC is an authentication and authorization layer built on top of OAuth 2.0, it isn't backward compatible with OAuth 1.0. Microsoft Entra ID supports all OAuth 2.0 flows.

## Use for:

Rich client and modern app scenarios and RESTful web API access.

![Diagram of architecture](./media/authentication-patterns/oauth.png)

## Components of system

- **User:** Requests a service from the web application (app). The user is typically the resource owner who owns the data and has the power to allow clients to access the data or resource.

- **Web browser:** The web browser that the user interacts with is the OAuth client.

- **Web app:** The web app, or resource server, is where the resource or data resides. It trusts the authorization server to securely authenticate and authorize the OAuth client.

- **Microsoft Entra ID:** Microsoft Entra ID is the authentication server, also known as the Identity Provider (IdP). It securely handles anything to do with the user's information, their access, and the trust relationship. It's responsible for issuing the tokens that grant and revoke access to resources.

<a name='implement-oauth-20-with-azure-ad'></a>

## Implement OAuth 2.0 with Microsoft Entra ID

- [Integrating applications with Microsoft Entra ID](~/identity/saas-apps/tutorial-list.md)

- [OAuth 2.0 and OpenID Connect protocols on the Microsoft identity platform](~/identity-platform/v2-protocols.md)

- [Application types and OAuth2](~/identity-platform/v2-app-types.md)
