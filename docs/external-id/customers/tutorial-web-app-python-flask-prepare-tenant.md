---
title: 'Tutorial: Prepare your external tenant to sign in users in a Python Flask web app'
description: Learn how to prepare your external tenant to sign in users in your Python Flask web application.
author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id 
ms.subservice: external
ms.topic: tutorial
ms.date: 03/19/2024

#Customer intent: As a dev, devops, I want to learn about how to enable authentication in my Python Flask web app with an external tenant.
---

# Tutorial: Prepare your external tenant to sign in users in a Python Flask web app

This tutorial series demonstrates how to build a Python Flask web app that is secured by Microsoft Entra External ID. The series takes you through the steps of preparing your tenant, building a Flask web app and testing it by signing in a user. This article is the first in the series and demonstrates how to prepare your external tenant to sign in users in a Python Flask web application. If you want to just run a sample Flask web app secured by Microsoft Entra External ID, see [Sign in users in a sample Python Flask web application](sample-web-app-python-flask-sign-in.md).

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register a web application in the Microsoft Entra admin center. 
> - Create a sign in and sign out user flow in Microsoft Entra admin center.
> - Associate your web application with the user flow. 

If you've already registered a web application in the Microsoft Entra admin center, and associated it with a user flow, you can skip the steps in this article and move to [Prepare your Python Flask web app](tutorial-web-app-node-sign-in-prepare-app.md) tutorial.

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Register the web app

[!INCLUDE [register-application-common-steps](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [flask-app-redirect-uri-configuration](./includes/register-app/add-platform-redirect-url-python-flask.md)]   

## Add app client secret

[!INCLUDE [add-client-secret](./includes/register-app/add-app-client-secret.md)]

## Grant admin consent

[!INCLUDE [grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [associate-app-with-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Collect your app registration details 

Make sure you record the following details for use is later steps:

- The *Application (client) ID* of the client web app that you registered.
- The *Directory (tenant) subdomain* where you registered your web app. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
- The *Client secret* value for the web app you created.

## Next step

> [!div class="nextstepaction"]
> [Part 2: Prepare a Python Flask web application to authenticate users in an external tenant](./tutorial-web-app-python-flask-sign-in-sign-out.md)
