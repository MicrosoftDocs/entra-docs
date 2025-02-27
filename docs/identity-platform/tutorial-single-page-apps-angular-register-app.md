---
title: "Tutorial: Register an Angular Single-page Application"
description: Register an Angular Single-page Application in a Microsoft Entra tenant to manage authentication and secure user access.
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.date: 11/11/2024
ms.reviewer: ejahjaloo
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register an Angular application in a Microsoft Entra ID tenant

To interact with the Microsoft identity platform, Microsoft Entra ID must be made aware of the application you create. This tutorial shows you how to register an Angular single-page application (SPA) in a tenant on the Microsoft Entra admin center.

In this tutorial:

> [!div class="checklist"]
>
> * Register the application in a tenant
> * Add a Redirect URI to the application
> * Record the application's unique identifiers

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application developer
  * Cloud Application Administrator

## Register the application and record identifiers

[!INCLUDE [Register a single-page application](./includes/register-app/spa-common/register-application-spa-common.md)]

## Add a platform redirect URI

[!INCLUDE [Add a platform redirect URI](./includes/register-app/spa-common/add-platform-redirect-spa-port-4200.md)]

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Prepare an application for authentication](tutorial-single-page-apps-angular-prepare-app.md)
