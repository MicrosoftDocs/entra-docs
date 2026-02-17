---
title: Request agent user tokens for autonomous agents
description: Learn how to create agent users and authenticate using agent identities to obtain delegated access tokens for systems that require user accounts.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/10/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrcok

#customer-intent: As a developer, I want to create agent users for my autonomous agents and authenticate as those users, so that my agents can connect to systems that require user account representation while maintaining proper security controls.
---

# Request agent user tokens for autonomous agents

In addition to requesting tokens using an agent identity, autonomous agents can also authenticate using an agent user. Agent users are a special type of user account in Microsoft Entra purpose-built for use by agents. They're most commonly used when an agent needs to connect to systems that require the existence of a user account. For instance, mailbox, teams channel, or other user-specific resources.

This guide walks you through creating an agent user in a tenant and requesting tokens as the agent user. Each agent identity can only have a single associated agent user, and each agent user can only be associated with a single agent identity.

## Prerequisites

- [Understand agent users in Microsoft Entra Agent ID](agent-users.md)
- A created agent identity blueprint and at least one agent identity as described in [Create and delete agent identities](create-delete-agent-identities.md)

## Get authorization

To create agent users, your agent identity blueprint must be granted the application permission `AgentIdUser.ReadWrite.IdentityParentedBy` in the tenant. You can obtain authorization in one of two ways:

- [Request agent authorization](./autonomous-agent-request-authorization-entra-admin.md#request-authorization-from-a-tenant-administrator). Be sure to use your agent identity blueprint as the `client_id`, not the agent identity.
- [Manually create an appRoleAssignment](./autonomous-agent-request-authorization-entra-admin.md#create-an-app-role-assignment-via-apis) in the tenant. Be sure to use the object ID of the agent identity blueprint principal as the `principalId` value. Don't use the ID of your agent identity blueprint.

If you wish to use a different client, not the agent identity blueprint, to create agent users, that client needs to obtain the `AgentIdUser.ReadWrite.All` delegated or application permission instead.

## Create an agent user

This section covers creating an agent user using your agent identity blueprint or other approved client. The recommended way to create an agent user is using your agent identity blueprint. You [require an access token](./create-delete-agent-identities.md#get-an-access-token-using-agent-identity-blueprint) to create an agent user.

## [REST](#tab/rest)

Once you have an access token with the necessary permission, make the following request:

```http
POST https://graph.microsoft.com/beta/users
OData-Version: 4.0
Content-Type: application/json
Authorization: Bearer <token>

{
  "@odata.type": "microsoft.graph.agentUser",
  "displayName": "New Agent User",
  "userPrincipalName": "agentuserupn@tenant.onmicrosoft.com",
  "identityParentId": "{agent-identity-id}",
  "mailNickname": "agentuserupn",
  "accountEnabled": true
}
```

## [Microsoft.Identity.Web](#tab/msidweb)

To use `Microsoft.Identity.Web` to create an agent user, follow these steps:

1. Add the following to your config file:

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "TenantId": "<my-test-tenant>",
        "ClientId": "<my-agent-blueprint-id>",
        "Scopes": "access_agent",
        "ClientCredentials": [
          {
            "SourceType": "SignedAssertionFromManagedIdentity",
            "ManagedIdentityClientId": "managed-identity-client-id"  // Omit for system-assigned
          }
        ]
      },
    
      "DownstreamApis": {
        "agent-identity": {
          "BaseUrl": "https://graph.microsoft.com",
          "RelativePath": "/v1.0/users",
          "Scopes": ["00000003-0000-0000-c000-000000000000/.default"],
          "RequestAppToken": true
        }
      }
    }
    ```

1. Add required packages

    ```bash
    dotnet add package Microsoft.Identity.Web
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Configure services.

    ```csharp
    using Microsoft.Identity.Abstractions;
    using Microsoft.Identity.Web.Resource;
    using Microsoft.IdentityModel.S2S.Extensions.AspNetCore;

    var builder = WebApplication.CreateBuilder(args);
    
    // Add services to the container.
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi();
    builder.Services.AddAgentIdentities();
    builder.Services.AddInMemoryTokenCaches();
    
    var app = builder.Build();
    app.UseHttpsRedirection();
    app.UseAuthentication();
    app.UseAuthorization();
    app.Run()
    ```
    
1. Create the agent user creation endpoint

    ```csharp
    app.MapGet("/create-agent-id-user", async (HttpContext httpContext) =>
    {
        try
        {
            // Get the service to call the downstream API (preconfigured in the appsettings.json file)
            IDownstreamApi downstreamApi = httpContext.RequestServices.GetRequiredService<IDownstreamApi>();
    
            var requestBody = new AgentIdUser
            {
                displayName = "my-agent-name",
                mailNickname = "my-agent-alias",
                userPrincipalName = "my-agent-email-address",
                accountEnabled = true,
                identityParentId = "<associated-agent-identity-id>"
            };
    
            // Call the downstream API (Graph) with a POST request to create an Agent User
            var jsonResult = await downstreamApi.PostForAppAsync<AgentIdUser, AgentIdUser>(
                "agent-identity",
                requestBody
            );
    
            return Results.Json(jsonResult);
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    })
    ```
    
---

Once you have your agent user created, you don't need to configure anything else. These users don't have any credentials and can only be authenticated using the protocol described in the next sections.

## Grant consent to agent identity

Agent users behave like any other user account. Before you can request tokens using your agent user, you need to authorize the agent identity to act on its behalf. You can authorize the agent identity using admin authorization as described in [Request authorization from Microsoft Entra admin](autonomous-agent-request-authorization-entra-admin.md) or manually create an `oAuth2PermissionGrant` using Microsoft Graph or Microsoft Graph PowerShell.

For Microsoft Graph, your request is as shown in the following snippet:

```http
POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
Authorization: Bearer {token}
Content-Type: application/json

{
  "clientId": "{agent-identity-id}",
  "consentType": "Principal",
  "principalId": "{agent-id-user-object-id}",
  "resourceId": "{ms-graph-service-principal-object-id}",
  "scope": "Mail.Read"
}
```

For Microsoft Graph PowerShell, use the following script:

```powershell
Connect-MgGraph -Scopes "DelegatedPermissionGrant.ReadWrite.All" -TenantId <your-test-tenant>

# Get the service principal for Microsoft Graph
$graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"

# Get the service principal for your client app
$clientSp = Get-MgServicePrincipal -Filter "appId eq '{agent-identity-id}'"

# Create the delegated permission grant
New-MgOauth2PermissionGrant -BodyParameter @{
    clientId    = $clientSp.Id
    consentType = "Principal"
    principalId = "{agent-id-user-object-id}"
    resourceId  = $graphSp.Id
    scope       = "Mail.Read"
}
```

## Request agent user token

To authenticate an agent user, you need to follow a three-step process:

- Get a token as the agent identity blueprint
- Use that token to get another token as the agent identity
- Use both previous tokens to get another token as the agent user.

## [REST](#tab/rest)

First, request a token as the agent identity blueprint, as described in [Request agent tokens](autonomous-agent-request-tokens.md). Once you have your agent app token, use it to request a Federated Identity Credential (FIC) for your agent identity:

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-id>
&scope=api://AzureADTokenExchange/.default
&grant_type=client_credentials
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token>
```

This example gives you an access token you can use to authenticate your agent user. To use it, make a request like:

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-id>
&scope=https://graph.microsoft.com/.default
&grant_type=user_fic
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token>
&user_id=<agent-user-object-id>
&user_federated_identity_credential=<agent-identity-token>
```

This gives you a delegated access token you can use to call Microsoft Graph as your agent user. You can use `user_id=<user-object-id>` instead of `username=<UPN>` for the user identifier.

## [Microsoft.Identity.Web](#tab/msidweb)

*Microsoft.Identity.Web* handles the token acquisition for you. Use the `.WithAgentUserIdentity()` pattern to request access tokens.

```csharp
// Get the service to call the downstream API (preconfigured in the appsettings.json file)
IAuthorizationHeaderProvider authorizationHeaderProvider = serviceProvider.GetService<IAuthorizationHeaderProvider>();

// Configure options for the agent user identity
string agentIdentity = "agent-identity-id";
string userId = "<user-object-id>";
var options = new AuthorizationHeaderProviderOptions()
    .WithAgentUserIdentity(agentIdentity, userId);

// Create a ClaimsPrincipal to enable token caching
ClaimsPrincipal user = new ClaimsPrincipal();

// Acquire a user token
string authHeader = await authorizationHeaderProvider
    .CreateAuthorizationHeaderForUserAsync(
        scopes: ["https://graph.microsoft.com/.default"],
        options: options,
        user: user);
```
 You can also use the agent user principal name instead of the object ID.

---

## Related content

- [Request agent tokens](autonomous-agent-request-tokens.md)
- [Request authorization from Microsoft Entra admin](autonomous-agent-request-authorization-entra-admin.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
- [Acquire token using Microsoft Entra SDK for agent ID](./microsoft-entra-sdk-for-agent-identities.md)
