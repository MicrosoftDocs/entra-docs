---
title: Agent user impersonation protocol
description: Learn how Agent IDs operate with user context through agent users using the agent user impersonation protocol with OAuth 2.0 token exchange.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
manager: pmwongera
ms.service: entra-id
ms.topic: concept-article
ms.date: 10/30/2025
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer implementing agent user scenarios, I want to understand the agent user impersonation protocol so that I can enable agents to operate with user context and delegated permissions.
---

# Agent user impersonation protocol

Agent user impersonation enables Agent IDs to operate with user context through agent users, combining user permissions with autonomous operation. In this scenario, an agentic application (actor 1) impersonates an agentic application instance (actor 2) that impersonates an agent user (subject) using FIC. Access is scoped to delegations assigned to agentic application instance. Agent user can be impersonated only by a single agent ID.

[!INCLUDE [Use Microsoft SDKs](./includes/use-microsoft-libraries.md)]

[!INCLUDE [Managed identities support](./includes/managed-identities-preferred.md)]

## Protocol steps

1. The agent ID blueprint requests an exchange token (T1) that it will use for agent ID impersonation. The agent ID blueprint presents client credentials that could be a secret, a certificate or a managed identity token used as an FIC.

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

1. The agent identity requests a token (T2) that it will use for agent user impersonation. The agent identity presents T1 as its client assertion. Entra ID returns T2 to the agent ID after validating that T1 (aud) == Agent ID parent app == Agent ID blueprint.​

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

1. The agent ID then sends an OBO token exchange request to Entra ID, including both T1 and T2. Entra ID validates that T2 (aud) == agent identity.

    ```
    POST /oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded
    
    client_id=AgentIdentity
    &scope=https://resource.example.com/scope1
    &client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
    &client_assertion={T1}
    &assertion={T2}
    &username=agenticuser@contoso.com
    &grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer
    &requested_token_use=on_behalf_of
    ```

1. Entra ID then issues the resource token.

Agent user impersonation requires credential chaining that follows the pattern agent ID blueprint → Agent ID → Agent User. Each step in this chain uses the token from the previous step as a credential, creating a secure delegation pathway. The same client ID must be used for both phases to prevent privilege escalation attacks.
