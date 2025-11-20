---
title: Tokens in Microsoft agent identity platform
description: Learn about tokens in the Microsoft agent identity platform, including token types, claims structure, authentication flows, and how tokens enable secure communication between agent applications and resources.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/10/2025
ms.reviewer: jmprieur

#customer-intent: As a developer working with agent applications, I want to understand how tokens work in the Microsoft agent identity platform, so that I can properly implement authentication, authorization, and security patterns in my agent solutions.
---

# Tokens in Microsoft agent identity platform

Tokens are the fundamental security mechanism that enables secure communication and authorization in the Microsoft agent identity platform. This article explains how tokens work in agent app scenarios.

In agent app scenarios, tokens carry enhanced claims to support the unique requirements. Unlike nonagentic application tokens, tokens used by agents include specialized claims that identify entity types, delegation relationships, and authorization contexts specific to agent operations.

These tokens enable secure communication between:

- Agent identity blueprints and their agent identities
- Agent identities and resource APIs
- Agent users and the services they interact with
- Complex delegation chains involving multiple agent entities

## Token claims entity identifiers

Agent tokens include specialized claims that identify the type and role of entities participating in authentication flows:

- Actor facet claims (`xms_act_fct`): Identify the entity performing actions within the token flow. These claims enable systems to understand who is actually requesting access or performing operations.

- Subject facet claims (`xms_sub_fct`): Identify the ultimate subject for whom operations are being performed. It enables proper attribution even in complex delegation scenarios.

- Identity type claims (`idtyp`): Distinguish between user and application contexts, enabling appropriate policy application and security enforcement.

- Identity relationship claims (`xms_idrel`): Describe the relationship between the token subject and the resource tenant, supporting multi-tenancy and guest access scenarios.

## Token flow patterns

Agents participate in several distinct token flow patterns, each designed for specific operational scenarios. For more information, see [auth protocols in Microsoft agent identity platform](./agent-oauth-protocols.md).

### Tokens in user delegation scenarios

User delegation scenarios enable agent applications to operate on behalf of users. In this scenario, tokens preserve user identity while identifying the agent identity blueprint as the acting entity. The OBO protocol requires token audience to match the client ID. However, for agent identity (agent ID), the incoming token has the audience of the agent identity blueprint.
In this scenario, tokens have the following key characteristics:

- Maintain user identity context throughout operations
- Include delegated permissions granted to the agent identity blueprint
- Enable policy evaluation at both user and application levels
- Support both interactive and background operations

The agent identity receives delegated permissions that can be directly assigned or inherited from the parent agent identity blueprint when impersonation is used.

### Tokens in application-only scenarios

Application-only scenarios represent autonomous operations where agent identity blueprints act on their own behalf without user context.

In this scenario, tokens have the following key characteristics:

- Represent the agent identity blueprint's own identity
- Include application-level permissions directly assigned by the tenant administrator
- Enable unscoped access within granted permission boundaries. Delegated permissions aren't applied.
- Support fully autonomous background operations

### Tokens in agent user impersonation scenarios

Agent user impersonation scenarios enable agent users to operate like human users. These tokens support scenarios where agents need user-like context but with controlled, predefined identities.

In this scenario, tokens have the following key characteristics:

- Use specialized agent user identities
- Maintain user-context behavior patterns
- Include scoped delegated permissions
- Require explicit assignment to agent identities

In this scenario, the agent identity blueprint impersonates the agent identity, which then impersonates the assigned agent user. Access is scoped to delegated permissions assigned to the agent identity, ensuring the agent can't exceed its granted permissions even when operating with user context. Agent users can only be used when assigned to an agent identity and can't authenticate independently.

## Nonagentic API integration

Both agents and nonagentic OBO clients carry forward subject facets. It enables resource servers to apply appropriate policies and logging for agent subjects. It also enables proper attribution even when tokens pass through nonagentic intermediaries.

## Builder application claims

Platforms that create agents and integrate with Microsoft Entra Agent ID don't receive special token claims. These platforms use standard token claims appropriate for their authentication method and don't participate in the specialized agent claim structure.

## Tenancy models and token behavior

All tokens contain a tenant ID (`tid`) representing the organization's tenant. Tokens are bounded within the tenant of the agent identity. Each agent identity receives tokens scoped to its operational tenant. Agent identities can't access resources outside their assigned customer tenant. Permission inheritance flows directly from parent to child entities.

## Token validation

Clients using agent identities are expected to treat the access tokens issued to them to use at resource servers as opaque, and not try to parse them. However, resource servers that receive access tokens issued to agents need to parse the tokens to validate them and extract claims for authorization purposes.

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

Example of the validation process would be to do the following actions:

- Check if a token was issued for an agent identity and for which agent blueprint.

    ```csharp
    HttpContext.User.GetParentAgentBlueprint()
    ```

- Check if a token was issued for an agent user identity.

    ```csharp
    HttpContext.User.IsAgentUserIdentity()
    ```

These two extensions methods, apply to both `ClaimsIdentity` and `ClaimsPrincipal`.

## Audit and logging integration

Token claims provide the foundation for comprehensive audit trails:

- `azp` identifies the requesting agent identity for client attribution
- `oid` identifies the subject for resource access attribution
- `xms_act_fct` and `xms_sub_fct` enable detailed flow analysis
- `tid` ensures proper tenant context in logs

## Related content

[Agent token claims](./agent-token-claims.md)
