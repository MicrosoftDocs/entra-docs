---
title: Agentic service principals
description: Learn about agentic service principals in Microsoft Entra, including Agent ID Blueprint Principal (AB-SP) and Agent Identity (Agent ID), and how they differ from traditional service principals in authentication, permissions, and lifecycle management.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer or IT administrator, I want to understand how agentic service principals work and how they differ from traditional service principals, so that I can effectively implement authentication, permissions, and lifecycle management for agentic applications in my organization.
---

# Agent service principals

The Agent ID platform model introduces specific service principal types with distinct roles and characteristics compared to application service principals that aren't agent identities. This article focuses on how application service principals differ from those used by the Agent ID platform model for agent identities and agent identity blueprint principals.

## Agent ID blueprint principal

Agent ID blueprint principals are created automatically when an agent identity blueprint is instantiated in a tenant. These are a type of service principals that provide the runtime representation of the agent identity blueprint within the tenant's directory and enable the agent identity blueprint to perform operations like creating instances and managing lifecycle operations.

The creation process involves consent operations that require permissions like `AgentIdentity.Create` and `ServicePrincipal.Manage.OwnedBy`. The agent identity blueprint principal enables the agent identity blueprint to obtain app-only tokens for Microsoft Graph calls necessary to create and manage agent identities. This process is essential because agentic applications themselves can't directly obtain tokens for MS Graph operations.

## Agent identity as service principal

Agent identities are modeled as single-tenant service principals with a new subtype classification of "agent identity." This design uses existing Microsoft Entra ID service principal infrastructure while adding agentic-specific behaviors and constraints.

Agent identities inherit their protocol properties from their parent agent identity blueprint through the ParentID relationship. Unlike traditional service principals that operate independently, agent identities require their parent agent identity blueprint for impersonation and token exchange operations.

Agent identities can be granted permissions directly and appear in sign-in logs when tokens are issued for agent operations. They serve as the primary identity that customers reason about when managing agent permissions and access.

Agent identity service principals are created by their parent agent identity blueprint principal using Microsoft Graph calls with app-only tokens and appropriate roles. The creation process establishes the parent-child relationship and configures the necessary FIC relationships for impersonation.

## Agents built using application service principals

Before the introduction of the Agent ID platform, some Microsoft applications such as Microsoft Copilot Studio and Azure AI Foundry used application agent service principals to ensure their agents were secured with identities. These are shown alongside agent identity objects in your tenant in the [**All agent identities** list](agent-lists.md). 

They can be differentiated in this list using the "Uses agent identity" column and filter. With the "Uses agent identity" filter, you can show either or both of agent identity objects and agents using application service principals. See the list of columns in the [**All agent identities** list](agent-lists.md#select-viewing-options).

These agents using service principal behaves the same as application service principals, and don't have the same differences from application service principals as agent identities or agent identity blueprint principals.

## Key Differences from nonagentic service principals

### Impersonation model

Nonagentic service principals operate using their own credentials and identity. Agentic service principals use an impersonation model where the agent ID blueprint impersonates the agent ID to perform operations on the instance's behalf.

This impersonation model enables the agent ID blueprint to obtain tokens where the agent ID appears as the client, even though the agent ID blueprint is performing the actual token exchange. The resulting tokens maintain the agent ID's identity in audit logs while enabling the agent ID blueprint to orchestrate complex token flows.

### Multi-instance relationship

Nonagentic applications typically have a one-to-one relationship between application and service principal. The agentic model introduces a one-to-many relationship where a single agent ID blueprint can have multiple agent ID service principals across tenants and within tenants.

This multi-instance model enables scenarios like creating multiple agent IDs per Teams channel, per project, or per organizational unit, all sourcing their protocol properties from the same parent agent ID blueprint.

### Runtime credential management

Nonagentic service principals manage their own credentials (certificates, secrets, and managed identities). The service principal presents these credentials to obtain tokens for itself or to perform On-Behalf-Of operations for users. Agent identities rely on credentials from the parent agent ID blueprint and can't manage credentials independently. Agent ID service principals don't perform direct authentication.

### Consent and permission model

Nonagentic service principals receive permissions through direct assignment or admin consent. Agentic service principals support both direct permission assignment and inheritance from parent applications.

When inherit delegated permissions is enabled, an agent ID can inherit delegated permissions from their parent agent identity blueprint, reducing consent complexity for multi-instance scenarios. This inheritance applies when impersonation is used and enables efficient permission management across multiple instances.

## Permission and role assignment

Agentic service principals support both application permissions (for app-only operations) and delegated permissions (for user-delegated operations). Permission assignment can be direct or inherited depending on the scenario requirements.

**Direct assignment**: Permissions can be assigned directly to an agent ID for instance-specific access requirements.

**Inherited assignment**: When `InheritDelegatedPermissions` is enabled on the service principal, agent IDs inherit delegated permissions from their parent agent ID blueprint, simplifying permission management in multi-instance scenarios.

**Role assignment**: Agent IDs can be assigned Azure RBAC roles and directory roles like nonagentic service principals, enabling resource access and administrative operations. Agent ID blueprints can't be assigned Azure RBAC roles

## Audit and logging

Agentic service principals maintain distinct identities in audit logs and sign-in reports. When an agent ID performs operations, the logs show the agent ID as the acting client while indicating the relationship to the parent AB.

Sign-in logs differentiate between agent ID blueprints, agent identities, and agent users. This differentiation enables clear role identification (client, credential, subject) depending on the specific operation being performed. This enables audit trails for agentic operations.
