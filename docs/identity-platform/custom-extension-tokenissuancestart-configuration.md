---
title: "Custom claims provider: Configure a token issuance event"
description: Learn how to configure a custom claims provider for a token issuance start event in Microsoft Entra ID. You can add custom claims to a token before it's issued.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 04/10/2024
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to

#Customer intent: As a developer, I want to configure a custom claims provider token issuance event in the Azure portal, so that I can add custom claims to a token before it is issued.
---

# Configure a custom claim provider for a token issuance event

This article describes how to configure a custom claims provider for a [token issuance start event](custom-claims-provider-overview.md#token-issuance-start-event-listener). Using an existing Azure Functions REST API, you'll register a custom authentication extension and add attributes that you expect it to parse from your REST API. To test the custom authentication extension, you'll register a sample OpenID Connect application to get a token and view the claims.

## Prerequisites

- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/free/dotnet/) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- An HTTP trigger function configured for a token issuance event deployed to Azure Functions. If you don't have one, follow the steps in [create a REST API for a token issuance start event in Azure Functions](./custom-extension-tokenissuancestart-setup.md).
- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- A Microsoft Entra ID tenant. You can use either a customer or workforce tenant for this how-to guide.
    - For external tenants, use a [sign-up and sign-in user flow](~/external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md).

## Step 1: Register a custom authentication extension

You'll now configure a custom authentication extension, which will be used by Microsoft Entra ID to call your Azure function. The custom authentication extension contains information about your REST API endpoint, the claims that it parses from your REST API, and how to authenticate to your REST API. Follow these steps to register a custom authentication extension to your Azure Function app. 

> [!NOTE]
>
> You can have a maximum of 100 custom extension policies.

# [Azure portal](#tab/azure-portal)

### Register a custom authentication extension

1. Sign in to the [Azure portal](https://portal.azure.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-developer) and [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Search for and select **Microsoft Entra ID** and select **Enterprise applications**.
1. Select **Custom authentication extensions**, and then select **Create a custom extension**.
1. In **Basics**, select the **TokenIssuanceStart** event type and select **Next**.
1. In **Endpoint Configuration**, fill in the following properties:
    - **Name** - A name for your custom authentication extension. For example, *Token issuance event*.
    - **Target Url** - The `{Function_Url}` of your Azure Function URL. Navigate to the **Overview** page of your Azure Function app, then select the function you created. In the function **Overview** page, select **Get Function Url** and use the copy icon to copy the **customauthenticationextension_extension (System key)** URL.
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
1. Note the **App ID** under **API Authentication**, which is needed to [configure authentication for your Azure Function](./custom-extension-tokenissuancestart-setup.md#configure-authentication-for-your-azure-function) in your Azure Function app.

# [Microsoft Graph](#tab/microsoft-graph)

### Register an application

1. Sign in to [Graph Explorer](https://aka.ms/ge) using an account whose home tenant is the tenant in which you wish to manage your custom authentication extension in. This account must have privileges to create and manage an application registration in the tenant.
2. Run the following request.

    ```http
    POST https://graph.microsoft.com/v1.0/applications
    Content-type: application/json
    
    {
        "displayName": "authenticationeventsAPI"
    }
    ```

3. From the response, record the value of **id** and **appId** of the newly created app registration. These values are referenced in this article as `{authenticationeventsAPI_ObjectId}` and `{authenticationeventsAPI_AppId}` respectively.

### Create a service principal in the tenant for the authenticationeventsAPI app registration.

While in Graph Explorer, run the following request. Replace `{authenticationeventsAPI_AppId}` with the value of **appId** that you recorded from the previous step.

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
   - An example value is `api://authenticationeventsAPI.azurewebsites.net/00001111-aaaa-2222-bbbb-3333cccc4444`. Take note of this value as you'll use it later in this article in place of `{functionApp_IdentifierUri}`.

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
                "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
                "type": "Role"
            }
        ]
    }
]
}
```

### Register a custom authentication extension

To register the custom authentication extension, you associate it with the app registration for the Azure Function, and your Azure Function endpoint `{Function_Url}`.

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
    
1. Record the `id` value of the created custom claims provider object. You'll use the value later in this tutorial in place of `{customExtensionObjectId}`.

---

### 1.2 Grant admin consent

Once the custom authentication extension is created, you need to grant permissions to the API. The custom authentication extension uses `client_credentials` to authenticate to the Azure Function App using the `Receive custom authentication extension HTTP requests` permission.

1. Open the **Overview** page of your new custom authentication extension. Take a note of the **App ID** under **API Authentication**, as it will be needed when adding an identity provider.
1. Under **API Authentication**, select **Grant permission**. 
1. A new window opens, and once signed in, it requests permissions to receive custom authentication extension HTTP requests. This allows the custom authentication extension to authenticate to your API. Select **Accept**. 

    :::image type="content" border="false"source="./media/custom-extension-tokenissuancestart-configuration/custom-extensions-overview.png" alt-text="Screenshot that shows how grant admin consent." lightbox="media/custom-extension-tokenissuancestart-configuration/custom-extensions-overview.png":::

## Step 2: Configure an OpenID Connect app to receive enriched tokens

To get a token and test the custom authentication extension, you can use the <https://jwt.ms> app. It's a Microsoft-owned web application that displays the decoded contents of a token (the contents of the token never leave your browser).

### 2.1 Register a test web application

Follow these steps to register the **jwt.ms** web application:

1. From the **Home** page in the Azure portal, select **Microsoft Entra ID**.
1. Select **App registrations** > **New registration**.
1. Enter a **Name** for the application. For example, **My Test application**.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. In the **Select a platform** dropdown in **Redirect URI**, select **Web** and then enter `https://jwt.ms` in the URL text box.
1. Select **Register** to complete the app registration.

    :::image type="content" border="false"source="media/custom-extension-tokenissuancestart-configuration/register-test-web-application.png" alt-text="Screenshot that shows how to select the supported account type and redirect URI.":::

1. In the **Overview** page of your app registration, copy the **Application (client) ID**. The app ID is referred to as the `{App_to_enrich_ID}` in later steps. In Microsoft Graph, it's referenced by the **appId** property.

    :::image type="content" border="false"source="media/custom-extension-tokenissuancestart-configuration/get-the-test-application-id.png" alt-text="Screenshot that shows how to copy the application ID.":::

### 2.2 Enable implicit flow

The **jwt.ms** test application uses the implicit flow. Enable implicit flow in your *My Test application* registration:

1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.

### 2.3 Enable your App for a claims mapping policy

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

# [Workforce tenant](#tab/workforce-tenant)

Continue to the next step, [Assign a custom claims provider to your app](#step-3-assign-a-custom-claims-provider-to-your-app).

# [External tenant](#tab/external-tenant)
### 3.4 Associate your app with a user flow

For external tenants, you need to associate your app with a user flow. A user flow defines the authentication methods a customer can use to sign in to your application and the information they need to provide during sign-up. Ensure that you complete the steps in [Add an application to a user flow](~/external-id/customers/how-to-user-flow-add-application.md) before continuing to add *My Test application* to the user flow.

---

## Step 3: Assign a custom claims provider to your app

For tokens to be issued with claims incoming from the custom authentication extension, you must assign a custom claims provider to your application. This is based on the token audience, so the provider must be assigned to the client application to receive claims in an ID token, and to the resource application to receive claims in an access token. The custom claims provider relies on the custom authentication extension configured with the **token issuance start** event listener. You can choose whether all, or a subset of claims, from the custom claims provider are mapped into the token.

> [!NOTE]
>
> You can only create 250 unique assignments between applications and custom extensions. If you wish to apply the same custom extension call to multiple apps, we recommend using [authenticationEventListeners](/graph/api/identitycontainer-post-authenticationeventlisteners) Microsoft Graph API to create listeners for multiple applications. This is not supported in the Azure portal.

Follow these steps to connect the *My Test application* with your custom authentication extension:

# [Azure portal](#tab/azure-portal)

To assign the custom authentication extension as a custom claims provider source;

1. From the **Home** page in the Azure portal, select **Microsoft Entra ID**.
1. Select**Enterprise applications**, then under **Manage**, select **All applications**. Find and select *My Test application* from the list.
1. From the **Overview** page of *My Test application*, navigate to **Manage**, and select **Single sign-on**.
1. Under **Attributes & Claims**, select **Edit**.

    :::image type="content" border="false"  source="./media/custom-extension-tokenissuancestart-configuration/open-id-connect-based-sign-on.png" alt-text="Screenshot that shows how to configure app claims." lightbox="./media/custom-extension-tokenissuancestart-configuration/open-id-connect-based-sign-on.png":::

1. Expand the **Advanced settings** menu.
1. Next to **Custom claims provider**, select **Configure**.
1. Expand the **Custom claims provider** drop-down box, and select the *Token issuance event* you created earlier.
1. Select **Save**.

Next, assign the attributes from the custom claims provider, which should be issued into the token as claims:

1. Select **Add new claim** to add a new claim. Provide a name to the claim you want to be issued, for example *dateOfBirth*.
1. Under **Source**, select **Attribute**, and choose *customClaimsProvider.dateOfBirth* from the **Source attribute** drop-down box.

    :::image type="content" border="false"  source="media/custom-extension-tokenissuancestart-configuration/manage-claim.png" alt-text="Screenshot that shows how to add a claim mapping to your app." lightbox="media/custom-extension-tokenissuancestart-configuration/manage-claim.png":::

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

## Step 4: Protect your Azure Function

Microsoft Entra custom authentication extension uses server to server flow to obtain an access token that is sent in the HTTP `Authorization` header to your Azure function. When publishing your function to Azure, especially in a production environment, you need to validate the token sent in the authorization header.

To protect your Azure function, follow these steps to integrate Microsoft Entra authentication, for validating incoming tokens with your *Azure Functions authentication events API* application registration. Choose one of the following tabs based on your tenant type.

> [!NOTE]
> If the Azure function app is hosted in a different Azure tenant than the tenant in which your custom authentication extension is registered, choose the [Open ID Connect](#42-using-openid-connect-identity-provider) tab.

### 4.1 Using Microsoft Entra identity provider

Use the following steps to add Microsoft Entra as an identity provider to your Azure Function app.

# [Workforce tenant](#tab/workforce-tenant)

1. In the [Azure portal](https://portal.azure.com), find and select the function app you previously published.
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **Microsoft** as the identity provider.
1. Select **Workforce** as the tenant type.
1. Under **App registration** select **Pick an existing app registration in this directory** for the **App registration type**, and pick the *Azure Functions authentication events API* app registration you [previously created](#step-1-register-a-custom-authentication-extension) when registering the custom claims provider.
1. Enter the following issuer URL, `https://login.microsoftonline.com/{tenantId}/v2.0`, where `{tenantId}` is the tenant ID of your workforce tenant.
1. Under **Client application requirement** select **Allow requests from specific client applications** and enter `99045fe1-7639-4a75-9d4a-577b6ca3810f`.
1. Under **Tenant requirement** select **Allow requests from specific tenants** and enter your workforce tenant ID.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

    :::image type="content" border="true"  source="media/custom-extension-tokenissuancestart-configuration/add-identity-provider-auth-function-app-workforce.png" alt-text="Screenshot that shows how to add authentication to your function app while in a workforce tenant." lightbox="media/custom-extension-tokenissuancestart-configuration/add-identity-provider-auth-function-app-workforce.png":::

# [External tenant](#tab/external-tenant)

1. In the [Azure portal](https://portal.azure.com), find and select the function app you previously published.
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **Microsoft** as the identity provider.
1. Select **Customer** as the tenant type.
1. Under **App registration**, enter the `client_id` of the *Azure Functions authentication events API* app registration you [previously created](#step-1-register-a-custom-authentication-extension) when registering the custom claims provider.
1. For the **Issuer URL**, enter the following URL `https://{domainName}.ciamlogin.com/{tenant_id}/v2.0`, where
    - `{domainName}` is the domain name of your external tenant, in the form `{domainName}.contoso.com`.
    - `{tenantId}` is the tenant ID of your external tenant.
1. Under **Client application requirement** select **Allow requests from specific client applications** and enter `99045fe1-7639-4a75-9d4a-577b6ca3810f`.
1. Under **Tenant requirement** select **Allow requests from specific tenants** and enter your external tenant ID.
1. Under **Unauthenticated requests**, select **HTTP 401 Unauthorized** as the identity provider.
1. Unselect the **Token store** option.
1. Select **Add** to add authentication to your Azure Function.

    :::image type="content" border="true"  source="media/custom-extension-tokenissuancestart-configuration/add-identity-provider-auth-function-app-customer.png" alt-text="Screenshot that shows how to add authentication to your function app while in an external tenant." lightbox="media/custom-extension-tokenissuancestart-configuration/add-identity-provider-auth-function-app-customer.png":::

---

### 4.2 Using OpenID Connect identity provider

If you configured the [Microsoft identity provider](#step-4-protect-your-azure-function), skip this step. Otherwise, if the Azure Function is hosted under a different tenant than the tenant in which your custom authentication extension is registered, follow these steps to protect your function:

#### Create a client secret 

1. From the **Home** page of the Azure portal, select **Microsoft Entra ID** > **App registrations**.
1. Select the *Azure Functions authentication events API* app registration [you created previously](#step-1-register-a-custom-authentication-extension).
1. Select **Certificates & secrets** > **Client secrets** > **New client secret**.
1. Select an expiration for the secret or specify a custom lifetime, add a description, and select **Add**.
1. Record the **secret's value** for use in your client application code. This secret value is never displayed again after you leave this page.

#### Add the OpenID Connect identity provider to your Azure Function app.

1. Find and select the function app you previously published.
1. Under **Settings**, select **Authentication**.
1. Select **Add Identity provider**.  
1. Select **OpenID Connect** as the identity provider.
1. Provide a name, such as *Contoso Microsoft Entra ID*.
1. Under the **Metadata entry**, enter the following URL to the **Document URL**. Replace the `{tenantId}` with your Microsoft Entra tenant ID.

    ```http
    https://login.microsoftonline.com/{tenantId}/v2.0/.well-known/openid-configuration
    ```

1. Under the **App registration**, enter the application ID (client ID) of the *Azure Functions authentication events API* app registration [you created previously](#step-1-register-a-custom-authentication-extension).

1. Return to the Azure Function, under the **App registration**, enter the **Client secret**.
1. Unselect the **Token store** option.
1. Select **Add** to add the OpenID Connect identity provider.

## Step 5: Test the application

To test your custom claims provider, follow these steps:

# [Workforce tenant](#tab/workforce-tenant)

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://login.microsoftonline.com/{tenantId}/oauth2/v2.0/authorize?client_id={App_to_enrich_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```

1. Replace `{tenantId}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{App_to_enrich_ID}` with the *My Test application* client ID.  
1. After logging in, you'll be presented with your decoded token at `https://jwt.ms`. Validate that the claims from the Azure Function are presented in the decoded token, for example, `dateOfBirth`.

# [External tenant](#tab/external-tenant)

1. Open a new private browser and navigate and sign-in through the following URL.

    ```http
    https://{domainName}.ciamlogin.com/{tenantId}/oauth2/v2.0/authorize?client_id={App_to_enrich_ID}&response_type=id_token&redirect_uri=https://jwt.ms&scope=openid&state=12345&nonce=12345
    ```
1. Replace `{domainName}` with your domain name, for example, `contoso`.
1. Replace `{tenantId}` with your tenant ID, tenant name, or one of your verified domain names. For example, `contoso.onmicrosoft.com`.
1. Replace `{App_to_enrich_ID}` with the *My Test application* client ID. 
1. Go through the sign in user flow that you've configured, and accept the requested permissions.
1. After logging in, you'll be presented with your decoded token at `https://jwt.ms`. Validate that the claims from the Azure Function are presented in the decoded token, for example, `dateOfBirth`.

---

## See also

- [Configure a SAML app to receive tokens with claims from an external store](custom-extension-configure-saml-app.md)
- [Custom claims provider reference](custom-claims-provider-reference.md)
- [Troubleshoot your custom authentication extensions API](custom-extension-troubleshoot.md)
