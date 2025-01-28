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
#Customer intent: As a developer, devops, I want to 
---

# Set up a reverse proxy for a single-page app that calls native authentication API by using Azure Function App

In this article, you learn how to set up a reverse proxy by using an HTTP trigger in an Azure Functions to manage CORS headers in a test environment for a single-page app (SPA) that uses uses [native authentication API](/entra/identity-platform/reference-native-authentication-api?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=emailOtp).

Native authentication API doesn't support Cross-Origin Resource Sharing (CORS). So, a SPA that authenticates users via native authentication API can't successfully make requests from front-end JavaScript code.

In order to inject the appropriate CORS headers into the response from native authentication API, you need to add a proxy server between the SPA and the native authentication API server.

This solution is for testing purposes and should **NOT be used in a production environment**. If you're looking for a solution to use in a production environment, we recommended you use an Azure Front Door solution, see the instructions in [Use Azure Front Door as a reverse proxy to manage CORS headers for SPA in production](how-to-native-authentication-cors-solution-production-environment.md).

## Prerequisites

- An Azure subscription. [Create an account for free](https://azure.microsoft.com/free/?ref=microsoft.com&utm_source=microsoft.com&utm_medium=docs&utm_campaign=visualstudio).
- [Azure Developer CLI](/cli/azure/install-azure-cli). After you install it, sign into it for the first time. For more information, see [Sign into the Azure CLI](/cli/azure/get-started-with-azure-cli#sign-into-the-azure-cli).
- A sample SPA that you can access via a URL such as `http://www.contoso.com`:
    - You can use the React app described in [Quickstart: Sign in users into a sample React SPA by using native authentication API](quickstart-native-authentication-single-page-app-react-sign-in.md). However, don't configure or run the proxy server, as this guide covers that setup.
    - Once you run the app, record the app URL for later use in this guide.

## Create reverse proxy in an Azure function app by using ARM template

1. [Create a Resource Group](/azure/azure-resource-manager/management/manage-resource-groups-cli#create-resource-groups) using `az group create`

    ```console
    az group create --name Enter_Resource_Group_Name_Here --location Enter_Location_Name_Here
    ```

    Replace the placeholder:
    - `Enter_Resource_Group_Name_Here` with the name of the new resource group.
    - `Enter_Location_Name_Here` with the geographical region where the resource group is be created. 

    Wait for this process to complete before creating the function app.

1. Get an Azure Resource Manager (ARM) template:

    1. Clone a sample SPA that contains the ARM template:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples.git
    ```

    1. Navigate to the ARM template directory by using the following command:

    ```console
    cd API/CORSTestEnviroment
    ```

1. Create the function app running the following command:

    ```console
    az deployment group create \
        --resource-group Enter_Resource_Group_Name_Here \
        --template-file ReverseProxyARMTemplate.json \
        --parameters functionAppName=Enter_App_Function_Name_Here \
        --parameters location=Enter_Location_Name_Here \
        --parameters SPAurl=Enter_The_SPA_URL_Here
    ```

    Replace:
    - `Enter_Resource_Group_Name_Here` with the name of the new resource group.
    - `Enter_App_Function_Name_Here` with the name of your function app.
    - `Enter_Location_Name_Here` with the geographical region where the resource group is be created.
    - `Enter_The_SPA_URL_Here` with the SPA app URL you recorded earlier.

1. Open */API/CORSTestEnviroment/ReverseProxy/index.js* file, then replace the placeholder`Enter_the_Tenant_Subdomain_Here` with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

1. Deploy the project files to an Azure Function App:

    1. Make sure you're in the */API/CORSTestEnviroment/* directory,then zip the project files by using the following command:

    ```console
    zip -r ReverseProxy.zip ReverseProxy
    ```

    1. Deploy app files by using the following command:

    ```console
    az functionapp deployment source config-zip \
        --resource-group "Enter_Resource_Group_Name_Here" \
        --name "Enter_App_Function_Name_Here" \
        --src ReverseProxy.zip  
    ```

## Test your sample SPA with the reverse proxy

1. In your sample SPA, open the *API\React\ReactAuthSimple\src\config.ts* file, then replace the the value of `BASE_API_URL`, *http://localhost:3001/api*, with `https://Enter_App_Function_Name_Here.azurewebsites.net/api/ReverseProxy`. Replace the placeholder `Enter_App_Function_Name_Here` with the name of your function app. If necessary, rerun your sample SPA.

1. Browse to the sample SPA URL, then test sign-up, sign-in and password reset flows. Your SPA app should work correctly as the reverse proxy manages CORS headers correctly.

## Related content

- [Use Azure Front Door as a reverse proxy in production environment for a SPA that uses native authentication](how-to-native-authentication-cors-solution-production-environment.md).