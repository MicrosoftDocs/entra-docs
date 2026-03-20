---
title:  Agents' user accounts in Microsoft Entra Agent ID
description: This article explains the concept of agents' user accounts, how they function within Microsoft Entra ID, and their relationship with agent identities.
titleSuffix: Microsoft Entra Agent ID
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.topic: concept-article

#customer intent: As a developer or IT administrator, I want to understand agents' user accounts and their capabilities so that I can determine when to create them and how to manage agents that need to act as digital workers in my organization.
ms.reviewer: yukarppa
---

# Agents' user accounts in Microsoft Entra Agent ID

Agents' user accounts are a specialized identity type designed to bridge the gap between agents and human user capabilities. Agents' user accounts enable AI-powered applications to interact with systems and services that require user identities, while maintaining appropriate security boundaries and management controls. It allows organizations to manage those agent's access using similar capabilities as they do for human users.

## Example of agent's user account scenarios

Sometimes it's not enough for an agent to perform tasks on behalf of a user or operate as an autonomous application. In certain scenarios, an agent needs to act as a user, functioning essentially as a digital worker. The following are example scenarios where the agent's user account would be applicable:

-  The organization needs long-term digital employees that function as team members with mailboxes, chat access, and inclusion in HR systems.
- The agent needs to access APIs or resources that are only available to user identities
- The agent needs to participate in collaborative workflows as a team member

For these reasons, agents' user accounts are created. Agents' user accounts are optional and should only be created for interactions where the agent needs to act as a user or access resources restricted to user accounts.

## Agents' user accounts

Agents' user accounts represent a subtype of user identity within Microsoft Entra. These identities are designed to enable agent applications to perform actions in contexts where a user identity is required. Unlike nonagentic service principals or application identities, agents' user accounts receive tokens with claim `idtyp=user`, allowing them to access APIs and services that specifically require user identities. It also maintains security constraints necessary for nonhuman identities.

An agent's user account isn't created automatically. It requires an explicit creation process that connects it to its parent agent identity. This parent-child relationship is fundamental to understanding how agents' user accounts function and are secured in Microsoft Entra. Once established, this relationship is immutable and serves as a cornerstone of the security model for agents' user accounts. The relationship is a one-to-one (1:1) mapping. Each agent identity can have at most one associated agent's user account, and each agent's user account is linked to exactly one parent agent identity, itself linked to exactly one agent identity blueprint application.

Agents' user accounts:

- Are also created using an agent identity blueprint.
- Are always associated to a specific agent identity, specified upon creation.
- Have distinct unique identifiers, separate from the agent identity.
- Can only authenticate by presenting a token issued to the associated agent identity.

:::image type="content" source="media/agent-users/agent-user.png" alt-text="Diagram showing the relationship between an agent's user account and agent identity.":::

## Agent's user account and agent ID relationship

The agent identity blueprint doesn't have the permission by default to create agents' user accounts because this capability is optional and not always needed. It's a permission that must be explicitly granted to the agent identity blueprint.

Agents' user accounts are created using agent identity blueprint. When granted proper permissions, the agent identity blueprint can create an agent's user account and establish a parent relationship with a specific agent identity. Agent identity is considered as the parent of the agent's user account.

Admins manage the lifecycle of an agent's user account. An admin user can delete the agent's user account once agent's user account functionalities aren't needed anymore.

## Authentication and security model

The authentication model for agents' user accounts differs significantly from human-user accounts:

- **Federated identity credentials**: Authentication happens through credentials assigned to the agent's user account. In production systems, use Federated Identity Credentials (FIC). These credentials are used for authenticating both the agent identity blueprint and the agent identity. The credential assigned to the user is used for authenticating across the agent ecosystem.

- **Restricted credential model**: Agents' user accounts don't have regular credentials like passwords. Instead, they're restricted to using the credentials provided through their parent relationship. This restriction on credentials, along with restrictions on interactive sign-in, ensures that agents' user accounts can't be used like standard user accounts.

- **Impersonation mechanism**: The associated agent identity can impersonate its child agent's user account. It allows the parent's business logic to obtain tokens and act as the agent's user account when needed.

## Capabilities of agents' user accounts

Agents' user accounts possess capabilities that allow them to function effectively within Microsoft 365 and other environments:

- Agents' user accounts can be added to Microsoft Entra groups, including dynamic groups, enabling them to inherit permissions granted to those groups. They can't, however, be added to role-assignable groups.

- Agents' user accounts can access resources and utilize other collaborative features typically reserved for human users.

- Agents' user accounts can be added to administrative units, similar to human users.

- Agents' user accounts can be assigned licenses, which is often necessary for provisioning Microsoft 365 resources.

## Security constraints

Agents' user accounts operate under specific security constraints to ensure appropriate use:

- Credential limitations: Agents' user accounts can't have credentials like passwords or passkeys. The only credential type they support is the agent identity reference to their parent. So even if agents' user accounts behave as users, their credentials are confidential client credentials.

- Administrative role restrictions: Agents' user accounts can't be assigned privileged administrator roles. This limitation provides an important security boundary, preventing potential elevation of privileges.

- Permission model: Agents' user accounts typically have permissions similar to guest users, with more capabilities for enumerating users and groups. Agents' user accounts can't be assigned privileged admin roles. Custom role assignment and role-assignable groups aren't available to agents' user accounts. For more information, see [Microsoft Graph permissions reference](/graph/permissions-reference)
