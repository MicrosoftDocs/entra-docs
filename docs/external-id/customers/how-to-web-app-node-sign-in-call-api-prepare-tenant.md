---
title: Prepare customer tenant to call an API in a Node.js web application
description: Learn how to prepare your Microsoft Entra ID for customers tenant to sign in users and call an API in your Node.js web application. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: how-to
ms.date: 11/27/2023
ms.custom: developer, devx-track-js
---

# Prepare customer tenant to call an API in a Node.js web application

In this article, you prepare your Microsoft Entra ID for customers tenant for authorization.

## Prerequisite

- Complete the steps in [Tutorial: Prepare your customer tenant to sign in users in a Node.js web app](tutorial-web-app-node-sign-in-prepare-tenant.md). After you complete this tutorial, you've registered an app in your customers tenant, and you've a web app app that signs in users. We refer to this web application as the client application. You extend this application to call a protected web API.

- Complete the steps in [Tutorial: Secure an ASP.NET web API registered in a customer tenant](tutorial-protect-web-api-dotnet-core-build-app.md). After you complete this tutorial, you've registered a web API in your customers tenant, which exposes API permissions and publishes application roles. You also have a secured web API. You call this web API from the client web application.

## Configure idtyp token claim

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-optional-claims-access.md)]

### Grant API permissions to the web app

From the prerequisites, you registered a client app in your customers tenant. You also registered a web API app in your customers. Now, you need to grant API permissions to your client app: 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permission-call-api-common.md)]

## Next step

Next, learn how to prepare your web application and API.

> [!div class="nextstepaction"]
> [Start building your web application and API >](how-to-web-app-node-sign-in-call-api-prepare-app.md)
