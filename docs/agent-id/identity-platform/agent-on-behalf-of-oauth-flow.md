---
title: Agent OAuth flows - On-behalf-of flow
description: Learn how agent applications operate on behalf of signed-in users using OAuth 2.0 On-Behalf-Of flows with agent identity blueprints and agent identities.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer implementing on-behalf-of flows for agents, I want to understand how Agent IDs operate on behalf of signed-in users so that I can enable agents to access user data with proper delegated permissions.
---

# Agent OAuth flows: On behalf of flow

Agents (agent identity blueprints) operating on behalf of regular, signed-in users use the standard OAuth 2.0 protocol with all its capabilities. User delegation enables agent identities to operate on behalf of signed-in users using standard OAuth 2.0 On-Behalf-Of flows with agent-specific impersonation. The agent identity is assigned the necessary delegated permissions needed for OBO access. It requires consent from users to access their data.

Agents have the capabilities of Microsoft Entra ID resource (API) applications and support the API attributes required for the (OAuth2Permissions, AppURI). Agents can’t use any OBO flows. Redirect URIs aren't supported.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

## Protocol steps

Agents aren't supported for OBO (`/authorize`) flows. Supported grant types are `client_credential`, `jwt_bearer`, and `refresh_token`. The flow involves the agent identity blueprint, agent identity, and a client credential. The client credential can be a client secret, a client certificate, or a managed identity used as Federated Identity Credential (FIC).

:::image type="content" source="media/agent-on-behalf-of-oauth-flow/on-behalf-of-flow.png" alt-text="Diagram showing the illustration of on-behalf-of token acquisition flow for agents.":::

1. The user authenticates with the client and obtains a user access token (client token, Tc).

1. Client sends the user access token (Tc) to the agent identity blueprint to act on behalf of the user. It's the token that is used for the OBO exchange for the agent identity blueprint.

1. The agent identity blueprint requests an exchange token by presenting its client credential (secret, certificate, or managed identity token (TUAMI)). In this example, we use a managed identity as FIC. Microsoft Entra ID returns token T1 to the agent.

    [!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentBlueprint
    &scope=api://AzureADTokenExchange/.default
    &fmi_path=AgentIdentity
    &client_assertion=TUAMI
    &grant_type=client_credentials
    ```

    Where TUAMI is the managed identity token for user assigned managed identity (UAMI). This step returns T1.

1. The agent identity, a child of the agent identity blueprint, sends an OBO token exchange request. This request includes both T1 and the user access token Tc.

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentIdentity
    &scope=https://resource.example.com/scope1
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion={T1}
    &grant_type=urn:ietf:params:oauth:grant-type:jwt_bearer
    &assertion={Tc(aud=AgentIdentity Blueprint, oid=User)}
    &requested_token_use=on_behalf_of
    ```

1. Microsoft Entra ID returns the resource token after validating both the T1 and Tc. The OBO protocol requires token audience to match the client ID:

    - T1 (aud) == Agent identity Parent app == Agent identity blueprint client ID
    - Tc (aud) == Agent identity blueprint client ID

### Sequence diagram

The following sequence diagram shows the OBO flow

:::image type="content" source="media/agent-on-behalf-of-oauth-flow/on-behalf-of-flow-token-sequence.png" alt-text="Diagram showing the token sequence of on-behalf-of token acquisition flow for agents.":::

### Refresh token support

Refresh token can be used for asynchronous scenarios and background processes:

```
POST /oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

client_id=AgentIdentity
&scope=https://resource.example.com/scope1
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion={T1}
&grant_type=refresh_token
&refresh_token={AgentIdentityRefreshToken}
```

### Permission inheritance

Agent identities can inherit delegated permissions from their parent agent identity blueprint when the `InheritDelegatedPermissions` property is enabled. This inheritance mechanism reduces consent complexity for multi-instance scenarios by allowing agent identities to use permissions already granted to their parent application. The inheritance functionality applies specifically when FIC impersonation is used and enables efficient permission management across multiple instances. However, inheritance works only within tenant boundaries, ensuring that permission scope remains contained within appropriate organizational limits.

## Related content

- [Oauth2.0 flows for agents](./agent-oauth-protocols.md)
- [Autonomous app flow in agents](./agent-autonomous-app-oauth-flow.md)
- [Agent user flow in agents](./agent-user-oauth-flow.md)
