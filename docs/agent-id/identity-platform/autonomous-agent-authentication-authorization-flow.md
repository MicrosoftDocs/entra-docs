---
title: Authenticate and acquire tokens for autonomous agents
description: Learn how to authenticate autonomous agents with Microsoft Entra ID, grant application permissions, and optionally create and authenticate as an agent's user account.
titleSuffix: Microsoft Entra Agent ID
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: how-to
ms.date: 03/30/2026
ms.custom: agent-id-ignite
ms.reviewer: jomondi, dastrock
ai-usage: ai-assisted

#customer-intent: As a developer building autonomous agents, I want to authenticate my agent, grant it application permissions, and optionally create an agent's user account, so that my agent can operate independently and access Microsoft Graph and other resources.
---

# Authenticate and acquire tokens for autonomous agents

Autonomous agents perform operations using their own identity rather than acting as a delegate of a user. To operate securely, an autonomous agent must authenticate with Microsoft Entra ID, obtain access tokens, and be granted the appropriate permissions. This article walks you through the end-to-end flow:

1. Configure client credentials.
1. Request a token for the agent identity blueprint.
1. Request an agent identity token.
1. Grant application permissions (admin consent).
1. (Optional) Create and authenticate as an agent's user account for resources that require a user identity.

> [!NOTE]
> This article covers autonomous agents that operate with their own identity. If your agent needs to act on behalf of a signed-in user, see [Authenticate users and acquire tokens for interactive agents](interactive-agent-authentication-authorization-flow.md).

## Prerequisites

Before implementing agent token authentication, ensure you have:

- [An agent identity blueprint](./create-blueprint.md).
- [An agent identity](create-delete-agent-identities.md). You need the agent identity client ID.
- Understanding of [OAuth protocols in Microsoft Entra Agent ID](./agent-oauth-protocols.md).

For admin authorization, you also need:

- Administrator privileges in your Microsoft Entra ID tenant.
- Understanding of the specific permissions your agent requires.

For agent's user account authentication, you also need:

- Understanding of [agents' user accounts in Microsoft Entra Agent ID](agent-users.md).

## Configure your client credentials

Get your client credential details. This could be your client secret, a certificate, or a managed identity that you're using as a federated identity credential.

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

### [Microsoft Graph API](#tab/Microsoft-graph-api)

Gather the credential you configured on your agent identity blueprint. You need one of the following:

- **Managed identity** (recommended): The managed identity client ID and a token from the Azure Instance Metadata Service (IMDS).
- **Certificate**: The certificate thumbprint or PFX file.
- **Client secret** (development only): The secret value.

### [Microsoft.Identity.Web](#tab/microsoft-identity-web)

For production, use a managed identity as a federated identity credential:

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<your-tenant-id>",
    "ClientId": "<agent-blueprint-clientid>",
    "ClientCredentials": [
      {
        "SourceType": "SignedAssertionFromManagedIdentity",
        "ManagedIdentityClientId": "<managed-identity-client-id>"
      }
    ]
  }
}
```

For local development and testing only, you can use a client secret instead:

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

When requesting the token for the agent identity blueprint, provide the agent identity's client ID in the `fmi_path` (Federated Managed Identity path) parameter. This parameter tells Microsoft Entra ID which agent identity the blueprint is acting on behalf of.

When using a client secret during local development, provide the `client_secret` parameter. For certificates and managed identities, use `client_assertion` and `client_assertion_type` instead.

### [Microsoft Graph API](#tab/Microsoft-graph-api)

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-blueprint-client-id>
&scope=api://AzureADTokenExchange/.default
&grant_type=client_credentials
&client_secret=<client-secret>
&fmi_path=<agent-identity-client-id>
```

### [Microsoft.Identity.Web](#tab/microsoft-identity-web)

With *Microsoft.Identity.Web*, you don't need to explicitly request a token for the agent identity blueprint. *Microsoft.Identity.Web* does it for you.

```bash
dotnet add package Microsoft.Identity.Web
dotnet add package Microsoft.Identity.Web.AgentIdentities
```

---

## Request an agent identity token

### [Microsoft Graph API](#tab/Microsoft-graph-api)

Once you have the agent identity blueprint token (T1), use it to request the agent identity token.

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-client-id>
&scope=https://graph.microsoft.com/.default
&grant_type=client_credentials
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token-T1>
```

### [Microsoft.Identity.Web](#tab/microsoft-identity-web)

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
// In an API endpoint or service method where HttpContext is available
app.MapGet("/call-api", async (HttpContext httpContext) =>
{
    IAuthorizationHeaderProvider authorizationHeaderProvider =
        httpContext.RequestServices.GetRequiredService<IAuthorizationHeaderProvider>();

    AuthorizationHeaderProviderOptions options =
        new AuthorizationHeaderProviderOptions().WithAgentIdentity("<agent-identity-client-id>");

    // Request agent identity tokens
    string authorizationHeader = await authorizationHeaderProvider
        .CreateAuthorizationHeaderForAppAsync("https://graph.microsoft.com/.default", options);

    // The authHeader contains "Bearer " + the access token
    return Results.Ok(authorizationHeader);
});
```

---

## Grant application permissions

Agents often need to take actions in Microsoft Graph and other web services that require a Microsoft Entra ID application permission (represented as app roles). Autonomous agents need to request these permissions from a Microsoft Entra ID administrator.

There are two ways to grant application permissions to an autonomous agent:

- An admin can create an *appRoleAssignment* by using Microsoft Graph APIs or PowerShell.
- The agent can direct the admin to a consent page using an admin consent URL.

### Create an app role assignment via APIs

Use the following steps to get an app role assignment.

1. [Obtain an access token](#request-an-agent-identity-token) with the application permissions `Application.Read.All` and `AppRoleAssignment.ReadWrite.All`.

1. Get the object ID of the resource service principal that you're trying to access. For example, to find the Microsoft Graph service principal object ID:
    1. Go to the [Microsoft Entra admin center](https://entra.microsoft.com/).
    1. Navigate to **Entra ID** --> **Enterprise Applications**
    1. Filter by Application type == Microsoft Applications
    1. Search for **Microsoft Graph**.

1. Get the unique ID of the [app role you want to assign](/graph/permissions-reference).

1. Create the app role assignment:

    #### [Microsoft Graph API](#tab/microsoft-graph-api)
    
    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
    Authorization: Bearer <token>
    Content-Type: application/json
    
    {
      "principalId": "<agent-identity-id>",
      "resourceId": "<microsoft-graph-sp-object-id>",
      "appRoleId": "<app-role-id>"
    }
    ```
    
    #### [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)
    
    ```powershell
    Connect-MgGraph -Scopes "Application.Read.All AppRoleAssignment.ReadWrite.All" -TenantId <your-test-tenant>
    
    # Get the service principal for Microsoft Graph (well-known app ID)
    $graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"
    
    # Get your application's service principal (replace with your app's client ID)
    $agentId = "<agent-identity-id>"
    
    # Find the App Role ID for "User.ReadBasic.All"
    $userReadBasicRole = $graphSp.AppRoles | Where-Object {
        $_.Value -eq "User.ReadBasic.All" -and $_.AllowedMemberTypes -contains "Application"
    }
    
    # Assign the app role
    New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $agentId `
        -PrincipalId $agentId `
        -ResourceId $graphSp.Id `
        -AppRoleId $userReadBasicRole.Id
    ```

---

### Request authorization from a tenant administrator

To grant delegated permissions, construct the authorization URL that is used to prompt the administrator. The role parameter is used to specify the requested application permissions.

Be sure to use the agent identity client ID in the following request.

```bash
https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/adminconsent
?client_id=<agent-identity-client-id>
&role=User.Read.All
&redirect_uri=https://entra.microsoft.com/TokenAuthorize
&state=xyz123
```

Agent implementations might redirect the admin to this URL in various ways, such as including it in a message sent to the admin in a chat window. When the admin is redirected to this URL, they're asked to sign in and grant consent to the permissions specified in the scope parameter. At the moment you must use the redirect URI listed, which directs the admin to a blank page after granting consent.

After you grant your application the required permissions, request a new agent access token for the permissions to take effect.

## Authenticate as an agent's user account

In addition to operating with app-only tokens, autonomous agents can authenticate as an agent's user account. Agents' user accounts are a special type of user account in Microsoft Entra purpose-built for use by agents. They're most commonly used when an agent needs to connect to systems that require the existence of a user account, for instance, a mailbox, Teams channel, or other user-specific resources.

Each agent identity can only have a single associated agent's user account, and each agent's user account can only be associated with a single agent identity.

### Get authorization to create agents' user accounts

To create agents' user accounts, your agent identity blueprint must be granted the application permission `AgentIdUser.ReadWrite.IdentityParentedBy` in the tenant. You can obtain authorization in one of two ways:

- [Request agent authorization](#request-authorization-from-a-tenant-administrator). Be sure to use your agent identity blueprint as the `client_id`, not the agent identity.
- [Manually create an appRoleAssignment](#create-an-app-role-assignment-via-apis) in the tenant. Use the service principal object ID of the agent identity blueprint as the `principalId` value, not its application (client) ID.

If you wish to use a different client, not the agent identity blueprint, to create agents' user accounts, that client needs to obtain the `AgentIdUser.ReadWrite.All` delegated or application permission instead.

### Create an agent's user account

Create an agent's user account using your agent identity blueprint or other approved client. The recommended way to create an agent's user account is using your agent identity blueprint. You [require an access token](create-delete-agent-identities.md#get-an-access-token-using-agent-identity-blueprint) to create an agent's user account.

#### [REST](#tab/rest)

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

#### [Microsoft.Identity.Web](#tab/msidweb)

To use `Microsoft.Identity.Web` to create an agent's user account, follow these steps:

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
    app.Run();
    ```
    
1. Create the agent's user account creation endpoint.

    ```csharp
    app.MapPost("/create-agent-id-user", async (HttpContext httpContext) =>
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
    
            // Call the downstream API (Graph) with a POST request to create an agent's user account
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

Once you have your agent's user account created, you don't need to configure anything else. These accounts don't have any credentials and can only be authenticated using the protocol described in the next sections.

### Grant consent to agent identity

Agents' user accounts behave like any other user account. Before you can request tokens using your agent's user account, you need to authorize the agent identity to act on its behalf. You can authorize the agent identity using [admin authorization](#request-authorization-from-a-tenant-administrator) or manually create an `oAuth2PermissionGrant` using Microsoft Graph or Microsoft Graph PowerShell.

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

### Request an agent's user account token

To authenticate an agent's user account, you need to follow a three-step process:

1. Get a token as the agent identity blueprint.
1. Use that token to get another token as the agent identity.
1. Use both previous tokens to get another token as the agent's user account.

#### [REST](#tab/rest)

First, request a token as the agent identity blueprint, as described in [Request a token for the agent identity blueprint](#request-a-token-for-the-agent-identity-blueprint). Once you have your agent app token, use it to request a Federated Identity Credential (FIC) for your agent identity:

```http
POST https://login.microsoftonline.com/<my-test-tenant>/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=<agent-identity-id>
&scope=api://AzureADTokenExchange/.default
&grant_type=client_credentials
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<agent-blueprint-token>
```

This returns an exchange token (T2) for the agent identity. Use it in the next request to obtain a delegated token for the agent's user account:

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

This gives you a delegated access token you can use to call Microsoft Graph as your agent's user account. You can use `user_id=<user-object-id>` instead of `username=<UPN>` for the user identifier.

#### [Microsoft.Identity.Web](#tab/msidweb)

*Microsoft.Identity.Web* handles the token acquisition for you. Use the `.WithAgentUserIdentity()` pattern to request access tokens.

```csharp
// In an API endpoint or service method where HttpContext is available
app.MapGet("/agent-user-token", async (HttpContext httpContext) =>
{
    IAuthorizationHeaderProvider authorizationHeaderProvider =
        httpContext.RequestServices.GetRequiredService<IAuthorizationHeaderProvider>();

    // Configure options for the agent's user account identity
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

    return Results.Ok(authHeader);
});
```

You can also use the agent's user account principal name instead of the object ID.

---

## Related content

- [Agent identity access token claims](./agent-token-claims.md)
- [Acquire token using Microsoft Entra SDK for agent ID](./microsoft-entra-sdk-for-agent-identities.md)
- [Microsoft Graph permissions reference](/graph/permissions-reference)
- [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview)
- [Agent's user account flow in agents](agent-user-oauth-flow.md)
- [Agents' user accounts](agent-users.md)
