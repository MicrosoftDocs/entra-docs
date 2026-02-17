---
title: Create Agent Identities in Microsoft Agent Identity Platform
description: Learn how to create agent identities that represent AI agents in your test tenant using Microsoft Graph APIs and various authentication libraries.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer, I want to create agent identities that represent my AI agents in Microsoft Entra, so that my agents can securely authenticate.
---

# Create agent identities in agent identity platform

After you create an agent identity blueprint, the next step is to create one or more agent identities that represent AI agents in your test tenant. Agent identity creation is typically performed when provisioning a new AI agent.
	
This article guides you through the process of building a simple web service that creates agent identities via Microsoft Graph APIs.
	
If you want to quickly create agent identities for testing purposes, consider using [this PowerShell module for creating and using agent identities](https://aka.ms/agentidpowershell). 

## Prerequisites

Before creating agent identities, ensure you have:

- [Understand agent identities](./agent-identities.md)
- A configured agent identity blueprint (see [Create an agent blueprint](create-blueprint.md)). Record the agent identity blueprint app ID from the creation process
- A web service or application (running locally or deployed to Azure) that host the agent identity creation logic

## Get an access token using agent identity blueprint

You use the agent identity blueprint to create each agent identity. Request an access token from Microsoft Entra using your agent identity blueprint:

## [Microsoft Graph API](#tab/microsoft-graph-api)

When using a managed identity as a credential, you must first obtain an access token using your managed identity. Managed identity tokens can be requested from an IP address locally exposed in the compute environment. Refer to the [managed identity documentation for details](/entra/identity/managed-identities-azure-resources/).

```
GET http://169.254.169.254/metadata/identity/oauth2/token?api-version=2019-08-01&resource=api://AzureADTokenExchange/.default
Metadata: True
```

After you obtain a token for the managed identity, request a token for the agent identity blueprint:

```
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-blueprint-id>
scope=https://graph.microsoft.com/.default
client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
client_assertion=<msi-token>
grant_type=client_credentials
```

A `client_secret` parameter can also be used instead of `client_assertion` and `client_assertion_type`, when a client secret is being used in local development.


## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

To install Microsoft.Identity.Web:

```ps
dotnet add package Microsoft.Identity.Web
```

*Microsoft.Identity.Web* includes an interface that automatically requests an access token and attaches it to outbound HTTP requests. When using *Microsoft.Identity.Web*, you can skip to the next step.

---

## Create an agent identity

Using the access token acquired in the previous step, you can now create agent identities in your test tenant. Agent identity creation might occur in response to many different events or triggers, such as a user selecting a button to create a new agent.

We recommend you create one agent identity for each agent, but you might choose a different approach based on your needs.

## [Microsoft Graph API](#tab/microsoft-graph-api)

Always include the OData-Version header when using @odata.type.

```
POST https://graph.microsoft.com/beta/serviceprincipals/Microsoft.Graph.AgentIdentity
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>
{
    "displayName": "My Agent Identity",
    "agentIdentityBlueprintId": "<my-agent-blueprint-id>",
    "sponsors@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<id>",
        "https://graph.microsoft.com/v1.0/groups/<id>"
    ],
}
```

## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

To use *Microsoft.Identity.Web* to execute the Microsoft Graph API request to create an agent identity, add the following MISE configuration file:

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<my-test-tenant>",
    "ClientId": "<my-agent-blueprint-id>",
    "Scopes": "access_agent",
    "ClientCredentials": [
        {
            "SourceType": "ClientSecret",
            "ClientSecret": "your-client-secret"
        }
    ]
  },

  "DownstreamApis": {
    "agent-identity": {
      "BaseUrl": "https://graph.microsoft.com",
      "RelativePath": "/beta/serviceprincipals/Microsoft.Graph.AgentIdentity",
      "Scopes": ["00000003-0000-0000-c000-000000000000/.default"],
      "RequestAppToken": true
    }
  }
}
```

The code for the ASP.NET Core app (*Program.cs*) is the following example:

```csharp
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web.Resource;
using Microsoft.IdentityModel.S2S.Extensions.AspNetCore;
using MyAgent;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
    .EnableTokenAcquisitionToCallDownstreamApi();
builder.Services.AddInMemoryTokenCaches();
var app = builder.Build();

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

public class AgentIdentity
{
	[JsonPropertyName("@odata.type")]
	public string @odata_type { get; set; } = "#Microsoft.Graph.AgentIdentity";

	[JsonPropertyName("displayName")]
	public string? displayName { get; set; }

	[JsonPropertyName("agentIdentityBlueprintId")]
	public string? agentIdentityBlueprintId { get; set; }

	[JsonPropertyName("id")]
	public string? id { get; set; }

  [JsonPropertyName("sponsors@odata.bind")]
	public string[]? sponsorsOdataBind { get; set; }

  [JsonPropertyName("owners@odata.bind")]
	public string[]? ownersOdataBind { get; set; }
}

// Create an Agent identity
app.MapGet("/create-agent-identity", async (HttpContext httpContext) =>
{
	try
	{
		// Get the service to call the downstream API (preconfigured in the appsettings.json file)
		IDownstreamApi downstreamApi = httpContext.RequestServices.GetRequiredService<IDownstreamApi>();

		// Call the downstream API with a POST request to create an Agent Identity
		var jsonResult = await downstreamApi.PostForAppAsync<AgentIdentity, AgentIdentity>(
			"agent-identity",
			new AgentIdentity {
			    displayName = "My agent identity",
			    agentIdentityBlueprintId = "<my-agent-blueprint-id>",
          sponsorsOdataBind = new [] { "https://graph.microsoft.com/v1.0/users/<id>" }
			}
		  );
		return jsonResult?.id;
	}
	catch (Exception ex)
	{
		return ex.Message;
	}

})

app.Run();
```

---

## Delete an agent identity

When an agent is deallocated or destroyed, your service should also delete the associated agent identity:

## [Microsoft Graph API](#tab/microsoft-graph-api)

```http
DELETE https://graph.microsoft.com/beta/serviceprincipals/<agent-identity-id>
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>
```

## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

```csharp
// Delete an Agent identity
app.MapGet("/delete-agent-identity", async (HttpContext httpContext, string id) =>
{
	// Get the service to call the downstream API (preconfigured in the appsettings.json file)
	IDownstreamApi downstreamApi = httpContext.RequestServices.GetRequiredService<IDownstreamApi>();

	// Call the downstream API with a DELETE request to remove an Agent Identity
	var jsonResult = await downstreamApi.DeleteForAppAsync<string, string>(
		"agent-identity",
		null!,
		options =>
		{
			options.RelativePath += $"/{id}"; // Specify the ID of the agent identity to delete
		});
	return jsonResult;
})
```
