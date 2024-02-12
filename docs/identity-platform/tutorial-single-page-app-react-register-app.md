---
title: "Tutorial: Register a Single-page application with the Microsoft identity platform"
description: Register an application in a Microsoft Entra tenant.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 12/13/2023
ms.reviewer: EmLauber
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As a React developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register a Single-page application with the Microsoft identity platform

To interact with the Microsoft identity platform, Microsoft Entra ID must be made aware of the application you create. This tutorial shows you how to register a single-page application (SPA) in a tenant on the Microsoft Entra admin center.

In this tutorial:

> [!div class="checklist"]
>
> * Register the application in a tenant
> * Add a Redirect URI to the application
> * Record the application's unique identifiers

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application administrator
  * Application developer
  * Cloud application administrator

## Register the application and record identifiers

[!INCLUDE [Register a single-page application](./includes/register-app/spa-common/register-application-spa-common.md)]

## Add a platform redirect URI

[!INCLUDE [Add a platform redirect URI](./includes/register-app/spa-common/add-platform-redirect-spa-port-3000.md)]

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Prepare an application for authentication](tutorial-single-page-app-react-prepare-spa.md)