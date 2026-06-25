---
title: Authentication with Microsoft Entra Auth SDK (sidecar)
titleSuffix: Microsoft Entra Agent ID
description: Learn how Microsoft Entra Auth SDK (sidecar) manages credentials and tokens for AI agents so that secrets never enter agent code.
ms.topic: concept-article
ms.date: 04/28/2026
ms.custom: agent-id, msecd-doc-authoring-1012
ai-usage: ai-assisted

#customer intent: As a developer or architect building AI agents, I want to understand how Microsoft Entra Auth SDK (sidecar) handles authentication so that I can keep credentials out of agent code while giving each agent its own auditable identity.

---

# Authentication with Microsoft Entra Auth SDK (sidecar)

The [Microsoft Entra Auth SDK (sidecar)](https://mcr.microsoft.com/en-us/product/entra-sdk/auth-sidecar/about) handles authentication and token operations for your AI agent. It runs as a second container next to your agent that handles client-credentials exchange, on-behalf-of flows, and token lifecycle management. This article explains the Microsoft Entra Auth SDK (sidecar) design pattern, how it works, and the identity objects involved. 

## Why use the Microsoft Entra SDK auth sidecar?

AI agents need credentials to call downstream APIs, but the common approaches to agent authentication fall short:

- **Hard-coded secrets in agent code:** Every agent image holds a copy of your app's `client_secret`. Any compromise, log leak, or forgotten `.env` file committed to Git exposes the full tenant.
- **Delegated user tokens for everything:** The agent can only act when a human is present. You also lose individual auditability because every call looks like the same service principal.

Microsoft Entra Agent ID gives each agent its own identity. The sidecar pattern makes that identity easy to use by keeping all credential handling outside your agent code.

## How the Microsoft Entra SDK auth sidecar works

The [Microsoft Entra SDK auth sidecar](https://mcr.microsoft.com/en-us/product/entra-sdk/auth-sidecar/about) runs as a container that exposes HTTP endpoints on the pod-local network. It handles the following responsibilities:

- Exchanges client credentials with `login.microsoftonline.com`.
- Acquires tokens through client credentials or federated identity credentials (FIC) for the agent identity in autonomous flows.
- Handles on-behalf-of (OBO) flows for user-context calls.
- Caches tokens and manages refresh and expiry.
- Abstracts the credential source - uses `ClientSecret` for development and `SignedAssertionFromManagedIdentity` for Azure deployments through the same API.

The following table summarizes the flow of auth actions between your agent and the sidecar:

| Agent (your code) | Sidecar (Microsoft Entra SDK) |
|---|---|
| Decide when to call the API | Acquire and cache the right token |
| Build the HTTP request | Perform client-credentials and OBO exchange |
| Pass through user token for OBO | Validate and forward user assertion |
| Handle business logic | Communicate with `login.microsoftonline.com` |

The security boundary is explicit: the sidecar has no host port. Only services inside the same network, such as your agent container, can request tokens.

## Identity objects in the sidecar pattern

The following table describes the Microsoft Entra objects in the sidecar pattern:

| Object | Role | Location |
|---|---|---|
| **Blueprint application** | Template that creates and issues agent identities. Holds the client credential (secret or federated). | Your Microsoft Entra tenant |
| **Agent identity** | The individual AI agent. Has a unique app ID, permission grants, and audit trail. | Your Microsoft Entra tenant |
| **Client SPA** (OBO only) | Web UI that signs the user in and exchanges the user's token for an agent token on their behalf. | Your Microsoft Entra tenant |
| **Sidecar container** | Runs client-credentials and OBO flows. Holds the blueprint credential. | Next to your agent |
| **Agent container** | Your application code. Requests authorization headers from the sidecar. | Your pod, compose service, or App Service |

For more information about blueprints and agent identities, see [Agent identity blueprints](agent-blueprint.md) and [Agent identities](what-are-agent-identities.md).

## Credential source abstraction

The sidecar abstracts the credential source from your agent code. During development, you can use a `ClientSecret` for convenience. In production Azure deployments, you can switch to `SignedAssertionFromManagedIdentity`, a federated identity credential backed by managed identity, without changing your agent code.

The sidecar's configuration determines which credential source to use. Your agent continues to call the same `/AuthorizationHeader` endpoint regardless of the authentication mechanism.

## Sidecar sample scenarios

The [Microsoft Entra Agent ID sidecar samples](https://github.com/microsoft/entra-agentid-samples/tree/dev/sidecar) demonstrate the following concepts:

- How a blueprint differs from an agent identity and why agents need their own identity.
- How the sidecar exposes `/AuthorizationHeader` (get token) and `/DownstreamApi` (token + proxied call) endpoints.
- How the sidecar forwards a signed-in user's token and has the Microsoft Entra SDK mint an agent-on-behalf-of-user token via OBO.
- How the downstream API validates agent tokens including the signature, issuer, `xms_par_app_azp`, and audience.
- How to swap from `ClientSecret` (development) to `SignedAssertionFromManagedIdentity` (Azure deployments) without changing agent code.

## Related content

- [Microsoft Entra ID Auth SDK (sidecar) documentation](/entra/msidweb/agent-id-sdk/overview)
- [Acquire tokens and call downstream APIs with Microsoft Entra ID Auth SDK (sidecar)](microsoft-entra-sdk-for-agent-identities.md)
- [Microsoft Entra Agent ID design patterns](concept-agent-id-design-patterns.md)
- [Agent identity blueprints](agent-blueprint.md)
- [Autonomous agent app OAuth flow](agent-autonomous-app-oauth-flow.md)
- [On-behalf-of OAuth flow](agent-on-behalf-of-oauth-flow.md)
