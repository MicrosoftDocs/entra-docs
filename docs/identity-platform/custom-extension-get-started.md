---
title: Get started with custom claims providers (preview)
description: Learn how to develop and register a Microsoft Entra custom authentication extensions REST API. The custom authentication extension allows you to source claims from a data store that is external to Microsoft Entra ID.  
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 08/16/2023
ms.reviewer: JasSuri
ms.service: active-directory
ms.subservice: develop
ms.topic: how-to
titleSuffix: Microsoft identity platform

#Customer intent: As a developer, I want to configure a custom claims provider token issuance event, so that I can add custom claims to a token before it is issued.
---

# Configure a custom claim provider token issuance event (preview)

**Applies to:** Microsoft Entra External ID customer configuration, Microsoft Entra ID workforce configuration,

This article describes how to configure and set up a custom claims provider with the [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener) type. This event is triggered right before the token is issued, and allows you to call a REST API to add claims to the token.

This how-to guide demonstrates the token issuance start event with a REST API running in Azure Functions and a sample OpenID Connect application. In this article, you'll create a REST API using Azure Functions in the Azure portal, then register a custom authentication extension in the Microsoft Entra admin center. You'll add some attributes that you expect your custom authentication extension to parse from your REST API. To test the custom authentication extension, you'll register a test web application to get a token and view the claims.

Before you start, take a look at following video, which demonstrates how to configure Microsoft Entra custom claims provider with Function App:

> [!VIDEO https://www.youtube.com/embed/fxQGVIwX8_4]

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=TokenAugmentation)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Add claims to security tokens from a REST API” use case.

## Prerequisites

- An basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).

- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, you may sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).

- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
    - For customer tenants, you'll need a [sign-up and sign-in user flow](~/external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).

## Step 1: Create an Azure Function app

[!INCLUDE [portal updates](~/includes/portal-update.md)]

In this step, you create an HTTP trigger function API in the Azure portal. The function API is the source of extra claims for your token. Follow these steps to create an Azure Function:

1. Sign in to the [Azure portal](https://portal.azure.com) with your administrator account.
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

### 1.1 Create an HTTP trigger function

After the Azure Function app is created, create an HTTP trigger function. The HTTP trigger lets you invoke a function with an HTTP request. This HTTP trigger will be referenced and called by your Microsoft Entra custom authentication extension.

1. Within the **Overview** page of your function app, select the **Functions** pane and select **Create function** under **Create in Azure portal**.
1. In the **Create Function** window, leave the **Development environment** property as **Develop in portal**. Under **Template**, select **HTTP trigger**.
1. Under **Template details**, enter *CustomAuthenticationExtensionsAPI* for the **New Function** property.
1. For the **Authorization level**, select **Function**.
1. Select **Create**.

:::image type="content" border="false"source="media/custom-extension-get-started/create-http-trigger-function.png" alt-text="Screenshot that shows how to choose the development environment, and template." lightbox="media/custom-extension-get-started/create-http-trigger-function.png":::

### 1.2 Edit the function

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

    The code starts with reading the incoming JSON object. Microsoft Entra ID sends the [JSON object](./custom-claims-provider-reference.md) to your API. In this example, it reads the correlation ID value. Then, the code returns a collection of customized claims, including the original `CorrelationId`, the `ApiVersion` of your Azure Function, a `DateOfBirth` and `CustomRoles` that is returned to Microsoft Entra ID.

1. From the top menu, select **Get Function Url**, and copy the **URL** value. In the next step, the function URL will be used and referred to as `{Function_Url}`. It's a good idea to leave your Azure portal window open, as it'll be used again in later steps.

## Step 2: Register a custom authentication extension

In this step, you configure a custom authentication extension, which will be used by Microsoft Entra ID to call your Azure function. The custom authentication extension contains information about your REST API endpoint, the claims that it parses from your REST API, and how to authenticate to your REST API. Follow these steps to register a custom authentication extension:

# [Microsoft Entra admin center](#tab/entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator). If you have access to multiple tenants, check that you're in the same tenant as the [previous step](#step-1-create-an-azure-function-app).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select **Custom authentication extensions**, and then select **Create a custom extension**.
1. In **Basics**, select the **TokenIssuanceStart** event type and select **Next**.
1. In **Endpoint Configuration**, fill in the following properties:

    - **Name** - A name for your custom authentication extension. For example, *Token issuance event*.
    - **Target Url** - The `{Function_Url}` of your Azure Function URL.
    - **Description** - A description for your custom authentication extensions.
1. Select **Next**.
1. In **API Authentication**, select the **Create new app registration** option to create an app registration that represents your *function app*.  
1. Give the app a name, for example **Azure Functions authentication events API**.
1. Select **Next**.
1. In **Claims**, enter the attributes that you expect your custom authentication extension to parse from your REST API and will be merged into the token. Add the following claims:
    - dateOfBirth
    - customRoles
    - apiVersion
    - correlationId
1. Select **Next**, then **Create**, which registers the custom authentication extension and the associated application registration.

# [Microsoft Graph](#tab/microsoft-graph)

Register an application to authenticate your custom authentication extension to your Azure Function.

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant you wish to manage your custom authentication extension in. The account must have the privileges to create and manage an application registration in the tenant.
2. Run the following request.

    ```http
    POST https://graph.microsoft.com/v1.0/applications
    Content-type: application/json
    
    {
        "displayName": "authenticationeventsAPI"
    }
    ```

3. From the response, record the value of **id** and **appId** of the newly created app registration. These values will be referenced in this article as `{authenticationeventsAPI_ObjectId}` and `{authenticationeventsAPI_AppId}` respectively.

Create a service principal in the tenant for the authenticationeventsAPI app registration.

Still in Graph Explorer, run the following request. Replace `{authenticationeventsAPI_AppId}` with the value of **appId** that you recorded from the previous step.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals
Content-type: application/json
    
{
    "appId": "{authenticationeventsAPI_AppId}"
}
```

### Set the App ID URI, access token version, and required resource access

Update the newly created application to set the application ID URI value, the access token version, and the required resource access.

In Graph Explorer, run the following request. 
   - Set the application ID URI value in the *identifierUris* property. Replace `{Function_Url_Hostname}` with the hostname of the `{Function_Url}` you recorded earlier.
   - Set the `{authenticationeventsAPI_AppId}` value with the **appId** that you recorded earlier.
   - An example value is `api://authenticationeventsAPI.azurewebsites.net/f4a70782-3191-45b4-b7e5-dd415885dd80`. Take note of this value as you'll use it later in this article in place of `{functionApp_IdentifierUri}`.

```http
POST https://graph.microsoft.com/v1.0/applications/{authenticationeventsAPI_ObjectId}
Content-type: application/json

{
"identifierUris": [
    "api://{Function_Url_Hostname}/{authenticationeventsAPI_AppId}"
],    
"api": {
    "requestedAccessTokenVersion": 2,
    "acceptMappedClaims": null,
    "knownClientApplications": [],
    "oauth2PermissionScopes": [],
    "preAuthorizedApplications": []
},
"requiredResourceAccess": [
    {
        "resourceAppId": "00000003-0000-0000-c000-000000000000",
        "resourceAccess": [
            {
                "id": "214e810f-fda8-4fd7-a475-29461495eb00",
                "type": "Role"
            }
        ]
    }
]
}
```

### Register a custom authentication extension

Next, you register the custom authentication extension. You register the custom authentication extension by associating it with the app registration for the Azure Function, and your Azure Function endpoint `{Function_Url}`.

1. In Graph Explorer, run the following request. Replace `{Function_Url}` with the hostname of your Azure Function app. Replace `{functionApp_IdentifierUri}` with the identifierUri used in the previous step.
   - You need the *CustomAuthenticationExtension.ReadWrite.All* delegated permission. 

    ```http
    POST https://graph.microsoft.com/beta/identity/customAuthenticationExtensions
    Content-type: application/json
    
    {
        "@odata.type": "#microsoft.graph.onTokenIssuanceStartCustomExtension",
        "displayName": "onTokenIssuanceStartCustomExtension",
        "description": "Fetch additional claims from custom user store",
        "endpointConfiguration": {
            "@odata.type": "#microsoft.graph.httpRequestEndpoint",
            "targetUrl": "{Function_Url}"
        },
        "authenticationConfiguration": {
            "@odata.type": "#microsoft.graph.azureAdTokenAuthentication",
            "resourceId": "{functionApp_IdentifierUri}"
        },
        "claimsForTokenConfiguration": [
            {
                "claimIdInApiResponse": "DateOfBirth"
            },
            {
                "claimIdInApiResponse": "CustomRoles"
            }
        ]
    }
    ```
    
1. Record the **id** value of the created custom claims provider object. You'll use the value later in this tutorial in place of `{customExtensionObjectId}`.

---

### 2.2 Grant admin consent

After your custom authentication extension is created, you need to grant permissions to the API. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission.

1. Open the **Overview** page of your new custom authentication extension. Take a note of the **App ID** under **API Authentication**, as it'll be needed when adding an identity provider.
1. Under **API Authentication**, select **Grant permission**. 
1. A new window opens, and once signed in, it requests permissions to receive custom authentication extension HTTP requests. This allows the custom authentication extension to authenticate to your API. Select **Accept**. 

    :::image type="content" border="false"source="./media/custom-extension-get-started/custom-extensions-overview.png" alt-text="Screenshot that shows how grant admin consent." lightbox="media/custom-extension-get-started/custom-extensions-overview.png":::

## Step 3: Configure an OpenID Connect app to receive enriched tokens

To get a token and test the custom authentication extension, you can use the <https://jwt.ms> app. It's a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser).

Follow these steps to register the **jwt.ms** web application:

### 3.1 Register a test web application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application. For example, **My Test application**.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. In the **Select a platform** dropdown in **Redirect URI**, select **Web** and then enter `https://jwt.ms` in the URL text box.
1. Select **Register** to complete the app registration.

    :::image type="content" border="false"source="media/custom-extension-get-started/register-test-web-application.png" alt-text="Screenshot that shows how to select the supported account type and redirect URI.":::

1. In the **Overview** page of your app registration, copy the **Application (client) ID**. The app ID is referred to as the `{App_to_enrich_ID}` in later steps. In Microsoft Graph, it's referenced by the **appId** property.

    :::image type="content" border="false"source="media/custom-extension-get-started/get-the-test-application-id.png" alt-text="Screenshot that shows how to copy the application ID.":::

### 3.2 Enable implicit flow

The **jwt.ms** test application uses the implicit flow. Enable implicit flow in your *My Test application* registration:

1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.

### 3.3 Enable your App for a claims mapping policy

A claims mapping policy is used to select which attributes returned from the custom authentication extension are mapped into the token. To allow tokens to be augmented, you must explicitly enable the application registration to accept mapped claims:

1. In your *My Test application* registration, under **Manage**, select **Manifest**.
1. In the manifest, locate the `acceptMappedClaims` attribute, and set the value to `true`.
1. Set the `accessTokenAcceptedVersion` to `2`.
1. Select **Save** to save the changes.

The following JSON snippet demonstrates how to configure these properties.

```json
{
	"id": "22222222-0000-0000-0000-000000000000",
	"acceptMappedClaims": true,
	"accessTokenAcceptedVersion": 2,  
    ...
}
```

> [!WARNING]
> Do not set `acceptMappedClaims` property to `true` for multi-tenant apps, which can allow malicious actors to create claims-mapping policies for your app. Instead [configure a custom signing key](/graph/application-saml-sso-configure-api#option-2-create-a-custom-signing-certificate).

# [Customer tenant](#tab/customer-tenant)
### 3.4 Associate your app with a user flow

For customer tenants, you need to associate your app with a user flow. A user flow defines the authentication methods a customer can use to sign in to your application and the information they need to provide during sign-up. Ensure that you complete the steps in [Add an application to a user flow](~/external-id/customers/how-to-user-flow-add-application.md) before continuing to add *My Test application* to the user flow.

# [Workforce tenant](#tab/workforce-tenant)

Continue to the next step, [Assign a custom claims provider to your app](#step-4-assign-a-custom-claims-provider-to-your-app).

---

## Step 4: Assign a custom claims provider to your app

For tokens to be issued with claims incoming from the custom authentication extension, you must assign a custom claims provider to your application. This is based on the token audience, so the provider must be assigned to the client application to receive claims in an ID token, and to the resource application to receive claims in an access token. The custom claims provider relies on the custom authentication extension configured with the **token issuance start** event listener. You can choose whether all, or a subset of claims, from the custom claims provider are mapped into the token.

Follow these steps to connect the *My Test application* with your custom authentication extension:

# [Microsoft Entra admin center](#tab/entra-admin-center)

To assign the custom authentication extension as a custom claims provider source;

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Under **Manage**, select **All applications**, and then select *My Test application* from the list.
1. From the **Overview** page of *My Test application*, navigate to **Manage**, and select **Single sign-on**.
1. Under **Attributes & Claims**, select **Edit**.

    :::image type="content" border="false"  source="./media/custom-extension-get-started/open-id-connect-based-sign-on.png" alt-text="Screenshot that shows how to configure app claims." lightbox="./media/custom-extension-get-started/open-id-connect-based-sign-on.png":::

1. Expand the **Advanced settings** menu.
1. Next to **Custom claims provider**, select **Configure**.
1. Expand the **Custom claims provider** drop-down box, and select the *Token issuance event* you created earlier.
1. Select **Save**.

Next, assign the attributes from the custom claims provider, which should be issued into the token as claims:

1. Select **Add new claim** to add a new claim. Provide a name to the claim you want to be issued, for example *dateOfBirth*.
1. Under **Source**, select **Attribute**, and choose *customClaimsProvider.dateOfBirth* from the **Source attribute** drop-down box.

    :::image type="content" border="false"  source="media/custom-extension-get-started/manage-claim.png" alt-text="Screenshot that shows how to add a claim mapping to your app." lightbox="media/custom-extension-get-started/manage-claim.png":::

1. Select **Save**.
1. Repeat this process to add the *customClaimsProvider.customRoles*, *customClaimsProvider.apiVersion* and *customClaimsProvider.correlationId* attributes, and the corresponding name. It's a good idea to match the name of the claim to the name of the attribute.

# [Microsoft Graph](#tab/microsoft-graph)

First create an event listener to trigger a custom authentication extension for the *My Test application* using the token issuance start event.

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant you wish to manage your custom authentication extension in.
1. Run the following request. Replace `{App_to_enrich_ID}` with the app ID of *My Test application* recorded earlier. Replace `{customExtensionObjectId}` with the custom authentication extension ID recorded earlier.
    - You need the *EventListener.ReadWrite.All* delegated permission. 

    ```http
    POST https://graph.microsoft.com/beta/identity/authenticationEventListeners
    Content-type: application/json
    
    {
        "@odata.type": "#microsoft.graph.onTokenIssuanceStartListener",
        "conditions": {
            "applications": {
                "includeAllApplications": false,
                "includeApplications": [
                    {
                        "appId": "{App_to_enrich_ID}"
                    }
                ]
            }
        },
        "priority": 500,
        "handler": {
            "@odata.type": "#microsoft.graph.onTokenIssuanceStartCustomExtensionHandler",
            "customExtension": {
                "id": "{customExtensionObjectId}"
            }
        }
    }
    ```

Next, create the claims mapping policy, which describes which claims can be issued to an application from a custom claims provider.

1. Still in Graph Explorer, run the following request. You'll need the *Policy.ReadWrite.ApplicationConfiguration* delegated permission.

    ```http
    POST https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies
    Content-type: application/json

    {
        "definition": [
            "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"CustomClaimsProvider\",\"ID\":\"DateOfBirth\",\"JwtClaimType\":\"dob\"},{\"Source\":\"CustomClaimsProvider\",\"ID\":\"CustomRoles\",\"JwtClaimType\":\"my_roles\"},{\"Source\":\"CustomClaimsProvider\",\"ID\":\"CorrelationId\",\"JwtClaimType\":\"correlationId\"},{\"Source\":\"CustomClaimsProvider\",\"ID\":\"ApiVersion\",\"JwtClaimType\":\"apiVersion \"},{\"Value\":\"tokenaug_V2\",\"JwtClaimType\":\"policy_version\"}]}}"
        ],
        "displayName": "MyClaimsMappingPolicy",
        "isOrganizationDefault": false
    }
    ```

2. Record the `ID` generated in the response, later it's referred to as `{claims_mapping_policy_ID}`.

Get the service principal object ID:

1. Run the following request in Graph Explorer. Replace `{App_to_enrich_ID}` with the **appId** of *My Test Application*.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals(appId='{App_to_enrich_ID}')
    ```

Record the value of **id**.

Assign the claims mapping policy to the service principal of *My Test Application*.

1. Run the following request in Graph Explorer. You'll need the *Policy.ReadWrite.ApplicationConfiguration* and *Application.ReadWrite.All* delegated permission.

    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals/{test_App_Service_Principal_ObjectId}/claimsMappingPolicies/$ref
    Content-type: application/json

    {
        "@odata.id": "https://graph.microsoft.com/v1.0/policies/claimsMappingPolicies/{claims_mapping_policy_ID}"
    }
    ```

---

## Step 5: Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration. Choose one of the following tabs based on your tenant type.

> [!NOTE]
> If the Azure function app is hosted in a different Azure tenant than the tenant in which your custom authentication extension is registered, choose the [Open ID Connect](#52-using-openid-connect-identity-provider) tab.

# [Customer tenant](#tab/customer-tenant)

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you [previously published](#step-1-create-an-azure-function-app).
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **Microsoft** as the identity provider.
1. Select **Customer** as the tenant type.
1. Under **App registration**, enter the `client_id` of the *Azure Functions authentication events API* app registration you [previously created](#step-2-register-a-custom-authentication-extension) when registering the custom claims provider.
1. For the **Issuer URL**, enter the following URL `https://{domainName}.ciamlogin.com/{tenant_id}/v2.0`, where
    - `{domainName}` is the domain name of your customer tenant, in the form `{domainName}.contoso.com`.
    - `{tenantId}` is the tenant ID of your customer tenant.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

    :::image type="content" border="true"  source="media/custom-extension-get-started/add-identity-provider-auth-function-app-customer.png" alt-text="Screenshot that shows how to add authentication to your function app while in a customer tenant." lightbox="media/custom-extension-get-started/add-identity-provider-auth-function-app-customer.png":::

# [Workforce tenant](#tab/workforce-tenant)

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you [previously published](#step-1-create-an-azure-function-app).
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **Microsoft** as the identity provider.
1. Select **Workforce** as the tenant type.
1. Under **App registration** select **Pick an existing app registration in this directory** for the **App registration type**, and pick the *Azure Functions authentication events API* app registration you [previously created](#step-2-register-a-custom-authentication-extension) when registering the custom claims provider.
1. Enter the following issuer URL, `https://login.microsoftonline.com/{tenantId}/v2.0`, where `{tenantId}` is the tenant ID of your workforce tenant.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

    :::image type="content" border="true"  source="media/custom-extension-get-started/add-identity-provider-auth-function-app-workforce.png" alt-text="Screenshot that shows how to add authentication to your function app while in a workforce tenant." lightbox="media/custom-extension-get-started/add-identity-provider-auth-function-app-workforce.png":::

# [OpenID Connect](#tab/openid-connect)

If the Azure Function is hosted under a different tenant than the tenant in which your custom authentication extension is registered, follow these steps to protect your function:

1. Sign in to the [Azure portal](https://portal.azure.com)
1. Navigate and select the function app you previously published.
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **OpenID Connect** as the identity provider.
1. Provide a name, such as *Contoso Microsoft Entra ID*.
1. Under the **Metadata entry**, enter the following URL to the **Document URL**. Replace the `{tenantId}` with your Microsoft Entra tenant ID.

    ```http
    https://login.microsoftonline.com/{tenantId}/v2.0/.well-known/openid-configuration
    ```

1. Under the **App registration**, enter the application ID (client ID) of the *Azure Functions authentication events API* app registration [you created previously](#step-2-register-a-custom-authentication-extension).

1. Next, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator):
    1. Select the *Azure Functions authentication events API* app registration [you created previously](#step-2-register-a-custom-authentication-extension).
    1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
    1. Add a description for your client secret.
    1. Select an expiration for the secret or specify a custom lifetime.
    1. Select **Add**.
    1. Record the **secret's value** for use in your client application code. This secret value is never displayed again after you leave this page.
1. Back to the Azure Function, under the **App registration**, enter the **Client secret**.
1. Unselect the **Token store** option.
1. Select **Add** to add the OpenID Connect identity provider.

---

## Step 6: Test the application

To test your custom claim provider, follow these steps:

# [Customer tenant](#tab/customer-tenant)

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://{domainName}.ciamlogin.com/{tenantId}/oauth2/v2.0/authorize?client_id={App_to_enrich_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```
1. Replace `{domainName}` with your domain name, for example, `contoso`.
1. Replace `{tenant-id}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{App_to_enrich_ID}` with the [My Test application registration ID](#31-get-the-application-id).  
1. Go through the sign in user flow that you've configured, and accept the requested permissions.
1. After logging in, you'll be presented with your decoded token at `https://jwt.ms`. Validate that the claims from the Azure Function are presented in the decoded token, for example, `dateOfBirth`.

# [Workforce tenant](#tab/workforce-tenant)

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/authorize?client_id={App_to_enrich_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```

1. Replace `{tenant-id}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{App_to_enrich_ID}` with the [My Test application registration ID](#31-get-the-application-id).  
1. Go through the sign in user flow that you've configured, and accept the requested permissions.
1. After logging in, you'll be presented with your decoded token at `https://jwt.ms`. Validate that the claims from the Azure Function are presented in the decoded token, for example, `dateOfBirth`.

---

## See also

- Learn how to configure a [SAML application](custom-extension-configure-saml-app.md) to receive tokens with claims sourced from an external store.
- Learn more about custom claims providers with the [custom claims provider reference](custom-claims-provider-reference.md) article.
- Learn how to [troubleshoot your custom authentication extensions API](custom-extension-troubleshoot.md).