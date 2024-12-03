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

The example below demonstrates how to connect to an Azure storage container, but can be adapted to access any resource protected by Microsoft Entra. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant.

### Azure.Identity

```csharp
using Azure.Identity;
using Azure.Storage.Blobs;

internal class Program
{
    // This example demonstrates how to access an Azure blob storage account by utilizing the manage identity credential.
  static void Main(string[] args)
  {
        string storageAccountName = "YOUR_STORAGE_ACCOUNT_NAME";
        string containerName = "CONTAINER_NAME";
        
        // The application must be granted access on the target resource
      string appClientId = "YOUR_APP_CLIENT_ID";

        // The tenant where the target resource is created, in this example, the storage account tenant
        // If the resource tenant different from the app tenant, your app needs to be 
      string resourceTenantId = "YOUR_RESOURCE_TENANT_ID";

        // The managed identity which you configured as a Federated Identity Credential (FIC)
      string miClientId = "YOUR_MANAGED_IDENTITY_CLIENT_ID"; 

        // Audience value must be one of the below values depending on the target cloud.
        // Public cloud: api://AzureADTokenExchange
        //  Fairfax: api://AzureADTokenExchangeUSGov
        //  Mooncake: api://AzureADTokenExchangeChina
        //  USNat: api://AzureADTokenExchangeUSNat
        //  USSec: api://AzureADTokenExchangeUSSec
      string audience = "api://AzureADTokenExchange";

        // 1. Create an assertion with the managed identity access token, so that it can be exchanged an app token
        var miCredential = new ManagedIdentityCredential(managedIdentityClientId);
        ClientAssertionCredential assertion = new(
            tenantId,
            appClientId,
            async (token) =>
            {
                // fetch Managed Identity token for the specified audience
                var tokenRequestContext = new Azure.Core.TokenRequestContext(new[] { $"{audience}/.default" });
                var accessToken = await miCredential.GetTokenAsync(tokenRequestContext).ConfigureAwait(false);
                return accessToken.Token;
            });

        // 2. The assertion can be used to obtain an App token (taken care of by the SDK)
        var containerClient  = new BlobContainerClient(new Uri($"https://{storageAccountName}.blob.core.windows.net/{containerName}"), assertion);

        await foreach (BlobItem blob in containerClient.GetBlobsAsync())
        {
            // TODO: perform operations with the blobs
            BlobClient blobClient = containerClient.GetBlobClient(blob.Name);
            Console.WriteLine($"Blob name: {blobClent.Name}, uri: {blobClient.Uri}");            
        }
  }
}
```

### Microsoft.Identity.Web

In **Microsoft.Identity.Web**, a web application or web API can replace the client certificate with a signed client assertion for authentication. Below is an example of how this configuration can be represented in the appsettings.json file:

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
> For .NET apps, we strongly advise to use higher-level libraries that are based on MSAL, such as Microsoft.Identity.Web or Azure.Identity.

In **MSAL**, you can leverage the [ManagedClientApplication](https://learn.microsoft.com/en-us/entra/msal/dotnet/advanced/managed-identity) class to acquire a Managed Identity token. This token can then be used as a client assertion when constructing a confidential client application.

``` csharp
using Microsoft.Identity.Client;
using Azure.Storage.Blobs;
using Azure.Core;

internal class Program
{
  static async Task Main(string[] args)
  {
        string storageAccountName = "YOUR_STORAGE_ACCOUNT_NAME";
        string containerName = "CONTAINER_NAME";

      string appClientId = "YOUR_APP_CLIENT_ID";
      string resourceTenantId = "YOUR_RESOURCE_TENANT_ID";
      Uri authorityUri = new($"https://login.microsoftonline.com/{resourceTenantId}");
      string miClientId = "YOUR_MI_CLIENT_ID";
      string audience = "api://AzureADTokenExchange";

      // Get mi token to use as assertion
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

      // Create a confidential client application with the assertion.
      IConfidentialClientApplication app = ConfidentialClientApplicationBuilder.Create(appClientId)
        .WithAuthority(authorityUri, false)
        .WithClientAssertion(miAssertionProvider)
        .WithCacheOptions(CacheOptions.EnableSharedCacheOptions)
        .Build();

        // Get the federated app token for the storage account
      string[] scopes = [$"https://{storageAccountName}.blob.core.windows.net/.default"];
      AuthenticationResult result = await app.AcquireTokenForClient(scopes).ExecuteAsync().ConfigureAwait(false);

        TokenCredential tokenCredential = new AccessTokenCredential(result.AccessToken);
        var client = new BlobContainerClient(
            new Uri($"https://{storageAccountName}.blob.core.windows.net/{containerName}"),
            tokenCredential);

        await foreach (BlobItem blob in containerClient.GetBlobsAsync())
        {
            // TODO: perform operations with the blobs
            BlobClient blobClient = containerClient.GetBlobClient(blob.Name);
            Console.WriteLine($"Blob name: {blobClient.Name}, URI: {blobClient.Uri}");
        }
  }
}
```

### [Node.js](#tab/nodejs)

The example below demonstrates how to connect to an Azure KeyVault, but can be adapted to access any resource protected by Microsoft Entra. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant.

### Azure Identity library for Node.js

The below snippet uses the the [@azure/identity](https://www.npmjs.com/package/@azure/identity) package to generate client assertions with a managed identity. 

```javascript
import { ManagedIdentityCredential, ClientAssertionCredential, TokenCredential } from "@azure/identity";
import { SecretClient } from "@azure/keyvault-secrets";

const KEY_VAULT_URI: string = "https://testfickv.vault.azure.net";
const SECRET_NAME: string = "VerySecretHiddenString";
const MI_CLIENT_ID: string = "YOUR_MI_CLIENT_ID";
const AUDIENCE: string = "api://AzureADTokenExchange";
const RESOURCE_TENANT_ID: string = "YOUR_RESOURCE_TENANT_ID";
const APP_CLIENT_ID: string = "YOUR_APP_CLIENT_ID";

async function getAccessToken(credential: TokenCredential, audience: string[]): Promise<string> {
    const accessToken = await credential.getToken(audience);
    const token = accessToken?.token;
    if(!token)
        throw new Error(`Failed to obtain valid access token, received ${token}`);
    return token;
}

const main = async () => {
    const managedIdentityCredential = new ManagedIdentityCredential({ clientId: MI_CLIENT_ID })
    const clientAssertionCredential = new ClientAssertionCredential(RESOURCE_TENANT_ID, APP_CLIENT_ID, () => getAccessToken(managedIdentityCredential, [AUDIENCE]));
    const client = new SecretClient(KEY_VAULT_URI, clientAssertionCredential);

    try {
        const secret = await client.getSecret(SECRET_NAME);
        console.log("Found the secret from keyvault:", secret);
    } catch (error) {
        console.error("Failed to retrieve secret:", error);
        throw error;
    }
};
main();
```

### MSAL for Node.js

> [!WARNING]
>
> We strongly advise customers to use higher-level libraries, like [Azure client SDKs](https://azure.microsoft.com/downloads/), where possible.

Managed Identity is supported natively in [MSAL for Node.js](https://www.npmjs.com/package/@azure/msal-node). The token received from the Managed Identity is provided as a clientAssertion to the confidential client application.

```javascript
import https from "https";
import {
    ConfidentialClientApplication,
    ClientCredentialRequest,
    ManagedIdentityRequestParams,
    ManagedIdentityConfiguration,
    Configuration,
    ManagedIdentityApplication,
    ManagedIdentityIdParams,
    NodeSystemOptions,
} from "@azure/msal-node";
import {
    LogLevel,
    LoggerOptions,
    AuthenticationResult,
} from "@azure/msal-common";

const KEY_VAULT_URI: string = "YOUR_KEYVAULT_URL";
const SECRET_NAME: string = "YOUR_SECRET_NAME";
const AUDIENCE: string = "api://AzureADTokenExchange";
const APP_CLIENT_ID: string = "YOUR_APP_CLIENT_ID";
const RESOURCE_TENANT_ID: string = "YOUR_RESOURCE_TENANT_ID";
/*
 * uncomment when using user assigned MI (clientId, resourceId, or ObjectId)
 * const USER_ASSIGNED_MI_ID: string = "YOUR_USER_ASSIGNED_MI_ID";
 */

const getSecretFromKeyVault = async (
    accessToken: string,
    keyVaultUri: string,
    secretName: string
): Promise<string> => {
    const options = {
        headers: {
            Authorization: `Bearer ${accessToken}`,
        },
    };

    return new Promise<string>((resolve, reject) => {
        https
            .get(
                `${keyVaultUri}secrets/${secretName}?api-version=7.2`,
                options,
                (response) => {
                    const data: Buffer[] = [];
                    response.on("data", (chunk) => {
                        data.push(chunk);
                    });

                    response.on("end", () => {
                        // combine all received buffer streams into one buffer, convert it to a string,
                        // then parse it as a JSON object
                        let parsedData;
                        try {
                            parsedData = JSON.parse(
                                Buffer.concat([...data]).toString()
                            );
                        } catch (error) {
                            return reject(
                                new Error(
                                    "Unable to parse response from the Key Vault"
                                )
                            );
                        }

                        if (parsedData.error) {
                            return reject(
                                new Error(`${parsedData.error.message}`)
                            );
                        }

                        return resolve(parsedData.value);
                    });
                }
            )
            .on("error", (error) => {
                return reject(new Error(`${error.message}`));
            });
    });
};

async function getAccessTokenFromManagedIdentity(): Promise<string> {
    const config: ManagedIdentityConfiguration = {
        managedIdentityIdParams: {
            // uncomment only one of the following lines for user assigned managed identity
            /*
             * userAssignedClientId: USER_ASSIGNED_MI_ID,
             * userAssignedObjectId: USER_ASSIGNED_MI_ID,
             * userAssignedResourceId: USER_ASSIGNED_MI_ID,
             */
        } as ManagedIdentityIdParams,
        system: {
            loggerOptions: {
                logLevel: LogLevel.Verbose,
            } as LoggerOptions,
        } as NodeSystemOptions,
    };
    const managedIdentityApplication: ManagedIdentityApplication =
        new ManagedIdentityApplication(config);

    const managedIdentityRequestParams: ManagedIdentityRequestParams = {
        resource: AUDIENCE,
    };

    try {
        const tokenResponse: AuthenticationResult =
            await managedIdentityApplication.acquireToken(
                managedIdentityRequestParams
            );

        return tokenResponse.accessToken;
    } catch (error) {
        throw `Error acquiring token from the Managed Identity: ${error}`;
    }
}

async function createConfig(): Promise<Configuration> {
    const clientAssertion: string = await getAccessTokenFromManagedIdentity();
    return {
        auth: {
            clientId: APP_CLIENT_ID,
            authority: `https://login.microsoftonline.com/${RESOURCE_TENANT_ID}`,
            clientAssertion: clientAssertion,
        },
    };
}

const main = async () => {
    const config: Configuration = await createConfig();
    const confidentialClientApplication = new ConfidentialClientApplication(
        config
    );

    const request: ClientCredentialRequest = {
        scopes: ["https://vault.azure.net/.default"],        
    };

    let tokenResponse: AuthenticationResult | null = null;
    try {
        tokenResponse =
            await confidentialClientApplication.acquireTokenByClientCredential(
                request
            );
    } catch (error) {
        `Error acquiring token from the Confidential Client application: ${error}`;
    }

    if (!tokenResponse) {
        throw "Token was not received from the Confidential Client";
    }

    let secret: string;
    try {
        secret = await getSecretFromKeyVault(
            tokenResponse.accessToken,
            KEY_VAULT_URI,
            SECRET_NAME
        );
    } catch (error) {
        throw error;
    }

    console.log("Secret value:", secret);
};

(async () => {
    try {
        await main();
    } catch (error) {
        console.error(error);
    }
})();
```

### [Java](#tab/java)

The example below demonstrates how to connect to an Azure KeyVault, but can be adapted to access any resource protected by Microsoft Entra. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant.

### Azure Identity library for Java

You can use [azure-identity](https://mvnrepository.com/artifact/com.azure/azure-identity) to obtain the [ManagedIdentityCredential](https://learn.microsoft.com/en-us/java/api/com.azure.identity.managedidentitycredential) and [TokenCredential](https://learn.microsoft.com/en-us/java/api/com.azure.core.credential.tokencredential), which in turn can be combined to form a client assertion. If you're using Maven, your pom.xml should include these two dependencies:

```xml
<dependencies>
  <dependency>
    <groupId>io.projectreactor</groupId>
    <artifactId>reactor-core</artifactId>
    <version>3.6.5</version>
  </dependency>

  <dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-identity</artifactId>
    <version>1.12.0</version>
  </dependency>
</dependencies>
```

```java
import com.azure.core.credential.TokenRequestContext;
import com.azure.core.credential.*;
import com.azure.identity.*;
import com.azure.security.keyvault.secrets.SecretClient;
import com.azure.security.keyvault.secrets.SecretClientBuilder;
import com.azure.security.keyvault.secrets.models.KeyVaultSecret;

import reactor.core.publisher.Mono;

public class KeyVaultFIC {
  private static final String MI_CLIENT_ID = "YOUR_MI_CLIENT_ID";
  private static final String MI_AUDIENCE = "api://AzureADTokenExchange";
  private static final String APP_CLIENT_ID = "YOUR_APP_CLIENT_ID";
  private static final String RESOURCE_TENANT_ID = "YOUR_TENANT_ID";
  private static ManagedIdentityCredential managedIdentityCredential;

  public static void main(String[] args) throws Exception {
    TokenCredential clientAssertionCredential = new ClientAssertionCredentialBuilder().tenantId(RESOURCE_TENANT_ID)
        .clientId(APP_CLIENT_ID)
        .clientAssertion(() -> getTokenUsingManagedIdentity(MI_AUDIENCE).block()).build();

    String keyVaultUrl = "https://testfickv.vault.azure.net";

    SecretClient secretClient = new SecretClientBuilder().vaultUrl(keyVaultUrl)
        .credential(clientAssertionCredential).buildClient();
    managedIdentityCredential = new ManagedIdentityCredentialBuilder().clientId(MI_CLIENT_ID).build();
    String secretName = "VerySecretHiddenString";

    KeyVaultSecret secret = secretClient.getSecret(secretName);
    System.out.println(secret.getValue());
  }

  private static Mono<String> getTokenUsingManagedIdentity(String audience) {
    TokenRequestContext requestContext = new TokenRequestContext().addScopes(audience);
    return managedIdentityCredential.getToken(requestContext).map(accessToken -> accessToken.getToken());
  }
}
```

### MSAL Java

> [!WARNING]
>
> We strongly advise customers to use higher-level libraries, like [Azure client SDKs](https://azure.microsoft.com/downloads/), where possible.

To get a federated identity credential with MSAL Java, you'll add a dependency to the [msal4j](https://mvnrepository.com/artifact/com.microsoft.azure/msal4j) library in your project. If you're using Maven, you need to add the following to your pom.xml:

```xml
<dependencies>
  <dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>msal4j</artifactId>
    <version>1.15.0</version>
  </dependency>
</dependencies>
```

The example below demonstrates acquiring the Managed Identity tokenaudience, and then passing it as a client assertion to a ConfidentialClientApplication.

```java
import java.net.MalformedURLException;
import java.util.Collections;
import java.util.Set;
import java.util.concurrent.ExecutionException;
import com.microsoft.aad.msal4j.*;

public class BaseFIC {
    private static final String MI_CLIENT_ID = "YOUR_MI_CLIENT_ID";
    private static final String MI_AUDIENCE = "api://AzureADTokenExchange";
    private static final String APP_CLIENT_ID = "YOUR_APP_CLIENT_ID";
    private static final String RESOURCE_TENANT_ID = "YOUR_RESOURCE_TENANT_ID";
    private static final String AUTHORITY_URI = String.format("https://login.microsoftonline.com/%s", RESOURCE_TENANT_ID);
    private static final Set<String> SCOPES = Collections.singleton("https://vault.azure.net/.default");
    
    public static void main(String[] args) throws Exception {
        String accessToken = getTokenUsingClientCredentials(getTokenUsingManagedIdentity());
    }
    
    private static String getTokenUsingManagedIdentity() throws Exception {
        ManagedIdentityApplication miApp = ManagedIdentityApplication.builder(ManagedIdentityId.userAssignedClientId(MI_CLIENT_ID)).build();
        ManagedIdentityParameters miParams = ManagedIdentityParameters.builder(MI_AUDIENCE).build();
        IAuthenticationResult result = miApp.acquireTokenForManagedIdentity(miParams).get();
        return result.accessToken();
    }
    
    private static String getTokenUsingClientCredentials(String accessToken) throws InterruptedException, ExecutionException, MalformedURLException {
        IClientCredential credential = ClientCredentialFactory.createFromClientAssertion(accessToken);
        ClientCredentialParameters ccaParams = ClientCredentialParameters.builder(SCOPES).build();
        ConfidentialClientApplication cca = ConfidentialClientApplication.builder(APP_CLIENT_ID, credential).authority(AUTHORITY_URI).build();
        IAuthenticationResult result = cca.acquireToken(ccaParams).get();
        return result.accessToken();
    }
}
```

### [Python](#tab/python)

The example below demonstrates how to connect to an Azure KeyVault, but can be adapted to access any resource protected by Microsoft Entra. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant.

### [Azure Identity library for Python](#tab/azure-identity)

The azure-identity library is used to generate client assertions with a managed identity and the azure.keyvault.secrets library to interact with Azure KeyVault.

```python
from azure.identity import ManagedIdentityCredential, ClientAssertionCredential
from azure.keyvault.secrets import SecretClient

# Replace these placeholders with actual values
APP_CLIENT_ID = 'YOUR_APP_CLIENT_ID'
RESOURCE_TENANT_ID = 'YOUR_RESOURCE_TENANT_ID'
MI_CLIENT_ID = 'YOUR_MI_CLIENT_ID'
AUDIENCE = 'api://AzureADTokenExchange'

def get_managed_identity_token(credential, audience):
    return credential.get_token(audience).token

managed_identity_credential = ManagedIdentityCredential(client_id=MI_CLIENT_ID)
credential = ClientAssertionCredential(RESOURCE_TENANT_ID, APP_CLIENT_ID, lambda: get_managed_identity_token(managed_identity_credential, AUDIENCE))

client = SecretClient(vault_url='https://{KEYVAULT_NAME}.vault.azure.net', credential=credential)

secret_name = 'VerySecretHiddenString'
retrieved_secret = client.get_secret(secret_name)

print(retrieved_secret.value)
```

### MSAL Python

> [!WARNING]
>
> We strongly advise customers to use higher-level libraries, like [Azure client SDKs](https://azure.microsoft.com/downloads/), where possible.

Since Managed Identity support is not yet natively available in the Python version of MSAL, a workaround is required to fetch the Managed Identity token. This involves making a direct REST call to the Azure Instance Metadata Service (IMDS) endpoint. The retrieved token can then be used as a client assertion to authenticate with Azure services. Below is an example that demonstrates how to implement this approach.

```python
To use MI+FIC from MSAL Python, you'll need to depend on both the requests and msal packages. Managed Identity isn't generally available yet for the Python SKU of MSAL, therefore a REST call is needed against the IMDS endpoint to acquire the MI token.

import requests
import msal

APP_CLIENT_ID = 'YOUR_APP_CLIENT_ID'
RESOURCE_TENANT_ID = 'YOUR_RESOURCE_TENANT_ID'
AUTHORITY = f'https://login.microsoftonline.com/{RESOURCE_TENANT_ID}'
MI_CLIENT_ID = 'YOUR_MI_CLIENT_ID'
AUDIENCE = 'api://AzureADTokenExchange'

def get_managed_identity_token(audience, miClientId):
    url = f'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource={audience}&client_id={miClientId}'
    headers = {'Metadata': 'true'}

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.json()['access_token']
    else:
        return None

app = msal.ConfidentialClientApplication(
    APP_CLIENT_ID, 
    authority=AUTHORITY,    
    client_credential={"client_assertion": get_managed_identity_token(AUDIENCE, MI_CLIENT_ID)}
)

result = app.acquire_token_for_client(['https://vault.azure.net/.default'])

if "access_token" in result:
    print("Got access token!")
```

### [Go](#tab/go)

The example below demonstrates how to connect to an Azure KeyVault, but can be adapted to access any resource protected by Microsoft Entra. The samples are valid in both cases where the resource tenant is in the same tenant as the app registration and the Managed identity or a different tenant.

### Azure Identity library for Go
The below snippet uses [Azure Identity for Go](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity) to get a federated identity credential.

```go
package main

import (
  "context"
  "log"

  "github.com/Azure/azure-sdk-for-go/sdk/azcore/policy"
  "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
)

func main() {
  appClientID := "YOUR_APP_CLIENT_ID"
  tenantID := "YOUR_TENANT_ID"
  managedIdentityClientID := "YOUR_MANAGED_IDENTITY_CLIENT_ID"
  azScopes := []string{"api://AzureADTokenExchange/.default"}

  mic, err := azidentity.NewManagedIdentityCredential(
    &azidentity.ManagedIdentityCredentialOptions{
      ID: azidentity.ClientID(managedIdentityClientID),
    },
  )
  if err != nil {
    log.Fatal("error constructing managed identity credential: ", err)
  }

  getAssertion := func(ctx context.Context) (string, error) {
    tk, err := mic.GetToken(ctx, policy.TokenRequestOptions{Scopes: azScopes})
    return tk.Token, err
  }
  cred, err := azidentity.NewClientAssertionCredential(tenantID, appClientID, getAssertion, nil)
  if err != nil {
    log.Fatal("error constructing client assertion credential: ", err)
  }

  tk, err := cred.GetToken(context.Background(), policy.TokenRequestOptions{Scopes: azScopes})
  if err != nil {
    log.Fatal("error getting token: ", err)
  }

  // TODO: use the access token
  _ = tk.Token
}
```

### MSAL for Go

> [!WARNING]
>
> We strongly advise customers to use higher-level libraries, like [Azure client SDKs](https://azure.microsoft.com/downloads/), where possible.

To use MSAL for go, install the [confidential](https://learn.microsoft.com/en-us/entra/msal/go/packages/confidential/) package or the [MSAL for Go](https://github.com/AzureAD/microsoft-authentication-library-for-go) library:

```bash
go get -u github.com/AzureAD/microsoft-authentication-library-for-go/
```

Since Managed Identity support is not yet natively available in MSAL for Go, a workaround is required to fetch the Managed Identity token. This involves making a direct REST call to the Azure Instance Metadata Service (IMDS) endpoint. The retrieved token can then be used as a client assertion to authenticate with Azure services. Below is an example that demonstrates how to implement this approach.

```go
package main

import (
    "context"
    "encoding/json"
    "fmt"
    "io/ioutil"
    "net/http"

    "github.com/AzureAD/microsoft-authentication-library-for-go/apps/confidential"
)

const (
    TenantID    = "YOUR_TENANT_ID"
    ClientID    = "YOUR_APP_CLIENT_ID"
    Scopes      = "api://AzureADTokenExchange/.default"
    MIClientID  = "YOUR_MI_CLIENT_ID"    
)

func main() {
    msalAccessToken, err := getTokenFromAssertion(func() (string, error) {
        return getMIAccessToken(MIClientID, "api://AzureADTokenExchange")
    }, TenantID, ClientID, Scopes)
    if err != nil {
        fmt.Println("Error getting access token:", err)
        return
    }
}

func getMIAccessToken(clientID, audience string) (string, error) {
    url := fmt.Sprintf("http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=%s&client_id=%s", audience, clientID)

    client := http.Client{}
    req, err := http.NewRequest("GET", url, nil)
    if err != nil {
        return "", err
    }

    req.Header.Add("Metadata", "true")

    resp, err := client.Do(req)
    if err != nil {
        return "", err
    }
    defer resp.Body.Close()

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return "", err
    }

    var response struct {
        AccessToken string `json:"access_token"`
    }
    err = json.Unmarshal(body, &response)
    if err != nil {
        return "", err
    }

    return response.AccessToken, nil
}

func getTokenFromAssertion(assertionProvider func() (string, error), tenantID, clientID, scopes string) (string, error) {
    assertion, err := assertionProvider()
    if err != nil {
        return "", err
    }

    app, err := confidential.New("https://login.microsoftonline.com/"+tenantID, clientID,
        confidential.NewCredFromAssertionCallback(func(ctx context.Context, options confidential.AssertionRequestOptions) (string, error) {
            return assertion, nil
        }))
    if err != nil {
        return "", err
    }

    result, err := app.AcquireTokenByCredential(context.TODO(), []string{scopes})
    if err != nil {
        return "", err
    }

    return result.AccessToken, nil
}
```
---


## See also

- [Important considerations and restrictions for federated identity credentials](workload-identity-federation-considerations.md).