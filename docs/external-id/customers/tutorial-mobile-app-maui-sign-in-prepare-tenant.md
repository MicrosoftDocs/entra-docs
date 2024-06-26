---
title: "Tutorial: Register and configure .NET MAUI mobile app in an external tenant"
description: The tutorials provide a step-by-step guide on how to register and configure a .NET MAUI app with Microsoft Entra External ID for the customer's tenant.
author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id
ms.topic: tutorial
ms.subservice: customers
ms.custom: devx-track-dotnet
ms.date: 06/05/2023
---

# Tutorial: Register and configure .NET MAUI mobile app in an external tenant

This tutorial series demonstrates how to build a .NET Multi-platform App UI (.NET MAUI) mobile app that authenticates using an external tenant. You'll register an app within the customer's tenant, create the .NET MAUI desktop app, and you implement the sign-in and sign-out code to enable secure authentication. You'll use cross-platform code while enhancing the default application class with Android platform-specific code. You'll register the app in the Microsoft Entra admin center, create the app and implement the sign-in and sign-out code to enable secure authentication.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register a .NET MAUI mobile app in customers tenant.
> - Create a sign-in and sign-out user flow in customers tenant.
> - Associate your .NET MAUI mobile app with the user flow.

## Prerequisites

- An external tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    - Application Administrator
    - Application Developer
    - Cloud Application Administrator

## Register .NET MAUI mobile app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-platform](./includes/register-app/add-platform-redirect-url-dotnet-maui.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the .NET MAUI mobile app with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next steps

> [!div class="nextstepaction"]
> [Part 2: Create a .NET MAUI shell app, add MSAL, and include an image resource](tutorial-mobile-app-maui-sign-in-prepare-app.md)
