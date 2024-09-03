---
title: 'Tutorial: Prepare your external tenant to authorize a Node.js daemon application'
description: Learn how to prepare your external tenant to authorize your Node.js daemon application

author: kengaderdus
manager: mwongerapk

ms.author: kengaderdus
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 08/27/2024
ms.custom: developer, devx-track-js

#Customer intent: As a developer, devops, I want to learn how to set up my external tenant so that I can call a web API from my Node.js daemon application
---

# Tutorial: Prepare your external tenant to authorize a Node.js daemon application

This tutorial series demonstrates how to build a Node.js daemon client app and prepare it for authentication in the Microsoft Entra admin center. You'll be using the [Open Authorization (OAuth) 2.0 client credentials grant flow](~/identity-platform/v2-oauth2-client-creds-grant-flow.md), then configure it to acquire an access token for calling a web API.

In this tutorial;

> [!div class="checklist"]
> - Register a web API in the Microsoft Entra admin center, and record its identifiers
> - Configure app roles for the web API
> - Register a client daemon application
> - Grant permissions to the daemon app
> - Create a client secret for your daemon app

If you've already registered a client daemon application and a web API in the Microsoft Entra admin center, you can skip the steps in this tutorial, then proceed to [Acquire access token for calling an API](tutorial-daemon-node-call-api-build-app.md).

## Prerequisites

- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

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

## Collect your app registration details

In the next step, you prepare your daemon app application. Make sure you've the following details:

- The Application (client) ID of the client daemon app that you registered.
- The Directory (tenant) subdomain where you registered your daemon app. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
- The application secret value for the daemon app you created.
- The Application (client) ID of the web API app you registered.

## Next step

> [!div class="nextstepaction"]
> [Part 2: Prepare your daemon application](tutorial-daemon-node-call-api-build-app.md)