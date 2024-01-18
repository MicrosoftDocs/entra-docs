---
title: "Tutorial: Register an application with the Microsoft identity platform"
description: In this tutorial, you learn how to register a web application with the Microsoft identity platform.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/02/2023
ms.service: active-directory
ms.subservice: develop
ms.topic: tutorial
#Customer intent: As an application developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register an application with the Microsoft identity platform

To interact with the Microsoft identity platform, Microsoft Entra ID must be made aware of the application you create. This tutorial shows you how to register a web application in a tenant on the Microsoft Entra admin center.

In this tutorial:

> [!div class="checklist"]
>
> * Register a web application in a tenant
> * Record the web application's unique identifiers
> * Add a platform redirect URI

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/).
* This Azure account must have permissions to manage applications. Use any of the following roles needed to register the application:
  * Application administrator
  * Application developer
  * Cloud application administrator

## Register the application and record identifiers

[!INCLUDE [Register a single-page application](./includes/register-app/web-app-common/register-application-web-app-common.md)]

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Prepare a web application for authentication](tutorial-web-app-dotnet-prepare-app.md)