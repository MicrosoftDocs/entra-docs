---
title: Secure a web API with Microsoft Entra ID
description: Configure a web API to validate Agent ID access tokens and authorize requests from agents and users.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: dastrock

#customer-intent: As an API developer, I want to validate Agent ID tokens so that only authorized agents and users can call my API.
---

# Secure a web API with Microsoft Entra ID

A downstream API must validate every access token before it trusts the Agent ID, user, or permissions represented by the token. Use a supported authentication middleware or token-validation library instead of parsing tokens in application code.

This article covers Microsoft identity platform v2.0 access tokens.

The API registration must expose the delegated scope or application role that each endpoint requires, and the calling client or agent must have the corresponding grant. For an assembled local delegated test, follow [Call a custom API as a user](aspnet-core-call-custom-api-as-user.md). For app-only caller setup and consent, follow [Call a custom API as an agent](call-api-custom.md).

## Configure token validation

Configure the API with:

- The Microsoft Entra tenant or accepted issuer set.
- The API's Application ID URI or client ID as the expected audience.
- Microsoft identity platform signing-key discovery.
- The delegated scopes or application roles required by each operation.

For ASP.NET Core, use Microsoft.Identity.Web. For other frameworks, use a Microsoft-supported JWT validation library.

For complete registration and framework guidance, see [Configure protected web API apps](/entra/identity-platform/scenario-protected-web-api-app-configuration).

## Configure an ASP.NET Core API

Install Microsoft.Identity.Web:

```dotnetcli
dotnet add package Microsoft.Identity.Web
```

Configure the tenant and API registration:

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "<tenant-id>",
    "ClientId": "<downstream-api-client-id>"
  }
}
```

Register token validation and protect delegated and app-only endpoints:

```csharp
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.Resource;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddMicrosoftIdentityWebApiAuthentication(
    builder.Configuration);

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(
        "AgentApplication",
        policy => policy.RequireRole("Agent.Access"));
});

var app = builder.Build();

app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/data-for-user", (HttpContext context) =>
{
    context.VerifyUserHasAnyAcceptedScope("access_as_user");
    return Results.Ok();
})
.RequireAuthorization();

app.MapGet("/data-for-agent", () => Results.Ok())
    .RequireAuthorization("AgentApplication");

app.Run();
```

Replace `access_as_user` with the delegated scope exposed by the API. Replace `Agent.Access` with the application role assigned to the Agent ID.

`AddMicrosoftIdentityWebApiAuthentication` validates the token signature, issuer, audience, and lifetime. `VerifyUserHasAnyAcceptedScope` enforces the delegated `scp` claim. `RequireRole` enforces the application permission in the `roles` claim.

For more complete authorization patterns, see [Verify scopes and app roles in a protected web API](/entra/identity-platform/scenario-protected-web-api-verification-scope-app-roles).

Test each endpoint with a token issued for **this downstream API**, not the agent's inbound token. With the required scope or role, the sample returns `200 OK`. Without a token or with the wrong audience, expect `401`. With an otherwise valid token for this API that lacks the required scope or role, expect rejection. Use the linked walkthroughs for token acquisition; don't return or log tokens to inspect them.

## Validate the token

Reject the request unless all of these checks succeed:

1. **Signature:** The token is signed by a trusted Microsoft Entra signing key.
1. **Issuer:** The `iss` claim matches an issuer accepted by the API.
1. **Audience:** The `aud` claim identifies this API.
1. **Lifetime:** The token is within its valid time window.
1. **Tenant:** The `tid` claim is allowed by the API's tenant policy.
1. **Client:** The authorized-party claim identifies an allowed client or blueprint where the API restricts callers.
1. **Agent identity:** Agent-specific claims, including the Agent ID relationship claims expected by the scenario, are present and valid.
1. **Permission:** Delegated requests contain the required `scp` value; app-only requests contain the required `roles` value.

Don't authorize a request based only on the presence of an Agent ID claim. Apply the same issuer, audience, lifetime, and permission checks used for other Microsoft Entra access tokens.

## Distinguish access types

| Access type | User context | Permission claim | API authorization |
| --- | --- | --- | --- |
| Agent acting as itself | None | `roles` | Verify the required application role and Agent ID. |
| Agent acting for a signed-in user | Signed-in user | `scp` | Verify the scope, user authorization, and Agent ID. |
| Agent acting as its user account | Agent's user account | `scp` | Verify the scope, account authorization, and Agent ID relationship. |

## Return authorization errors

- Return `401 Unauthorized` when the token is missing or invalid.
- Return `403 Forbidden` when the token is valid but lacks the required permission or resource access.

Don't include tokens or sensitive claim values in logs.

## Related content

- [Configure protected web API apps](/entra/identity-platform/scenario-protected-web-api-app-configuration)
- [Verify scopes and app roles in a protected web API](/entra/identity-platform/scenario-protected-web-api-verification-scope-app-roles)
- [Agent identity token claims](agent-token-claims.md)
- [Microsoft identity platform access tokens](/entra/identity-platform/access-tokens)
