---
title: Provision agent identities for a fleet with ASP.NET Core
description: Create an agent identity and an optional agent's user account when an agent is deployed to a shared ASP.NET Core runtime, and delete them when it's retired.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building an agent hosting platform with ASP.NET Core, I want to create an agent identity for each agent I deploy so that every agent in my fleet has its own identity.
---

# Provision agent identities for a fleet with ASP.NET Core

When an agent is deployed to the fleet, the provisioning service authenticates as the agent identity blueprint and calls Microsoft Graph. It creates an agent identity and, if the agent needs one, an agent's user account. It records both in the agent directory so the runtime can select them on later token requests. When the agent is retired, the service deletes both identities.

## Prerequisites

- Complete [Set up an agent identity blueprint for a fleet](set-up-blueprint-agent-fleet.md).
- The .NET 8 SDK or later.
- A user or group to assign as each agent's sponsor.
- A verified domain in the tenant for agent's user account user principal names, if agents need them.
- A persistent store for the agent directory, such as a database table.

The snippets extend your ASP.NET Core provisioning service; they aren't a standalone application or a complete `Program.cs`. Implement `IAgentDirectory` with the persistent store and register that implementation before invoking `AgentProvisioner`. Keep the service's existing host startup code.

## Install the packages

```dotnetcli
dotnet add package Microsoft.Identity.Web
dotnet add package Microsoft.Identity.Web.DownstreamApi
```

## Configure the blueprint and Microsoft Graph

Add the blueprint credential and two Microsoft Graph profiles to *appsettings.json*. `RequestAppToken` requests a token for the blueprint itself, not for an agent identity.

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<tenant-id>",
    "ClientId": "<agent-identity-blueprint-client-id>",
    "ClientCredentials": [
      {
        "SourceType": "SignedAssertionFromManagedIdentity",
        "ManagedIdentityClientId": "<managed-identity-client-id>"
      }
    ]
  },
  "DownstreamApis": {
    "agent-identities": {
      "BaseUrl": "https://graph.microsoft.com/",
      "RelativePath": "beta/serviceprincipals/Microsoft.Graph.AgentIdentity",
      "Scopes": [ "https://graph.microsoft.com/.default" ],
      "RequestAppToken": true
    },
    "agent-users": {
      "BaseUrl": "https://graph.microsoft.com/",
      "RelativePath": "v1.0/users/microsoft.graph.agentUser",
      "Scopes": [ "https://graph.microsoft.com/.default" ],
      "RequestAppToken": true
    }
  }
}
```

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

Register the downstream APIs:

```csharp
using Microsoft.Identity.Web;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
    .EnableTokenAcquisitionToCallDownstreamApi()
    .AddInMemoryTokenCaches();

builder.Services.AddDownstreamApis(
    builder.Configuration.GetSection("DownstreamApis"));
builder.Services.AddScoped<AgentProvisioner>();
// Register your IAgentDirectory implementation.
```

## Define the agent directory

The agent directory maps the runtime's agent ID to the agent's identities. Later articles in this path use it to select the identity for each token request.

```csharp
public record AgentRegistration(
    string AgentId,
    string AgentIdentityId,
    string? AgentUserId);

public interface IAgentDirectory
{
    Task<AgentRegistration?> FindAsync(string agentId);
    Task SaveAsync(AgentRegistration registration);
    Task DeleteAsync(string agentId);
}
```

| Field | Value | Used by |
| --- | --- | --- |
| `AgentId` | The runtime's own identifier for the agent. | Lookups |
| `AgentIdentityId` | The agent identity's ID. For an agent identity, the object ID (`id`) and client ID (`appId`) are the same value. | Token requests, creating the agent's user account, and deleting the agent identity |
| `AgentUserId` | The agent's user account object ID, or `null`. | `WithAgentUserIdentity` and deletion |

## Provision an agent

Call the provisioning service from the code that deploys agents, not from an endpoint that agents or users can reach.

```csharp
using System.Text.Json.Serialization;
using Microsoft.Identity.Abstractions;

public class AgentProvisioner(
    IDownstreamApi graph,
    IAgentDirectory directory,
    IConfiguration configuration)
{
    public async Task<AgentRegistration> ProvisionAsync(
        string agentId,
        string displayName,
        string sponsorUserId,
        string? agentUserPrincipalName = null)
    {
        AgentRegistration registration = await directory.FindAsync(agentId)
            ?? await CreateAgentIdentityAsync(agentId, displayName, sponsorUserId);

        if (agentUserPrincipalName is not null && registration.AgentUserId is null)
        {
            registration = await CreateAgentUserAsync(
                registration, displayName, agentUserPrincipalName);
        }

        return registration;
    }

    private async Task<AgentRegistration> CreateAgentIdentityAsync(
        string agentId, string displayName, string sponsorUserId)
    {
        AgentIdentityResponse? identity = await graph
            .PostForAppAsync<AgentIdentityRequest, AgentIdentityResponse>(
                "agent-identities",
                new AgentIdentityRequest(
                    displayName,
                    configuration["AzureAd:ClientId"]!,
                    [$"https://graph.microsoft.com/v1.0/users/{sponsorUserId}"]));

        var registration = new AgentRegistration(
            agentId, identity!.Id, AgentUserId: null);
        await directory.SaveAsync(registration);
        return registration;
    }

    private async Task<AgentRegistration> CreateAgentUserAsync(
        AgentRegistration registration, string displayName, string userPrincipalName)
    {
        AgentUserResponse? agentUser = await graph
            .PostForAppAsync<AgentUserRequest, AgentUserResponse>(
                "agent-users",
                new AgentUserRequest(
                    AccountEnabled: true,
                    displayName,
                    MailNickname: userPrincipalName.Split('@')[0],
                    userPrincipalName,
                    IdentityParentId: registration.AgentIdentityId));

        registration = registration with { AgentUserId = agentUser!.Id };
        await directory.SaveAsync(registration);
        return registration;
    }
}

public record AgentIdentityRequest(
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("agentIdentityBlueprintId")] string AgentIdentityBlueprintId,
    [property: JsonPropertyName("sponsors@odata.bind")] string[] Sponsors)
{
    [JsonPropertyName("@odata.type")]
    public string ODataType => "#Microsoft.Graph.AgentIdentity";
}

public record AgentIdentityResponse(
    [property: JsonPropertyName("id")] string Id);

public record AgentUserRequest(
    [property: JsonPropertyName("accountEnabled")] bool AccountEnabled,
    [property: JsonPropertyName("displayName")] string DisplayName,
    [property: JsonPropertyName("mailNickname")] string MailNickname,
    [property: JsonPropertyName("userPrincipalName")] string UserPrincipalName,
    [property: JsonPropertyName("identityParentId")] string IdentityParentId);

public record AgentUserResponse(
    [property: JsonPropertyName("id")] string Id);
```

The service saves the agent directory entry after each Microsoft Graph call and reuses saved identities on retries. This isn't an atomic transaction with Microsoft Graph. Serialize provisioning for each agent ID, and reconcile a successful Graph call whose response or directory write failed before retrying, to avoid duplicate identities.

Pass `agentUserPrincipalName` only for agents that need an agent's user account. Use a verified domain and a unique alias for each agent. Creating the account doesn't assign licenses, a mailbox, or team membership. For those steps, see [Use an agent's user account with Microsoft 365](agent-user-oauth-flow.md#provision-access).

A new agent identity can take a short time to become available for permission assignments, agent-user creation, and token requests. If Microsoft Graph or the token service reports that the newly created identity or the agent user's parent can't be found, retry with bounded backoff and reuse the saved registration. A new agent user can also take time to be recognized as the principal in a consent grant. Use the same bounded retry approach if Microsoft Graph explicitly reports that the new principal can't be found.

After granting permissions, allow time for those grants to appear in a newly acquired token; retrying with the same cached token doesn't pick up new grants. Don't treat an authorization failure as successful provisioning.

Before continuing, read the saved registration through `IAgentDirectory.FindAsync` using the runtime's agent ID. Confirm it contains the returned agent identity ID and, when requested, the agent user ID. This verifies the directory handoff; it doesn't yet prove downstream API access.

## Grant the agent access

After the agent identity exists, grant it the access that this agent needs. Grant application permissions, delegated permissions, Azure role assignments, and access to other resources directly to the agent identity. Each agent's access then stays separate and visible on its own identity.

- [Grant application permissions](grant-application-permissions-agent-identity.md)
- [Grant delegated permissions](grant-agent-access-microsoft-365.md)

Permissions that are [inherited from the blueprint](set-up-blueprint-agent-fleet.md#optionally-configure-inheritable-permissions) apply to the new agent identity without another grant.

## Retire an agent

Stop routing new requests and scheduling work for the agent, and let its in-flight operations finish before deleting its identities. Retire only that agent's resources; don't delete the shared blueprint or runtime credential while other agents still use them.

Delete the agent's user account before the agent identity, and then remove the agent directory entry:

```csharp
public async Task RetireAsync(string agentId)
{
    AgentRegistration? registration = await directory.FindAsync(agentId);
    if (registration is null)
    {
        return;
    }

    if (registration.AgentUserId is not null)
    {
        await graph.DeleteForAppAsync<string>(
            "agent-users",
            null!,
            options => options.RelativePath += $"/{registration.AgentUserId}");
    }

    await graph.DeleteForAppAsync<string>(
        "agent-identities",
        null!,
        options => options.RelativePath =
            $"beta/serviceprincipals/{registration.AgentIdentityId}");

    await directory.DeleteAsync(agentId);
}
```

Add `RetireAsync` to the `AgentProvisioner` class. Deleted agent identities can be restored for a limited time. For details, see [Delete and restore agent identity objects](howto-delete-agent-identity.md).

Use the single-type `DeleteForAppAsync<TInput>` overload because Microsoft Graph returns `204 No Content`; the two-type overload tries to deserialize a response body. In production, make retirement retry-safe by treating `404 Not Found` as already deleted and reconciling the directory after partial failures.

## Use Agent 365 provisioning instead

If agents are created through Agent 365, Agent 365 creates the agent identity. Instead of calling Microsoft Graph, listen for Agent 365 agent provisioning events, read the agent identity ID from each event, and save an `AgentRegistration` in the agent directory. For event details, see the [Agent 365 developer documentation](/microsoft-agent-365/developer/).

## Next step

[Call APIs as an agent in a fleet with ASP.NET Core](aspnet-core-fleet-call-apis-as-agent.md)

## Related content

- [Create and delete agent identities](create-delete-agent-identities.md)
- [Create and delete an agent's user account](create-delete-agent-user-account.md)
- [Plan an agent fleet on a shared runtime](plan-agent-fleet.md)
