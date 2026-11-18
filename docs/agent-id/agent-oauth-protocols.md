---
title: Choose an authentication protocol for an agent
description: Choose an OAuth protocol for a local, hosted, delegated, or autonomous agent in Microsoft Entra Agent ID.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 11/03/2026
ms.reviewer: jmprieur
ai-usage: ai-assisted

#customer-intent: As a developer or identity architect, I want to choose the right authentication protocol for my agent's hosting model and access requirements.
---

# Choose an authentication protocol for an agent

The right authentication protocol depends on where the agent runs and whose identity it uses to access a resource. Start with these questions:

1. Does the agent run on a user's device or in a hosted service?
1. Does the agent act for a signed-in user, as itself, or as a dedicated agent user account?
1. If it acts for a signed-in user, does the agent initiate sign-in or receive a user access token from another application?

Use Microsoft Authentication Library (MSAL) or another supported authentication library instead of constructing protocol requests directly.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

## Choose a protocol

| Use case | Recommended protocol | Access type | Client type |
| --- | --- | --- | --- |
| A local agent runs on an endpoint device and signs in the user | Authorization code flow with Proof Key for Code Exchange (PKCE) | Delegated | Public |
| A hosted agent receives a user access token from a client application and calls another service for that user | On-Behalf-Of (OBO) flow | Delegated | Confidential |
| A hosted agent runs without a user and accesses resources as itself | Client credentials flow; blueprint impersonation for multi-instance Agent IDs | Application | Confidential |
| An autonomous agent needs a mailbox or another resource available only to a user | Agent's user account impersonation | Delegated permissions assigned to the agent's user account | Confidential |

If more than one row applies, use a separate token acquisition path for each operating mode. For example, a hosted agent might use OBO for requests initiated by a user and app-only access for scheduled work that doesn't have user context.

The blueprint's [instance mode](agent-blueprint.md#instance-modes-preview) also affects token acquisition. A single-instance Agent ID (preview) uses the shared blueprint client ID directly for authorization code, refresh, client credentials, and OBO requests. It doesn't acquire an intermediate blueprint impersonation token. Single-instance mode isn't limited to local or public clients. For an overview and links to the consent and SDK walkthroughs, see [Authentication for a single-instance agent identity](authenticate-single-instance-agent.md). To start with a platform-specific walkthrough, see [Choose an integration path for an agent](choose-agent-integration-path.md).

## Local agent that signs in a user

Choose the authorization code flow with PKCE when the agent:

- Runs on a desktop, mobile device, or other endpoint.
- Can open a browser for interactive sign-in.
- Accesses protected services for the signed-in user.
- Can't securely store a client secret, certificate, or federated identity credential.

The local agent is a public client. It sends the user to the Microsoft identity platform `/authorize` endpoint, receives an authorization code at its registered redirect URI, and redeems the code by using a PKCE verifier. It doesn't present a client credential.

A registered public-client Agent ID must use [single-instance mode](agent-blueprint.md#instance-modes-preview). Every installation uses the same client ID; don't create an Agent ID for each device. A local agent can alternatively use a [Client ID Metadata Document (CIMD)](client-id-metadata-documents.md) URL as its client ID.

Don't use this flow for a hosted agent that receives a user access token from another application. Use OBO instead.

For implementation and protocol details, see:

- [Authenticate a local agent with Microsoft Entra ID](authenticate-local-agent.md)
- [OAuth 2.0 authorization code grant](agent-authorization-code-oauth-flow.md)
- [Microsoft identity platform and OAuth 2.0 authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow)
- [Public client and confidential client applications](/entra/identity-platform/msal-client-applications)

## Hosted agent that acts for a signed-in user

Choose the OBO flow when:

- A client application signs in the user.
- The client calls the hosted agent or its API with a user access token.
- The agent must call a downstream API with the user's identity and delegated permissions.

The hosted agent is a confidential client. It doesn't start another interactive sign-in. Instead, it exchanges the incoming user access token for a token to the downstream resource. The incoming token must be intended for the agent's blueprint; don't relay a token issued for another resource.

For a multi-instance Agent ID, configure the required delegated permissions as inheritable permissions on the blueprint and obtain administrator consent.

Don't use OBO when no signed-in user initiated the operation. Use app-only access for autonomous work.

For implementation and protocol details, see:

- [Agent OAuth flows: On behalf of flow](agent-on-behalf-of-oauth-flow.md)
- [Microsoft identity platform and OAuth 2.0 On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)
- [Configure inheritable permissions for agent identity blueprints](configure-inheritable-permissions-blueprints.md)

## Hosted agent that acts as itself

Choose the client credentials flow with Agent ID impersonation when the agent:

- Runs in a hosted service that can protect a credential.
- Performs scheduled, event-driven, or other autonomous work.
- Accesses a resource as the Agent ID rather than as a user.

For a multi-instance Agent ID, the blueprint first authenticates and obtains a token-exchange token for its child Agent ID. The Agent ID then uses that token as a client assertion in the client credentials flow. A single-instance Agent ID instead authenticates directly with the shared client ID and a credential on the blueprint. The resource token contains application permissions granted by an administrator and identifies the Agent ID as the actor.

Use a managed identity and federated identity credential when the hosting environment supports them. Avoid client secrets.

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

Don't use application permissions when the resource should apply a signed-in user's permissions or consent. Use authorization code with PKCE or OBO instead.

For implementation and protocol details, see:

- [Agent autonomous app OAuth flow](agent-autonomous-app-oauth-flow.md)
- [Microsoft identity platform and the OAuth 2.0 client credentials flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow)
- [Workload identity federation](/entra/workload-id/workload-identity-federation)

## Autonomous agent that acts as a dedicated user

Choose agent's user account impersonation only when an autonomous agent needs capabilities that are available to a user but not to an application identity. For example, an agent might need its own mailbox.

An [agent's user account](agent-users.md) is a dedicated user identity for the agent, not the account of the person using the agent. The Agent ID impersonates this account through an agent-specific token exchange. Access is limited by the permissions assigned to the Agent ID and the agent's user account.

Don't create an agent's user account only to run unattended work. If the resource supports application permissions, prefer app-only access so the workload doesn't depend on a user identity.

For implementation details, see:

- [Agent's user account impersonation protocol](agent-user-oauth-flow.md)
- [Agent's user accounts](agent-users.md)

## Related authentication concepts

The following settings affect authentication but don't replace the protocol choice:

- **Public or confidential client** describes whether the agent can securely hold a credential. For more information, see [Public client and confidential client applications](/entra/identity-platform/msal-client-applications).
- **Managed identity, certificate, secret, or federated identity credential** describes how a confidential client proves its identity. Prefer managed identities and federated identity credentials when possible.
- **CIMD or registered client ID** describes how a public client is identified. Both options can use authorization code flow with PKCE.
- **Refresh token** lets a client obtain new access tokens without repeating the original authorization. It continues an existing delegated session; it isn't a separate operating model.

## Related content

- [Request consent for delegated permissions](grant-agent-access-microsoft-365.md)
- [Agent identity token claims](agent-token-claims.md)
- [OAuth 2.0 and OpenID Connect protocols on the Microsoft identity platform](/entra/identity-platform/v2-protocols)
