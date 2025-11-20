---
title: Request agent tokens for autonomous agents
description: Learn how to authenticate autonomous agents with Microsoft Entra ID and obtain access tokens using their agent identity through a three-step process.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock
#customer-intent: As a developer, I want to implement secure token authentication for my autonomous agents, so that my agents can authenticate independently and access Microsoft Graph and other resources without user delegation.
---

# Request agent tokens for autonomous agents

When agents perform operations using their own identity, rather than acting as a delegate of a user, they're called *autonomous agents*. To perform operations, agents must first authenticate with Microsoft Entra ID and obtain an access token using their agent identity (agent ID). This article walks you through the process of requesting an access token for an agent identity in Microsoft Entra ID using a two-step process. You'll:

- Obtain a token for an agent identity blueprint.
- Exchange the agent identity blueprint token for an agent ID token.

## Prerequisites

Before implementing agent token authentication, ensure you have:

- [An agent identity](create-delete-agent-identities.md). You'll need the agent identity client ID.
- Understand [oauth protocols in Microsoft Entra Agent ID](./agent-oauth-protocols.md)
- [An agent identity blueprint](./create-blueprint.md).

## Configure your client credentials

Get your client credential details. This could be your client secret, a certificate or a managed identity that you are using as a federated identity credential.

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

## [Microsoft Graph API](#tab/Microsoft-graph-api)

Proceed to the next step

## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<your-tenant-id>",
    "ClientId": "<agent-blueprint-clientid>",
    "ClientCredentials": [
      {
        "SourceType": "ClientSecret",
        "ClientSecret": "your-client-secret"
        }
    ]
  }
}
```

---

## Request a token for the agent identity blueprint

When requesting the token for the agent identity blueprint, provide the agent ID's client ID in the `fmi_path` parameter. Provide the `client_secret` parameter instead of `client_assertion` and `client_assertion_type` when using a client secret as a credential during local development. For certificates and managed identities, use  `client_assertion` and `client_assertion_type`.

## [Microsoft Graph API](#tab/Microsoft-graph-api)

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-blueprint-client-id>
&scope=api://AzureADTokenExchange/.default
&grant_type=client_credentials
&client_secret=<client-secret>
&fmi_path=<agent-identity-client-id>
```

## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

With *Microsoft.Identity.Web*, you don't need to request explicitly a token for the agent identity blueprint. *Microsoft.Identity.Web* does it for you.

```bash
dotnet add package Microsoft.Identity.Web
dotnet add package Microsoft.Identity.Web.AgentIdentities
```

---

## Request an agent identity token

## [Microsoft Graph API](#tab/Microsoft-graph-api)

Once you have the agent identity blueprint token (T1), use it to request for the agent identity token.

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-client-id>
&scope=https://graph.microsoft.com/.default
&grant_type=client_credentials
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token-T1>
```

## [Microsoft.Identity.Web](#tab/microsoft-identity-web)

*Microsoft.Identity.Web* handles the details of token acquisition protocol for you, provided you use the new `services.AddAgentIdentities()` in your service collection at the initialization of the application.

Initialize the application:

```csharp
// Program.cs
using Microsoft.AspNetCore.Authorization;
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.Resource;
using Microsoft.Identity.Web.TokenCacheProviders.InMemory;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration);
builder.Services.AddAgentIdentities();
builder.Services.AddInMemoryTokenCaches();
```

Use the `.WithAgentIdentity()` pattern to request access tokens:

```csharp
// Get the service to call the downstream API (preconfigured in the appsettings.json file)
IAuthorizationHeaderProvider authorizationHeaderProvider = serviceProvider.GetService<IAuthorizationHeaderProvider>();
AuthorizationHeaderProviderOptions options = new AuthorizationHeaderProviderOptions().WithAgentIdentity("<agent-identity-client-id>");

// Request agent identity tokens
string authorizationHeaderWithAppTokens = await authorizationHeaderProvider.CreateAuthorizationHeaderForAppAsync("https://resource/.default", options);

// The authHeader contains "Bearer " + the access token (or another protocol
// depending on the options)
```

---

## Related content

- [Agent identity access token claims](./agent-token-claims.md)
- [Acquire token using Microsoft Entra SDK for agent ID](./microsoft-entra-sdk-for-agent-identities.md)
