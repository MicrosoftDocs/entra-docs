---
title: "Tutorial: Prepare your external tenant to sign in users in a Node.js CLI app"
description: Learn how to register and configure a Node.js CLI application to signs in users in an external tenant
 
author: Dickson-Mwendia
manager: mwongerapk

ms.author: dmwendia
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: tutorial
ms.date: 08/04/2023
ms.custom: developer, devx-track-js

#Customer intent: As a dev, devops, I want to learn how to register and configure a Node.js CLI application to signs in users in an external tenant
---

# Tutorial: Prepare your external tenant to sign in users in a Node.js CLI app

This tutorial series demonstrates how to build a Node.js command line interface (CLI) app and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for Node](/javascript/api/%40azure/msal-node) (MSAL Node) library to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial;

> [!div class="checklist"]
>
> - Register a Node.js CLI app in the Microsoft Entra admin center, and record its identifiers
> - Define the platform and URLs
> - Grant permissions to the Node CLI app to access the Microsoft Graph API
> - Create a sign in and sign out user flow in Microsoft Entra admin center.
> - Associate your Node.js CLI app with a user flow. 

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Register the Node.js CLI app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)] 


## Add platform configurations

[!INCLUDE [active-directory-b2c-app-integration-add-platform-configurations](./includes/register-app/add-platform-redirect-url-node-cli.md)]

[!INCLUDE [active-directory-b2c-enable-public-client-flow](./includes/register-app/enable-public-client-flow.md)]  

## Grant admin consent 

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)] 

## Create a user flow 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 

## Associate the Node.js CLI application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]


## Next step

Prepare your app to sign in users in an external tenant:

> [!div class="nextstepaction"]
> [Part 2: Prepare a Node.js CLI application for authentication](tutorial-cli-app-node-sign-in-prepare-app.md)
