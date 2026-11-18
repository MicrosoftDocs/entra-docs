---
title: Call APIs as an agent in a fleet with ASP.NET Core
description: Select the agent identity for each app-only token request in a shared ASP.NET Core runtime that hosts many agents.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with ASP.NET Core, I want each agent in my fleet to call APIs with its own agent identity.
---

# Call APIs as an agent in a fleet with ASP.NET Core

In a fleet, the runtime acquires app-only tokens for many agents with one blueprint credential. Look up the agent's identity in the agent directory, and pass it to `WithAgentIdentity` on each token request. The token request is otherwise the same as for a single agent.

## Prerequisites

- Complete [Provision agent identities for a fleet with ASP.NET Core](aspnet-core-fleet-provision-agent-identities.md).
- Application permissions for the target API, [granted to the agent identity](grant-application-permissions-agent-identity.md) or [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions).
- A Redis service reachable from the runtime. Set `Redis:ConnectionString` in the runtime's configuration, using your hosting platform's protected configuration for connection credentials.

## Install the packages

```dotnetcli
dotnet add package Microsoft.Identity.Web
dotnet add package Microsoft.Identity.Web.AgentIdentities
dotnet add package Microsoft.Extensions.Caching.StackExchangeRedis
```

## Configure the runtime

Use the same `AzureAd` section and blueprint credential as the provisioning service. Register Agent ID support and a distributed token cache:

Apply these registrations before `builder.Build()` in your ASP.NET Core runtime. The snippets extend that project; they aren't a complete `Program.cs`. Keep its startup pipeline and register the persistent `IAgentDirectory` implementation from the provisioning step.

```csharp
using Microsoft.Identity.Web;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
    .EnableTokenAcquisitionToCallDownstreamApi()
    .AddDistributedTokenCaches();

builder.Services.AddStackExchangeRedisCache(options =>
    options.Configuration = builder.Configuration["Redis:ConnectionString"]);

builder.Services.AddAgentIdentities();
builder.Services.AddHttpClient();
builder.Services.AddAuthorization();
builder.Services.AddScoped<FleetTokenService>();
// Register your IAgentDirectory implementation.
```

The runtime caches tokens for every agent identity in the fleet. Use a distributed token cache so the cache is shared across runtime instances and survives restarts. For options, see [Token cache serialization](/entra/msal/dotnet/how-to/token-cache-serialization).

## Get a token for an agent

Create a service that resolves the agent identity and acquires a token for it. The runtime passes its own agent ID, never an agent identity client ID taken from a request or from agent output.

```csharp
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web;

public class FleetTokenService(
    IAgentDirectory directory,
    IAuthorizationHeaderProvider authorizationHeaderProvider)
{
    public async Task<string> CreateAuthorizationHeaderForAgentAsync(
        string agentId, string scope)
    {
        AgentRegistration registration = await GetRegistrationAsync(agentId);

        var options = new AuthorizationHeaderProviderOptions()
            .WithAgentIdentity(registration.AgentIdentityId);

        return await authorizationHeaderProvider
            .CreateAuthorizationHeaderForAppAsync(scope, options);
    }

    private async Task<AgentRegistration> GetRegistrationAsync(string agentId) =>
        await directory.FindAsync(agentId)
            ?? throw new InvalidOperationException($"Agent '{agentId}' isn't provisioned.");
}
```

Call the service from the code that runs the agent's work, such as a scheduled job or message handler:

```csharp
using System.Net.Http.Headers;

string authorizationHeader = await fleetTokenService
    .CreateAuthorizationHeaderForAgentAsync(agentId, "api://<custom-api-client-id>/.default");

HttpClient client = httpClientFactory.CreateClient();
client.DefaultRequestHeaders.Authorization =
    AuthenticationHeaderValue.Parse(authorizationHeader);

using HttpResponseMessage response =
    await client.GetAsync("https://api.contoso.com/data");
response.EnsureSuccessStatusCode();
```

Don't expose `FleetTokenService` to agent code that the runtime doesn't trust. Code that can call it can request a token for any agent in the fleet.

## Call specific resources

Use the resource scopes and permission setup from the linked articles, while keeping the fleet's blueprint configuration and `AddAgentIdentities` registration. The single-instance samples use the configured client ID directly and omit identity overrides. For each fleet request, use `FleetTokenService` to select the directory entry. The Microsoft Graph and Azure SDK examples in this article show explicit SDK options.

| Resource | Scope | Guidance |
| --- | --- | --- |
| Custom API | `api://<custom-api-client-id>/.default` | [Call a custom API as an agent](call-api-custom.md) |
| Azure services | The service's `.default` scope, such as `https://storage.azure.com/.default` | [Call Azure services as an agent](call-api-azure-services.md) |
| Microsoft Graph | `https://graph.microsoft.com/.default` | [Call Microsoft Graph as an agent](call-api-microsoft-graph.md) |

### Use the Microsoft Graph SDK

Install `Microsoft.Identity.Web.GraphServiceClient` and register the client:

```dotnetcli
dotnet add package Microsoft.Identity.Web.GraphServiceClient
```

```csharp
builder.Services.AddMicrosoftGraph(options =>
{
    options.BaseUrl = "https://graph.microsoft.com/v1.0";
    options.Scopes = ["https://graph.microsoft.com/.default"];
});
```

After resolving `registration` from the directory in trusted runtime code, select that agent on each Graph request:

```csharp
using Microsoft.Graph;
using Microsoft.Identity.Web;

var users = await graphClient.Users.GetAsync(request =>
    request.Options.WithAuthenticationOptions(options =>
    {
        options.RequestAppToken = true;
        options.WithAgentIdentity(registration.AgentIdentityId);
    }));
```

The operation requires an application permission such as `User.Read.All`. Don't remove `WithAgentIdentity` when adapting the single-instance Graph sample.

### Use an Azure SDK client

Install the identity integration and the resource SDK, and register the credential:

```dotnetcli
dotnet add package Microsoft.Identity.Web.Azure
dotnet add package Azure.Storage.Blobs
```

```csharp
builder.Services.AddMicrosoftIdentityAzureTokenCredential();
```

For each agent operation, create a separate dependency injection scope. Set `MicrosoftIdentityTokenCredential.Options.RequestAppToken` to `true` for app-only access, and pass the resolved `registration.AgentIdentityId` to `credential.Options.WithAgentIdentity`. This selects the fleet agent whose token the Azure SDK client requests:

```csharp
using Azure.Storage.Blobs;
using Microsoft.Identity.Web;

using IServiceScope agentScope = serviceScopeFactory.CreateScope();
var credential = agentScope.ServiceProvider
    .GetRequiredService<MicrosoftIdentityTokenCredential>();
credential.Options.RequestAppToken = true;
credential.Options.WithAgentIdentity(registration.AgentIdentityId);

var blobs = new BlobServiceClient(
    new Uri("https://<storage-account>.blob.core.windows.net"),
    credential);
var properties = await blobs.GetPropertiesAsync();
```

Inject `IServiceScopeFactory` as `serviceScopeFactory`. The credential has mutable options: don't share it or its Azure SDK client across agents, and finish the operation before disposing the scope. Assign the required Azure role to the agent identity, not to the blueprint or the runtime's managed identity.

## Next step

[Call APIs as an agent's user account in a fleet with ASP.NET Core](aspnet-core-fleet-call-apis-as-agent-user.md)

## Related content

- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
- [Validate Agent ID tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md)
