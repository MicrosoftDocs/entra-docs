---
title: Configure an application to trust a managed identity (preview)
description: Learn how to configure an application to trust a managed identity in Microsoft Entra ID.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: how-to
ms.date: 11/6/2024
ms.author: cilwerner
ms.reviewer: hosamsh
#Customer intent: As an application developer, I want to configure my application to trust a managed identity so that I can access Microsoft Entra protected resources without needing to use or manage application secrets or certificates.
---

# Configure an application to trust a managed identity (preview)

This article describes how to configure An Entra App to trust a Managed Identity. You can then exchange the managed identity token for an access token that can access Microsoft Entra protected resources without needing to use or manage App secrets.

## Prerequisites

### App Registration
[Create an app registration](~/identity-platform/quickstart-register-app.md) in Microsoft Entra ID.  Grant your app access to the Azure resources targeted by your Azure workload.


    > [!IMPORTANT]
    > If you need to access resources in another tenant, you must create a multitenant application and provision the App into the other tenant. Additionally, you must grant the app access permissions on the resources in that tenant. Refer to this article for more information on adding multitenant app in other tenants: https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/grant-admin-consent 
    
Find the client ID of the app, which you need in the following steps.  You can find it in the [Microsoft Entra admin center](https://entra.microsoft.com).  Go to the list of app registrations and select your app registration.  In **Overview**->**Essentials**, find the **Client ID**.

### User-Assigned Managed Identity
- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview). Be sure to review the [difference between a system-assigned and user-assigned managed identity](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview#managed-identity-types).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before you continue.
- To create a user-assigned managed identity and configure a federated identity credential, your account needs the [Contributor](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#contributor) or [Owner](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#owner) role assignment.
- [Create a user-assigned managed identity](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/how-manage-user-assigned-managed-identities?pivots=identity-mi-methods-azp#create-a-user-assigned-managed-identity)
- The Managed Identity must be assigned to Azure compute resource (e.g., VM or App Service) that hosts your workload. 
- Find the Managed Identity's `Object ID`, which you will use as the *subject* field in the federated credential configuration. To get this value, navigate to Managed Identities in the Azure Portal, select the managed identity you want to use in the Federated Credential, and copy the `Object (Principal) ID` value. 

![Locate the Object ID of a managed identity](assets\msi-principal-id.png)

- Also note the managed identity's `Client ID`, which you will use when requesting the managed identity token from your code.

## Important considerations and restrictions

To create, update, or delete a federated identity credential, the account performing the action must have the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator), [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer), [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or Application Owner role.  The [microsoft.directory/applications/credentials/update permission](~/identity/role-based-access-control/custom-available-permissions.md#microsoftdirectoryapplicationscredentialsupdate) is required to update a federated identity credential.

A maximum of 20 federated identity credentials can be added to an application or user-assigned managed identity.

When you configure a federated identity credential, there are several important pieces of information to provide:

- *issuer* and *subject* are the key pieces of information needed to set up the trust relationship. The combination of `issuer` and `subject` must be unique on the app.  When the Azure workload requests Microsoft identity platform to exchange the Managed Identity token for an access token, the *issuer* and *subject* values of the federated identity credential are checked against the `issuer` and `subject` claims provided in the Managed Identity token. If that validation check passes, Microsoft identity platform issues an access token to the external software workload.

- *issuer* is the URL of the Entra tenant's Authority URL in the form `https://login.microsoftonline.com/{tenant}/v2.0`. The Entra App and the Managed Identity must belong to the same tenant. If the `issuer` claim has leading or trailing whitespace in the value, the token exchange is blocked.
    
- *subject* is the GUID of the Managed Identity's Object ID (Principal ID) assigned to the Azure workload. Microsoft identity platform will look at the incoming external token and reject the exchange for an access token if the *subject* field configured in the Federated Identity Credential does not match the Principal ID of the Managed Identity. 

    > [!IMPORTANT]
    > You can only use User-Assigned Managed Identities in this feature.
    
- *audiences* lists the audiences that can appear in the external token.  Required. You must add a single audience value, which has a limit of 600 characters. The recommended value is "api://AzureADTokenExchange". This value must match the value of the `aud` claim in the Managed Identity token.  

    > [!IMPORTANT]
    > If you accidentally add  incorrect information in the *issuer*, *subject* or *audience* setting the federated identity credential is created successfully without error.  The error does not become apparent until the token exchange fails.
    
- *name* is the unique identifier for the federated identity credential. Required.  This field has a character limit of 3-120 characters and must be URL friendly. Alphanumeric, dash, or underscore characters are supported, the first character must be alphanumeric only.  It's immutable once created.

- *description* is the user-provided description of the federated identity credential.  Optional. The description isn't validated or checked by Microsoft Entra ID. This field has a limit of 600 characters.

Wildcard characters aren't supported in any federated identity credential property value.

To learn more about supported regions, time to propagate federated credential updates, supported issuers and more, read [Important considerations and restrictions for federated identity credentials](workload-identity-federation-considerations.md).

## Configure a federated identity credential on an app

### [Entra Portal](#tab/entra-portal)

To add a federated identity from the Entra Portal, follow these steps:
1. Navigate to [https://entra.microsoft.com](https://entra.microsoft.com/) and sign in to the Entra tenant where you registered the App.
1. Navigate to App registrations under the Applications left menu item. (click Show more if the item is not visible).
1. Click on the App Registration you created earlier to navigate to the App management page.
1. Under Manage on the left menu, select Certificates & secrets
1. Select the Federated credentials tab and click on Add credential
1. Choose Other Issuer and fill in the values as follows:
	- Name: enter a unique descriptive name for the credential. This can't be changed later.
	- Subject identifier: enter the `Principal ID` GUID of the Managed Identity.
	- Issuer: enter the OAuth 2.0 / OIDC issuer URL of the Entra ID authority in the following format: `https://login.microsoftonline.com/{tenantID}/v2.0`, where the tenant ID is the Entra tenant ID of the Azure subscription where both the App registration and Managed Identity exist.
	- Audience: enter the recommended value -  `api://AzureADTokenExchange`

![Configure the FIC](.\assets\configure-issuer.png)

### [Azure CLI](#tab/azure-cli)

Run the [az ad app federated-credential create](/cli/azure/ad/app/federated-credential) command to create a new federated identity credential on your app.

The `id` parameter specifies the identifier URI, application ID, or object ID of the application. The `parameters` parameter specifies the parameters, in JSON format, for creating the federated identity credential.
```Shell
az ad app federated-credential create --id 00001111-aaaa-2222-bbbb-3333cccc4444 --parameters credential.json
```

#### Contents of credential.json:

```Json
{
    "name": "MyMsiFic",
    "issuer": "https://login.microsoftonline.com/{tenantID}/v2.0",
    "subject": "{Managed_Identity_Principal_ID}",
    "description": "Trust the workload's UAMI to impersonate the App",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
```

### [PowerShell](#tab/powershell)

```Powershell
New-AzADAppFederatedCredential -ApplicationObjectId $appObjectId -Audience api://AzureADTokenExchange -Issuer 'https://login.microsoftonline.com/{tenantID}/v2.0' -Name 'MyMsiFic' -Subject '{Managed_Identity_Principal_ID}'
```

### [APIs](#tab/api)

```bash
az rest --method POST --uri 'https://graph.microsoft.com/applications/{app_registration_id}/federatedIdentityCredentials' --body '{"name":"MyMsiFicTest","issuer":"https://login.microsoftonline.com/{tenantID}/v2.0","subject":"{Managed_Identity_Principal_ID}","description":"Trust the workloads UAMI to impersonate the App","audiences":["api://AzureADTokenExchange"]}'
```

### [Bicep](#tab/bicep)

This example shows how to use Bicep to create a FIC to make your app trust the assigned managed identity.

```Bicep
extension microsoftGraph
  
resource MyMsiFic 'federatedIdentityCredentials' = {
	name: 'MyMsiFic'
	
	issuer: '${environment().authentication.loginEndpoint}${tenant().tenantId}/v2.0' 
	subject: '<Managed-Identity-Principal-ID>' 
	audiences: [       'api://AzureADTokenExchange']
	
	description: 'Trust the workloads UAMI to impersonate the App'
	    
	languageVersion: 1
}
```

---

## Request an access token

The below code samples are valid in both cases where the resource tenant is in the same tenant as the App Reg and the Managed identity or a different tenant. 

### [Azure.Identity](#tab/azure-identity)

``` csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
  
internal class Program
{
	static void Main(string[] args)
	{
	    string appClientId = "YOUR_APP_CLIENT_ID";
	
	    string resourceTenantId = "YOUR_RESOURCE_TENANT_ID";
	
	    string miClientId = "YOUR_MI_CLIENT_ID"; //<hosam> do we need it?
	
	    string audience = "api://AzureADTokenExchange";
	
	    // 1. Create the mi assertion
	    ClientAssertionCredential assertion = new(
		resourceTenantId,
		appClientId,
		async (token) => await GetManagedIdentityToken(miClientId, audience));
	
	    // 2. Access the resource
	    var client = new SecretClient(new Uri($"https://testfickv.vault.azure.net/"), assertion);
	
	    // Retrieve the secret
	    KeyVaultSecret secret = client.GetSecret("VerySecretHiddenString");
	
	    // Print the secret value
	    Console.WriteLine($"Secret Value: {secret.Value}");
	
	}

	static async Task<string> GetManagedIdentityToken(string miClientId, string audience)
	{
		return (await miCredential.GetTokenAsync(new Azure.Core.TokenRequestContext([$"{audience}/.default"])).ConfigureAwait(false)).Token;
	}
}
```

### [Microsoft.Identity.Web](#tab/microsoft-identity-web)

``` JSON
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "ClientId": "YOUR_APPLICATION_ID",
    "TenantId": "common",
   // To call an API
   "ClientCredentials": [
      {
        "SourceType": "SignedAssertionFromManagedIdentity",
        "ManagedIdentityClientId": "YOUR_USER_ASSIGNED_MANAGED_IDENTITY_CLIENT_ID",
        "TokenExchangeUrl":"api://AzureADTokenExchange"
      }
   ]
  }
}
```

### [MSAL (.NET)](#tab/msal-dotnet)

``` csharp
using Microsoft.Identity.Client;
using Microsoft.Identity.Client.AppConfig;

internal class Program

{

	static async Task Main(string[] args)
	{
	    string appClientId = "YOUR_APP_CLIENT_ID";
	    string resourceTenantId = "YOUR_RESOURCE_TENANT_ID";
	    Uri authorityUri = new($"https://login.microsoftonline.com/{resourceTenantId}");
	    string miClientId = "YOUR_MI_CLIENT_ID";
	    string audience = "api://AzureADTokenExchange";
	
	    // 1. Get mi token to use as assertion
	    var miAssertionProvider = async (AssertionRequestOptions _) =>
	    {
		var miApplication = ManagedIdentityApplicationBuilder
		    .Create(ManagedIdentityId.WithUserAssignedClientId(miClientId))
		    .Build();
	
		var miResult = await miApplication.AcquireTokenForManagedIdentity(audience)
		    .ExecuteAsync()
		    .ConfigureAwait(false);
		return miResult.AccessToken;
	    };
	
	   // 2. get the federated app credenial
	    IConfidentialClientApplication app = ConfidentialClientApplicationBuilder.Create(appClientId)
	      .WithAuthority(authorityUri, false)
	      .WithClientAssertion(miAssertionProvider)
	      .WithCacheOptions(CacheOptions.EnableSharedCacheOptions)
	      .Build();
	
	    string[] scopes = ["https://vault.azure.net/.default"];
	    AuthenticationResult result = await app.AcquireTokenForClient(scopes).ExecuteAsync().ConfigureAwait(false);
	}
}
```
---