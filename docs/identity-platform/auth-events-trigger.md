---
title: Authentication events trigger for Azure Functions
description: Implement a HTTP trigger function using the Authentication events trigger for Azure Functions for .NET library.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 08/16/2023 
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As an app developer, I want to use an IDE to use the Authentication events trigger for Azure Functions client library for .NET. 
---

# Set up Authentication events trigger for Azure Functions client library for .NET

**Applies to:** Microsoft Entra ID workforce configurations

In this how-to guide, you'll learn how to set up and test the Authentication events trigger for Azure Functions client library for .NET. The authentication events trigger handles all the backend processing for incoming HTTP requests for authentication events. 

## Prerequisites

- To use Azure services, including Azure Functions, you need an Azure subscription. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Visual Studio Enterprise subscription.
- Visual Studio or Visual Studio Code 
- Azure Functions extension for Visual Studio Code, Azure Development workload for Visual Studio

## Step 1: Create an Azure Function app

In this step, you'll create a HTTP trigger function using your chosen integrated development environment (IDE). 

# [Visual Studio](#tab/visual-studio)

1. Open Visual Studio, and select **Create a new project**.
1. Search for and select **Azure Functions**, then select **Next**.
1. Give the project a name, such as *AuthEventsTrigger*. It's a good idea to match the solution name with the project name Select a location for the project. Select **Next**.
1. Select **.NET 6.0 (Long Term Support)** as the target framework. <!--Why? Why .NET 6.0 and not a later version-->
1. Select *HTTP trigger* as the **Function** type, and that **Authorization level** is set to *Function*. Select **Create**.
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

1. Next, open the *local.settings.json* file and add the AzureWebJobsStorage value

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
      }
    }
    ```

# [Visual Studio Code](#tab/visual-studio-code)

1. Open Visual Studio Code.
1. Select the **New Folder** icon in the **Explorer** window, and create a new folder for your project, for example *AuthEventsTrigger*.
1. Select the Azure extension icon on the left-hand side of the screen. Sign in to your Azure account if you haven't already. **TODO**
1. Under the **Workspace** bar, select the **Azure Functions** icon > **Create New Project**.

    :::image type="content" border="true"  source="media/auth-events-trigger/visual-studio-code-add-azure-function.png" alt-text="Screenshot that shows how to add an Azure function in Visual Studio Code.":::

1. In the top bar, select the location to create the project.
1. Select **C#** as the language, and **.NET 6.0 LTS** as the .NET runtime.
1. Provide a name for the project, such as *AuthEventsTrigger*.
1. Select **HTTP trigger** as the template, and accept **Company.Function** as the namespace, with **AccessRights** set to *Function*. 
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

1. Next, open the *local.settings.json* file and add the AzureWebJobsStorage value

    ```json
    {
      "IsEncrypted": false,
      "Values": {
        "AzureWebJobsStorage": "UseDevelopmentStorage=true",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet"
      }
    }
    ```
---

### 1.2 Install NuGet packages and build the project

After creating the project, you'll need to install the required NuGet packages and build the project.

# [Visual Studio](#tab/visual-studio)

1. In the top menu of Visual Studio, select **Project**, then **Manage NuGet packages**.
1. Select the **Browse** tab, then search for and select *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents*. In the right pane, Select **Install**.
1. Apply and accept the changes in the popups that appear.
1. Navigate to **Build** in the top menu, and select **Build Solution**.
1. Press **F5** or select *AuthEventsTrigger* from the top menu to run the function. 
1. Copy the **Function url** from the terminal that popups up when running the function. 

# [Visual Studio Code](#tab/visual-studio-code)

1. Open the **Terminal** in Visual Studio Code, and navigate to the project folder.
1. Enter the following command into the console to install the *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents* NuGet package.

    ```console
    dotnet add package Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents --prerelease
    ```

1. In the top menu, select **Run** > **Start Debugging** or press **F5** to run the function.
1. In the terminal, copy the **Function url** that appears.

---

At this point, you can [test authentication events token augmentation using Postman](./auth-events-nuget-postman.md) or continue on to deployment.

### 1.3 Deploy function and publish to Azure 

So far we've set up the project to install the NuGet packages and added soem starter code. We'll now deploy this to Azure using our IDE.

# [Visual Studio](#tab/visual-studio)

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
    | **Application Insights** | TODO | TODO |
    

1. Wait a few moments for your function app to be deployed. Once the window closes, select **Finish** on the **Publish** screen.
1. You'll still need to wait ~5 minutes for your function app to be deployed.

# [Visual Studio Code](#tab/visual-studio-code)

> [!NOTE]
>
> The steps required for this section are not yet available.

---

## Step 2: Add environment variables <!--So this is workforce tenant only, can we add a note saying that CIAM is expected shortly-->

1. Sign in to the [Azure portal](https://portal.azure.com/) with your administrator account.
1. Search for and select **Function App** to navigate to the function app you just deployed. You may need to refresh the page to see the new function app.
<!--Environment variables, do we need to add these for each deployment?-->
1. In the left menu, navigate to **Settings** > **Environment variables**, and enter name and values for the *AuthenticationEvents__TenantID* and *AuthenticationEvents__TenantIDAudienceAppID*. You'll need to define additional values for the object ID for token metadata and the token issuer. 
1. Navigate back to the **Overview** screen and select the function you have created, **onTokenIssuanceStart**.
1. In the **onTokenIssuanceStart** overview page, select **Get function URL** and copy the URL value. You'll need this for the next step.

## Step 3: Create a custom authentication extension

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select **Custom authentication extensions**, and then select **Create a custom authentication extension**.
1. In **Basics**, select the **tokenIssuanceStart** event and select **Next**.
1. In **Endpoint Configuration**, fill in the following properties:
    - **Name** - A name for your custom authentication extension. For example, *NuGet Token issuance event*.
    - **Target Url** - The `{Function_Url}` of your Azure Function URL from [Step 1: Create an Azure Function app](#step-1-create-an-azure-function-app). 
    - **Description** - A description for your custom authentication extensions.
1. Select **Next**.
1. In **API Authentication**, select the **Create new app registration** option to create an app registration that represents your *function app*.  
1. Give the app a name, for example **Azure Functions NuGet Authentication events API**.
1. Select **Next**.
1. In **Claims**, enter the attributes that you expect your custom authentication extension to parse from your REST API and will be merged into the token. Add the following claims:
    - dateOfBirth
    - customRoles
1. Select **Create**, which registers the custom authentication extension and the associated application registration.

### 3.2 Grant admin consent

After your custom authentication extension is created, open the **Overview** tab of the new custom authentication extension.

From the **Overview** page, select the **Grant permission** button to give admin consent to the registered app, which allows the custom authentication extension to authenticate to your API. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission. Select **Accept**.

1. On the **Overview** page of your custom extension, copy the App ID, and store it somewhere for use later. This enables ASTS to call this API during *onTokenIssuanceStart*. This API will then respond back with the custom claims.

<!--Why does the popup not disappear-->

## Step 4: Configure an OpenID Connect app to receive enriched tokens

To get a token and test the custom authentication extension, you can use the <https://jwt.ms> app. It's a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser).

### 4.1 Register a new application

1. Sign into the Microsoft Entra admin center with your administrator account.
1. Navigate to **Identity** > **Applicatons** > **App registrations**, and register a new application.
1. Give your application a name, such as *Test JWT NuGet*. 
1. Under **Redirect URI**, select **Web** and enter the following URL: *https://jwt.ms*. Select **Register**.
1. Take note of the **Application (client) ID** and **Directory (tenant) ID**. You'll need these for the next step. 

### 4.2 Enable implicit flow

The **jwt.ms** test application uses the implicit flow. Enable implicit flow in your *Test JWT NuGet* registration:

1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.

### 4.3 Enable your App for a claims mapping policy

A claims mapping policy is used to select which attributes returned from the custom authentication extension are mapped into the token. To allow tokens to be augmented, you must explicitly enable the application registration to accept mapped claims:

1. In your *Test JWT NuGet* registration, under **Manage**, select **Manifest**.
1. In the manifest, locate the `acceptMappedClaims` attribute, and set the value to `true`
1. Set the `accessTokenAcceptedVersion` to `2`.  <!--Does this matter-->,
1. Select **Save** to save the changes.

> [!WARNING]
> Do not set `acceptMappedClaims` property to `true` for multi-tenant apps, which can allow malicious actors to create claims-mapping policies for your app. Instead [configure a custom signing key](/graph/application-saml-sso-configure-api#option-2-create-a-custom-signing-certificate).


## Step 5: Assign a custom claims provider to your app

For tokens to be issued with claims incoming from the custom authentication extension, you must assign a custom claims provider to your application. This is based on the token audience, so the provider must be assigned to the client application to receive claims in an ID token, and to the resource application to receive claims in an access token. The custom claims provider relies on the custom authentication extension configured with the **token issuance start** event listener. You can choose whether all, or a subset of claims, from the custom claims provider are mapped into the token.

Follow these steps to connect the *Test JWT NuGet* with your custom authentication extension:

First assign the custom authentication extension as a custom claims provider source:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Application registrations**.
1. In the **Overview** page, under **Managed application in local directory**, select **My Test application**.
1. Under **Manage**, select **Single sign-on**.
1. Under **Attributes & Claims**, select **Edit**.
1. Expand the **Advanced settings** menu.
1. Select **Configure** against **Custom claims provider**.
1. Expand the **Custom claims provider** drop-down box, and select the *Token issuance event* you created earlier.
1. Select **Save**.

Next, assign the attributes from the custom claims provider, which should be issued into the token as claims:

1. Navigate to **Enterprise applications** > **Single sign-on**. 
1. Under **Attributes and claims**, select **Add new claim** to add a new claim. Provide a name to the claim you want to be issued, for example *dateOfBirth*.
1. Under **Source**, select **Attribute**, and choose `customClaimsProvider.DateOfBirth` from the S#source attribute drop-down box. Repeat for the other claims outlined in your function app.

## Step 6: Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you previously published.
1. Select **Authentication** in the menu on the left.
1. Select **Add Identity provider**.  
1. Select **Workforce** as the tenant type.
<!--This next step is different -->
1. Under App registration select **App registration type** <!-- Why not "Pick an existing app registration in this directory"?-->. Enter the app ID of the custom authentication extension you created earlier. 
1. Enter the following issuer URL, `https://login.microsoftonline.com/{tenantId}/v2.0/`, where `{tenantId}` is the tenant ID of your workforce tenant. <!--Why was this not entered? This is a bug-->
<!-- 
EasyAuth setup, why then do the env variables not matter?
-->
1. Under **Additional checks** <!--What is this??-->, select **Allow requests from specific client applications**
1. Under Unauthenticated requests, select **HTTP 401 Unauthorized**.
1. Unselect the **Token store** option.
1. Select Add to add authentication to your Azure Function.

## Set the environment variables (non Easy Auth)

1. Navigate back to the **Environment variables** tab. 
1. Add the *AuthenticationEvents__TenantID* and *AuthenticationEvents__TenantIDAudienceAppID* (custom extension), if not done so already. 

<!--TODO sign in the user with Easy Auth and Sign in with internal token validation

We need to signify why one would use one over the other.
-->

## Step 7: Test the application

To test your custom claim provider, follow these steps:

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize?client_id={App_to_enrich_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```

1. Replace `{tenant-id}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{App_to_enrich_ID}` with the *Test JWT NuGet* application ID.  
1. After logging in, you'll be presented with your decoded token at `https://jwt.ms`. Validate that the claims from the Azure Function are presented in the decoded token, for example, `dateOfBirth`.

## See also

[Monitoring Azure Functions with Azure Monitor Logs](/azure/azure-functions/functions-monitor-log-analytics?tabs=csharp)

