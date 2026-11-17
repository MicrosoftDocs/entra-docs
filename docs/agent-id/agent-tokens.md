---
title: Tokens in Microsoft agent identity platform
description: Learn about tokens in the Microsoft agent identity platform, including token types, claims structure, authentication flows, and how tokens enable secure communication between agent applications and resources.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: jmprieur

#customer-intent: As a developer working with agent applications, I want to understand how tokens work in the Microsoft agent identity platform, so that I can properly implement authentication, authorization, and security patterns in my agent solutions.
---

# Tokens in Microsoft agent identity platform

Tokens are the fundamental security mechanism that enables secure communication and authorization in the Microsoft agent identity platform. This article explains how tokens work in agent app scenarios.

In agent app scenarios, tokens carry enhanced claims to support the unique requirements. Unlike nonagentic application tokens, tokens used by agents include specialized claims that identify entity types, delegation relationships, and authorization contexts specific to agent operations.

These tokens enable secure communication between:

- Agent identity blueprints and their agent identities
- Agent identities and resource APIs
- Agents' user accounts and the services they interact with
- Complex delegation chains involving multiple agent entities

## Token claims entity identifiers

Agent tokens include specialized claims that identify the type and role of entities participating in authentication flows:

- Actor facet claims (`xms_act_fct`): Identify the entity performing actions within the token flow. These claims enable systems to understand who is actually requesting access or performing operations.

- Subject facet claims (`xms_sub_fct`): Identify the ultimate subject for whom operations are being performed. It enables proper attribution even in complex delegation scenarios.

- Identity type claims (`idtyp`): Distinguish between user and application contexts, enabling appropriate policy application and security enforcement.

- Identity relationship claims (`xms_idrel`): Describe the relationship between the token subject and the resource tenant, supporting multitenancy and guest access scenarios.

## Token flow patterns

Agents participate in several distinct token flow patterns, each designed for specific operational scenarios. For more information, see [auth protocols in Microsoft agent identity platform](./agent-oauth-protocols.md).

### Tokens in user delegation scenarios

User delegation scenarios enable agents to operate on behalf of users. A downstream access token preserves the user's identity as the subject and identifies the agent identity as the actor. For a multi-instance agent, the incoming user token targets the blueprint's client ID. For a single-instance agent, it targets the client ID shared by the blueprint and agent identity. The downstream token targets the API being called, not the agent.
In this scenario, tokens have the following key characteristics:

- Maintain user identity context throughout operations
- Include delegated permissions granted to the agent identity, directly or through supported blueprint inheritance.
- Enable policy evaluation at both user and application levels
- Support both interactive and background operations

The agent identity receives delegated permissions that can be directly assigned or inherited from the parent agent identity blueprint when impersonation is used.

### Tokens in application-only scenarios

Application-only scenarios represent autonomous operations where agent identities act on their own behalf without user context.

In this scenario, tokens have the following key characteristics:

- Represent the agent identity as both actor and subject.
- Include application-level permissions directly assigned by the tenant administrator
- Enable unscoped access within granted permission boundaries. Delegated permissions aren't applied.
- Support fully autonomous background operations

### Tokens in agent's user account impersonation scenarios

Agent's user account impersonation scenarios enable the agent's user account to operate like a human user. These tokens support scenarios where agents need user-like context but with controlled, predefined identities.

In this scenario, tokens have the following key characteristics:

- Use specialized agent's user account identities
- Maintain user-context behavior patterns
- Include scoped delegated permissions
- Require explicit assignment to agent identities

In the blueprint exchange pattern, the agent identity blueprint impersonates the agent identity, which then impersonates the assigned agent's user account. Access is scoped to delegated permissions assigned to the agent identity, ensuring the agent can't exceed its granted permissions even when operating with user context. The agent's user account can only be used when assigned to an agent identity and can't authenticate independently.

## Nonagentic API integration

Both agents and nonagentic OBO clients carry forward subject facets. It enables resource servers to apply appropriate policies and logging for agent subjects. It also enables proper attribution even when tokens pass through nonagentic intermediaries.

## Builder application claims

Platforms that create agents and integrate with Microsoft Entra Agent ID don't receive special token claims. These platforms use standard token claims appropriate for their authentication method and don't participate in the specialized agent claim structure.

## Tenancy models and token behavior

All tokens contain a tenant ID (`tid`) representing the organization's tenant. Tokens are bounded within the tenant of the agent identity. Each agent identity receives tokens scoped to its operational tenant. Agent identities can't access resources outside their assigned customer tenant. Supported permission inheritance applies to multi-instance blueprint-to-child exchanges; a single-instance agent has direct grants and no blueprint principal.

## Token validation

Clients using agent identities are expected to treat the access tokens issued to them to use at resource servers as opaque, and not try to parse them. However, resource servers that receive access tokens issued to agents need to parse the tokens to validate them and extract claims for authorization purposes.

Use the API's authentication middleware to validate the token before reading claims. For framework setup and permission enforcement, see [Secure a web API with Microsoft Entra ID](how-to-validate-agent-tokens-downstream-api.md).

Resource servers should validate agent tokens by:

- Verifying standard OAuth claims (aud, exp, iss)
- Checking agent facet claims for proper entity identification
- Validating permissions based on token type (delegated vs app-only)
- Ensuring tenant boundary compliance

Token claims enable policy engines to:

- Identify agents vs nonagentic clients
- Distinguish between different agent scenarios
- Apply appropriate conditional access policies
- Generate accurate audit logs

[!INCLUDE [Validate tokens from agent identities](includes/validate-tokens.md)]

## Audit and logging integration

Token claims provide the foundation for comprehensive audit trails:

- `azp` identifies the requesting agent identity for client attribution
- `oid` identifies the subject for resource access attribution
- `xms_act_fct` and `xms_sub_fct` enable detailed flow analysis
- `tid` ensures proper tenant context in logs

## Related content

[Agent token claims](./agent-token-claims.md)
