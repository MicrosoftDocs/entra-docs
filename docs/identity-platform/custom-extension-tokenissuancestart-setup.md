---
title: Create a REST API for a token issuance event in Azure Functions
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

#Customer intent: As a developer, I want to create an Azure Function app with for a token issuance start event using the Azure Functions client library for .NET, and deploy it to the Azure portal, or create the app directly on the Azure portal.
---

# Create a REST API for a token issuance start event in Azure Functions

::: zone pivot="azure-portal"

This article describes how to create a REST API with a [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) using Azure Functions in the Azure portal. You create an Azure Function app and an HTTP trigger function which can return extra claims for your token. 

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.

::: zone-end

::: zone pivot="nuget-library" 

This article describes how to create a REST API for a [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) using the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library and set it up for authentication. You'll create an HTTP trigger function in Visual Studio or Visual Studio Code, configure it for authentication, and deploy it to the Azure portal, where it can be accessed through Azure Functions.

## Prerequisites

- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
- One of the following IDEs and configurations:
    - Visual Studio with [Azure Development workload for Visual Studio](/dotnet/azure/configure-visual-studio) configured.
    - Visual Studio Code, with the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension enabled.

> [!NOTE]
>
> The [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library is currently in preview. Steps in this article are subject to change. For general availability implementation of implementing a token issuance start event, you can do so using the [Azure portal](#create-the-azure-function-app).
    
::: zone-end

::: zone pivot="azure-portal"

## Create the Azure Function app

In the Azure portal, create an Azure Function app and its associated resource, before continuing to create the HTTP trigger function.

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. From the Azure portal menu or the **Home** page, select **Create a resource**.
1. Search for and select **Function App** and select **Create**.
1. On the **Basics** page, create a function app using the settings as specified in the following table:

    | Setting      | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Subscription** | Your subscription | The subscription under which the new function app will be created. |
    | **[Resource Group](/azure/azure-resource-manager/management/overview)** |  *myResourceGroup* | Select and existing resource group, or name for the new one in which you'll create your function app. |
    | **Function App name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`.  |
    |**Deploy code or container image**| Code | Option to publish code files or a Docker container. For this tutorial, select **Code**. |
    | **Runtime stack** | .NET | Your preferred programming language. For this tutorial, select **.NET**.  |
    |**Version**| 6 (LTS) In-process | Version of the .NET runtime. In-process signifies that you can create and modify functions in the portal, which is recommended for this guide |
    |**Region**| Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Operating System** | Windows | The operating system is preselected for you based on your runtime stack selection. |
    | **Plan type** | Consumption (Serverless) | Hosting plan that defines how resources are allocated to your function app.  |

1. Select **Review + create** to review the app configuration selections and then select **Create**. Deployment takes a few minutes.
1. Once deployed, select **Go to resource** to view your new function app.

## Create an HTTP trigger function

After the Azure Function app is created, create an HTTP trigger function within the app. The HTTP trigger lets you invoke a function with an HTTP request and is referenced by your Microsoft Entra custom authentication extension.

1. Within the **Overview** page of your function app, select the **Functions** pane and select **Create function** under **Create in Azure portal**.
1. In the **Create Function** window, leave the **Development environment** property as **Develop in portal**. Under **Template**, select **HTTP trigger**.
1. Under **Template details**, enter *CustomAuthenticationExtensionsAPI* for the **New Function** property.
1. For the **Authorization level**, select **Function**.
1. Select **Create**.
    :::image type="content" border="false"source="media/custom-extension-tokenissuancestart-configuration/create-http-trigger-function.png" alt-text="Screenshot that shows how to choose the development environment, and template." lightbox="media/custom-extension-tokenissuancestart-configuration/create-http-trigger-function.png":::

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
        
        // Read the correlation ID from the Microsoft Entra request    
        string correlationId = data?.data.authenticationContext.correlationId;
        
        // Claims to return to Microsoft Entra
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

1. From the top menu, select **Get Function Url**, and copy the **URL** value. This function URL can be used when setting up a custom authentication extension.  

::: zone-end

::: zone pivot="nuget-library"

## Create and build the Azure Function app

In this step, you create an HTTP trigger function API using your IDE, install the required NuGet packages and copy in the sample code. You build the project and run the function to extract the local function URL.

### Create the application

To create an Azure Function app, follow these steps:

### [Visual Studio](#tab/visual-studio)

1. Open Visual Studio, and select **Create a new project**.
1. Search for and select **Azure Functions**, then select **Next**.
1. Give the project a name, such as *AuthEventsTrigger*. It's a good idea to match the solution name with the project name.
1. Select a location for the project. Select **Next**.
1. Select **.NET 6.0 (Long Term Support)** as the target framework. 
1. Select *Http trigger* as the **Function** type, and that **Authorization level** is set to *Function*. Select **Create**.
1. In the **Solution Explorer**, rename the *Function1.cs* file to *AuthEventsTrigger.cs*, and accept the rename change suggestion.

### [Visual Studio Code](#tab/visual-studio-code)

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

---

### Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

### [Visual Studio](#tab/visual-studio)

1. In the top menu of Visual Studio, select **Project**, then **Manage NuGet packages**.
1. Select the **Browse** tab, then search for and select *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents* in the right pane. Select **Install**.
1. Apply and accept the changes in the popups that appear.

### [Visual Studio Code](#tab/visual-studio-code)

1. Open the **Terminal** in Visual Studio Code, and navigate to the project folder.
1. Enter the following command into the console to install the *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents* NuGet package.

    ```console
    dotnet add package Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents
    ```

---

### Add the sample code

The function API is the source of extra claims for your token. For the purposes of this article, we're hardcoding the values for the sample app. In production, you can fetch information about the user from external data store.

In your *AuthEventsTrigger.cs* file, replace the entire contents of the file with the following code:

[!INCLUDE [nuget-code](./includes/scenarios/custom-extension-tokenissuancestart-setup-nuget-code.md)]

### Build and run the project locally

The project has been created, and the sample code has been added. Using your IDE, we need to build and run the project locally to extract the local function URL.

### [Visual Studio](#tab/visual-studio)

1. Navigate to **Build** in the top menu, and select **Build Solution**.
1. Press **F5** or select *AuthEventsTrigger* from the top menu to run the function. 
1. Copy the **Function url** from the terminal that popups up when running the function. This can be used when setting up a custom authentication extension.

### [Visual Studio Code](#tab/visual-studio-code)

1. In the top menu, select **Run** > **Start Debugging** or press **F5** to run the function.
1. In the terminal, copy the **Function url** that appears. This can be used when setting up a custom authentication extension.

---

## Run the function locally (recommended)

It's a good idea to test the function locally before deploying it to Azure. We can use a dummy JSON body that imitates the request that Microsoft Entra ID sends to your REST API. Use your preferred API testing tool to call the function directly.

1. In your IDE, open *local.settings.json* and replace the code with the following JSON. We can set `"AuthenticationEvents__BypassTokenValidation"` to `true` for local testing purposes.

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "",
        "AzureWebJobsSecretStorageType": "files",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet",
        "AuthenticationEvents__BypassTokenValidation" : true
      }
    }
    ```

1. Using your preferred API testing tool, create a new HTTP request and set the **HTTP method** to `POST`.
1. Use the following JSON body that imitates the request Microsoft Entra ID sends to your REST API.

    ```json
    {
        "type": "microsoft.graph.authenticationEvent.tokenIssuanceStart",
        "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/00001111-aaaa-2222-bbbb-3333cccc4444",
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartCalloutData",
            "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
            "authenticationEventListenerId": "11112222-bbbb-3333-cccc-4444dddd5555",
            "customAuthenticationExtensionId": "22223333-cccc-4444-dddd-5555eeee6666",
            "authenticationContext": {
                "correlationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
                "client": {
                    "ip": "127.0.0.1",
                    "locale": "en-us",
                    "market": "en-us"
                },
                "protocol": "OAUTH2.0",
                "clientServicePrincipal": {
                    "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
                    "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
                    "appDisplayName": "My Test application",
                    "displayName": "My Test application"
                },
                "resourceServicePrincipal": {
                    "id": "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb",
                    "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
                    "appDisplayName": "My Test application",
                    "displayName": "My Test application"
                },
                "user": {
                    "companyName": "Casey Jensen",
                    "createdDateTime": "2023-08-16T00:00:00Z",
                    "displayName": "Casey Jensen",
                    "givenName": "Casey",
                    "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
                    "mail": "casey@contoso.com",
                    "onPremisesSamAccountName": "Casey Jensen",
                    "onPremisesSecurityIdentifier": "<Enter Security Identifier>",
                    "onPremisesUserPrincipalName": "Casey Jensen",
                    "preferredLanguage": "en-us",
                    "surname": "Jensen",
                    "userPrincipalName": "casey@contoso.com",
                    "userType": "Member"
                }
            }
        }
    }

1. Select **Send**, and you should receive a JSON response similar to the following:

    ```json
    {
        "data": {
            "@odata.type": "microsoft.graph.onTokenIssuanceStartResponseData",
            "actions": [
                {
                    "@odata.type": "microsoft.graph.tokenIssuanceStart.provideClaimsForToken",
                    "claims": {
                        "customClaim1": "customClaimValue1",
                        "customClaim2": [
                            "customClaimString1",
                            "customClaimString2" 
                        ]
                    }
                }
    
            ]
        }
    }
    ```

## Deploy the function and publish to Azure 

The function needs to be deployed to Azure using our IDE. Check that you're correctly signed in to your Azure account so the function can be published.

### [Visual Studio](#tab/visual-studio)

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

### [Visual Studio Code](#tab/visual-studio-code)

1. Select the **Azure** extension icon. In **Resources**, select the **+** icon to **Create a resource**.
1. Select **Create Function App in Azure**. Use the following settings for setting up your function app.
1. Give the function app a name, such as *AuthEventsTriggerNuGet*, and press **Enter**.
1. Select the **.NET 6 (LTS) In-Process** runtime stack. 
1. Select a location for the function app, such as *East US*.
1. Wait a few minutes for your function app to be deployed and show up in the Azure portal.

---

## Configure authentication for your Azure Function

There are three ways to set up authentication for your Azure Function: 

- [Set up authentication in the Azure portal using environment variables](#set-up-authentication-in-the-azure-portal-using-environment-variables) (recommended)
- [Set up authentication in your code using `WebJobsAuthenticationEventsTriggerAttribute`](#set-up-authentication-in-your-code-using-webjobsauthenticationeventstriggerattribute)
- [Azure App service authentication and authorization](/azure/app-service/configure-authentication-provider-aad?tabs=workforce-tenant)

By default, the code has been set up for authentication in the Azure portal using environment variables. Use the tabs below to select your preferred method of implementing environment variables, or alternatively, refer to the built-in [Azure App service authentication and authorization](/azure/app-service/overview-authentication-authorization). For setting up environment variables, use the following values:

   | Name | Value |
   | ---- | ----- | 
   | *AuthenticationEvents__AudienceAppId* | *Custom authentication extension app ID* which is set up in [Configure a custom claim provider for a token issuance event](./custom-extension-tokenissuancestart-configuration.md) |
   | *AuthenticationEvents__AuthorityUrl* | &#8226; Workforce tenant `https://login.microsoftonline.com/<tenantID>` <br> &#8226; External tenant `https://<mydomain>.ciamlogin.com/<tenantID>` | 
   | *AuthenticationEvents__AuthorizedPartyAppId* | `99045fe1-7639-4a75-9d4a-577b6ca3810f` or another authorized party | 

### [Set up authentication in Azure portal](#tab/azure-portal)

### Set up authentication in the Azure portal using environment variables

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) or [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Navigate to the function app you created, and under **Settings**, select **Configuration**.
1. Under **Application settings**, select **New application setting** and add the environment variables from the table and their associated values.  
1. Select **Save** to save the application settings.

### [Set up authentication in your code](#tab/nuget-library)

### Set up authentication in your code using `WebJobsAuthenticationEventsTriggerAttribute`

1. Open the *AuthEventsTrigger.cs* file in your IDE.
1. Modify the `WebJobsAuthenticationEventsTriggerAttribute` include the `AuthorityUrl`, `AudienceAppId` and `AuthorizedPartyAppId` properties, as shown in the below snippet.

```csharp
    [FunctionName("onTokenIssuanceStart")]
    public static WebJobsAuthenticationEventResponse Run(
        [WebJobsAuthenticationEventsTriggerAttribute(
            AudienceAppId = "Enter custom authentication extension app ID here",
            AuthorityUrl = "Enter authority URI here", 
            AuthorizedPartyAppId = "Enter the Authorized Party App Id here")]WebJobsTokenIssuanceStartRequest request, ILogger log)
```

---

::: zone-end

## Next step

> [!div class="nextstepaction"]
> [Configure a custom claims provider token issuance event](./custom-extension-tokenissuancestart-configuration.md)
