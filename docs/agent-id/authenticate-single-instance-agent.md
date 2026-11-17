---
title: Single-instance OAuth (preview)
description: Understand direct authentication with a single-instance Agent ID and find the local, ASP.NET Core, and sidecar walkthroughs.
ms.topic: concept-article
ms.date: 11/06/2026
ai-usage: ai-assisted
# Customer intent: As an agent developer, I want to understand how my single-instance Agent ID authenticates and find the walkthrough for my platform.
---

# Single-instance agent authentication overview (preview)

A single-instance Agent ID (preview) authenticates directly with the client ID it shares with its blueprint. It uses the same authentication-library APIs as a regular application. It doesn't acquire an intermediate blueprint impersonation token or send `fmi_path`.

The blueprint and Agent ID have different directory object IDs. Configure credentials on the blueprint, grant permissions to the Agent ID, and use their shared OAuth client ID for token requests. A single-instance blueprint has no blueprint principal.

## Choose an integration path

> [!IMPORTANT]
> Single-instance agent identities are in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

Choose a walkthrough based on where your agent runs. If you're building a platform that hosts separate agents for teams or customers, follow the fleet guidance.

| Environment | Walkthrough |
| --- | --- |
| Local public client | [Sign in users from a local agent](authenticate-local-agent.md). |
| Cloud agent with ASP.NET Core | [Call a custom API as an agent](call-api-custom.md). |
| Cloud agent with the Auth SDK sidecar | [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md). |
| Shared runtime with many identities | [Plan an agent fleet](plan-agent-fleet.md). |

Authentication requires a provisioned single-instance Agent ID and a tenant enabled for authentication. Successful Microsoft Graph provisioning alone doesn't establish authentication enablement. For setup, see [Create a single-instance agent identity](create-single-instance-agent.md).

## Sign in a user

Local public clients use authorization code flow with PKCE and no client credential. Confidential clients use a credential on the blueprint. An authentication library handles state, PKCE, token caching, and refresh rather than requiring hand-built protocol requests.

For local sign-in and refresh behavior, follow [Sign in users from a local agent](authenticate-local-agent.md). For a front end that calls a hosted agent API, follow [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md) or [Authenticate users with the sidecar](sidecar-authenticate-users.md).

## Grant application permissions

Declaring permissions on the blueprint doesn't grant them. An administrator grants application permissions to the agent identity. Browser-based admin consent requires a registered `web` redirect URI, even for an unattended agent.

For the consent request and assignment verification, see [Grant application permissions in the cloud-agent walkthrough](call-api-custom.md#grant-application-permissions). For Microsoft Graph, see [Grant application permissions to an agent identity](grant-application-permissions-agent-identity.md).

## Request an app-only token

The standard client credentials flow uses the shared client ID, the blueprint credential, and the resource's `/.default` scope. It doesn't use an Agent ID override.

Follow [Call a custom API with ASP.NET Core](call-api-custom.md#call-the-api) for `CreateAuthorizationHeaderForAppAsync`, or [Call a custom API with the sidecar](sidecar-call-custom-api-as-agent.md) for the corresponding HTTP endpoint. For protocol parameters, see [OAuth 2.0 client credentials flow](~/identity-platform/v2-oauth2-client-creds-grant-flow.md).

## Call a downstream API on behalf of a user

OBO exchanges an incoming user access token for a downstream token. The incoming token must target the agent's shared client ID, not Microsoft Graph or another resource. The agent authenticates with its blueprint credential. The downstream API evaluates the user's delegated access.

Two separate grants are required: front-end access to the agent's exposed scope and the agent's delegated access to the downstream API. During preview, grant front-end access through Microsoft Graph as described in [Grant the upstream client access](aspnet-core-authenticate-users.md#grant-the-upstream-client-access).

Follow [Call a custom API as a user with ASP.NET Core](aspnet-core-call-custom-api-as-user.md) or [Call a custom API as a user with the sidecar](sidecar-call-custom-api-as-user.md). These walkthroughs use standard OBO, without an intermediate blueprint exchange. For protocol parameters, see [OAuth 2.0 On-Behalf-Of flow](~/identity-platform/v2-oauth2-on-behalf-of-flow.md).

## Verify access

A successful token response establishes token issuance, not authorization at the API. API authorization depends on a valid signature, issuer, audience, and lifetime, plus the required scope or role. Requests with insufficient permissions are rejected. Tokens, certificate assertions, and private keys aren't safe diagnostic output.

For API-side validation, see [Secure a web API with Microsoft Entra ID](how-to-validate-agent-tokens-downstream-api.md).
