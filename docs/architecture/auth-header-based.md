---
title: Header-based authentication with Microsoft Entra ID
description: Architectural guidance on achieving header-based authentication with Microsoft Entra ID.
author: janicericketts
manager: martinco

ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 01/10/2023
ms.author: jricketts
ms.reviewer: ajburnle
---

# Header-based authentication with Microsoft Entra ID

Legacy applications commonly use Header-based authentication. In this scenario, a user (or message originator) authenticates to an intermediary identity solution. The intermediary solution authenticates the user and propagates the required Hypertext Transfer Protocol (HTTP) headers to the destination web service. Microsoft Entra ID supports this pattern via its Application Proxy service, and integrations with other network controller solutions.

In our solution, Application Proxy provides remote access to the application, authenticates the user, and passes headers required by the application.

## Use when

Remote users need to securely single sign-on (SSO) into to on-premises applications that require header-based authentication.

![Architectural image header-based authentication](./media/authentication-patterns/header-based-auth.png)

## Components of system

- **User:** Accesses legacy applications served by Application Proxy.

- **Web browser:** The component that the user interacts with to access the external URL of the application.

- **Microsoft Entra ID:** Authenticates the user.

- **Application Proxy service:** Acts as reverse proxy to send request from the user to the on-premises application. It resides in Microsoft Entra ID and can also enforce any Conditional Access policies.

- **Private network connector:** Installed on-premises on Windows servers to provide connectivity to the applications. It only uses outbound connections. Returns the response to Microsoft Entra ID.

- **Legacy applications:** Applications that receive user requests from Application Proxy. The legacy application receives the required HTTP headers to set up a session and return a response.

<a name='implement-header-based-authentication-with-azure-ad'></a>

## Implement header-based authentication with Microsoft Entra ID

- [Add an on-premises application for remote access through Application Proxy in Microsoft Entra ID](~/identity/app-proxy/application-proxy-add-on-premises-application.md)

- [Header-based authentication for single sign-on with Application Proxy and PingAccess](~/identity/app-proxy/application-proxy-configure-single-sign-on-with-headers.md)

- [Secure legacy apps with app delivery controllers and networks](~/identity/enterprise-apps/secure-hybrid-access.md)
