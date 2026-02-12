---
title: Call Azure services from an agent  using .NET Azure SDK
titleSuffix: Microsoft Entra Agent ID
description: Learn how to call Azure services  using .NET Azure SDK from an agent using agent identities.
author: SHERMANOUKO
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer building AI agents, I want to call Azure services from my agent using agent identities so that the agent can securely access Azure resources like Storage and Key Vault.
---

# Call Azure services from your agent using .NET Azure SDK

This article guides you on how to call Azure services from your agent. To authenticate to Azure services such as Azure Storage or Azure Key Vault using agent identities, use the `MicrosoftIdentityTokenCredential` class from *Microsoft.Identity.Web.Azure*. The `MicrosoftIdentityTokenCredential` class implements Azure SDK's `TokenCredential` interface, enabling seamless integration between *Microsoft.Identity.Web* and Azure SDK clients.

[!INCLUDE [Common call API content](./includes/call-api-common-dotnet.md)]

## Implementation steps

1. Install the Azure integration package and the *Microsoft.Identity.Web.AgentIdentities* package to add support for agent identities.

    ```bash
    dotnet add package Microsoft.Identity.Web.Azure
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Install the Azure SDK package you want to use, for example, Azure Storage:

    ```bash
    dotnet add package Azure.Storage.Blobs
    ```

1. Configure your services to add Azure token credential support:
 
    ```csharp
    using Microsoft.Identity.Web;

    var builder = WebApplication.CreateBuilder(args);

    // Add authentication
    builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"))
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();

    // Add Azure token credential support
    builder.Services.AddMicrosoftIdentityAzureTokenCredential();

    builder.Services.AddControllersWithViews();
    var app = builder.Build();
    app.UseAuthentication();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
    ```

1. Configure Azure token credential options in *appsettings.json*

    [!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "TenantId": "<your-tenant>",
        "ClientId": "<agent-blueprint-id>",
    
       // Other client creedentials available. See <https://aka.ms/ms-id-web/client-credentials>
        "ClientCredentials": [
          {
            "SourceType": "ClientSecret",
            "ClientSecret": "your-client-secret"
          }
        ]   
      }
    }
    ```

1. Acquire a token credential from the service provider and use it with Azure SDK clients. 

    1. For agent identities, you can acquire either an app only token (autonomous agents) or an on-behalf of user token (interactive agents) by using the `WithAgentIdentity` method. For app only tokens, set the `RequestAppToken` property to `true`. For delegated on-behalf of user tokens, don't set the `RequestAppToken` property or explicitly set it to `false`.

        ```csharp
        using Microsoft.Identity.Web;
        
        public class AgentService
        {
            private readonly MicrosoftIdentityTokenCredential _credential;
            
            public AgentService(MicrosoftIdentityTokenCredential credential)
            {
                _credential = credential;
            }
            
            // Call Azure service with the agent identity for app only scenario
            public async Task<List<string>> ListBlobsForAgentAsync(string agentIdentity)
            {
                // Configure for agent identity
                string agentIdentity = "agent-identity-guid";
                _credential.Options.WithAgentIdentity(agentIdentity);
                _credential.Options.RequestAppToken = true;
                
                var blobClient = new BlobServiceClient(
                    new Uri("https://myaccount.blob.core.windows.net"),
                    _credential);
                
                var container = blobClient.GetBlobContainerClient("agent-data");
                var blobs = new List<string>();
                
                await foreach (var blob in container.GetBlobsAsync())
                {
                    blobs.Add(blob.Name);
                }
                
                return blobs;
            }

            // Call Azure service with the agent identity for on-behalf of user scenario
            public async Task<List<string>> ListBlobsForAgentAsync(string agentIdentity)
            {
                // Configure for agent identity
                var blobClient = new BlobServiceClient(
                    new Uri("https://myaccount.blob.core.windows.net"));
                
                var container = blobClient.GetBlobContainerClient("agent-data");
                var blobs = new List<string>();
                
                await foreach (var blob in container.GetBlobsAsync())
                {
                    blobs.Add(blob.Name);
                }
                
                return blobs;
            }
        }
        ```


    1. You can also acquire a token for an agent user. To do this, you can use either User Principal Name (UPN) or Object Identity (OID) to identify the agent user.

        For object ID:
        
        ```csharp
        using Microsoft.Identity.Web;
        
        public class AgentService
        {
            private readonly MicrosoftIdentityTokenCredential _credential;
            
            public AgentService(MicrosoftIdentityTokenCredential credential)
            {
                _credential = credential;
            }
            
            // Use object ID to identify the agent user
            public async Task<List<string>> ListBlobsForAgentAsync(string agentIdentity)
            {
                // Configure for agent identity
                string agentIdentity = "agent-identity-guid";
                string userOid = "user-object-id";
                _credential.Options.WithAgentUserIdentity(agentIdentity, userOid);
        
                var blobClient = new BlobServiceClient(
                    new Uri("https://myaccount.blob.core.windows.net"),
                    _credential);
                
                var container = blobClient.GetBlobContainerClient("agent-data");
                var blobs = new List<string>();
                
                await foreach (var blob in container.GetBlobsAsync())
                {
                    blobs.Add(blob.Name);
                }
                
                return blobs;
            }

            // Use UPN to identify the agent user\
            public async Task<List<string>> ListBlobsForAgentAsync(string agentIdentity)
            {
                // Configure for agent identity
                string agentIdentity = "agent-identity-guid";
                string userUpn = "user@contoso.com";
        
                _credential.Options.WithAgentUserIdentity(agentIdentity, userUpn);
        
                var blobClient = new BlobServiceClient(
                    new Uri("https://myaccount.blob.core.windows.net"),
                    _credential);
        
                var container = blobClient.GetBlobContainerClient("agent-data");
                var blobs = new List<string>();
        
                await foreach (var blob in container.GetBlobsAsync())
                {
                    blobs.Add(blob.Name);
                }
        
                return blobs;
            }
        }
        ```

## Related content

- [Call custom APIs](./call-api-custom.md)
- [Call Microsoft Graph](./call-api-microsoft-graph.md)
