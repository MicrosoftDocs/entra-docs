---
title: "Tutorial: Register and configure a .NET MAUI app in an external tenant"
description: The tutorials provide a step-by-step guide on how to register and configure a .NET MAUI desktop app with Microsoft Entra External ID for the customer's tenant.
author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id
ms.topic: tutorial
ms.subservice: customers
ms.custom: devx-track-dotnet
ms.date: 06/05/2023
---

# Tutorial: Register and configure .NET MAUI app in an external tenant

This tutorial series demonstrates how to build a .NET Multi-platform App UI (.NET MAUI) desktop app that authenticates using an external tenant. You'll register an app within the customer's tenant, create the .NET MAUI desktop app, and you implement the sign-in and sign-out code to enable secure authentication. The .NET MAUI app you create uses cross-platform code while enhancing the default application class with *Window* platform-specific code.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register a .NET MAUI desktop app in customers tenant.
> - Create a sign-in and sign-out user flow in customers tenant.
> - Associate your .NET MAUI desktop app with the user flow.

## Prerequisites

- An external tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    - Application Administrator
    - Application Developer
    - Cloud Application Administrator

## Register .NET MAUI desktop app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-platform](./includes/register-app/add-platform-redirect-url-dotnet-maui.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the .NET MAUI desktop app with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next steps

> [!div class="nextstepaction"]
> [Part 2: Create a .NET MAUI shell app, add MSAL SDK, and include an image resource](tutorial-desktop-app-maui-sign-in-prepare-app.md)
