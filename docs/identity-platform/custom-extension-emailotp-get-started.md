---
title: Configure a custom email provider for one time code send events (preview)
description: Learn how to configure and set up a custom email provider with the One Time Code Send event type. 
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.reviewer: almars
ms.date: 9/30/2024
ms.service: identity-platform
ms.topic: how-to
titleSuffix: Microsoft identity platform
#customer intent: As a Microsoft Entra External ID customer, I want to learn how to configure a custom email provider for one time code send events, so that I can use my own email provider to send one time codes.
---

# Configure a custom email provider for one time code send events (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This article provides a guide on configuring and setting up a custom email provider for the One Time Code Send event type. The event is triggered when a one time code email is activated, it allows you to call a REST API to use your own email provider by calling a REST API.

> [!TIP]
> [![Try it now](media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CustomEmailOTP)
>
> To try out this feature, go to the Woodgrove Groceries demo and start the “Use a custom Email Provider for One Time code” use case.

## Prerequisites

- A familiarity and understanding of the concepts covered in [custom authentication extensions](/entra/identity-platform/custom-extension-overview).
- An Azure subscription. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A Microsoft Entra ID [external tenant](../external-id/customers/quickstart-tenant-setup.md).
- For Azure Communications Services users;
    - An Azure Communications Services resource. If you don't have one, create one in [Quickstart: Create and manage Communication Services resources](/azure/communication-services/quickstarts/create-communication-resource?tabs=windows&pivots=platform-azp) using a new or existing resource group.
    - An Azure Email Communication Services Resource created and ready with a provisioned domain. If you don't have one, refer to [Quickstart: Create and manage Email Communication Service resources](/azure/communication-services/quickstarts/email/create-email-communication-resource?pivots=platform-azp), and use the same resource group as the Azure Communication Services.
    - An active Communication Services resource connected with an Email Domain. Refer to [Quickstart: How to connect a verified email domain](/azure/communication-services/quickstarts/email/connect-email-communication-resource?branch=main&pivots=azure-portal)
    - (Optional) [Send an email using Azure Communication Services](/azure/communication-services/quickstarts/email/send-email?tabs=windows%2Cconnection-string%2Csend-email-and-get-status-async%2Csync-client&pivots=platform-azportal) to test sending emails to the desired recipients using Azure Communication Services, while verifying the configuration for your application to send email.
- For SendGrid users:
    - A SendGrid account. If you don't already have one, start by setting up a SendGrid account. For setup instructions, see the [Create a SendGrid Account](https://docs.sendgrid.com/for-developers/partners/microsoft-azure-2021#create-a-sendgrid-account) section of [How to send email using SendGrid with Azure](https://docs.sendgrid.com/for-developers/partners/microsoft-azure-2021#create-a-twilio-sendgrid-accountcreate-a-twilio-sendgrid-account).

## Step 1: Create an Azure Function app

This section shows you how to set up an Azure Function app in the Azure portal. The function API is the gateway to your email provider. You create an Azure Function app to host the HTTP trigger function and configure the settings in the function.

> [!TIP]
> Steps in this article might vary slightly based on the portal you start from.

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. From the Azure portal menu or the **Home** page, select **Create a resource**.
1. Search for and select **Function App** and select **Create**.
1. On the **Create Function App** page, select **Consumption**, then **Select**.
1. On the **Create Function App (Consumption)** page, in the **Basics** tab, create a function app using the settings as specified in the following table:

    | Setting      | Suggested value  | Description |
    | ------------ | ---------------- | ----------- |
    | **Subscription** | Your subscription | The subscription under which the new function app is created. |
    | **[Resource Group](/azure/azure-resource-manager/management/overview)** |  *myResourceGroup* | Select the resource group used to set up the [Azure Communications Service](/azure/communication-services/quickstarts/create-communication-resource?tabs=windows&pivots=platform-azp) and [Email Communication Service](/azure/communication-services/quickstarts/email/create-email-communication-resource?pivots=platform-azp) resources as part of the prerequisites |
    | **Function App name** | Globally unique name | A name that identifies the new function app. Valid characters are `a-z` (case insensitive), `0-9`, and `-`.  |
    | **Deploy code or container image** | Code | Option to publish code files or a Docker container. For this tutorial, select **Code**. |
    | **Runtime stack** | .NET | Your preferred programming language. For this tutorial, select **.NET**.  |
    | **Version** | 8 (LTS) In-process | Version of the .NET runtime. In-process signifies that you can create and modify functions in the portal, which is recommended for this guide |
    | **Region** | Preferred region | Select a [region](https://azure.microsoft.com/regions/) that's near you or near other services that your functions can access. |
    | **Operating System** | Windows | The operating system is preselected for you based on your runtime stack selection. |

1. Select **Review + create** to review the app configuration selections and then select **Create**. Deployment takes a few minutes.
1. Once deployed, select **Go to resource** to view your new function app.

### 1.1 Create an HTTP trigger function

After the Azure Function app is created, create an HTTP trigger function. The HTTP trigger lets you invoke a function with an HTTP request. This HTTP trigger is referenced by your Microsoft Entra custom authentication extension.

1. Within your **Function App**, from the menu select **Functions**.
1. Select **Create function**.
1. In the **Create Function** window, under **Select a template**, search for and select the **HTTP trigger** template. Select **Next**.
1. Under **Template details**, enter *CustomAuthenticationExtensionsAPI* for the **Function Name** property.
1. For the **Authorization level**, select **Function**.
1. Select **Create**.

### 1.2 Edit the function

The code starts with reading the incoming JSON object. Microsoft Entra ID sends the [JSON object](/entra/identity-platform/custom-claims-provider-reference) to your API. In this example, it reads the email address (identifier) and the one time code (OTP). Then, the code sends the details to the communications service to send the email using a [dynamic template](https://sendgrid.com/en-us/solutions/email-api/dynamic-email-templates).

This how-to guide demonstrates the OTP send event using Azure Communication Services and SendGrid. Use the tabs to select your implementation.

### [Azure Communication Services](#tab/azure-communication-services)

1. From the menu, select **Code + Test**.
1. Replace the entire code with the following code snippet.

    :::code language="csharp" source="~/../custom-authentication-extension/OnOtpSend/CustomEmailACS.cs":::

1. Select **Get Function Url**, and copy the **Function key** URL, which is henceforth used and referred to as `{Function_Url}`. Close the function.

### [SendGrid](#tab/sendgrid)

1. From the menu, select **Code + Test**.
1. Replace the entire code with the following code snippet.

    :::code language="csharp" source="~/../custom-authentication-extension/OnOtpSend/CustomEmailSendGrid.cs":::

1. Select **Get Function Url**, and copy the **Function key** URL, which is henceforth used and referred to as `{Function_Url}`. Close the function.
---

## Step 2: Add connection strings to the Azure Function

Connection strings enable the Communication Services SDKs to connect and authenticate to Azure. For both Azure Communication Services and SendGrid You'll then need to add these connection strings to your Azure Function app as environment variables.

### [Azure Communication Services](#tab/azure-communication-services)

### 2.1: Extract the connection strings and service endpoints from your Azure Communication Services resource

You can access your Communication Services connection strings and service endpoints from the Azure portal or programmatically with Azure Resource Manager APIs.

1. From the **Home** page in the [Azure portal](https://portal.azure.com/#home), open the portal menu, search for and select **All resources**.
1. Search for and select the **Azure Communications Service** created as part of the [Prerequisites](#prerequisites) to this article.
1. In the left pane, select the **Settings** dropdown, then select **Keys**.
1. Copy the **Endpoint**, and from **Primary key** copy the values for **Key** and **Connection string**.

    :::image type="content" border="false"source="media/custom-extension-emailotp-get-started/extract-communications-service-keys.png" alt-text="Screenshot of the Azure Communications Service Keys page showing the endpoint and key locations." lightbox="media/custom-extension-emailotp-get-started/extract-communications-service-keys.png":::

### 2.2: Add the connection strings to the Azure Function

1. Navigate back to the Azure Function you created in [Create an Azure Function app](#11-create-an-http-trigger-function).
1. From **Overview** page of your function app, in the left menu, select **Settings** > **Environment variables** add the following App settings. Once all the settings are added, select **Apply**, then **Confirm**.

    | Setting      | Value (Example) | Description |
    | ------------ | ---------------- | ----------- |
    | **mail_connectionString** | A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u | The Azure Communication Services Primary Key. | 
    | **mail_sender** | <from.email@myemailprovider.com> | The from email address. |
    | **mail_subject** | CIAM Demo | The subject of the email. |

### [SendGrid](#tab/sendgrid)

### 2.1: Add the connection strings to the Azure Function 

1. Navigate back to the Azure Function you created in [Create an Azure Function app](#11-create-an-http-trigger-function).
1. From **Overview** page of your function app, in the left menu, select **Settings** > **Environment variables** add the following App settings. Once all the settings are added, select **Apply**, then **Confirm**.

    | Setting      | Value (Example) | Description |
    | ------------ | ---------------- | ----------- |
    | **mail_sendgridKey** | SG.12a3456789... | The SendGrid API Key. | 
    | **mail_sender** | <from.email@myemailprovider.com> | The from email address. |
    | **mail_senderName** | CIAM Demo | The name of the From Email. |
    | **mail_template** | d-01234567.... | The SendGrid dynamic template ID. |

---

## Step 3: Register a custom authentication extension

In this step, you configure a custom authentication extension, which Microsoft Entra ID uses to call your Azure Function. The custom authentication extension contains information about your REST API endpoint, the claims that it parses from your REST API, and how to authenticate to your REST API. Use either the Azure portal or Microsoft Graph to register an application to authenticate your custom authentication extension to your Azure Function.

### [Azure portal](#tab/azure-portal)

### Register a custom authentication extension

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Search for and select **Microsoft Entra ID** and select **Enterprise applications**.
1. Select **Custom authentication extensions**, and then select **Create a custom extension**.
1. In **Basics**, select the **EmailOtpSend** event type and select **Next**.
1. In the **Endpoint Configuration** tab, fill in the following properties, then select **Next** to continue.
    - **Name** - A name for your custom authentication extension. For example, *Email OTP Send*.
    - **Target Url** - The `{Function_Url}` of your Azure Function URL. Navigate to the **Overview** page of your Azure Function app, then select the function you created. In the function **Overview** page, select **Get Function Url** and use the copy icon to copy the **customauthenticationextension_extension (System key)** URL.
    - **Description** - A description for your custom authentication extensions.
1. In the **API Authentication** tab, select the **Create new app registration** option to create an app registration that represents your *function app*.  
1. Give the app a name, for example **Azure Functions authentication events API**, and select **Next**.
1. In the **Applications** tab, select the application to associate with the custom authentication extension. Select **Next**. You have the option to apply it across the whole tenant by checking the box. Select **Next** to continue. 
1. In the **Review** tab, check that the details are correct for the custom authentication extension. Note the **App ID** under **API Authentication**, which is needed to [configure authentication for your Azure Function](./custom-extension-tokenissuancestart-setup.md#configure-authentication-for-your-azure-function) in your Azure Function app. Select **Create**.

### [Microsoft Graph](#tab/microsoft-graph)

### 3.1 Register an application in Graph Explorer

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant you wish to manage your custom authentication extension in. The account must have the privileges to create and manage an application registration in the tenant.
1. Run the following request.

    ```http
    POST https://graph.microsoft.com/v1.0/applications
    Content-type: application/json
    
    {
        "displayName": "authenticationeventsAPI"
    }
    ```

1. From the response, record the value of **id** and **appId** of the newly created app registration. These values are referenced in this article as `{authenticationeventsAPI_ObjectId}` and `{authenticationeventsAPI_AppId}` respectively.
1. Create a service principal in the tenant for the **authenticationeventsAPI** app registration.
1. Run the following request in Graph Explorer. Replace `{authenticationeventsAPI_AppId}` with the value of **appId** that you recorded from the previous step.

    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals
    Content-type: application/json
        
    {
        "appId": "{authenticationeventsAPI_AppId}"
    }
    ```

### 3.2 Set the App ID URI, access token version, and required resource access

Update the newly created application to set the application ID URI value, the access token version, and the required resource access.

1. In Graph Explorer, run the following request.

- Set the application ID URI value in the *identifierUris* property. Replace `{Function_Url_Hostname}` with the hostname of the `{Function_Url}` you recorded earlier.
- Set the `{authenticationeventsAPI_AppId}` value with the **appId** that you recorded earlier.
- An example value is `api://authenticationeventsAPI.azurewebsites.net/00001111-aaaa-2222-bbbb-3333cccc4444`. Take note of this value as it's needed later in this article in place of `{functionApp_IdentifierUri}`.

    ```http
    PATCH https://graph.microsoft.com/v1.0/applications/{authenticationeventsAPI_ObjectId}
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

### 3.3 Register a custom authentication extension

Next, you register the custom authentication extension and associating it with the app registration for the Azure Function, and your Azure Function endpoint `{Function_Url}`.

1. In Graph Explorer, run the following request. Replace `{Function_Url}` with the hostname of your Azure Function app. Replace `{functionApp_IdentifierUri}` with the identifierUri used in the previous step.
   - You need the *CustomAuthenticationExtension.ReadWrite.All* delegated permission.

    ```http
    POST https://graph.microsoft.com/beta/identity/customAuthenticationExtensions
    Content-type: application/json
    
    {
        "@odata.type": "#microsoft.graph.OnOtpSendCustomExtension",
        "displayName": "onEmailOtpSendCustomExtension",
        "description": "Use an external Email provider to send OTP Codes.",
        "authenticationConfiguration": {
            "@odata.type": "#microsoft.graph.azureAdTokenAuthentication",
            "resourceId": "{functionApp_IdentifierUri}"
        },
        "endpointConfiguration": {
            "@odata.type": "#microsoft.graph.httpRequestEndpoint",
            "targetUrl": "{Function_Url}"
        }
    }
    ```

1. Record the **id** value of the created custom email OTP provider object, which is used later in this article in place of `{customExtensionObjectId}`.

### 3.4 Assign a custom email provider to your app

To use the custom emails, you must assign a custom email provider to your application. The custom email provider relies on the custom authentication extension configured with the **one time code send** event listener. 

Follow these steps to connect the *My Test application* with your custom authentication extension:

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant you wish to manage your custom authentication extension in.
1. Run the following request. Replace `{App_to_sendotp_ID}` with the app ID of *My Test application* recorded earlier. Replace `{customExtensionObjectId}` with the custom authentication extension ID recorded earlier.
    - You need the *EventListener.ReadWrite.All* delegated permission.

    ```json
    POST https://graph.microsoft.com/beta/identity/authenticationEventListeners
    Content-type: application/json

    {
        "@odata.type": "#microsoft.graph.onEmailOtpSendListener",
        "conditions": {
            "applications": {
                "includeAllApplications": false,
                "includeApplications": [
                    {
                        "appId": "{App_to_sendotp_ID}"
                    }
                ]
            }
        },
        "priority": 500,
        "handler": {
            "@odata.type": "#microsoft.graph.onOtpSendCustomExtensionHandler",
            "customExtension": {
                "id": "{customExtensionObjectId}"
            }
        }
    }
    ```

1. Record the **id** value of the created listener object, which is used later in this article in place of `{customListenerOjectId}`.

---

### Grant admin consent

After your custom authentication extension is created, open the application from the portal under **App registrations** and select **API permissions**.

From the **API permissions** page, select the **Grant admin consent for "YourTenant"** button to give admin consent to the registered app, which allows the custom authentication extension to authenticate to your API. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission.

The following screenshot shows how to grant permissions.

:::image type="content" border="false"source="media/custom-extension-emailotp-get-started/application-grantconsent.png" alt-text="Screenshot of Azure portal and how to grant admin consent." lightbox="media/custom-extension-emailotp-get-started/application-grantconsent.png":::

## Step 4: Configure an OpenID Connect app to test with

To get a token and test the custom authentication extension, you can use the <https://jwt.ms> app. It's a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser).

Follow these steps to register the **jwt.ms** web application:

### 4.1 Register a test web application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-developer).
1. Browse to **Identity** > **Applications** > **Application registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application. For example, **My Test application**.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. In the **Select a platform** dropdown in **Redirect URI**, select **Web**, and then enter `https://jwt.ms` in the URL text box.
1. Select **Register** to complete the app registration.
1. In your app registration, under **Overview**, copy the **Application (client) ID**, which is used later and referred to as the `{App_to_sendotp_ID}`. In Microsoft Graph, it's referenced by the **appId** property.

The following screenshot shows how to register the *My Test application*.

:::image type="content" border="false"source="media/custom-extension-emailotp-get-started/register-test-web-application.png" alt-text="Screenshot that shows how to select the supported account type and redirect URI." lightbox="media/custom-extension-emailotp-get-started/register-test-web-application.png":::

### 4.1 Get the application ID

In your app registration, under **Overview**, copy the **Application (client) ID**. The app ID is referred to as the `{App_to_sendotp_ID}` in later steps. In Microsoft Graph, it's referenced by the **appId** property.

### 4.2 Enable implicit flow

The **jwt.ms** test application uses the implicit flow. Enable implicit flow in *My Test application* registration:

1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.

> [!NOTE]
> 
> The **jwt.ms** app uses the implicit flow to get an ID token and is for testing purposes only. The implicit flow is not recommended for production applications. For production applications, use the authorization code flow.

## Step 5: Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration.

> [!NOTE]
> If the Azure function app is hosted in a different Azure tenant than the tenant in which your custom authentication extension is registered, skip to [using OpenID Connect identity provider](#51-using-openid-connect-identity-provider) step.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate and select the function app you previously published.
1. Select **Authentication** in the menu on the left.
1. Select **Add Identity provider**.  
1. From the dropdown menuSelect **Microsoft** as the identity provider.
1. Under **App registration**->**App registration type**, select **Pick an existing app registration in this directory** and pick the *Azure Functions authentication events API* app registration you [previously created](#step-3-register-a-custom-authentication-extension) when registering the custom email provider.
1. Add the **Client secret** expiration for the app.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

:::image type="content" border="false"source="media/custom-extension-emailotp-get-started/configure-auth-function-app.png" alt-text="Screenshot that shows how to add authentication to your function app." lightbox="media/custom-extension-emailotp-get-started/configure-auth-function-app.png":::

### 5.1 Using OpenID Connect identity provider

If you configured the [Microsoft identity provider](#step-5-protect-your-azure-function), skip this step. Otherwise, if the Azure Function is hosted under a different tenant than the tenant in which your custom authentication extension is registered, follow these steps to protect your function:

1. Sign in to the [Azure portal](https://portal.azure.com), then navigate and select the function app you previously published.
1. Select **Authentication** in the left pane.
1. Select **Add Identity provider**.  
1. Select **OpenID Connect** as the identity provider.
1. Provide a name, such as *Contoso Microsoft Entra ID*.
1. Under the **Metadata entry**, enter the following URL to the **Document URL**. Replace the `{tenantId}` with your Microsoft Entra tenant ID, and `{tenantname}` with the name of your tenant without the 'onmicrosoft.com'.

    ```http
    https://{tenantname}.ciamlogin.com/{tenantId}/v2.0/.well-known/openid-configuration
    ```

1. Under the **App registration**, enter the application ID (client ID) of the *Azure Functions authentication events API* app registration [you created previously](#step-3-register-a-custom-authentication-extension).

1. In the Microsoft Entra admin center:
    1. Select the *Azure Functions authentication events API* app registration [you created previously](#step-3-register-a-custom-authentication-extension).
    1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
    1. Add a description for your client secret.
    1. Select an expiration for the secret or specify a custom lifetime.
    1. Select **Add**.
    1. Record the **secret's value** for use in your client application code. This secret value is never displayed again after you leave this page.
1. Back to the Azure Function, under the **App registration**, enter the **Client secret**.
1. Unselect the **Token store** option.
1. Select **Add** to add the OpenID Connect identity provider.

## Step 6: Test the application

To test your custom email provider, follow these steps:

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://{tenantname}.ciamlogin.com/{tenant-id}/oauth2/v2.0/authorize?client_id={App_to_sendotp_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```

1. Replace `{tenant-id}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{tenantname}` with the name of your tenant without the 'onmicrosoft.com'.
1. Replace `{App_to_sendotp_ID}` with the [My Test application registration ID](#41-get-the-application-id).  
1. Ensure you sign in using an [Email One Time Passcode account](/entra/external-id/one-time-passcode). Then select **Send Code**. Ensure that the code sent to the registred email addresses uses the custom provider registered above.

## Step 7: Fall back to Microsoft Provider

If an error occurs within your extension API, by default Entra ID will not send a one time code to the user. You can instead set the behavior on error to fall back to the Microsoft Provider.

To enable this, run the following request. Replace `{customListenerOjectId}` with the custom authentication listener ID recorded earlier.

- You need the *EventListener.ReadWrite.All* delegated permission.

```json
PATCH https://graph.microsoft.com/beta/identity/authenticationEventListeners/{customListenerOjectId}

{
    "@odata.type": "#microsoft.graph.onEmailOtpSendListener",
    "handler": {
        "@odata.type": "#microsoft.graph.onOtpSendCustomExtensionHandler",
        "configuration": {
            "behaviorOnError": {
                "@odata.type": "#microsoft.graph.fallbackToMicrosoftProviderOnError"
            }
        }
    }
}
```

## See also

- [Configure a custom claim provider for a token issuance event](custom-extension-tokenissuancestart-configuration.md)
- [Create a custom authentication extension for attribute collection start and submit events]
- [Custom claims provider reference](custom-claims-provider-reference.md)