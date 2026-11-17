---
title: Call a custom API as a user with ASP.NET Core
description: Call a custom API for a signed-in user from an ASP.NET Core agent.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ms.reviewer: dastrock, jomondi
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1013
#customer-intent: As a developer building an interactive cloud agent, I want to call my protected API on behalf of the signed-in user.
---

# Call a custom API as a user with ASP.NET Core

Call your custom API with the signed-in user's access, rather than the agent's application permissions. This article uses the OAuth On-Behalf-Of (OBO) flow: a client signs in the user, calls your agent, and the agent gets a token for the downstream API.

You'll extend the agent API from the authentication walkthrough and test the complete call with the same client. You can use an existing protected API or the local test API below. The agent doesn't start another interactive sign-in.

## Prerequisites

- Complete [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md).
- A credential on the agent identity blueprint. For local testing, use the [certificate registered during provisioning](create-single-instance-agent.md#add-a-certificate-for-confidential-clients) and the [local certificate configuration](call-api-custom.md#configure-a-local-development-credential). For production, configure a [managed identity federated credential](create-blueprint.md#configure-credentials-for-the-agent-identity-blueprint).
- An existing custom API's delegated scope, HTTPS endpoint, and user authorization requirements, or permission to [set up the local test API](#prepare-a-downstream-api).
- The management client and consent permissions from the authentication walkthrough, to grant the test user's downstream access.
- An app role assigned to the user if the agent uses [app roles to control access](control-user-access-agents.md).

The authentication walkthrough establishes client-to-agent consent. You also need agent-to-API consent; one grant doesn't replace the other.

## Prepare a downstream API

For an existing API, ask its owner for the application (client) ID, enterprise application object ID, fully qualified delegated scope, HTTPS endpoint, and test user's access requirements. Skip the local API steps only when that API is ready to validate and authorize delegated requests.

To create an isolated local API:

1. [Register a single-tenant application](~/identity-platform/quickstart-register-app.md) named **Agent downstream test API**.
1. [Expose a delegated permission](~/identity-platform/quickstart-configure-app-expose-web-apis.md) with application ID URI `api://<custom-api-client-id>` and scope value `read_data`. Record the scope's GUID. In the app manifest, set `api.requestedAccessTokenVersion` to `2`.
1. Record the corresponding enterprise application's **Object ID** for consent. Don't use its client ID in place of this object ID.
1. Create a web API project in a separate directory:

    ```dotnetcli
    dotnet new webapi --framework net10.0 --name DownstreamApi
    cd DownstreamApi
    dotnet add package Microsoft.Identity.Web --version 4.17.0
    ```

1. Configure `AzureAd` in this project's `appsettings.json` with `Instance` set to `https://login.microsoftonline.com/`, your `TenantId`, and `ClientId` set to the **downstream API's** client ID. This resource API validates tokens and doesn't need a client credential.
1. Replace this project's `Program.cs` with:

    ```csharp
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.Resource;

    var builder = WebApplication.CreateBuilder(args);
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration);
    builder.Services.AddAuthorization();
    var app = builder.Build();
    app.UseAuthentication();
    app.UseAuthorization();

    app.MapGet("/user-data", (HttpContext context) =>
    {
        context.VerifyUserHasAnyAcceptedScope("read_data");
        return Results.Ok(new
        {
            objectId = context.User.GetObjectId(),
            tenantId = context.User.GetTenantId()
        });
    }).RequireAuthorization();

    app.Run();
    ```

1. Run `dotnet run --urls https://localhost:5002` and leave this terminal open. Use the trusted development certificate from the authentication walkthrough.

The test endpoint returns only the authenticated caller's identity. For real data, enforce the user's access to each requested resource as well as the delegated scope. A scope alone doesn't authorize access to another user's records.

## Grant downstream access

Declare the API's delegated scope on the blueprint using [Declare the API permissions](create-single-instance-agent.md#declare-the-api-permissions). Use the downstream API's client ID for `resourceAppId` and its scope GUID with `"type": "Scope"`. A declaration isn't consent.

Through the authorized management client, check for an existing grant:

```http
GET https://graph.microsoft.com/v1.0/oauth2PermissionGrants?$filter=clientId eq '<agent-identity-object-id>' and resourceId eq '<custom-api-service-principal-object-id>'
```

Follow pagination. If an applicable grant already includes the scope, reuse it. If a grant for this user lacks the scope, [update the OAuth2 permission grant](/graph/api/oauth2permissiongrant-update) with the union of existing and required scopes. Otherwise, grant access for the same user who signs in through the test client:

```http
POST https://graph.microsoft.com/v1.0/oauth2PermissionGrants
Content-Type: application/json

{
  "clientId": "<agent-identity-object-id>",
  "resourceId": "<custom-api-service-principal-object-id>",
  "consentType": "Principal",
  "principalId": "<user-object-id>",
  "scope": "read_data"
}
```

Expect `201 Created` and save the grant's `id` for cleanup. For an existing API, replace `read_data` with its scope value, without the `api://` prefix. For other consent options, see [Grant delegated permissions to an agent identity](grant-agent-access-microsoft-365.md).

## Configure the blueprint credential

Keep the agent API's existing `AzureAd` settings from the authentication walkthrough. Add the credential for where you run the API.

# [Local workstation](#tab/local)

Follow [Configure a local development credential](call-api-custom.md#configure-a-local-development-credential) to add the registered certificate in `appsettings.Development.json` and supply its password through the environment.

Keep the tenant ID and agent client ID from the authentication walkthrough. Don't use the downstream API's client ID for the agent, and don't add a managed identity credential to the local configuration.

# [Azure host](#tab/azure)

Use the following `appsettings.json` configuration only on an Azure host with the specified managed identity assigned and its federated credential configured on the blueprint. Signing in to Azure CLI on your workstation doesn't make this configuration work locally.

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<tenant-id>",
    "ClientId": "<agent-client-id>",
    "ClientCredentials": [
      {
        "SourceType": "SignedAssertionFromManagedIdentity",
        "ManagedIdentityClientId": "<managed-identity-client-id>"
      }
    ]
  }
}
```

---

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

## Configure token validation and OBO

Replace the agent API's `Program.cs` from the authentication walkthrough with the following code and the endpoint in **Call the API**, in that order. Don't append a second application builder or a second `app.Run()`. This version adds token acquisition and uses an in-memory token cache for the local test.

```csharp
using System.Net.Http.Headers;
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.Resource;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
    .EnableTokenAcquisitionToCallDownstreamApi()
    .AddInMemoryTokenCaches();

builder.Services.AddHttpClient();
builder.Services.AddAuthorization();

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/whoami", (HttpContext context) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");
    return Results.Ok(new
    {
        objectId = context.User.GetObjectId(),
        tenantId = context.User.GetTenantId()
    });
}).RequireAuthorization();
```

## Call the API

Use `CreateAuthorizationHeaderForUserAsync` with the authenticated `HttpContext.User`. Microsoft.Identity.Web uses the validated incoming access token as the OBO assertion and authenticates with the configured shared client ID and blueprint credential.

Append this endpoint after the `/whoami` mapping in the previous block. Keep `/whoami` so you can compare the inbound and downstream identities. Replace the client ID, scope value, and URL with your API's values. For the local test API, use `read_data` and `https://localhost:5002/user-data`.

```csharp
app.MapGet("/custom-api-for-user", async (
    HttpContext context,
    IAuthorizationHeaderProvider authorizationHeaderProvider,
    IHttpClientFactory httpClientFactory) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");

    string authorizationHeader = await authorizationHeaderProvider
        .CreateAuthorizationHeaderForUserAsync(
            ["api://<custom-api-client-id>/<delegated-scope>"],
            claimsPrincipal: context.User);

    HttpClient client = httpClientFactory.CreateClient();
    client.DefaultRequestHeaders.Authorization =
        AuthenticationHeaderValue.Parse(authorizationHeader);

    using HttpResponseMessage response =
        await client.GetAsync("https://api.contoso.com/user-data");
    response.EnsureSuccessStatusCode();

    return Results.Content(
        await response.Content.ReadAsStringAsync(),
        response.Content.Headers.ContentType?.ToString());
})
.RequireAuthorization();

app.Run();
```

The returned authorization header includes the `Bearer` scheme. Send it only to the intended custom API, and don't return or log it.

The custom API must validate the token and enforce both the delegated scope and resource-level access for the user. For protocol details, see [OAuth protocols in Microsoft Entra Agent ID](agent-oauth-protocols.md#hosted-agent-that-acts-for-a-signed-in-user) and the [OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow).

## Verify delegated access

1. If the downstream API isn't already running, start it at `https://localhost:5002`. Leave it running while you start the agent API in its own terminal with `dotnet run --urls https://localhost:5001`.
1. In the [test client](aspnet-core-authenticate-users.md#run-the-test-client), change only the request URL from `https://localhost:5001/whoami` to `https://localhost:5001/custom-api-for-user`. Keep the requested scope as `api://<agent-client-id>/access_agent`, not the downstream scope.
1. Run the test client and sign in as the user in both consent grants. Expect `HTTP 200`. For the local API, the response must contain the same user and tenant IDs returned by `/whoami`.
1. Call the agent endpoint without a bearer token. Expect `401`. A token issued for the agent must also be rejected if sent directly to the downstream API because its audience is wrong.
1. For an existing API, test a resource the signed-in user isn't allowed to access. The local identity-only endpoint doesn't expose another user's records, so this resource-level test doesn't apply to it.

If either API exposes another delegated scope, you can also run a scope-negative test against it. For a direct call from the test client, declare and grant that client the alternate scope on the target API. Request only that scope, then send the resulting token directly to that API's endpoint and confirm rejection. The token must have the target API's audience but lack the endpoint's required scope. If you instead test a downstream token acquired through OBO, the alternate downstream grant belongs to the agent identity, not the upstream test client. The minimal local setup doesn't define alternate scopes, so these tests are optional. Don't treat the wrong-audience test as a substitute.

If OBO reports missing consent, check front-end access to the agent separately from the agent's downstream permission. OBO can't display an interactive consent prompt. Record correlation IDs for failures, not tokens or assertions.

## Clean up the local test

Stop the three projects. Through the management client, delete test-only grants with `DELETE https://graph.microsoft.com/v1.0/oauth2PermissionGrants/<grant-id>` before deleting their client or resource registrations. Delete the test client's and downstream API's app registrations only if you created them for this test. For a test-only agent, follow [Delete agent identity objects](howto-delete-agent-identity.md). Don't delete shared registrations, scopes, or grants.

## Related content

- [Call APIs for users of an agent fleet](aspnet-core-fleet-call-apis-as-user.md)
- [Validate Agent ID tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md)
- [Protected web API: verify scopes and app roles](/entra/identity-platform/scenario-protected-web-api-verification-scope-app-roles)
- [Call a custom API as an agent](call-api-custom.md)
