---
title: Sidecar design pattern for agent authentication
titleSuffix: Microsoft Entra Agent ID
description: Learn how the sidecar design pattern keeps credentials out of AI agent code while giving each agent its own auditable Microsoft Entra identity.
author: Dickson-Mwendia
ms.author: dmwendia
ms.topic: concept-article
ms.date: 04/28/2026
ms.custom: agent-id, msecd-doc-authoring-1012
ai-usage: ai-assisted

#customer intent: As a developer or architect building AI agents, I want to understand the sidecar design pattern for agent authentication so that I can keep credentials out of agent code while giving each agent its own auditable identity.

---

# Sidecar design pattern for AI agent authentication

The sidecar design pattern is an architectural approach where a separate container handles authentication and token management on behalf of your AI agent. The sidecar runs as a second container next to your agent and exposes a small HTTP API on the pod-local network. Your agent asks the sidecar for an authorization header and gets back a `Bearer` token. Credentials never live in agent memory.

This article explains why the sidecar pattern exists, how it works, and the identity objects involved.

For implementation steps, see [Acquire tokens and call downstream APIs with Microsoft Entra SDK for Agent ID](microsoft-entra-sdk-for-agent-identities.md).

## The problem the sidecar solves

Two common approaches to agent authentication both fall short:

- **Hard-coded secrets in agent code.** Every agent image holds a copy of your app's `client_secret`. Any compromise, log leak, or forgotten `.env` file committed to Git exposes the full tenant.
- **Delegated user tokens for everything.** The agent can only act when a human is present, and you lose individual auditability because every call looks like the same service principal.

Microsoft Entra Agent ID gives each agent its own identity. The sidecar pattern makes that identity easy to use by keeping all credential handling outside your agent code.

## How the sidecar works

The sidecar container ([Microsoft Entra SDK auth sidecar](https://mcr.microsoft.com/en-us/product/entra-sdk/auth-sidecar/about)) exposes HTTP endpoints on the pod-local network and handles the following responsibilities:

- Client-credentials exchange with `login.microsoftonline.com`.
- Client-credentials or federated identity credential (FIC) token acquisition for the agent identity (autonomous flow).
- On-behalf-of (OBO) flows for user-context calls.
- Token caching, refresh, and expiry.
- Credential source abstraction — `ClientSecret` for development, `SignedAssertionFromManagedIdentity` for Azure deployments, using the same API.

The following table summarizes the flow of auth actions between your agent and the sidecar:

| Agent (your code) | Sidecar (Microsoft Entra SDK) |
|---|---|
| Decide when to call the API | Acquire and cache the right token |
| Build the HTTP request | Perform client-credentials and OBO exchange |
| Pass through user token for OBO | Validate and forward user assertion |
| Handle business logic | Communicate with `login.microsoftonline.com` |

The security boundary is explicit: the sidecar has no host port. Only services inside the same network, such as your agent container, can request tokens.

## Identity objects in the sidecar pattern

The following table describes the Microsoft Entra objects in the sidecar pattern and where each one lives:

| Object | Role | Location |
|---|---|---|
| **Blueprint application** | Factory/template that issues agent identities. Holds the client credential (secret or federated). | Your Microsoft Entra tenant |
| **Agent identity** | The individual AI agent. Has its own app ID, its own permission grants, and its own audit trail. | Your Microsoft Entra tenant |
| **Client SPA** (OBO only) | Web UI that signs the user in and exchanges the user's token into an agent token on their behalf. | Your Microsoft Entra tenant |
| **Sidecar container** | Runs client-credentials and OBO flows. Knows the blueprint credential. | Next to your agent |
| **Agent container** | Your application code. Asks the sidecar for headers. | Your pod, compose service, or App Service |

For more information about blueprints and agent identities, see [Agent identity blueprints](agent-blueprint.md) and [Agent identities](what-are-agent-identities.md).

## Credential source abstraction

The sidecar abstracts the credential source from your agent code. During development, you might use a `ClientSecret` for convenience. In production Azure deployments, you can switch to `SignedAssertionFromManagedIdentity` (a federated identity credential backed by managed identity) without changing your agent code.

The sidecar's configuration determines which credential source to use, and your agent continues to call the same `/AuthorizationHeader` endpoint regardless of the authentication mechanism.

## Sidecar sample scenarios

The [Microsoft Entra Agent ID sidecar samples](https://github.com/microsoft/entra-agentid-samples/tree/dev/sidecar) demonstrate the following:

- The difference between a blueprint and an agent identity, and why agents need their own identity.
- How the sidecar exposes `/AuthorizationHeader` (get token) and `/DownstreamApi` (token + proxied call) endpoints.
- How to forward a signed-in user's token to the agent and have the Microsoft Entra SDK mint an agent-on-behalf-of-user token via OBO.
- How the downstream API validates agent tokens cryptographically — signature, issuer, `xms_par_app_azp`, and audience.
- How to swap from `ClientSecret` (development) to `SignedAssertionFromManagedIdentity` (Azure deployments) without changing agent code.

## Related content

- [Microsoft Entra SDK for Agent ID documentation](/entra/msidweb/agent-id-sdk/overview)
- [Acquire tokens and call downstream APIs with Microsoft Entra SDK for Agent ID](microsoft-entra-sdk-for-agent-identities.md)
- [Microsoft Entra Agent ID design patterns](concept-agent-id-design-patterns.md)
- [Agent identity blueprints](agent-blueprint.md)
- [Autonomous agent app OAuth flow](agent-autonomous-app-oauth-flow.md)
- [On-behalf-of OAuth flow](agent-on-behalf-of-oauth-flow.md)
