---
title: "Tutorial: Prepare your customer tenant to authenticate users in a .NET browserless app"
description: Learn how to register and configure .NET browserless app authentication details in a customer tenant so as to sign in users using Device Code flow.
author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: active-directory
 
ms.custom: devx-track-dotnet
ms.subservice: ciam
ms.topic: tutorial
ms.date: 07/24/2023
#Customer intent: As a dev, devops, I want to learn how to register and configure .NET browserless app authentication details in a customer tenant so as to sign in users using Device Code flow.
---

# Tutorial: Prepare your customer tenant to authenticate users in a .NET browserless app

This tutorial series demonstrates how to build a .NET browserless app and prepare it for authentication using the Microsoft Entra admin center. You'll build authenticate your app with your Microsoft Entra ID for customers tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Register a .NET browserless app in the Microsoft Entra admin center
> - Create a sign-in and sign-out user flow in customers tenant.
> - Associate your browserless app with the user flow.

## Prerequisites

* A Microsoft Entra ID for customer tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application administrator
    * Application developer
    * Cloud application administrator

## Register the browserless app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Enable public client flow

[!INCLUDE [enable-public-client-flow](./includes/register-app/enable-public-client-flow.md)]

## Grant API permissions

Since this app signs-in users, add delegated permissions:

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)] 

## Create a user flow 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 

## Associate the browserless app with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Record your registration details

The next step after this tutorial is to build a WPF desktop app that authenticates users. Ensure you have the following details:

- The Application (client) ID of the .NET browserless app that you registered.
- The Directory (tenant) subdomain where you registered your .NET browserless app. If your primary domain is *contoso.onmicrosoft.com*, your Directory (tenant) subdomain is *contoso*. If you don't have your primary domain, learn how to [read tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

## Next steps

> [!div class="nextstepaction"]
> [Part 2: Sign-in to your .NET browserless app >](./tutorial-browserless-app-dotnet-sign-in-build-app.md)
