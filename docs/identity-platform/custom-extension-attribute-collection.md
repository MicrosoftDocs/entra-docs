---
title: Get started with attribute collection events (preview)
titleSuffix: Microsoft identity platform
description: Learn how to develop and register a Microsoft Entra custom authentication extensions REST API. The custom authentication extension allows you to add logic to attribute collection.  
services: active-directory
author: msmimart
manager: CelesteDG

ms.service: active-directory
ms.subservice: develop
ms.topic: how-to
ms.workload: identity
ms.date: 10/09/2023
ms.author: mimart

#Customer intent: As an application developer, I want to create and register a custom authentication extensions API so I can add logic to the authentication flow before or after attribute collection.
---

# Custom authentication extensions for attribute collection start and submit events

**Applies to:** Microsoft Entra External ID customer configurations

This article describes how to extend the user sign-up experience in Microsoft Entra External ID for customers. In customer sign-up user flows, event listeners can be used to extend the attribute collection process before attribute collection and at the time of attribute submission:

- The **OnAttributeCollectionStart** event occurs at the beginning of the attribute collection step, before the attribute collection page renders. You can add actions such as prefilling values and displaying a blocking error.
- The **OnAttributeCollectionSubmit** event occurs after the user enters and submits attributes. You can add actions such as validating or modifying the user's entries.

In addition to creating a custom authentication extension for the attribute collection start and submit events, you need to create a REST API that defines the workflow actions to take for each event. You can use any programming language, framework, and hosting environment to create and host your REST API. This article demonstrates a quick way to get started using a C# Azure Function. With Azure Functions, you run your code in a serverless environment without having to first create a virtual machine (VM) or publish a web application.

## Prerequisites

- To use Azure services, including Azure Functions, you need an Azure subscription. If you don't have an existing Azure account, you can sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A [sign-up and sign-in user flow](~/external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).

## Step 1: Create a custom authentication extensions REST API (Azure Function app)

[!INCLUDE [portal updates](~/includes/portal-update.md)]

In this step, you create an HTTP trigger function API using Azure Functions. The function API is the source of the business logic for your user flows. Follow these steps to create an Azure Function:

1. Sign in to the [Azure portal](https://portal.azure.com) with your administrator account.

1. From the Azure portal menu or the **Home** page, select **Create a resource**.

1. In the **New** page, select **Compute** > **Function App**.

1. On the **Basics** page, use the function app settings as specified in the following table:

    | Setting      | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Subscription** | Your subscription | The subscription in which the new function app will be created. |
    | **Resource Group** |  *myResourceGroup* | Select and existing resource group, or name for the new one in which you'll create your function app. |
    | **Function App name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`.  |
    |**Publish**| Code | Option to publish code files or a Docker container. For this tutorial, select **Code**. |
    | **Runtime stack** | .NET | Your preferred programming language. For this tutorial, select **.NET**.  |
    |**Version**| 6 | Version of the .NET runtime. |
    |**Region**| Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Operating System** | Windows | The operating system is preselected for you based on your runtime stack selection. |
    | **Plan type** | Consumption (Serverless) | Hosting plan that defines how resources are allocated to your function app.  |

1. Select **Review + create** to review the app configuration selections and then select **Create**.

1. Select the **Notifications** icon in the upper-right corner of the portal and watch for the **Deployment succeeded** message. Then, select **Go to resource** to view your new function app.

### 1.1 Create HTTP trigger functions

Now that you've created the Azure Function app, you create HTTP trigger functions for the actions you want to invoke with an HTTP request. HTTP triggers are referenced and called by your Microsoft Entra custom authentication extension.

1. Within your **Function App**, from the menu select **Functions**.

1. From the top menu, select **+ Create**.

1. In the **Create Function** window, leave the **Development environment** property as **Develop in portal**, and then select the **HTTP trigger** template.

1. Under **Template details**, enter *CustomAuthenticationExtensionsAPI* for the **New Function** property.

1. For the **Authorization level**, select **Function**.

1. Select **Create**

<!--The following screenshot demonstrates how to configure the Azure HTTP trigger function.

:::image type="content" border="false"source="media/custom-extension-attribute-collection/create-http-trigger-function-attribute-collection.png" alt-text="Screenshot that shows how to choose the development environment, and template." lightbox="media/custom-extension-attribute-collection/create-http-trigger-function-attribute-collection.png":::-->

### 1.2 Configure the HTTP trigger for OnAttributeCollectionStart

1. From the menu, select **Code + Test**

1. Select the tab below for the scenario you want to implement: **Continue**, **Block**, or **SetPrefillValues**. Replace the code with the code snippet(s) provided.

# [**Continue**](#tab/start-continue)

Use this HTTP trigger to block the user from continuing the sign-up process. For example, you could use an identity verification service or external identity data source to verify the user's email address. You could also block sign ups based on various user conditions.

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic request = JsonConvert.DeserializeObject(requestBody);


    var actions = new List<ContinueWithDefaultBehavior>{
        new ContinueWithDefaultBehavior { type = "microsoft.graph.attributeCollectionStart.continueWithDefaultBehavior"}
    };

    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionStartResponseData",
        actions= actions
    };

    dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<ContinueWithDefaultBehavior> actions { get; set; }
}

[JsonObject]
public class ContinueWithDefaultBehavior {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
}
```

# [**Block**](#tab/start-block)

Use this HTTP trigger to block the user from continuing the sign-up process. For example, you could use an identity verification service or external identity data source to verify the user's email address.

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    
    dynamic request = JsonConvert.DeserializeObject(requestBody);       

    var actions = new List<BlockedActions>{
        new BlockedActions { 
            type = "microsoft.graph.attributeCollectionStart.showBlockPage", 
            message = "AttributeCollectionStart Custom Extension message: Sorry, your access request has been blocked. Try reaching an admin at admin@contoso.com."
        }
    };

    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionStartResponseData",
        actions= actions
    };

    dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<BlockedActions> actions { get; set; }
}

[JsonObject]
public class BlockedActions {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public string message { get; set; }
}
```

# [**Prefill values**](#tab/start-set-prefill-values)

Use this HTTP trigger to prefill the values associated with the user flow, for example from an external HR system or other data source. You can prefill values for built-in attributes (for example, address), custom user attributes (for example, loyalty number), and attributes that are not shown on the Attribute Collection page but are stored with the user object (for example, the security default setting).

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic request = JsonConvert.DeserializeObject(requestBody);

    //We should see all the attributes we expect to collect with their default values
    var inputs = new Dictionary<string, object>()
    {
        { "postalCode", "12345-This is override Value" },
        { "streetAddress", "One Microsoft Way-This is override Value" },
        { "city", "Tampa-This is override Value" }
    };

    // ModifyAttributesToCollect
    var actions = new List<ModifiedAttributesAction>{
        new ModifiedAttributesAction { 
            type = "microsoft.graph.attributeCollectionStart.setPrefillValues", 
            inputs = inputs }
    };

    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionStartResponseData",
        actions= actions
    };

    dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<ModifiedAttributesAction> actions { get; set; }
}

[JsonObject]
public class ModifiedAttributesAction {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public Dictionary<string, object> inputs { get; set; }
}
```
---

1. After you replace the code, from the top menu, select **Get Function Url**, and copy the URL. You use this URL in [Step 2: Create and register a custom authentication extension](#step-2-create-and-register-a-custom-authentication-extension) for **Target Url**.

### 1.3 Configure the HTTP trigger for OnAttributeCollectionSubmit

1. From the menu, select **Code + Test**

1. Select the tab below for the scenario you want to implement: **Continue**, **Block**, **Modify values**, or **Validation error**. Replace the code with the code snippet(s) provided.

# [Continue](#tab/submit-continue)

Use this HTTP trigger to allow the user to continue with the sign-up flow if no further action is needed.

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic request = JsonConvert.DeserializeObject(requestBody);
    
    var actions = new List<ContinueWithDefaultBehavior>{
        new ContinueWithDefaultBehavior { type = "microsoft.graph.attributeCollectionSubmit.continueWithDefaultBehavior"}
    };
						
    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionSubmitResponseData",
        actions= actions
    };
	    
	dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    
    public List<ContinueWithDefaultBehavior> actions { get; set; }
}

[JsonObject]
public class ContinueWithDefaultBehavior {
    [JsonProperty("@odata.type")]
	public string type { get; set; }
}
```

# [Block](#tab/submit-block)

Use this HTTP trigger to block the user from continuing the sign-up process based on the attribute values they entered. For example, you can block sign-up based on a risky phone number. Or you can terminate the sign-up flow and send the user to a custom approval system for account creation.

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic request = JsonConvert.DeserializeObject(requestBody);
    
    var actions = new List<BlockedActions>{
        new BlockedActions { 
            type = "microsoft.graph.attributeCollectionSubmit.showBlockPage", 
            message = "AttributeCollectionSubmit Custom Extension Message: Thank you so much for your response! Your access request is processing. You'll be notified when your request has been approved."
        }
    };

    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionSubmitResponseData",
        actions= actions
    };

    dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<BlockedActions> actions { get; set; }
}

[JsonObject]
public class BlockedActions {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public string message { get; set; }
}
```

# [Modify values](#tab/submit-modify-collected-values)

Use this HTTP trigger to modify attributes collection from the user. For example, you can change the format of a user-provided attribute. Or you can use an attribute to set the value for a hidden security defaults custom attribute. After attributes are modified, sign-up continues without notification to user. If notification is required, use the validate action.

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");

    // Put UserSignUpInfo as override for one of the attributes
    var attributes = new Dictionary<string, object>()
    {
        { "postalCode", "98007" },
        { "streetAddress", "222 Assigned St" },
        { "city", "Bellevue" }
    };

    // ModifyAttributesToCollect
    var actions = new List<ModifiedAttributesAction>{
        new ModifiedAttributesAction { 
            type = "microsoft.graph.attributeCollectionSubmit.modifyAttributeValues", 
            attributes = attributes 
        }
    };

    log.LogInformation("actions: " + actions);

    var dataObject = new Data {
        type = "microsoft.graph.onAttributeCollectionSubmitResponseData",
        actions= actions
    };

    //var dataCoverted = JsonConvert.SerializeObject(dataObject);

    dynamic response = new ResponseObject {
        data = dataObject
    };

    // Send the response
    return response;
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<ModifiedAttributesAction> actions { get; set; }
}

[JsonObject]
public class ModifiedAttributesAction {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public Dictionary<string, object> attributes { get; set; }
}
```

# [Validation error](#tab/submit-show-validation-error)

Use this HTTP trigger to validate attributes entered by the user. For example, you can validate attributes against an external data store. You can validate built-in attributes (for example, country), custom user attributes (for example, loyalty number), and attributes that are not shown on Attribute Collection page but are stored with the user object (for example, the “security default” setting).

```csharp
#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;

public static async Task<object> Run(HttpRequest req, ILogger log)
{
    log.LogInformation($"C# HTTP trigger function processed a request.");

    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    dynamic request = JsonConvert.DeserializeObject(requestBody);

    // Parse specified attributes
    string cityValue = (JsonConvert.SerializeObject(request?.data?.userSignUpInfo?.attributes?.city?.value)).ToString();

    string postalCodeValue = (JsonConvert.SerializeObject(request?.data?.userSignUpInfo?.attributes?.postalCode?.value)).ToString();

    string streetAddressValue = (JsonConvert.SerializeObject(request?.data?.userSignUpInfo?.attributes?.streetAddress?.value)).ToString();

    // JSON convert makes the length different, so we put 7 here
    if(cityValue.Length < 7 || postalCodeValue.Length < 7 || streetAddressValue.Length < 7){
        var inputs = new Dictionary<string, string>();

        if(cityValue.Length < 7){
            inputs.Add("city", "Length of city string should be of at 5 characters at least");
        }

        if(postalCodeValue.Length < 7){
            inputs.Add("postalCode", "Length of postalCodeValue string should be of at 5 characters at least");
        }

        if(streetAddressValue.Length < 7){
            inputs.Add("streetAddress", "Length of streetAddress string should be of at 5 characters at least");
        }

        string pageMessage = "Please fix below errors to proceed";

        var actions = new List<ValidationErrorActions>{
            new ValidationErrorActions { type = "microsoft.graph.attributeCollectionSubmit.ShowValidationError", message = pageMessage, attributeErrors = inputs }
        };

        
        var dataObject = new Data {
            type = "microsoft.graph.onAttributeCollectionSubmitResponseData",
            actions= actions
        };

        dynamic response = new ResponseObject {
            data = dataObject
        };

        log.LogInformation($"Returning validation error");
        // Send the validation error response
        return response;
    }else{
        var actions = new List<ContinueWithDefaultBehavior>{
            new ContinueWithDefaultBehavior { type = "microsoft.graph.attributeCollectionSubmit.ContinueWithDefaultBehavior"}
            };

        
        var dataObject = new DataContinue {
            type = "microsoft.graph.onAttributeCollectionSubmitResponseData",
            actions= actions
            };

        dynamic response = new ResponseObjectContinue {
            data = dataObject
        };

        log.LogInformation($"Returning continue");
        
        // Send the continue response
        return response;
    }
}

public class ResponseObject
{
    public Data data { get; set; }
}

[JsonObject]
public class Data {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<ValidationErrorActions> actions { get; set; }
}

[JsonObject]
public class ValidationErrorActions {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public string message { get; set; }
    public Dictionary<string, string> attributeErrors {get; set;}
}


public class ResponseObjectContinue
{
    public DataContinue data { get; set; }
}

[JsonObject]
public class DataContinue {
    [JsonProperty("@odata.type")]
    public string type { get; set; }
    public List<ContinueWithDefaultBehavior> actions { get; set; }
}

[JsonObject]
public class ContinueWithDefaultBehavior {
    [JsonProperty("@odata.type")]
	public string type { get; set; }
}
```
---

1. After you replace the code, from the top menu, select **Get Function Url**, and copy the URL. You'll use this URL in [Step 2: Create and register a custom authentication extension](#step-2-create-and-register-a-custom-authentication-extension) for **Target Url**.

## Step 2: Create and register a custom authentication extension

In this step, you register a custom authentication extension that is used by Microsoft Entra ID to call your Azure function. The custom authentication extension contains information about your REST API endpoint, the attribute collection start and submit actions that it parses from your REST API, and how to authenticate to your REST API. Follow these steps to register a custom authentication extension:

# [Microsoft Entra admin center](#tab/entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an  [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).

1. Browse to **Identity** > **External Identities** > **Custom authentication extensions**.

1. Select **Create a custom extension**.

1. In **Basics**, select the **AttributeCollectionStart** event or the **AttributeCollectionSubmit** event, and then select **Next**.

1. In **Endpoint Configuration**, fill in the following properties:

    - **Name** - A name for your custom authentication extension. For example, *On Attribute Collection Event*.
    - **Target Url** - The `{Function_Url}` of your Azure Function URL.
    - **Description** - A description for your custom authentication extensions.

1. Select **Next**.

1. In **API Authentication**, select the **Create new app registration** option to create an app registration that represents your *function app*.  

1. Give the app a name, for example **Azure Functions authentication events API**.

1. Select **Next**.

1. Select **Create**, which creates the custom authentication extension and the associated application registration.
<!--
# [Microsoft Graph](#tab/microsoft-graph)

Register an application to authenticate your custom authentication extension to your Azure Function.

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant you wish to manage your custom authentication extension in. The account must have the privileges to create and manage an application registration in the tenant.
2. Run the following request.

    # [HTTP](#tab/http)
    ```http
    POST https://graph.microsoft.com/v1.0/applications
    Content-type: application/json
    
    {
        "displayName": "authenticationeventsAPI"
    }
    ```

    # [C#](#tab/csharp)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/csharp/v1/tutorial-application-basics-create-app-csharp-snippets.md)]
    
    # [Go](#tab/go)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/go/v1/tutorial-application-basics-create-app-go-snippets.md)]
    
    # [Java](#tab/java)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/java/v1/tutorial-application-basics-create-app-java-snippets.md)]
    
    # [JavaScript](#tab/javascript)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/javascript/v1/tutorial-application-basics-create-app-javascript-snippets.md)]
    
    # [PHP](#tab/php)
    Snippet not available.
    
    # [PowerShell](#tab/powershell)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/powershell/v1/tutorial-application-basics-create-app-powershell-snippets.md)]
    
    # [Python](#tab/python)
    [!INCLUDE [sample-code](~/microsoft-graph/includes/snippets/python/v1/tutorial-application-basics-create-app-python-snippets.md)]
    
    ---

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
   - You'll need the *CustomAuthenticationExtension.ReadWrite.All* delegated permission. 

    # [HTTP](#tab/http)
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
    # [C#](#tab/csharp)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/csharp/create-customauthenticationextension-from--csharp-snippets.md)]
    
    # [Go](#tab/go)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/go/create-customauthenticationextension-from--go-snippets.md)]
    
    # [Java](#tab/java)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/java/create-customauthenticationextension-from--java-snippets.md)]
    
    # [JavaScript](#tab/javascript)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/javascript/create-customauthenticationextension-from--javascript-snippets.md)]
    
    # [PHP](#tab/php)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/php/create-customauthenticationextension-from--php-snippets.md)]
    
    # [PowerShell](#tab/powershell)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/powershell/create-customauthenticationextension-from--powershell-snippets.md)]
    
    # [Python](#tab/python)
    [!INCLUDE [sample-code](~/microsoft-graph/api-reference/beta/includes/snippets/python/create-customauthenticationextension-from--python-snippets.md)]

    ---

1. Record the **id** value of the created custom claims provider object. You'll use the value later in this tutorial in place of `{customExtensionObjectId}`.
-->
---

### 2.2 Grant admin consent

After your custom authentication extension is created, grant application consent to the registered app, which allows the custom authentication extension to authenticate to your API.

1. Browse to **Identity** > **External Identities** > **Custom authentication extensions (Preview)**.

1. Select your custom authentication extension from the list.

1. On the **Overview** tab, select the **Grant permission** button to give admin consent to the registered app. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission.

<!--The following screenshot shows how to grant permissions.

:::image type="content" border="false"source="./media/custom-extension-attribute-collection/custom-extensions-overview.png" alt-text="Screenshot that shows how grant admin consent." lightbox="media/custom-extension-get-started/custom-extensions-overview.png":::-->

## Step 3: Add the custom authentication extension to a user flow

Now you can associate the custom authentication extension with one or more of your user flows.

> [!NOTE]
> If you need to create a user flow, follow the steps in [Create a sign-up and sign-in user flow for customers](~/external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).

### 3.1 Add the custom authentication extension to an existing user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an  [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator)

1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="media/common/portal-directory-subscription-filter.png" border="false"::: in the top menu to switch to your customer tenant. 

1. Browse to **Identity** > **External Identities** > **User flows**.

1. Select the user flow from the list.

1. Select **Custom authentication extensions**.

1. On the **Custom authentication extensions** page, you can associate your custom authentication extension with two different steps in your user flow:

   - **Before collecting information from the user** is associated with the OnAttributeCollectionStart event. Select the edit pencil. only those custom extensions configured for the OnAttributeCollectionStart event will be displayed. Select the application you configured for the attribute collection start event, and then choose **Select**.
   - **When a user submits their information** is associated with the OnAttributeCollectionSubmit event. only those custom extensions configured for the OnAttributeCollectionSubmit event will be displayed. Select the application you configured for the attribute collection submit event, and then choose **Select**.

1. Make sure the applications listed next to both attribute collection steps are correct.

1. Select the **Save** icon.

## Step 4: Test the application

To get a token and test the custom authentication extension, you can use the <https://jwt.ms> app. It's a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser).

Follow these steps to register the **jwt.ms** web application:

### 4.1 Register the jwt.ms web application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. Browse to **Identity** > **Applications** > **Application registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application. For example, **My Test application**.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. In the **Select a platform** dropdown in **Redirect URI**, select **Web** and then enter `https://jwt.ms` in the URL text box.
1. Select **Register** to complete the app registration.

<!--The following screenshot shows how to register the *My Test application*.

:::image type="content" border="false"source="media/custom-extension-get-started/register-test-web-application.png" alt-text="Screenshot that shows how to select the supported account type and redirect URI.":::-->

### 4.2 Get the application ID

In your app registration, under **Overview**, copy the **Application (client) ID**. The app ID is referred to as the `{App_to_enrich_ID}` in later steps. In Microsoft Graph, it's referenced by the **appId** property.

<!-->:::image type="content" border="false"source="media/custom-extension-get-started/get-the-test-application-id.png" alt-text="Screenshot that shows how to copy the application ID.":::-->

### 4.3 Enable implicit flow

The **jwt.ms** test application uses the implicit flow. Enable implicit flow in your *My Test application* registration:

1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.

## 4.4 Test the application

To test your custom authentication extension, follow these steps:

1. Open a new private browser and navigate to the following URL:

    ```http
    https://<domainName>.ciamlogin.com/<tenant_id>/oauth2/v2.0/authorize?client_id=<client_id>&response_type=code+id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```

   - Replace `domainName>` with your customer tenant name, and replace `<tenant-id>` with your customer tenant ID.
   - Replace `<client_id>` with the ID for the application you added to the user flow.

1. After signing in, you'll be presented with your decoded token at `https://jwt.ms`.

## Step 5: Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration.

> [!NOTE]
> If the Azure function app is hosted in a different Azure tenant than the tenant in which your custom authentication extension is registered, skip to [5.1 Using OpenID Connect identity provider](#51-using-openid-connect-identity-provider) step.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you previously published.
1. Select **Authentication** in the menu on the left.
1. Select **Add Identity provider**.  
1. Select **Microsoft** as the identity provider.
1. Under **App registration**->**App registration type**, select **Pick an existing app registration in this directory** and pick the *Azure Functions authentication events API* app registration you [previously created](#step-2-create-and-register-a-custom-authentication-extension) when registering the custom claims provider.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

    :::image type="content" border="true"  source="media/custom-extension-attribute-collection/configure-auth-function-app.png" alt-text="Screenshot that shows how to add authentication to your function app." lightbox="media/custom-extension-attribute-collection/configure-auth-function-app.png":::

### 5.1 Using OpenID Connect identity provider

If you configured [Step 5: Protect your Azure Function](#step-5-protect-your-azure-function), skip this step. Otherwise, if the Azure Function is hosted under a different tenant than the tenant in which your custom authentication extension is registered, follow these steps to protect your function:

1. Sign in to the [Azure portal](https://portal.azure.com), then navigate and select the function app you previously published.
1. Select **Authentication** in the menu on the left.
1. Select **Add Identity provider**.  
1. Select **OpenID Connect** as the identity provider.
1. Provide a name, such as *Contoso Microsoft Entra ID*.
1. Under the **Metadata entry**, enter the following URL to the **Document URL**. Replace the `{tenantId}` with your Microsoft Entra tenant ID.

    ```http
    https://login.microsoftonline.com/{tenantId}/v2.0/.well-known/openid-configuration
    ```

1. Under the **App registration**, enter the application ID (client ID) of the *Azure Functions authentication events API* app registration you [previously created](#step-2-create-and-register-a-custom-authentication-extension).

1. In the Microsoft Entra admin center:
    1. Select the *Azure Functions authentication events API* app registration you [previously created](#step-2-create-and-register-a-custom-authentication-extension).
    1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
    1. Add a description for your client secret.
    1. Select an expiration for the secret or specify a custom lifetime.
    1. Select **Add**.
    1. Record the **secret's value** for use in your client application code. This secret value is never displayed again after you leave this page.
1. Back to the Azure Function, under the **App registration**, enter the **Client secret**.
1. Unselect the **Token store** option.
1. Select **Add** to add the OpenID Connect identity provider.

## Next steps
