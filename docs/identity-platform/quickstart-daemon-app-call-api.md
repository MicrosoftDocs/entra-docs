---
title: Quickstart - Sign in users in a sample web app
description: Web app quickstart that shows how to configure a sample web app that signs in employees or customers by using Microsoft identity platform
author: kengaderdus
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.author: kengaderdus
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample web app so that I can sign in my employees or customers by using Microsoft identity platform.
---

# Quickstart: Sign in users in a sample web app

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

In this quickstart, you use a sample daemon application acquires and access token to call a protected web API as itself (its own identity) by using the [Microsoft Authentication Library (MSAL)](msal-overview.md).

A daemon application acquires a token on behalf of itself (not on behalf of a user). Users can't interact with a daemon application because it requires its own identity. This type of application requests an access token by using its application identity by presenting its application ID, credential (secret or certificate), and an application ID URI.

The application is a daemon uses the standard [OAuth 2.0 client credentials grant flow](v2-oauth2-client-creds-grant-flow.md) to acquire an access token.

::: zone pivot="workforce" 

## Prerequisites

#### [Node](#tab/node-workforce)


#### [.NET](#tab/asp-dot-net-core-workforce)



#### [Python Flask](#tab/java-workforce)



#### [Python Flask](#tab/python-flask-workforce)


--- 

::: zone-end 


::: zone pivot="external"

## Prerequisites

#### [Node](#tab/node-external)


#### [.NET](#tab/asp-dot-net-core-external)


--- 
::: zone-end 