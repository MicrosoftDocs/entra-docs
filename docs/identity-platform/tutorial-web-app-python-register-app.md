---
title: "Tutorial:  Register a web app with the Microsoft identity platform"
description: In this tutorial, you learn how to register a web app with the Microsoft identity platform.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 02/27/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register a Python web app with the Microsoft identity platform

This tutorial series demonstrates how to build a Python web app and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for Python](/entra/msal/python/) library to authenticate your app with your Microsoft Entra ID tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial, you'll;

> [!div class="checklist"]
> * Register a web application in the Microsoft Entra admin center, and record its identifiers
> * Create a client secret for the web application
> * Define the platform and URLs
> * Grant permissions to the web application to access the Microsoft Graph API
> * Create a sign in and sign out user flow in the Microsoft Entra admin center
> * Associate your web application with the user flow

## Prerequisites

* A Microsoft Entra ID tenant. If you don't have one, create a [trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
* The Azure account you use must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application Administrator
    * Application Developer
    * Cloud Application Administrator

## Register the web app and record identifiers


# Tutorial: Prepare your customer tenant to authenticate users in an ASP.NET Core web app

This tutorial series demonstrates how to build an ASP.NET Core web application and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for .NET](/entra/msal/dotnet/) and [Microsoft Identity Web](/dotnet/api/microsoft-authentication-library-dotnet/confidentialclient) libraries to authenticate your app with your Microsoft Entra ID for customers tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial, you'll;

> [!div class="checklist"]
> * Register a web application in the Microsoft Entra admin center, and record its identifiers
> * Create a client secret for the web application
> * Define the platform and URLs
> * Grant permissions to the web application to access the Microsoft Graph API
> * Create a sign in and sign out user flow in the Microsoft Entra admin center
> * Associate your web application with the user flow

## Prerequisites

* A Microsoft Entra ID for customers tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application Administrator
    * Application Developer
    * Cloud Application Administrator

## Register the web app and record identifiers

[!INCLUDE [Register app](./includes/register-app/web-app-common/register-application-web-app-common.md)]

## Add redirect URI

[!INCLUDE [Add redirect URI](./includes/register-app/web-app-common/add-platform-redirect-url-python.md)]


# Run the sample

