---
title: Call an Azure service as a user with ASP.NET Core
description: Use an agent identity and the on-behalf-of flow to call an Azure service for the signed-in user.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: dastrock, jomondi
#customer-intent: As a developer building an interactive cloud agent, I want to call Azure services on behalf of the signed-in user.
---

# Call an Azure service as a user with ASP.NET Core

Use the OAuth On-Behalf-Of (OBO) flow when an upstream client calls an agent API for a signed-in user and the agent calls an Azure service for that user.

The agent API validates the access token from the upstream client. Microsoft.Identity.Web then uses ordinary confidential-client OBO to acquire an Azure access token for the signed-in user. The user's Azure role assignments determine which resources the downstream call can access.

## Prerequisites

- Complete [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md).
- A credential on the agent identity blueprint. For local testing, use the [registered certificate and local credential configuration](call-api-custom.md#configure-a-local-development-credential). Use a managed identity federated credential in production.
- [User or administrator consent](grant-agent-access-microsoft-365.md) for the agent identity to use the Azure service's delegated scope.
- An Azure RBAC role assigned to the signed-in user at the required scope.

## Install the packages

```dotnetcli
dotnet add package Microsoft.Identity.Web
```

## Configure the blueprint credential

Use the same `AzureAd` section that validates incoming tokens, and add the blueprint credential:

The managed identity example requires an Azure host with that identity assigned and federation configured. On a workstation, use the local certificate configuration from the prerequisites instead; signing in to Azure CLI doesn't make the managed identity configuration work locally.

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

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

## Configure token validation and OBO

Replace the agent API's `Program.cs` from the authentication walkthrough with the following block, followed by the endpoint in **Call Azure Resource Manager**. Don't append a second application builder or `app.Run()`. This sample uses an in-memory token cache.

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
```

## Call Azure Resource Manager

Use `CreateAuthorizationHeaderForUserAsync` with the authenticated `HttpContext.User`. The provider uses the agent's configured client ID and blueprint credential.

The following endpoint enforces the agent API's `access_agent` scope, requests a delegated Azure Resource Manager token, and lists the subscriptions visible to the user:

```csharp
app.MapGet("/azure-subscriptions", async (
    HttpContext context,
    IAuthorizationHeaderProvider authorizationHeaderProvider,
    IHttpClientFactory httpClientFactory) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_agent");

    string authorizationHeader = await authorizationHeaderProvider
        .CreateAuthorizationHeaderForUserAsync(
            ["https://management.azure.com/user_impersonation"],
            claimsPrincipal: context.User);

    HttpClient client = httpClientFactory.CreateClient();
    client.DefaultRequestHeaders.Authorization =
        AuthenticationHeaderValue.Parse(authorizationHeader);

    using HttpResponseMessage response = await client.GetAsync(
        "https://management.azure.com/subscriptions?api-version=2022-12-01");
    response.EnsureSuccessStatusCode();

    return Results.Content(
        await response.Content.ReadAsStringAsync(),
        "application/json");
})
.RequireAuthorization();

app.Run();
```

The returned authorization header includes the `Bearer` scheme. Send it only to the intended Azure service, and don't return or log it.

For another Azure service, use the delegated scope, endpoint, and Azure RBAC role documented by that service.

## Verify the Azure call

1. Start the agent API with `dotnet run --urls https://localhost:5001` in the environment where its configured credential is available.
1. In the [local test client](aspnet-core-authenticate-users.md#run-the-test-client), change the request URL to `https://localhost:5001/azure-subscriptions`. Keep the requested scope as `api://<agent-client-id>/access_agent`, not the Azure Resource Manager scope.
1. Run the client and sign in as the user covered by both consent grants. Expect `HTTP 200` and a JSON subscription list. An empty list can be valid when the user has no visible subscriptions; compare it with the user's expected Azure access.
1. Call the agent endpoint without a token and confirm `401 Unauthorized`.

If token acquisition reports missing consent, check the agent identity's delegated Azure permission. If the Azure call is denied or expected subscriptions are absent, check the signed-in user's Azure RBAC assignments separately. The sample's `EnsureSuccessStatusCode` throws for a downstream failure; it doesn't forward that status to the client. Record correlation IDs and request times, not tokens.

Stop the API and test client when you're done. Follow the steps to [clean up the local agent authentication test](aspnet-core-authenticate-users.md#clean-up-the-local-test), and remove only test-specific grants or Azure role assignments you created.

## Related content

- [Call a custom API as a user](aspnet-core-call-custom-api-as-user.md)
- [Azure Resource Manager REST API](/rest/api/resources/)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Call an Azure service as an agent](call-api-azure-services.md)
