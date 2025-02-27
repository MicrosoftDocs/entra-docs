---
title: "Tutorial: Prepare your external tenant to authenticate users in a React SPA"
description: Learn how to configure your external tenant for authentication with a React single-page app (SPA).
author: garrodonnell
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 07/03/2024
ms.author: godonnell

#Customer intent: As a dev I want to prepare my external tenant for building a single-page app (SPA) with React
---

# Tutorial: Prepare your external tenant to authenticate users in a React SPA

This tutorial series demonstrates how to build a React single-page application (SPA) and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for JavaScript](/javascript/api/overview/msal-overview) library to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial;

> [!div class="checklist"]
>
> - Register a SPA in the Microsoft Entra admin center, and record its identifiers
> - Define the platform and URLs
> - Grant permissions to the SPA to access the Microsoft Graph API
> - Create a sign-in and sign-out user flow in the Microsoft Entra admin center
> - Associate your SPA with a user flow

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Register the SPA and record identifiers

[!INCLUDE [register-client-app-common](./includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [add-platform-redirect-url-react](./includes/register-app/add-platform-redirect-url-react.md)]

## Grant admin consent

[!INCLUDE [grant-api-permission-sign-in](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a sign-in and sign-up user flow

[!INCLUDE [register-client-app-common](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the application with your user flow

[!INCLUDE [add-app-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next step

> [!div class="nextstepaction"]
> [Part 2: Create a React SPA project for authentication in an external tenant](./tutorial-single-page-app-react-sign-in-prepare-app.md)
