---
title: Agent user impersonation protocol
description: Learn how agent identities operate with user context through agent users using the agent user impersonation protocol with OAuth 2.0 token exchange.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.service: entra-id
ms.topic: concept-article
ms.date: 10/30/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer implementing agent user scenarios, I want to understand the agent user impersonation protocol so that I can enable agents to operate with user context and delegated permissions.
---

# Agent user impersonation protocol

Agent user impersonation enables agent identities to operate with user context through agent users, combining user permissions with autonomous operation. In this scenario, an agent identity blueprint (actor 1) impersonates an agent identity (actor 2) that impersonates an agent user (subject) using FIC. Access is scoped to delegations assigned to the agent identity. Agent user can be impersonated only by a single agent identity.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

## Protocol steps

Then following are the protocol steps.

:::image type="content" source="media/agent-user-oauth-flow/agent-user-flow.png" alt-text="Diagram showing the illustration of agent user token acquisition flow for agents.":::

1. The agent identity blueprint requests an exchange token (T1) that it uses for agent identity impersonation. The agent identity blueprint presents client credentials that could be a secret, a certificate, or a managed identity token used as an FIC.

    [!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentBlueprint
    &scope=api://AzureADTokenExchange/.default
    &fmi_path=AgentIdentity
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion=TUAMI
    &grant_type=client_credentials
    ```

    Where TUAMI is the MSI token for user assigned managed identity (UAMI). This returns token T1.

1. The agent identity requests a token (T2) that it uses for agent user impersonation. The agent identity presents T1 as its client assertion. Microsoft Entra ID returns T2 to the agent identity after validating that T1 (aud) == Agent identity parent app == Agent identity blueprint.​

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentIdentity
    &scope=api://AzureADTokenExchange/.default
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion={T1}
    &grant_type=client_credentials
    ```

    This returns token T2.    

1. The agent identity then sends an OBO token exchange request to Microsoft Entra ID, including both T1 and T2. Microsoft Entra ID validates that T2 (aud) == agent identity.

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentIdentity
    &scope=https://resource.example.com/scope1
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion={T1}
    &assertion={T2}
    &username=agentuser@contoso.com
    &grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer
    &requested_token_use=on_behalf_of
    ```

1. Microsoft Entra ID then issues the resource token.

### Sequence diagram

The following sequence diagram shows the agent user impersonation flow

:::image type="content" source="media/agent-user-oauth-flow/agent-user-flow-token-sequence.png" alt-text="Diagram showing the token sequence of agent user token acquisition flow for agents.":::

Agent user impersonation requires credential chaining that follows the pattern agent identity blueprint → Agent identity → Agent user. Each step in this chain uses the token from the previous step as a credential, creating a secure delegation pathway. The same client ID must be used for both phases to prevent privilege escalation attacks.
