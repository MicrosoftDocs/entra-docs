---
title: Call Microsoft Graph API from an agent using .NET
titleSuffix: Microsoft Entra Agent ID
description: Learn how to call Microsoft Graph API from an agent using agent identities or agent users, including authentication configuration and implementation steps.
author: SHERMANOUKO
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer building AI agents, I want to call Microsoft Graph API from my agent using agent identities so that the agent can access organizational data and resources securely.
---

# Call a Microsoft Graph API from an agent using .NET

This article explains how to call a Microsoft Graph API from an agent using agent identities or agent user.

[!INCLUDE [Common call API content](./includes/call-api-common-dotnet.md)]

## Call a Microsoft Graph API

1. Install the *Microsoft.Identity.Web.GraphServiceClient* that handles authentication for the Graph SDK and the *Microsoft.Identity.Web.AgentIdentities* package to add support for agent identities.

    ```bash
    dotnet add package Microsoft.Identity.Web.GraphServiceClient
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Add the support for Microsoft Graph and agent identities in your service collection.

    ```csharp
    using Microsoft.Identity.Web;
    
    var builder = WebApplication.CreateBuilder(args);
    
    // Add authentication (web app or web API)
    builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"))
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();
    
    // Add Microsoft Graph support
    builder.Services.AddMicrosoftGraph();
    
    // Add Agent Identities support
    builder.Services.AddAgentIdentities();
    
    var app = builder.Build();
    app.UseAuthentication();
    app.UseAuthorization();
    app.Run();
    ``` 

1. Configure Graph and agent identity options in *appsettings.json*.

    [!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "TenantId": "<my-test-tenant>",
        "ClientId": "<agent-blueprint-client-id>",
        "ClientCredentials": [
          {
            "SourceType": "ClientSecret",
            "ClientSecret": "your-client-secret"
          }
        ]
      },
      "DownstreamApis": {
        "MicrosoftGraph": {
          "BaseUrl": "https://graph.microsoft.com/v1.0",
          "Scopes": ["User.Read", "User.ReadBasic.All"]
        }
      }
    }
    ```

1. You can now get the `GraphServiceClient` injecting it in your service or from the service provider and call Microsoft Graph.

  - For agent identities, you can acquire either an app only token (autonomous agents) or an on-behalf of user token (interactive agents) by using the `WithAgentIdentity` method. For app only tokens, set the `RequestAppToken` property to `true`. For delegated on-behalf of user tokens, don't set the `RequestAppToken` property or explicitly set it to `false`.

      ```csharp
      // Get the GraphServiceClient
      GraphServiceClient graphServiceClient = serviceProvider.GetRequiredService<GraphServiceClient>();
        
      string agentIdentity = "agent-identity-guid";
        
      // Call Microsoft Graph APIs with the agent identity for app only scenario
      var applications = await graphServiceClient.Applications
          .GetAsync(r => r.Options.WithAuthenticationOptions(options =>
          {
              options.WithAgentIdentity(agentIdentity);
              options.RequestAppToken = true; // Set to true for app only
          }));

      // Call Microsoft Graph APIs with the agent identity for on-behalf of user scenario
      var applications = await graphServiceClient.Applications
          .GetAsync(r => r.Options.WithAuthenticationOptions(options =>
          {
              options.WithAgentIdentity(agentIdentity);
              options.RequestAppToken = false; // False to show it's on-behalf of user
          }));
      ```

    - For agent user identities, you can specify either User Principal Name (UPN) or Object Identity (OID) to identify the agent user by using the `WithAgentUserIdentity` method.

        ```csharp
        // Get the GraphServiceClient
        GraphServiceClient graphServiceClient = serviceProvider.GetRequiredService<GraphServiceClient>();
        
        string agentIdentity = "agent-identity-guid";
        
        // Call Microsoft Graph APIs with the agent user identity using UPN
        string userUpn = "user-upn";
        var me = await graphServiceClient.Me
            .GetAsync(r => r.Options.WithAuthenticationOptions(options =>
                options.WithAgentUserIdentity(agentIdentity, userUpn)));
        
        // Or using OID
        string userOid = "user-object-id";
        var me = await graphServiceClient.Me
            .GetAsync(r => r.Options.WithAuthenticationOptions(options =>
                options.WithAgentUserIdentity(agentIdentity, userOid)));
        ```

## Related content

- [Call custom APIs](./call-api-custom.md)
- [Call Azure SDKs](./call-api-azure-services.md)
