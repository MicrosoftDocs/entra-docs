---
title: "Tutorial: Prepare your external tenant to sign in user in .NET WPF application"
description: Learn about how to prepare your external tenant to sign in users to your .NET WPF application

author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
ms.subservice: external
ms.custom: devx-track-dotnet
ms.topic: tutorial
ms.date: 07/26/2023
---

# Tutorial: Prepare your external tenant to sign in user in .NET WPF application

This tutorial series demonstrates how to build a .NET Windows Presentation Form (WPF) desktop application and prepare it for authentication using the Microsoft Entra admin center. You'll register the app in the Microsoft Entra admin center, create a .NET WPF desktop app, add sign-in and sign-out components and run the application.

In this tutorial;

> [!div class="checklist"]
> - Register a WPF desktop application in the Microsoft Entra admin center
> - Create a sign-in and sign-out user flow in customers tenant
> - Associate your WPF desktop app with the user flow

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator.

## Register the desktop app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Specify your app platform

[!INCLUDE [active-directory-b2c-wpf-app-platform](./includes/register-app/add-platform-redirect-url-wpf.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the WPF application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Record your registration details

The next step after this tutorial is to build a WPF desktop app that authenticates users. Ensure you have the following details:

- The Application (client) ID of the WPF desktop app that you registered.
- The Directory (tenant) subdomain where you registered your WPF desktop app.

## Next step

> [!div class="nextstepaction"]
> [Step 2: Authenticate users to your WPF desktop application](./tutorial-desktop-wpf-dotnet-sign-in-build-app.md)
