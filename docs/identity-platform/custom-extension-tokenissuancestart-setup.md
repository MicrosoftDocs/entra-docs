---
title: Create a REST API with a token issuance start event for Azure Functions (preview)
description: Learn how to use the Authentication events trigger for Azure Functions library to create a trigger function that uses the token issuance start event.  
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 03/14/2024
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to
zone_pivot_groups: custom-auth-extension

#Customer intent: As a developer, I want to create an Azure Function app with a token issuance start event using the Azure Functions client library for .NET, and deploy it to the Azure portal, or create the app directly on the Azure portal.
---

# Create a REST API with a token issuance start event for Azure Functions (preview)

::: zone pivot="visual-studio" 

This article describes how to create a REST API with a [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) using the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library. You create an HTTP trigger function in Visual Studio and deploy it to the Azure portal, where it can be accessed through Azure Functions.

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
- Visual Studio with [Azure Development workload for Visual Studio](/dotnet/azure/configure-visual-studio) configured.

::: zone-end

::: zone pivot="visual-studio-code"

This article describes how to create a REST API with a [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) using the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library. You create an HTTP trigger function in Visual Studio and deploy it to the Azure portal, where it can be accessed through Azure Functions. 

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
- Visual Studio Code, with the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension enabled.

::: zone-end

::: zone pivot="visual-studio"

## Create and build the Azure Function app

In this step, you create an HTTP trigger function API using Visual Studio, install the required NuGet packages and copy in the sample code. You build the project and run the function locally to extract the function URL.

### Create the Azure Function app

To create an Azure Function app, follow these steps:

1. Open Visual Studio, and select **Create a new project**.
1. Search for and select **Azure Functions**, then select **Next**.
1. Give the project a name, such as *AuthEventsTrigger*. It's a good idea to match the solution name with the project name.
1. Select a location for the project. Select **Next**.
1. Select **.NET 6.0 (Long Term Support)** as the target framework. 
1. Select *Http trigger* as the **Function** type, and that **Authorization level** is set to *Function*. Select **Create**.

### Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

1. In the top menu of Visual Studio, select **Project**, then **Manage NuGet packages**.
1. Select the **Browse** tab, then search for and select *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents*. In the right pane, Select **Install**.
1. Apply and accept the changes in the popups that appear.

### Add the sample code

The function API is the source of extra claims for your token. For the purposes of this article, we're hardcoding the values for the sample app. In production, fetch information about the user from external data store.

In your *Function1.cs* file, replace the entire contents of the file with the following code:

[!INCLUDE [nuget-code](./includes/scenarios/custom-extension-tokenissuancestart-setup-nuget-code.md)]

> [!TIP]
> 
> For local development and testing purposes, open *local.settings.json* and add the `AzureWebJobsStorage` and `AzureWebJobsSecretStorageType` value as shown in the following snippet:: 
>
>    ```json
>    {
>      "IsEncrypted": false,
>      "Values": {
>        "AzureWebJobsStorage": "",
>        "AzureWebJobsSecretStorageType": "files",
>        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
>      }
>    }
>    ```

### Build and run the project

The project has been created and the sample code has been added. Now we build and run the project to extract the function URL.

1. Navigate to **Build** in the top menu, and select **Build Solution**.
1. Press **F5** or select *AuthEventsTrigger* from the top menu to run the function. 
1. Copy the **Function url** from the terminal that popups up when running the function. This can be used when setting up a custom authentication extension.

## Deploy the function and publish to Azure 

The function needs to be deployed to Azure using our IDE. Check that you're correctly signed in to your Azure account so the function can be published.

1. In the Solution Explorer, right-click on the project and select **Publish**. 
1. In **Target**, select **Azure**, then select **Next**.
1. Select **Azure Function App (Windows)** for the **Specific Target**, select **Azure Function App (Windows)**, then select **Next**.
1. In the **Function instance**, use the **Subscription name** dropdown to select the subscription under which the new function app will be created in.
1. Select where you want to publish the new function app, and select **Create New**.
1. On the **Function App (Windows)** page, use the function app settings as specified in the following table, then select **Create**.
 
    |   Setting    | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`. |
    | **Subscription** | Your subscription | The subscription under which the new function app is created. |
    | **[Resource Group](/azure/azure-resource-manager/management/overview)** |  *myResourceGroup* | Select an existing resource group, or name the new one in which you'll create your function app. |
    | **Plan type** | Consumption (Serverless) | Hosting plan that defines how resources are allocated to your function app.  |
    | **Location** | Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Azure Storage** | Your storage account | An Azure storage account is required by the Functions runtime. Select New to configure a general-purpose storage account. |
    | **Application Insights** | *Default* | A feature of Azure Monitor. This is autoselected, select the one you wish to use or configure a new one. |
    

1. Wait a few moments for your function app to be deployed. Once the window closes, select **Finish**.
1. A new **Publish** pane opens. At the top, select **Publish**. Wait a few minutes for your function app to be deployed and show up in the Azure portal.

[!INCLUDE [environment-variables](./includes/scenarios/custom-extension-tokenissuancestart-setup-env-portal.md)]

::: zone-end

::: zone pivot="visual-studio-code"

## Create and build the Azure Function app

In this step, you create an HTTP trigger function API using Visual Studio Code, install the required NuGet packages and copy in the sample code. You'll build the project and run the function locally to extract the function URL.

## Create the Azure Function app

To create an Azure Function app, follow these steps:

1. Open Visual Studio Code.
1. Select the **New Folder** icon in the **Explorer** window, and create a new folder for your project, for example *AuthEventsTrigger*.
1. Select the Azure extension icon on the left-hand side of the screen. Sign in to your Azure account if you haven't already. 
1. Under the **Workspace** bar, select the **Azure Functions** icon > **Create New Project**.

    :::image type="content" border="true"  source="media/custom-extension-tokenissuancestart-setup/visual-studio-code-add-azure-function.png" alt-text="Screenshot that shows how to add an Azure function in Visual Studio Code.":::

1. In the top bar, select the location to create the project.
1. Select **C#** as the language, and **.NET 6.0 LTS** as the .NET runtime. 
1. Select **HTTP trigger** as the template.
1. Provide a name for the project, such as *AuthEventsTrigger*.
1. Accept **Company.Function** as the namespace, with **AccessRights** set to *Function*. 

### Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

1. Open the **Terminal** in Visual Studio Code, and navigate to the project folder.
1. Enter the following command into the console to install the *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents* NuGet package.

    ```console
    dotnet add package Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents --prerelease
    ```

### Add the sample code

The function API is the source of extra claims for your token. For the purposes of this article, we're hardcoding the values for the sample app. In production, fetch information about the user from external data store.

Replace the entire contents of the *AuthEventsTrigger.cs* file with the following code:

[!INCLUDE [nuget-code](./includes/scenarios/custom-extension-tokenissuancestart-setup-nuget-code.md)]

> [!TIP]
> 
> For local development and testing purposes, open *local.settings.json* and add the `AzureWebJobsStorage` and `AzureWebJobsSecretStorageType` value as shown in the following snippet:: 
>
>    ```json
>    {
>      "IsEncrypted": false,
>      "Values": {
>        "AzureWebJobsStorage": "",
>        "AzureWebJobsSecretStorageType": "files",
>        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
>      }
>    }
>    ```

### Build and run the project

1. In the top menu, select **Run** > **Start Debugging** or press **F5** to run the function.
1. In the terminal, copy the **Function url** that appears. This can be used when setting up a custom authentication extension.

## Deploy the function and publish to Azure 

The function needs to be deployed to Azure using our IDE. Check that you're correctly signed in to your Azure account so the function can be published.

1. Select the **Azure** extension icon. In **Resources**, select the **+** icon to **Create a resource**.
1. Select **Create Function App in Azure**. Use the following settings for setting up your function app.
1. Give the function app a name, such as *AuthEventsTriggerNuGet*, and press **Enter**.
1. Select the **.NET 6 (LTS) In-Process** runtime stack. 
1. Select a location for the function app, such as *East US*.
1. Wait a few minutes for your function app to be deployed and show up in the Azure portal.

[!INCLUDE [environment-variables](./includes/scenarios/custom-extension-tokenissuancestart-setup-env-portal.md)]

::: zone-end

## Next step

> [!div class="nextstepaction"]
> [Configure a custom claims provider token issuance event](./custom-extension-tokenissuancestart-configuration.md)
