---
title: Prepare external tenant to call an API in a Node.js web application
description: Learn how to prepare your external tenant to sign in users and call an API in your Node.js web application. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 06/10/2024
ms.custom: developer, devx-track-js
#Customer intent: As a developer, devops or IT admin, I want to learn about how to configure my external tenant so that I can call a web API that is protected by Microsoft Entra External ID. 
---

# Prepare external tenant for calling an API in a Node.js web application

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

In this article, you prepare your external tenant for authorization. This article is the first part of a four-part guide.

## Prerequisite

- Complete the steps in [Tutorial: Prepare your external tenant to sign in users in a Node.js web app](tutorial-web-app-node-sign-in-prepare-tenant.md). After you complete this tutorial, you register an app in your customer's tenant, and you've a web app that signs in users. We refer to this web application as the client application. You extend this application to call a protected web API.

- Complete the steps in [Tutorial: Secure an ASP.NET web API registered in an external tenant](tutorial-protect-web-api-dotnet-core-build-app.md). After you complete this tutorial, you register a web API in your customer's tenant, which exposes API permissions and publishes application roles. You also have a secured web API. You call this web API from the client web application.

## Configure idtyp token claim [optional]

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-optional-claims-access.md)]

Use the steps in [Configure optional claims](../../identity-platform/optional-claims.md?tabs=appui) article to add idtyp claim to the access token:

- For the **Token type** select **Access**.
- From the optional claims list, select **idtyp**.  

### Grant API permissions to the web app

From the prerequisites, you registered a client app in your customer's tenant. You also registered a web API app in your customers. Now, you need to grant API permissions to your client app:

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permission-call-api-common.md)]

## Next step

Next, learn how to prepare your web application and API.

> [!div class="nextstepaction"]
> [Start building your web application and API](how-to-web-app-node-sign-in-call-api-prepare-app.md)