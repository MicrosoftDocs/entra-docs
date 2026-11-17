---
title: Call APIs as a user from a local agent (preview)
description: Use a local agent to call a protected API for the signed-in user.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer, I want my local agent to call a protected API with the permissions of the signed-in user.
---

# Call APIs as a user from a local agent (preview)

After the local agent [signs in a user](authenticate-local-agent.md), request the delegated scopes required by the protected API. MSAL acquires an access token for the signed-in user and caches it for later calls. The API authorizes the request based on the user, the client Agent ID, and the scopes in the token.

## Prerequisites

> [!IMPORTANT]
> Local agent authentication is in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

- Complete [Sign in users from a local agent](authenticate-local-agent.md). The MSAL.NET snippets here continue in the same application and reuse its public-client application variable, `app`.
- Obtain the target API's delegated scope and endpoint from its owner. Replace `<resource-client-id>`, `<delegated-scope>`, and `<resource-url>` with values for that API.
- Arrange consent with a tenant administrator if the requested permission or tenant policy requires it.

## Request the API scope

Request only the delegated scopes needed for the operation:

```csharp
var scopes = new[] { "api://<resource-client-id>/<delegated-scope>" };
```

For Microsoft Graph, use Microsoft Graph scopes such as `User.Read` or `Files.Read`.

The resource owner controls which delegated permissions are available. A user or administrator must consent before the agent can use them.

## Acquire a token

Try the MSAL cache before prompting the user again:

```csharp
AuthenticationResult result;
var account = (await app.GetAccountsAsync()).FirstOrDefault();

try
{
    result = await app.AcquireTokenSilent(scopes, account).ExecuteAsync();
}
catch (MsalUiRequiredException)
{
    result = await app.AcquireTokenInteractive(scopes).ExecuteAsync();
}
```

Don't inspect or modify the access token in the agent. Treat it as an opaque credential for the target API.

## Call the API

Send the token in the HTTP `Authorization` header:

The snippet assumes your application supplies an `HttpClient` named `httpClient`. Keep the token acquisition and API call in the same operation so the call uses the resulting `result.AccessToken`.

```csharp
using System.Net.Http.Headers;

using var request = new HttpRequestMessage(HttpMethod.Get, "<resource-url>");
request.Headers.Authorization =
    new AuthenticationHeaderValue("Bearer", result.AccessToken);

using var response = await httpClient.SendAsync(request);
response.EnsureSuccessStatusCode();
```

Request a token for each resource. A token issued for one API, such as Microsoft Graph, can't be used with another API.

Local public clients support delegated access only. They can't use client credentials to obtain app-only tokens.

Verify that the API returns its expected response for the signed-in user; successful sign-in alone doesn't prove API access. For `401 Unauthorized`, check that the token was requested for this API and that the API's validation settings match its registration. For `403 Forbidden`, check delegated consent and the user's access to the requested resource. If consent requires administrator approval, hand off the client ID, target resource, and requested scopes instead of repeatedly prompting the user.

## Next steps

- For a custom API, configure the API to [validate Agent ID tokens](how-to-validate-agent-tokens-downstream-api.md).
- For Microsoft Graph permissions, see the [Microsoft Graph permissions reference](/graph/permissions-reference).
- For consent guidance, see [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview).

## Related content

- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Authenticate a local agent with Microsoft Entra ID](authenticate-local-agent.md)
