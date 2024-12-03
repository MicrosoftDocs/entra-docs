---
title: Configure an application to trust a managed identity (preview)
description: Learn how to configure an application to trust a managed identity in Microsoft Entra ID.
author: cilwerner
manager: CelesteDG
ms.service: entra-workload-id
ms.topic: how-to
ms.date: 12/3/2024
ms.author: cwerner
ms.reviewer: hosamsh
#Customer intent: As an application developer, I want to configure my application to trust a managed identity so that I can access Microsoft Entra protected resources without needing to use or manage application secrets or certificates.
---

# Configure an application to trust a managed identity (preview)

This article describes how to configure a Microsoft Entra application to trust a managed identity. You can then exchange the managed identity token for an access token that can access Microsoft Entra protected resources without needing to use or manage App secrets.

## Prerequisites

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F)
- This Azure account must have permissions to manage applications, specifically to [update permissions](~/identity/role-based-access-control/custom-available-permissions.md#microsoftdirectoryapplicationscredentialsupdate). Any of the following Microsoft Entra roles include the required permissions:
  - [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator)
  - [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer)
  - [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator)
- An understanding of the concepts in [managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview)
- [A user-assigned managed identity](/entra/identity/managed-identities-azure-resources/how-manage-user-assigned-managed-identities?pivots=identity-mi-methods-azp#create-a-user-assigned-managed-identity) assigned to the Azure compute resource (e.g., VM or App Service) that hosts your workload.
- An [app registration](~/identity-platform/quickstart-register-app.md) in Microsoft Entra ID. This app registration must belong to the same tenant as the managed identity 
    - If you need to access resources in another tenant, your app registration must be a multitenant application and provision the app into the other tenant. Additionally, you must grant the app access permissions on the resources in that tenant. Learn about [how to add a multitenant app in other tenants](/entra/identity/enterprise-apps/grant-admin-consent)
- The app registration must have access granted to Entra protected resources (e.g., Azure, Microsoft Graph, Microsoft 365, etc.). This access can be granted through [API permissions](../identity-platform/quickstart-configure-app-access-web-apis.md#add-permissions-to-access-microsoft-graph) or [delegated permissions](../identity-platform/quickstart-configure-app-access-web-apis.md#delegated-permission-to-microsoft-graph).

## Important considerations and restrictions

To create, update, or delete a federated identity credential, the account performing the action must have the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator), [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer), [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or Application Owner role.  The [microsoft.directory/applications/credentials/update permission](~/identity/role-based-access-control/custom-available-permissions.md#microsoftdirectoryapplicationscredentialsupdate) is required to update a federated identity credential.

A maximum of 20 federated identity credentials can be added to an application or user-assigned managed identity.

When you configure a federated identity credential, there are several important pieces of information to provide:
- *issuer* and *subject* are the key pieces of information needed to set up the trust relationship. The combination of `issuer` and `subject` must be unique on the app.  When the Azure workload requests Microsoft identity platform to exchange the Managed Identity token for an access token, the *issuer* and *subject* values of the federated identity credential are checked against the `issuer` and `subject` claims provided in the Managed Identity token. If that validation check passes, Microsoft identity platform issues an access token to the external software workload.
- *issuer* is the URL of the Entra tenant's Authority URL in the form `https://login.microsoftonline.com/{tenant}/v2.0`. The Entra App and the Managed Identity must belong to the same tenant. If the `issuer` claim has leading or trailing whitespace in the value, the token exchange is blocked.
    
    > [!IMPORTANT] 
    > Although the app registration and the managed identity must be in the same tenant, the service principal of the app registration can still redeem the managed identity token.
    
- *subject* is the GUID of the Managed Identity's Object ID (Principal ID) assigned to the Azure workload. Microsoft identity platform will look at the incoming external token and reject the exchange for an access token if the *subject* field configured in the Federated Identity Credential does not match the Principal ID of the Managed Identity. The GUID is case sensitive.
-  
    > [!IMPORTANT]
    > You can only use User-Assigned Managed Identities in this feature.
    
- *audiences* lists the audiences that can appear in the external token (Required). You must add a single audience value, which has a limit of 600 characters. The value must be one of the following and must match the value of the `aud` claim in the Managed Identity token.  
    - **Public cloud**: `api://AzureADTokenExchange`
    - **Fairfax**: `api://AzureADTokenExchangeUSGov`
    - **Mooncake**: `api://AzureADTokenExchangeChina`
    - **USNat**: `api://AzureADTokenExchangeUSNat`
    - **USSec**: `api://AzureADTokenExchangeUSSec`

  > [!IMPORTANT]
  > If you accidentally add  incorrect information in the *issuer*, *subject* or *audience* setting the federated identity credential is created successfully without error.  The error does not become apparent until the token exchange fails.
    
- *name* is the unique identifier for the federated identity credential. (Required) This field has a character limit of 3-120 characters and must be URL friendly. Alphanumeric, dash, or underscore characters are supported, the first character must be alphanumeric only.  It's immutable once created.
- *description* is the user-provided description of the federated identity credential (Optional). The description isn't validated or checked by Microsoft Entra ID. This field has a limit of 600 characters.
Wildcard characters aren't supported in any federated identity credential property value.

## Get the Object ID of the managed identity

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search box, enter Managed Identities. Under Services, select Managed Identities.
1. Search for and select the user-assigned managed identity you created as part of the [prerequisites](#prerequisites).
1. In the **Overview** pane, copy the **Object (principal) ID** value. This value will be used as the *subject* field in the federated credential configuration.

:::image type="content" source=".\media\workload-identity-federation-config-app-trust-managed-identity\managed-identity.png" alt-text="Screenshot of a user-assigned managed identity in the Azure portal. The Object ID is highlighted which will be used as the *subject* field in the federated credential configuration" :::

## Configure a federated identity credential on an app

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an . Check that you are in the tenant where your application is registered.
1. Browse to **Identity** > **Applications** > **App registrations**, and select your application in the main window.
1. Under **Manage**, select **Certificates & secrets**.
1. Select the Federated credentials tab and select **Add credential**.

    :::image type="content" source=".\media\workload-identity-federation-config-app-trust-managed-identity\select-federated-credential.png" alt-text="Screenshot of the certificates and secrets pane of the Microsoft Entra admin center with the federated credentials tab highlighted." ::: 

1. From the **Federated credential scenario** dropdown, select **Other Issuer** and fill in the values according to the table below:

    | Field | Description | Example |
    | --- | --- | --- |
    | Issuer | The OAuth 2.0 / OIDC issuer URL of the Entra ID authority. | `https://login.microsoftonline.com/{tenantID}/v2.0` |
    | Subject identifier | The `Principal ID` GUID of the Managed Identity. | `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` |
    | Name | A unique descriptive name for the credential. | *msi-webapp1* |
    | Description (Optional) | A user-provided description of the federated identity credential. | *Trust the workloads UAMI to impersonate the App* |
    | Audience | The audience value that must appear in the external token.  | &#8226; **Public cloud**: *api://AzureADTokenExchange* <br/>&#8226; **Fairfax**: *api://AzureADTokenExchangeUSGov* <br/>&#8226; **Mooncake**: *api://AzureADTokenExchangeChina* <br/>&#8226; **USNat**: *api://AzureADTokenExchangeUSNat* <br/>&#8226; **USSec**: *api://AzureADTokenExchangeUSSec* |

    :::image type="content" source=".\media\workload-identity-federation-config-app-trust-managed-identity\add-credential.png" alt-text="Screenshot of the add a credential window in the Microsoft Entra admin center." ::: 

### [Azure CLI](#tab/azure-cli)

Open a terminal in your preferred IDE and run the following command to create a federated identity credential on your app. Replace the GUID with the Object (principal) ID of the managed identity.

```console
az ad app federated-credential create --id 00001111-aaaa-2222-bbbb-3333cccc4444 --parameters credential.json
```

The `id` parameter specifies the identifier URI, application ID, or object ID of the application. The `parameters` parameter specifies the parameters, in JSON format, for creating the federated identity credential. You can refer to the following example for the contents of *credential.json*.

```json
{
    "name": "msi-webapp1",
    "issuer": "https://login.microsoftonline.com/{tenantID}/v2.0",
    "subject": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "description": "Trust the workload's UAMI to impersonate the App",
    "audiences": [
        "api://AzureADTokenExchange"
    ]
}
```

### [PowerShell](#tab/powershell)

Open a PowerShell terminal in your preferred IDE and run the following command to create a federated identity credential on your app. Replace the `Subject` GUID with the Object (principal) ID of the managed identity, and `{tenantID}` with your own tenant ID.

```Powershell
New-AzADAppFederatedCredential -ApplicationObjectId $appObjectId -Audience api://AzureADTokenExchange -Issuer 'https://login.microsoftonline.com/{tenantID}/v2.0' -Name 'MyMsiFic' -Subject '00001111-aaaa-2222-bbbb-3333cccc4444'
```

### [APIs](#tab/api)

Open a terminal in your preferred IDE and run the following command to create a federated identity credential on your app. Replace the placeholders with the appropriate values.

```bash
az rest --method POST --uri 'https://graph.microsoft.com/applications/{app_registration_id}/federatedIdentityCredentials' --body '{"name":"MyMsiFicTest","issuer":"https://login.microsoftonline.com/{tenantID}/v2.0","subject":"{Managed_Identity_Principal_ID}","description":"Trust the workloads UAMI to impersonate the App","audiences":["api://AzureADTokenExchange"]}'
```

### [Bicep](#tab/bicep)

This example shows how to use Bicep to create a FIC to make your app trust the assigned managed identity. Replace the placeholders with the appropriate values.

```Bicep
extension 'br:mcr.microsoft.com/bicep/extensions/microsoftgraph/v1.0:0.1.8-preview'

param myWorkloadManagedIdentity string = '[MANAGED-IDENTITY-NAME]'
param applicationDisplayName string = '[APPLICATION-DISPLAYNAME]'
param applicationName string = '[APPLICATION-UNIQUE-NAME]'

resource myManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: myWorkloadManagedIdentity
}

resource myApp 'Microsoft.Graph/applications@v1.0' = {
  displayName: applicationDisplayName
  uniqueName: applicationName

  resource myMsiFic 'federatedIdentityCredentials@v1.0' = {
    name: '${myApp.uniqueName}/msiAsFic'
    description: 'Trust the workloads UAMI to impersonate the App'
    audiences: [
       'api://AzureADTokenExchange'
    ]
    issuer: '${environment().authentication.loginEndpoint}${tenant().tenantId}/v2.0'
    subject: myManagedIdentity.properties.principalId
  }
}
```
---

## Update your application code to request an access token

The code samples in the following table show client credential "service to service" flows. However, managed identities as a credential can be used in other authentication flows such as on-behalf-of (OBO) flows. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant. 

### [.NET](#tab/dotnet)

### Azure.Identity

```csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
  
internal class Program
{
	static void Main(string[] args)
	{
	    string appClientId = "YOUR_APP_CLIENT_ID";
	
	    string resourceTenantId = "YOUR_RESOURCE_TENANT_ID";
	
	    string miClientId = "YOUR_MI_CLIENT_ID"; 
	
	    string audience = "api://AzureADTokenExchange";
	
	    // 1. Create the mi assertion
	    ClientAssertionCredential assertion = new(
		resourceTenantId,
		appClientId,
		async (token) => await GetManagedIdentityToken(miClientId, audience));
	
	    // 2. Access the resource
	    var client = new SecretClient(new Uri($"https://YOUR_KEY_VAULT_NAME.vault.azure.net/"), assertion);
	
	    // Retrieve the secret
	    KeyVaultSecret secret = client.GetSecret("SECRET_NAME");
	
	    // Print the secret value
	    Console.WriteLine($"Secret Value: {secret.Value}");
	
	}

	static async Task<string> GetManagedIdentityToken(string miClientId, string audience)
	{
		return (await miCredential.GetTokenAsync(new Azure.Core.TokenRequestContext([$"{audience}/.default"])).ConfigureAwait(false)).Token;
	}
}
```

### Microsoft.Identity.Web

``` JSON
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "ClientId": "YOUR_APPLICATION_ID",
    "TenantId": "YOUR_TENANT_ID",

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

### MSAL (.NET)

> [!WARNING]
>
> For .NET apps, we strongly advise to use higher-level libraries that are based on MSAL, such as Microsoft.Identity.Web or Azure.Identity.

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

        string vaultUrl = "YOUR_KEY_VAULT_NAME.vault.azure.net/";
        TokenCredential tokenCredential = new AccessTokenCredential(result.AccessToken);
        var client = new SecretClient(new Uri($"https://YOUR_KEY_VAULT_NAME.vault.azure.net/"), tokenCredential);
        
        // Retrieve the secret
        KeyVaultSecret secret = client.GetSecret("SECRET_NAME");
        
        // Print the secret value
        Console.WriteLine($"Secret Value: {secret.Value}");
	}
}
```
---

## See also

- [Important considerations and restrictions for federated identity credentials](workload-identity-federation-considerations.md).