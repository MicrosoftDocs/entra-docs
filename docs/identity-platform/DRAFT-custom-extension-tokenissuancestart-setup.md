---
title: Create a token issuance start event HTTP trigger function
description: Learn how to develop and register a Microsoft Entra custom authentication extensions REST API. The custom authentication extension allows you to source claims from a data store that is external to Microsoft Entra ID.  
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 02/26/2024
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to
titleSuffix: Microsoft identity platform
zone_pivot_groups: custom-auth-extension

#Customer intent: As a developer, I want to configure a custom claims provider token issuance event, so that I can add custom claims to a token before it is issued.
---

# Create a token issuance start event HTTP trigger function

> [!NOTE]
>
> This article is a work in progress and not yet complete.

::: zone pivot="visual-studio" 

This article describes how to create a HTTP trigger function API and deploy it to the Azure portal using Visual Studio. You'll create the API using using the [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) with the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library. The authentication events trigger handles all the backend processing for incoming HTTP requests for authentication events.

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
- Visual Studio with the Azure Development workload for Visual Studio installed 

::: zone-end

::: zone pivot="visual-studio-code"

This article describes how to create a HTTP trigger function API and deploy it to the Azure portal using Visual Studio Code. You'll create the API using using the [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) with the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library. The authentication events trigger handles all the backend processing for incoming HTTP requests for authentication events.

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
- Visual Studio Code, with Azure Functions extension enabled

::: zone-end

::: zone pivot="azure-portal"

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.

::: zone-end

::: zone pivot="visual-studio"

## Create the Azure Function app

In this step, you create an HTTP trigger function API using Visual Studio. The function API is the source of extra claims for your token.

1. Open Visual Studio, and select **Create a new project**.
1. Search for and select **Azure Functions**, then select **Next**.
1. Give the project a name, such as *AuthEventsTrigger*. It's a good idea to match the solution name with the project name.
1. Select a location for the project. Select **Next**.
1. Select **.NET 6.0 (Long Term Support)** as the target framework. <!--Why? Why .NET 6.0 and not a later version-->
1. Select *Http trigger* as the **Function** type, and that **Authorization level** is set to *Function*. Select **Create**.
1. In your *Function1.cs* file, replace the entire contents of the file with the following code:

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Extensions.Logging;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart.Actions;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.Framework;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents;
    
    namespace AuthEventTrigger
    {
        public static class Function1
        {
            [FunctionName("onTokenIssuanceStart")]
            public static async Task<AuthenticationEventResponse> Run(
                [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log)
            // [AuthenticationEventsTrigger(TenantId = "Enter tenant ID here", AudienceAppId = "Enter application client ID here")] TokenIssuanceStartRequest request, ILogger log)
            // This is required. The only way that [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log) will work is if the settings are set in local.settings.json are set to bypass token validation. i.e. "AuthenticationEvents__BypassTokenValidation": true. This is only recommended for local development and testing.
            {
                try
                {
                    // Checks if the request is successful and did the token validation pass
                    if (request.RequestStatus == RequestStatusType.Successful)
                    {
                        // Fetches information about the user from external data store
                        // request.Response = null;
                        // request.Response.Actions = null;
                        // Add new claims to the token's response
                        request.Response.Actions.Add(new ProvideClaimsForToken(
                                                      new TokenClaim("dateOfBirth", "01/01/2000"),
                                                      new TokenClaim("customRoles", "Writer", "Editor")
                                                 ));
                    }
                    else
                    {
                        // If the request fails, such as in token validation, output the failed request status
                        log.LogInformation(request.StatusMessage);
                    }
                    return await request.Completed();
                }
                catch (Exception ex) 
                { 
                    return await request.Failed(ex);
                }
            }
        }
    }
    ```

1. Next, open the *local.settings.json* file and check that the *.json* file matches the following snippet:

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
      }
    }
    ```

## Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

1. In the top menu of Visual Studio, select **Project**, then **Manage NuGet packages**.
1. Select the **Browse** tab, then search for and select *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents*. In the right pane, Select **Install**.
1. Apply and accept the changes in the popups that appear.
1. Navigate to **Build** in the top menu, and select **Build Solution**.
1. Press **F5** or select *AuthEventsTrigger* from the top menu to run the function. 
1. Copy the **Function url** from the terminal that popups up when running the function. 

## Deploy the function and publish to Azure 

So far we've set up the project to install the NuGet packages and added soem starter code. We'll now deploy this to Azure using our IDE.

1. In the Solution Explorer, right-click on the project and select **Publish**. 
1. In **Target**, select **Azure**, then select **Next**.
1. Select **Azure Function App (Windows)** for the **Specific Target**, select **Azure Function App (Windows)**, then select **Next**.
1. You may need to re-enter your credentials to be able to publish your app to your Azure account. Select **Re-enter your credentials**, and follow the steps to sign in.
1. In the **Function instance**, use the **Subscription name** dropdown to select the subscription under which the new function app will be created in.
1. Select where you want to publish the new function app, and select **Create New**.
1. On the **Function App (Windows)** page, use the function app settings as specified in the following table, then select **Create**.
 
    |   Setting    | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`. |
    | **Subscription** | Your subscription | The subscription under which the new function app will be created in. |
    | **[Resource Group](/azure/azure-resource-manager/management/overview)** |  *myResourceGroup* | Select an existing resource group, or name the new one in which you'll create your function app. |
    | **Plan type** | Consumption (Serverless) | Hosting plan that defines how resources are allocated to your function app.  |
    | **Location** | Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Azure Storage** | General-purpose storage account | An Azure storage account is required by the Functions runtime. Select New to configure a general-purpose storage account. |
    | **Application Insights** | ***TODO*** | How the logs are put together |
    

1. Wait a few moments for your function app to be deployed. Once the window closes, select **Finish** on the **Publish** screen.
1. You'll need to wait 5-10 minutes for your function app to be deployed and show up in the Azure portal.

::: zone-end

::: zone pivot="visual-studio-code"

## Create the Azure Function app

In this step, you create an HTTP trigger function API using Visual Studio Code. The function API is the source of extra claims for your token.

1. Open Visual Studio Code.
1. Select the **New Folder** icon in the **Explorer** window, and create a new folder for your project, for example *AuthEventsTrigger*.
1. Select the Azure extension icon on the left-hand side of the screen. Sign in to your Azure account if you haven't already. <!--Extra instructions maybe?-->
1. Under the **Workspace** bar, select the **Azure Functions** icon > **Create New Project**.

    :::image type="content" border="true"  source="media/auth-events-trigger/visual-studio-code-add-azure-function.png" alt-text="Screenshot that shows how to add an Azure function in Visual Studio Code.":::

1. In the top bar, select the location to create the project.
1. Select **C#** as the language, and **.NET 6.0 LTS** as the .NET runtime. <!--again mhy 6?-->
1. Select **HTTP trigger** as the template
1. Provide a name for the project, such as *AuthEventsTrigger*.
1. accept **Company.Function** as the namespace, with **AccessRights** set to *Function*. 
1. In the main window, a file called *AuthEventsTrigger.cs* will open. Replace the entire contents of the file with the following code:

    ```csharp
    using System;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Extensions.Logging;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart.Actions;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.TokenIssuanceStart;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents.Framework;
    using Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents;
    
    namespace AuthEventTrigger
    {
        public static class Function1
        {
            [FunctionName("onTokenIssuanceStart")]
            public static async Task<AuthenticationEventResponse> Run(
                [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log)
            // [AuthenticationEventsTrigger(TenantId = "Enter tenant ID here", AudienceAppId = "Enter application client ID here")] TokenIssuanceStartRequest request, ILogger log)
            // This is required. The only way that [AuthenticationEventsTrigger] TokenIssuanceStartRequest request, ILogger log) will work is if the settings are set in local.settings.json are set to bypass token validation. i.e. "AuthenticationEvents__BypassTokenValidation": true. This is only recommended for local development and testing.
            {
                try
                {
                    // Checks if the request is successful and did the token validation pass
                    if (request.RequestStatus == RequestStatusType.Successful)
                    {
                        // Fetches information about the user from external data store
                        // request.Response = null;
                        // request.Response.Actions = null;
                        // Add new claims to the token's response
                        request.Response.Actions.Add(new ProvideClaimsForToken(
                                                      new TokenClaim("dateOfBirth", "01/01/2000"),
                                                      new TokenClaim("customRoles", "Writer", "Editor")
                                                 ));
                    }
                    else
                    {
                        // If the request fails, such as in token validation, output the failed request status
                        log.LogInformation(request.StatusMessage);
                    }
                    return await request.Completed();
                }
                catch (Exception ex) 
                { 
                    return await request.Failed(ex);
                }
            }
        }
    }
    ```

1. Next, open the *local.settings.json* file and add the `AzureWebJobsStorage` value as shown in the following snippet: <!--Added automatically in Visual Studio?-->

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
      }
    }
    ```

## Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

1. Open the **Terminal** in Visual Studio Code, and navigate to the project folder.
1. Enter the following command into the console to install the *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents* NuGet package.

    ```console
    dotnet add package Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents --prerelease
    ```

1. In the top menu, select **Run** > **Start Debugging** or press **F5** to run the function.
1. In the terminal, copy the **Function url** that appears.

## Deploy the function and publish to Azure 

So far we've set up the project to install the NuGet packages and added soem starter code. We'll now deploy this to Azure using our IDE.

1. Select the **Azure** extension icon. In **Resources**, select the **+** icon to **Create a resource**.
1. Select **Create Function App in Azure**. Use the following settings for setting up your function app.
1. Give the function app a name, such as *AuthEventsTriggerNuGet*, and press **Enter**.
1. Select the **.NET 6 (LTS) In-Process** runtime stack. 
1. Select a location for the function app, such as *East US*.
1. You'll need to wait 5-10 minutes for your function app to be deployed and show up in the Azure portal.

::: zone-end

::: zone pivot="azure-portal"

## Create the Azure Function app

This setup is done entirely in the Azure portal. You'll create an Azure Function app and create a HTTP trigger function.

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. From the Azure portal menu or the **Home** page, select **Create a resource**.
1. Search for and select **Function App** and select **Create**
1. On the **Basics** page, create a function app using the settings as specified in the following table:

    | Setting      | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Subscription** | Your subscription | The subscription under which the new function app will be created in. |
    | **[Resource Group](/azure/azure-resource-manager/management/overview)** |  *myResourceGroup* | Select and existing resource group, or name for the new one in which you'll create your function app. |
    | **Function App name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`.  |
    |**Deploy code or container image**| Code | Option to publish code files or a Docker container. For this tutorial, select **Code**. |
    | **Runtime stack** | .NET | Your preferred programming language. For this tutorial, select **.NET**.  |
    |**Version**| 6 (LTS) In-process | Version of the .NET runtime. In-process signifies that you can create and modify functions in the portal, which is recommended for this guide |
    |**Region**| Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Operating System** | Windows | The operating system is pre-selected for you based on your runtime stack selection. |
    | **Plan type** | Consumption (Serverless) | Hosting plan that defines how resources are allocated to your function app.  |

1. Select **Review + create** to review the app configuration selections and then select **Create**. Deployment takes a few minutes.
1. Once deployed, select **Go to resource** to view your new function app.

## Create an HTTP trigger function

After the Azure Function app is created, create an HTTP trigger function. The HTTP trigger lets you invoke a function with an HTTP request. This HTTP trigger will be referenced and called by your Microsoft Entra custom authentication extension.

1. Within the **Overview** page of your function app, select the **Functions** pane and select **Create function** under **Create in Azure portal**.
1. In the **Create Function** window, leave the **Development environment** property as **Develop in portal**. Under **Template**, select **HTTP trigger**.
1. Under **Template details**, enter *CustomAuthenticationExtensionsAPI* for the **New Function** property.
1. For the **Authorization level**, select **Function**.
1. Select **Create**.

    :::image type="content" border="false"source="media/custom-extension-get-started/create-http-trigger-function.png" alt-text="Screenshot that shows how to choose the development environment, and template." lightbox="media/custom-extension-get-started/create-http-trigger-function.png":::

## Edit the function

The code reads the incoming JSON object and Microsoft Entra ID sends the [JSON object](./custom-claims-provider-reference.md) to your API. In this example, it reads the correlation ID value. Then, the code returns a collection of customized claims, including the original `CorrelationId`, the `ApiVersion` of your Azure Function, a `DateOfBirth` and `CustomRoles` that is returned to Microsoft Entra ID.

1. From the menu, under **Developer**, select **Code + Test**.
1. Replace the entire code with the following snippet, then select **Save**.

    ```csharp
    #r "Newtonsoft.Json"
    using System.Net;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Primitives;
    using Newtonsoft.Json;
    public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
    {
        log.LogInformation("C# HTTP trigger function processed a request.");
        string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
        dynamic data = JsonConvert.DeserializeObject(requestBody);
        
        // Read the correlation ID from the Azure AD  request    
        string correlationId = data?.data.authenticationContext.correlationId;
        
        // Claims to return to Azure AD
        ResponseContent r = new ResponseContent();
        r.data.actions[0].claims.CorrelationId = correlationId;
        r.data.actions[0].claims.ApiVersion = "1.0.0";
        r.data.actions[0].claims.DateOfBirth = "01/01/2000";
        r.data.actions[0].claims.CustomRoles.Add("Writer");
        r.data.actions[0].claims.CustomRoles.Add("Editor");
        return new OkObjectResult(r);
    }

    public class ResponseContent{
        [JsonProperty("data")]
        public Data data { get; set; }
        public ResponseContent()
        {
            data = new Data();
        }
    }

    public class Data{
        [JsonProperty("@odata.type")]
        public string odatatype { get; set; }
        public List<Action> actions { get; set; }
        public Data()
        {
            odatatype = "microsoft.graph.onTokenIssuanceStartResponseData";
            actions = new List<Action>();
            actions.Add(new Action());
        }
    }

    public class Action{
        [JsonProperty("@odata.type")]
        public string odatatype { get; set; }
        public Claims claims { get; set; }
        public Action()
        {
            odatatype = "microsoft.graph.tokenIssuanceStart.provideClaimsForToken";
            claims = new Claims();
        }
    }

    public class Claims{
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string CorrelationId { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string DateOfBirth { get; set; }
        public string ApiVersion { get; set; }
        public List<string> CustomRoles { get; set; }
        public Claims()
        {
            CustomRoles = new List<string>();
        }
    }
    ```

1. From the top menu, select **Get Function Url**, and copy the **URL** value. In the next step, the function URL will be used and referred to as `{Function_Url}`. It's a good idea to leave your Azure portal window open, as it'll be used again in later steps.

::: zone-end

## Next step

> [!div class="nextstepaction"]
> [Create a custom authentication extension](./DRAFT-custom-extension-tokenissuancestart-configuration.md)