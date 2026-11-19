---
title: Sign in users from a local agent
description: Configure a local agent as an OAuth public client and sign in users with authorization code flow and PKCE.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer, I want my local agent to sign in users securely without storing a client credential.
---

# Sign in users from a local agent (preview)

A local agent runs on an endpoint device and can't securely store a client secret or certificate. Configure it as an OAuth public client and use authorization code flow with Proof Key for Code Exchange (PKCE).

The user signs in through a browser. The agent receives an authorization code at its registered redirect URI and redeems the code without a client credential.

> [!IMPORTANT]
> Local agent authentication is in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

You need a Microsoft Entra tenant where you can register an Agent ID, or a tenant that supports Client ID Metadata Documents (CIMD).

## Choose a client ID

| Option | Client ID | Use when |
| --- | --- | --- |
| Register an Agent ID in Microsoft Entra | Client ID assigned by Microsoft Entra | Recommended when you know the agent connects to Microsoft Entra. |
| Use a CIMD | Public HTTPS URL of the client's metadata document | Use when the same distributed client connects to independently operated authorization servers and preregistration isn't practical. |

Prefer a registered Agent ID when possible. For more information about CIMD, see [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md#when-to-use-cimd).

## Register the Agent ID

1. [Create a single-instance blueprint and provision its Agent ID](create-single-instance-agent.md). Choose the instance mode when you create the blueprint; you can't change it afterward.
1. Add the redirect URI recommended by your authentication library under the blueprint's `publicClient` platform.
1. Record the Agent ID's client ID and tenant ID.

Every installation uses the same client ID. Don't create a separate Agent ID for each device, and don't add a client secret, certificate, or federated identity credential for this flow.

For redirect URI options, see [Desktop app that calls web APIs: Code configuration](/entra/identity-platform/scenario-desktop-app-configuration).

## Sign in with MSAL.NET

Install MSAL.NET:

```dotnetcli
dotnet add package Microsoft.Identity.Client
```

Create a public-client application:

```csharp
using Microsoft.Identity.Client;

var app = PublicClientApplicationBuilder
    .Create("<agent-client-id>")
    .WithAuthority("https://login.microsoftonline.com/<tenant-id>")
    .WithDefaultRedirectUri()
    .Build();
```

Sign in the user without requesting delegated permissions for an API:

```csharp
var result = await app
    .AcquireTokenInteractive(Array.Empty<string>())
    .ExecuteAsync();

Console.WriteLine($"Signed in as {result.Account.Username}");
```

`AcquireTokenInteractive` doesn't have a parameterless overload. Pass an empty scope collection when the agent only needs to sign in the user. MSAL adds the reserved OpenID Connect scopes required for sign-in, but it doesn't request a delegated scope for an API.

MSAL opens the system browser, uses PKCE, validates the response, and caches the account. Use a tenant-specific authority for a registered Agent ID. Don't use the account name or ID token to authorize access to an API. Request the API's delegated scopes in the next step.

<a id="use-a-cimd-client-for-delegated-api-access"></a>

## Use a CIMD client for delegated API access (preview)

Use the CIMD URL as the client ID in an OAuth library that supports URL-valued client IDs. The library must use authorization code flow with PKCE and must not send a client credential when it redeems the code.

CIMD doesn't support ID tokens for user sign-in. This branch uses browser authentication to obtain delegated API access, not the sign-in-only MSAL.NET result shown earlier. Request the resource's delegated scopes by following the CIMD configuration procedure.

For metadata and redirect URI requirements, see [Configure a client with a Client ID Metadata Document](configure-client-id-metadata-document.md).

## Next step

[Call APIs as the signed-in user](authenticate-local-agent-call-apis.md).

## Related content

- [OAuth 2.0 authorization code grant](agent-authorization-code-oauth-flow.md)
- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [AcquireTokenInteractive API reference](/dotnet/api/microsoft.identity.client.ipublicclientapplication.acquiretokeninteractive)
- [Public client and confidential client applications](/entra/identity-platform/msal-client-applications)
- [Choose an authentication protocol for an agent](agent-oauth-protocols.md)
