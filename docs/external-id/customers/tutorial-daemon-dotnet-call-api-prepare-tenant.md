---
title: "Tutorial: Prepare your external tenant to authorize a .NET daemon app"
description: Learn about how to prepare your external tenant to acquire an access token using client credentials flow in your .NET daemon application
 a
author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
ms.subservice: customers
ms.custom: devx-track-dotnet
ms.topic: tutorial
ms.date: 07/28/2023
---

# Tutorial: Prepare your external tenant to authorize a .NET daemon application

In this tutorial series, you'll learn how to build a .NET daemon app that calls your own custom protected web API using Microsoft Entra External ID. You'll register an app in Microsoft Entra ID and authenticate your app with your external tenant. Finally, you'll run the app and test the sign-in and sign-out experiences.

> [!div class="checklist"]
>
> - Register a web API and configure app permissions the Microsoft Entra admin center.
> - Register a client daemon application and grant it app permissions in the Microsoft Entra admin center
> - Create a client secret for your daemon application in the Microsoft Entra admin center.

## Prerequisites

- A Microsoft Entra ID for external tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    - Application Administrator
    - Application Developer
    - Cloud Application Administrator

## Register a web API application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/register-api-app.md)]

## Configure app roles

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-role.md)]

## Configure idtyp token claim

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-optional-claims-access.md)]

## Register the daemon app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Create a client secret

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-app-client-secret.md)]

## Grant API permissions to the daemon app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-app-permissions.md)]

## Record your app registration details

The next step after this tutorial is to build a daemon app that calls your web API. Ensure you have the following details:

- The Application (client) ID of the client daemon app that you registered.
- The Directory (tenant) subdomain where you registered your daemon app. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
- The application secret value for the daemon app you created.
- The Application (client) ID of the web API app you registered.

## Next step

> [!div class="nextstepaction"]
> [Part 2: Call a protected web API from your .NET daemon app](tutorial-daemon-dotnet-call-api-build-app.md)
