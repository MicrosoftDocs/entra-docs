---
title: 'Tutorial: Prepare your external tenant to sign in users in a Node.js web app'
description: Learn how to prepare your external tenant to sign in users in your Node.js web application.
 
author: kengaderdus
manager: mwongerapk

ms.author: kengaderdus
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: tutorial
ms.date: 08/27/2024
ms.custom: developer, devx-track-js
#Customer intent: As a developer, IT admin or devops, I want to learn about how to enable authentication in my own Node.js web app with an external tenant
---

# Tutorial: Prepare your external tenant to sign in users in a Node.js web app

This tutorial series demonstrates how to build a Node.js web app and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for JavaScript](/javascript/api/overview/msal-overview) library to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences. demonstrates how to prepare your external tenant to sign in users in a Node.js web application.


In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register a web application in the Microsoft Entra admin center. 
> - Create a sign in and sign out user flow in Microsoft Entra admin center.
> - Associate your web application with the user flow. 


If you've already registered a web application in the Microsoft Entra admin center, and associated it with a user flow, you can skip the steps in this article and move to [Prepare your Node.js web app](tutorial-web-app-node-sign-in-prepare-app.md).

## Prerequisites

* An external tenant. If you don't have one, [create a trial tenant](https://aka.ms/ciam-free-trial) or a [tenant with a subscription](./quickstart-tenant-setup.md) before you begin.
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application Administrator
    * Application Developer
    * Cloud Application Administrator

## Register the web app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-node.md)]  

## Add app client secret 

[!INCLUDE [active-directory-b2c-add-client-secret](./includes/register-app/add-app-client-secret.md)] 

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)] 

## Create a user flow 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 

## Associate the web application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Collect your app registration details 

Make sure you record the following details for use is later steps:

- The *Application (client) ID* of the client web app that you registered.
- The *Directory (tenant) subdomain* where you registered your web app. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
- The *Client secret* value for the web app you created.

## Next step

> [!div class="nextstepaction"]
> [Part 2: Prepare a Node.js web application for authentication in an external tenant](tutorial-web-app-node-sign-in-prepare-app.md)
