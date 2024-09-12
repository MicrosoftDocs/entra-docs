---
title: "Tutorial: Prepare your external tenant to authenticate users in a Vanilla JavaScript SPA"
description: Learn how to configure your external tenant for authentication with a Vanilla JavaScript single-page app (SPA).

author: OwenRichards1
manager: CelesteDG

ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: customers
ms.custom: devx-track-js
ms.topic: tutorial
ms.date: 08/17/2023
#Customer intent: As a developer, I want to learn how to configure a Vanilla JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Prepare your external tenant to authenticate a Vanilla JavaScript SPA

This tutorial series demonstrates how to build a Vanilla JavaScript single-page application (SPA) and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for JavaScript](/javascript/api/overview/msal-overview) library to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial;

> [!div class="checklist"]
> - Register a SPA in the Microsoft Entra admin center, and record its identifiers
> - Define the platform and URLs
> - Grant permissions to the SPA to access the Microsoft Graph API
> - Create a sign in and sign out user flow in the Microsoft Entra admin center
> - Associate your SPA with the user flow

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator.

## Register the SPA and record identifiers

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-vanilla-js.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the SPA with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next step

> [!div class="nextstepaction"]
> [Part 2: Create a VanillaJS SPA project for authentication in an external tenant](tutorial-single-page-app-Vanillajs-prepare-app.md)
