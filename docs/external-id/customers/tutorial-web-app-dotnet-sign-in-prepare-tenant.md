---
title: "Tutorial: Prepare your external tenant to authenticate users in an ASP.NET Core web app"
description: Learn how to configure your external tenant for authentication with an ASP.NET web application

author: cilwerner
manager: celestedg

ms.author: cwerner
ms.service: entra-external-id
ms.subservice: customers
ms.custom: devx-track-dotnet
ms.topic: tutorial
ms.date: 05/23/2023
#Customer intent: As a dev, DevOps, I want to learn about how to enable authentication in my own ASP.NET web app with an external tenant
---

# Tutorial: Prepare your external tenant to authenticate users in an ASP.NET Core web app

This tutorial series demonstrates how to build an ASP.NET Core web application and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for .NET](/entra/msal/dotnet/) and [Microsoft Identity Web](/dotnet/api/microsoft-authentication-library-dotnet/confidentialclient) libraries to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial, you'll;

> [!div class="checklist"]
> - Register a web application in the Microsoft Entra admin center, and record its identifiers
> - Create a client secret for the web application
> - Define the platform and URLs
> - Grant permissions to the web application to access the Microsoft Graph API
> - Create a sign in and sign out user flow in the Microsoft Entra admin center
> - Associate your web application with the user flow

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Register the web app and record identifiers

[!INCLUDE [ciam-register-app](./includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [ciam-register-app](./includes/register-app/add-platform-redirect-url-dotnet.md)]

## Add app client secret

[!INCLUDE [ciam-add-client-secret](./includes/register-app/add-app-client-secret.md)]

## Grant admin consent

[!INCLUDE [ciam-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [ciam-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [ciam-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next steps

> [!div class="nextstepaction"]
> [Part 2: Prepare an ASP.NET Core web app for authentication in an external tenant](tutorial-web-app-dotnet-sign-in-prepare-app.md)
