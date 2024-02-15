---
title: Authentication events trigger for Azure Functions
description: Learn about the Authentication events trigger for Azure Functions for .NET library
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 08/16/2023 
ms.reviewer: JasSuri
ms.service: active-directory
ms.subservice: develop
ms.topic: how-to
titleSuffix: Microsoft identity platform
---

# Set up Authentication events trigger for Azure Functions client library for .NET

<!--The authentication events trigger for Azure Functions allows you to implement a custom extension to handle Microsoft Entra ID authentication events. The authentication events trigger handles all the backend processing for incoming HTTP requests for authentication events and provides the developer with

- Token validation for securing the API call
- Object model, typing and IDE intellisense
- Inbound and outbound validation of the API request and response schemas
- -->

## Prerequisites

- To use Azure services, including Azure Functions, you need an Azure subscription. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- Visual Studio or Visual Studio Code 
- Azure Functions extension for Visual Studio Code, Azure Development workload for Visual Studio

## Steps for Visual Studio <!--Visual Studio only? Or can it be done also in VSC. Is a VSC version also needed for GA? -->

1. Open Visual Studio
1. Select **Create a new project**.
1. Search for and select **Azure Functions**.
1. Give the project a name, such as *AuthEventsTrigger*. It's a good idea to match the solution name with the project name Select a location for the project. Select **Next**.
1. Select **.NET 6.0 (Long Term Support)** as the target framework. <!--Why? Why .NET 6.0 and not a later version-->
1. Select hte **Function** type to be *HTTP trigger*. Leave all the other settings as default. Ensure **Use Azurite** is checked <!--Confirm-->. Select **Create**.
1. In the top menu, select **Project**, **Manage NuGEt packages**
1. Select the **Browse** tab, then search for and select *Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents*. Select **Install**
1. Accept and apply the changes in the following popups.
1. Navigate back to your *function1.cs* file.
1. Replace the entire contents of the file with the following code:


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
1. We'll need to add an extra line of code to the *local.settings.json* file. Ensure that your *local.settings.json* file looks like this: <!--Really? Why would we bypass the token validation here?-->

```json
{
    "IsEncrypted": false,
    "Values": {
        "AzureWebJobsStorage": "AzureWebJobsStorageConnectionStringValue",
        "FUNCTIONS_WORKER_RUNTIME": "dotnet",
        "AuthenticationEvents__BypassTokenValidation": true
    }
}
```
    
1. Navigate to **Build** in the top menu, and select **Build Solution**.
1. Press **F5** or select *AuthEventsTrigger* from the top menu to run the function. 
1. Copy the **Function url** from the terminal that popups up when running the function. <!--I don't get this-->
<!--### Checking with Postman-->

Now, let's check it with Postman.

1. Open Postman and select **Post** from the left dropdown. Paste in the function URL you copied earlier.
1. Select **Body**, **raw**, and paste in the following JSON. Modify the values as needed.

```json
{
    "type": "microsoft.graph.authenticationEvent.tokenIssuanceStart",
    "source": "/tenants/{Enter tenant ID here}/applications/{Enter test JWT app ID here}",
    "data": {
        "@odata.type": "microsoft.graph.onTokenIssuanceStartCalloutData",
        "tenantId": "Enter tenant ID here",
        "authenticationEventListenerId": "Enter authentication event listener ID here", ## What is this corresponding to?
        "customAuthenticationExtensionId": "Enter custom authentication extension ID here",
        "authenticationContext": {
            "correlationId": "Enter correlation ID here", ## Do we know this?
            "client": {
                "ip": "Enter client IP here", ##
                "locale": "en-us",
                "market": "en-us"
            },
            "protocol": "OAUTH2.0",
            "clientServicePrincipal": {
                "id": "Enter correlation ID here", ##
                "appId": "Enter test JWT app ID here", ##
                "appDisplayName": "Enter test JWT app display name here", ##
                "displayName": "Enter test JWT app display name here" ##
            },
            "user": {
                "createdDateTime": "2023-08-16T00:00:00Z",
                "displayName": "Enter user display name here", ##
                "givenName": "Enter user given name here", ##
                "id": "Enter user ID here", ##
                "mail": "Enter user email here", ##
                "preferredLanguage": "en-us",
                "surname": "Enter user surname here", ##
                "userPrincipalName": "Enter user principal name here", ##
                "userType": "Member"
            }
        }
    }
}
```

1. Select **Send**. 
1. You should see a similar output to below.

```json
{
    "data": {
        "@odata.type": "microsoft.graph.onTokenIssuanceStartResponseData",
        "actions": [
            {
                "@odata.type": "microsoft.graph.tokenIssuanceStart.provideClaimsForToken",
                "claims": {
                    "dateOfBirth": "01/01/2000",
                    "customRoles": [
                        "Writer",
                        "Editor" ## What about nested Json?
                    ]
                }
            }

        ]
    }
}
```

<!--Does the Postman account need to be associated with the same email address as your Azure subscription?-->

## Deploy Function to Azure 

So far we've set up the project to install the NuGet packages and starter code and have tested it locally in Postman. Now we will deploy this

1. In the Solution Explorer, right-click on the project and select **Publish**.
1. Select **Azure** > **Azure Function App (Windows)**
1. You'll need to sign in to your Azure account if you haven't already. Sign in with your password and select sign in. Use the Authentication code to sign in.
1. On the **Publish** screen, select **Create New**.
1. Give the function app a name, such as *AuthEventsTrigger*. Select the subscription (*Visual Studio Subscription*), resource group (*myresource*), Plan Type (*Consumption*), Location (one which matches best), Azure Storage, and Application Insights. Select **Create**. 
1. Wait a few moments for your function app to be deployed. Once the window closes, select **Finish** on the **Publish** screen.
1. You'll still need to wait ~5 minutes for your function app to be deployed.


## On Azure portal <!--So this is workforce tenant only, can we add a note saying that CIAM is expected shortly-->

1. Log in to the [Azure portal](https://portal.azure.com/) with your administrator account.
1. Search for and select **Function App** to navigate to the function app you just deployed. You may need to refresh the page to see the new function app.
<!--Environment variables, do we need to add these for each deployment?-->
1. In the left menu, navigate to **Settings** > **Environment variables**, and enter name and values for the *AuthenticationEvents__TenantID* and *AuthenticationEvents__TenantIDAudienceAppID*. You'll need to define additional values for the object ID for token metadata and the token issuer. 
1. Navigate back to the **Overview** screen and select the function you have created, **onTokenIssuanceStart**.
1. In the **onTokenIssuanceStart** overview page, select **Get function URL** and copy the URL value. You'll need this for the next step.

## Create a custom authentication extension

1. Sign into the Microsoft Entra admin center with your administrator account.
1. Navigate to **Identity** > **Applicatons** > **Enterprise applications**, and select **Custom authentication extension**.
1. Select **Create a custom extension**, and then select the **TokenIssuanceStart** event.
1. Give it a name, such as *NugetCustomExtension*.
1. Enter the function URL you copied earlier. Select **Next**.
1. In the **API Authentication** section, select **Create new app registration**.
1. Give it a name such as **NuGetTestAPI**. Select **Next**.
1. Add the following claims, *dateOfBirth* and *customRoles*. Select **Next**.
1. Select **Create**.

After your custom authentication extension is created, open the **Overview** tab of the new custom authentication extension.

From the **Overview** page, select the **Grant permission** button to give admin consent to the registered app, which allows the custom authentication extension to authenticate to your API. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission. Select **Accept**.

1. On the **Overview** page of your custom extension, copy the App ID, and store it somewhere for use later. This enables ASTS to call this API during *onTokenIssuanceStart*. This API will then respond back with the custom claims.

<!--Why does the popup not disappear-->

## Create a new test app registration

1. Sign into the Microsoft Entra admin center with your administrator account.
1. Navigate to **Identity** > **Applicatons** > **App registrations**, and register a new application.
1. Give your application a name, such as *Test JWT Nuget*. 
1. Under **Redirect URI**, select **Web** and enter the following URL: *https://jwt.ms*. Select **Register**.
1. Take note of the **Application (client) ID** and **Directory (tenant) ID**. You'll need these for the next step. 


1. Under **Manage**, select **Authentication**, and under **Implicit grant and hybrid flows**, select **ID tokens**. The JWT app used to view the token uses implicit flow. Select **Save**. 
1. Navigate to the **Manifest** tab. Under `accessTokenAcceptedVersion`, change the value to `2` <!--Does this matter-->, and the `acceptMappedClaims` to `true`. Select **Save**. 
1. Navigate to **Enterprise applications** > **Single sign-on**. 
1. Under **Attributes and claims**, select **Add new claim** to add a new claim. Provide a name to the claim you want to be issued, for example dateOfBirth.
1. Under Source, select Attribute, and choose `customClaimsProvider.DateOfBirth` from the Source attribute drop-down box. Repeat for the other claims.

## Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration.

> [!NOTE]
> If the Azure function app is hosted in a different Azure tenant than the tenant in which your custom authentication extension is registered, skip to [using OpenID Connect identity provider](#51-using-openid-connect-identity-provider) step.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you previously published.
1. Select **Authentication** in the menu on the left.
1. Select **Add Identity provider**.  
1. Select Workforce as the tenant type.
<!--This next step is different -->
1. Under App registration select **App registration type** <!-- Why not "Pick an existing app registration in this directory"?-->. Enter the app ID of the custom authentication extension you created earlier. 
1. Enter the following issuer URL, `https://login.microsoftonline.com/{tenantId}/v2.0/`, where {tenantId} is the tenant ID of your workforce tenant. <!--Why was this not entered? This is a bug-->
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

## Visual Studio Code

1. Create a new folder *AuthEventsTrigger* 
1. 


## See also 

[Monitoring Azure Functions with Azure Monitor Logs](/azure/azure-functions/functions-monitor-log-analytics?tabs=csharp)

