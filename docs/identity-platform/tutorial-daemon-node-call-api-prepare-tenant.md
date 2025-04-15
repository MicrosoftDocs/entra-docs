---
title: 'Tutorial: Prepare your external tenant to authorize a Node.js daemon application'
description: Learn how to prepare your external tenant to authorize your Node.js daemon application

author: kengaderdus
manager: mwongerapk

ms.author: kengaderdus
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 08/27/2024
ms.custom: developer, devx-track-js

#Customer intent: As a developer, devops, I want to learn how to set up my external tenant so that I can call a web API from my Node.js daemon application
---

# Tutorial: Prepare your external tenant to authorize a Node.js daemon application

This tutorial series demonstrates how to build a Node.js daemon client app and prepare it for authentication in the Microsoft Entra admin center. You'll be using the [Open Authorization (OAuth) 2.0 client credentials grant flow](~/identity-platform/v2-oauth2-client-creds-grant-flow.md), then configure it to acquire an access token for calling a web API.

In this tutorial;

> [!div class="checklist"]
> - Register a web API in the Microsoft Entra admin center
> - Configure app roles for the web API
> - Register a client daemon application
> - Grant permissions to the daemon app

If you've already registered a client daemon application and a web API in the Microsoft Entra admin center, you can skip the steps in this tutorial, then proceed to [Acquire access token for calling an API](tutorial-daemon-node-call-api-build-app.md).

## Prerequisites

* An external tenant. To create one, choose from the following methods: 
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
  * Directory (tenant) subdomain. Refer to [read your tenant details](../external-id//customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details) for your tenant subdomain.
* Add a client secret to your app registration. **Do not** use client secrets in production apps. Use certificates or federated credentials instead. For more information, see [add credentials to your application](./how-to-add-credentials.md?tabs=client-secret).

## Register a web API application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/register-api-app.md)]

## Configure app roles

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-app-role.md)]

## Configure idtyp token claim

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-optional-claims-access.md)]

## Grant API permissions to the daemon app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/grant-api-permissions-app-permissions.md)]


- The Directory (tenant) subdomain where you registered your daemon app. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
- The application secret value for the daemon app you created.
- The Application (client) ID of the web API app you registered.

## Next step

> [!div class="nextstepaction"]
> [Part 2: Prepare your daemon application](tutorial-daemon-node-call-api-build-app.md)