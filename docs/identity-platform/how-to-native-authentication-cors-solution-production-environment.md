---
title: Use Azure Front Door as proxy server for SPA with native auth
description: Learn how to set up Azure Front Door as a reverse proxy in a production environment for a single-page app that uses native authentication.
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 02/07/2025
#Customer intent: As a developer, devops, I want to set up Azure Front Door so that I can use it as a reverse proxy server for a single-page app that authenticates users by using native authentication API in a production environment
---

# Use Azure Front Door as a reverse proxy in production environment for a single-page app that uses native authentication (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this article, you learn how to Use Azure Front Door as a reverse proxy for a single-page app (SPA) that uses [native authentication API](/entra/identity-platform/reference-native-authentication-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).

The native authentication API doesn't support Cross-Origin Resource Sharing (CORS). Therefore, a single-page app (SPA) that uses this API for user authentication can't make successful requests from front-end JavaScript code. To resolve this issue, add a proxy server between the SPA and the native authentication API. The proxy server injects the appropriate CORS headers into the response.

In a production environment, we recommended using [Azure Front Door with a Standard/Premium subscription](/azure/frontdoor/standard-premium/troubleshoot-cross-origin-resources) as a reverse proxy.

## Prerequisites
- An Azure subscription. [Create an account for free](https://azure.microsoft.com/free/?ref=microsoft.com&utm_source=microsoft.com&utm_medium=docs&utm_campaign=visualstudio).
- A sample SPA that you can access via a URL such as `http://www.contoso.com`:
    - You can use the React app described in [Quickstart: Sign in users into a sample React SPA by using native authentication API](quickstart-native-authentication-single-page-app-react-sign-in.md). However, don't configure or run the proxy server, as this guide covers that set up.
    - After you run the app, record the app URL for later use in this guide. In production, this URL contains the domain that you want to use as a custom domain URL, such as `http://www.contoso.com`
- Install [Azure Developer CLI (azd)](/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows).

## Set up Azure Front Door as a reverse proxy

1. Familiarize yourself with how to use Azure Front Door with CORS by reading the article at [Using Azure Front Door Standard/Premium with CORS](/azure/frontdoor/standard-premium/troubleshoot-cross-origin-resources).
1. Use the instructions in [Enable custom URL domains for apps in external tenants](../external-id/customers/how-to-custom-url-domain.md) to add a custom domain name to your external tenant.
    - For creating an Azure Front Door, [use azd template](#create-azure-front-door-as-a-reverse-proxy-by-using-an-azure-developer-cli-azd-template).
1. In your sample SPA, open the *API\React\ReactAuthSimple\src\config.ts* file, then replace the value of `BASE_API_URL`, *http://localhost:3001/api*, with `https://Enter_Custom_Domain_URL/Enter_the_Tenant_ID_Here`. Replace the placeholder:
    1. `Enter_Custom_Domain_URL` with your custom domain url, such as `contoso.com`.
    1. `Enter_the_Tenant_ID_Here` with your Directory (tenant) ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
1. If necessary, rerun your sample SPA. 

## Create Azure Front Door as a reverse proxy by using an Azure Developer CLI (azd) template

1. To initialize the azd template, run the following command:

    ```console
    azd init --template https://github.com/azure-samples/ms-identity-extid-cors-proxy-frontdoor
    ```

    When prompted, enter a name for the azd environment. The name is used as a prefix for the resource group so it should be unique within your Azure subscription.

1. To sign into Azure, run the following command:

    ```console
    azd auth login
    ```

1. To build, provision, and deploy the app resources, run the following command:

    ```console
    azd up
    ```

    When prompted, enter following information to complete resource creation:

    - `Azure Location`: The Azure location where your resources are deployed.
    - `Azure Subscription`: The Azure Subscription where your resources are deployed.
    - `corsAllowedOrigin`: The origin domain to allow CORS requests from in the format of SCHEME://DOMAIN:PORT, for example, http://localhost:3000.
    - `tenantSubdomain`: The subdomain of your external tenant that we're proxying. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
    - `customDomain`: The full URL of the custom domain configured within External ID, for example, _login.example.com._

## Guidelines for using Azure Front Door as a reverse proxy 

We recommend the following guidelines when you set up Azure Front Door as a reverse proxy to manage the CORS headers in a production environment:

### Restrict origins

When you configure Azure Front Door, only allow your SPA domain url, such as `https://www.contoso.com`, as origin. Avoid configurations that permit all origins, such as `*` which could lead to security vulnerabilities.

### Use simple requests

 Native authentication requests already meet all conditions of [simple requests](https://developer.mozilla.org/docs/Web/HTTP/CORS#simple_requests):

- Uses `Http Method: POST`.
- Uses `Content-Type: application/x-www-form-urlencoded`.
- Request doesn't require custom headers. 
- Request doesn't involve `ReadableStream` object in the request. 
- Request doesn’t require usage of `XMLHttpRequest`.  

## Related content
- Read more about [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/docs/Web/HTTP/CORS).
- [Native authentication API reference](/entra/identity-platform/reference-native-authentication-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).