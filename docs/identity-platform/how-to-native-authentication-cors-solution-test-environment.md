---
title: Set up a reverse proxy for SPA by using Azure Function App
description: Learn how to set up a reverse proxy for a single-page app that calls native authentication API by using Azure Function App.
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 02/07/2025
#Customer intent: As a developer, devops, I want to create a reverse proxy by using Azure Function App so that I can use in for a single-page app that authenticates users by using native authentication API in a test environment
---

# Set up a reverse proxy for a single-page app that calls native authentication API by using Azure Function App (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this article, you learn how to set up a reverse proxy by using Azure Functions App to manage CORS headers in a test environment for a single-page app (SPA) that uses [native authentication API](/entra/identity-platform/reference-native-authentication-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).

The native authentication API doesn't support Cross-Origin Resource Sharing (CORS). Therefore, a single-page app (SPA) that uses this API for user authentication can't make successful requests from front-end JavaScript code. To resolve this issue, you need to add a proxy server between the SPA and the native authentication API. This proxy server injects the appropriate CORS headers into the response.

This solution is for testing purposes and should **NOT be used in a production environment**. If you're looking for a solution to use in a production environment, we recommended you use an Azure Front Door solution, see the instructions in [Use Azure Front Door as a reverse proxy to manage CORS headers for SPA in production](how-to-native-authentication-cors-solution-production-environment.md).

## Prerequisites

- An Azure subscription. [Create an account for free](https://azure.microsoft.com/free/?ref=microsoft.com&utm_source=microsoft.com&utm_medium=docs&utm_campaign=visualstudio).
- Register `Microsoft.App` resource provider, see [How to register resource provider](/azure/azure-resource-manager/management/resource-providers-and-types). You only need to complete this step once for each newly created subscription.
- Install [Azure Developer CLI (azd)](/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows).
- A sample SPA that you can access via a URL such as `http://www.contoso.com`:
    - You can use the React app described in [Quickstart: Sign in users into a sample React SPA by using native authentication API](quickstart-native-authentication-single-page-app-react-sign-in.md). However, don't configure or run the proxy server, as this guide covers that set up.
    - Once you run the app, record the app URL for later use in this guide.

## Create reverse proxy in an Azure function app by using Azure Developer CLI (azd) template

1. To initialize the azd template, run the following command:

    ```console
    azd init --template https://github.com/azure-samples/ms-identity-extid-cors-proxy-function
    ```

    When prompted, enter a name for the azd environment. This name is used as a prefix for the resource group so it should be unique within your Azure subscription.

1. To sign into Azure, run the following command:

    ```console
    azd auth login
    ```

1. To build, provision, and deploy the app resources, run the following command:

    ```console
    azd up
    ```

    When prompted, enter the following information to complete resource creation:

    - `Azure Location`: The Azure location where your resources are deployed.
    - `Azure Subscription`: The Azure Subscription where your resources are deployed.
    - `corsAllowedOrigin`: The origin domain to allow CORS requests from in the format of SCHEME://DOMAIN:PORT, for example, _http://localhost:3000_.
    - `tenantSubdomain`: The subdomain of your external tenant that we're proxying. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

## Test your sample SPA with the reverse proxy

1. In your sample SPA, open the *API\React\ReactAuthSimple\src\config.ts* file, then replace:  
    - the value of `BASE_API_URL`, *http://localhost:3001/api*, with `https://Enter_App_Function_Name_Here.azurewebsites.net`.  
    - the placeholder `Enter_App_Function_Name_Here` with the name of your function app. 
    If necessary, rerun your sample SPA.  

1. Browse to the sample SPA URL, then test sign-up, sign-in and password reset flows. Your SPA app should work correctly as the reverse proxy manages CORS headers correctly.

## Related content

- [Use Azure Front Door as a reverse proxy in production environment for a SPA that uses native authentication](how-to-native-authentication-cors-solution-production-environment.md).