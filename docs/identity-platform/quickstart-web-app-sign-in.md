---
title: Quickstart - Sign in users in a sample web app
description: Web app quickstart
services: identity-platform
author: kengaderdus
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.author: kengaderdus
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample web app so that I can sign in my employees and customers by using Microsoft identity platform.
---

# Quickstart - Sign in users in a sample web app

Before you begin, use the **Choose a tenant type** selector at the top of this page to select tenant type. Microsoft Entra ID provides two tenant configurations, [workforce](../external-id/tenant-configurations.md) and [external](../external-id/tenant-configurations.md). A workforce tenant configuration is for your employees, internal apps, and other organizational resources. An external tenant is for your customer-facing apps.

::: zone pivot="workforce"

This quickstart uses a sample web app to show you how to sign in users in your workforce tenant. The sample uses the [Microsoft Authentication Library](msal-overview.md) to handle authentication.


::: zone-end 


::: zone pivot="external"

This quickstart uses a sample web app to show you how to sign in users in your external tenant. The sample uses the [Microsoft Authentication Library](msal-overview.md) to handle authentication.

## Prerequisites

#### [Node](#tab/node)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org).
- [.NET 7.0](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install) or later.
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [ASP.NET Core](#tab/asp-dot-net-core)

- Although any IDE that supports ASP.NET Core applications can be used, Visual Studio Code is used for this guide. It can be downloaded from the [Downloads](https://visualstudio.microsoft.com/downloads/) page.
- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [Python Django](#tab/python-django)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [Python Flask](#tab/python-flask)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
---

## Register the web app

#### [Node](#tab/node)

PLACEHOLDER

#### [ASP.NET Core](#tab/asp-dot-net-core)

PLACEHOLDER

#### [Python Django](#tab/python-django)

PLACEHOLDER

#### [Python Flask](#tab/python-flask)

---

::: zone-end