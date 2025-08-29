---
title: How to register a daemon app that calls web APIs
description: Learn how to build a daemon app that calls web APIs - app registration
author: Dickson-Mwendia
manager: dougeby
ms.author: dmwendia
ms.date: 03/25/2025
ms.reviewer: jmprieur
ms.service: identity-platform.
ms.subservice: workforce
ms.topic: how-to
ms.custom: sfi-image-nochange
#Customer intent: As an application developer, I want to know how to write a daemon app that can call web APIs by using the Microsoft identity platform for developers.
---

# How to register a daemon app that calls web APIs

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

For a daemon application, here's what you need to know when you register the app.

## Supported account types

When creating the application in your in Microsoft Entra tenant, choose one of the following options for your app registration:

- **Accounts in this organizational directory only**. This choice is the most common one because daemon applications are written by line-of-business (LOB) developers.
- **Accounts in any organizational directory**. You make this choice if you're an Independent Software Vendor (ISV) providing a utility tool to your customers. You need your customers' tenant admins to approve it.

## Authentication - no reply URI needed

In the case where your confidential client application uses *only* the client credentials flow, the reply URI doesn't need to be registered. It's not needed for the application configuration or construction. The client credentials flow doesn't use it.

## API permissions - app permissions and admin consent

A daemon application can request only application permissions to APIs (not delegated permissions). On the **API permissions** page for the application registration, after you select **Add a permission** and choose the API family, choose **Application permissions**, and then select your permissions.

:::image type="content" source="media/scenario-daemon-app/app-permissions-and-admin-consent.png" alt-text="Screenshot of app permissions and admin consent." lightbox="media/scenario-daemon-app/app-permissions-and-admin-consent.png":::

The web API you're calling must define *Application permissions (app roles)*, not delegated permissions. To learn how to expose such an API, see [Protected web API: App registration - when your web API is called by a daemon app](scenario-protected-web-api-app-registration.md#if-your-web-api-is-called-by-a-service-or-daemon-app).

Daemon applications require the tenant admin to grant consent to the application calling the web API. Tenant admins provide consent on the **API permission** page by selecting **Grant admin consent to *our organization***.

[!INCLUDE [Pre-requisites](./includes/scenarios/scenarios-prerequisites.md)]

## Next steps

Move on to the next article in this scenario,
[App code configuration](./scenario-daemon-app-configuration.md).
