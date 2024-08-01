---
title: Supported account types
description: Conceptual documentation about audiences and supported account types in in the Microsoft identity platform
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom:
ms.date: 04/24/2024
ms.reviewer: saeeda, jmprieur
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As a developer building a multi-tenant web application, I want to understand the supported account types in the Microsoft identity platform, so that I can ensure my application can sign in users from any organization and with their work, school, or personal Microsoft accounts.
---

# Supported account types

This article explains what account types (sometimes called *audiences*) are supported in the Microsoft identity platform applications.

<!-- This section can be in an include for many of the scenarios (SPA, web app signing-in users, protecting a web API, Desktop (depending on the flows), Mobile -->

## Account types in the public cloud

In the Microsoft Azure public cloud, most types of apps can sign in users with any audience:

- If you're writing a line-of-business (LOB) application, you can sign in users in your own organization. Such an application is sometimes called *single-tenant*.
- If you're an independent software vendor (ISV), you can write an application that signs in users:

  - In any organization. Such an application is called a *multitenant* web application. You'll sometimes read that it signs in users with their work or school accounts.
  - With their work or school or personal Microsoft accounts.
  - With only personal Microsoft accounts.

- If you're writing a business-to-consumer application, you can also sign in users with their social identities, by using Azure Active Directory B2C (Azure AD B2C).

## Account type support in authentication flows

Some account types can't be used with certain authentication flows. For instance, in desktop, Universal Windows Platform (UWP), or daemon applications:

- Daemon applications can be used only with Microsoft Entra organizations. It doesn't make sense to try to use daemon applications to manipulate Microsoft personal accounts. The admin consent will never be granted.
- You can use the integrated Windows authentication flow only with work or school accounts (in your organization or any organization). Integrated Windows authentication works with domain accounts, and it requires the machines to be domain-joined or Microsoft Entra joined. This flow doesn't make sense for personal Microsoft accounts.
- The [Resource Owner Password Credentials grant](./v2-oauth-ropc.md) (username/password) can't be used with personal Microsoft accounts. Personal Microsoft accounts require that the user consents to accessing personal resources at each sign-in session. That's why this behavior isn't compatible with non-interactive flows.

## Account types in national clouds

Apps can also sign in users in [national clouds](authentication-national-cloud.md). However, Microsoft personal accounts aren't supported in these clouds. That's why the supported account types are reduced, for these clouds, to your organization (single tenant) or any organizations (multitenant applications).

## Next steps

- Learn more about [tenancy in Microsoft Entra ID](./single-and-multi-tenant-apps.md).
- Learn more about [national clouds](./authentication-national-cloud.md).
