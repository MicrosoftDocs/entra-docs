---
title: Agent identities, service principals, and applications
description: Learn about agent service principals in Microsoft Entra, including agent identity blueprint Principal and Agent Identity, and how they differ from traditional service principals in authentication, permissions, and lifecycle management.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer or IT administrator, I want to understand how agent service principals work and how they differ from traditional service principals, so that I can effectively implement authentication, and permissions for agent applications in my organization.
---

# Agent identities, service principals, and applications

The agent app model introduces specific service principal types with distinct roles and characteristics compared to nonagent application service principals. This article explains service principals in the agent application model, how they relate to agent identity blueprint and differ from nonagent application service principals.

## Agent identity blueprint principal

Agent identity blueprint principals are created automatically when an agent identity blueprint is instantiated in a tenant. These service principals provide the runtime representation of the agent identity blueprint within the tenant's directory and enable the agent identity blueprint to perform operations like creating instances and managing lifecycle operations.

The creation process involves consent operations that require permissions like `AgentIdentity.Create` and `ServicePrincipal.Manage.OwnedBy`. The agent identity blueprint principal enables the agent identity blueprint to obtain app-only tokens for Microsoft Graph calls necessary to create and manage agent identities. This process is essential because agent blueprints themselves can't directly obtain tokens for Microsoft Graph operations.

## Agent identity as service principal

Agent identities are modeled as single-tenant service principals with a new "agent" subtype classification. This design uses existing Microsoft Entra ID service principal infrastructure while adding agent-specific behaviors and constraints.

Agent identities inherit their protocol properties from their parent agent identity blueprint through the ParentID relationship. Unlike nonagentic service principals that operate independently, agent identities require their parent agent identity blueprint for impersonation and token exchange operations.

Agent identities can be granted permissions directly and appear in sign-in logs when tokens are issued for agent operations. They serve as the primary identity that customers reason about when managing agent permissions and access.

Agent identity blueprint principal creates agent identity service principals using Microsoft Graph calls with app-only tokens and appropriate roles. The creation process establishes the parent-child relationship and configures the necessary Federated Identity Credential (FIC) relationships for impersonation.

## Agents built using application service principals

Before the introduction of the Microsoft agent identity platform, some Microsoft applications such as Microsoft Copilot Studio and Azure AI Foundry used application agent service principals to ensure their agents were secured with identities. These are shown alongside agent identity objects in your tenant in the [**All agent identities** list](agent-lists.md). 

They can be differentiated in this list by filtering to get those that use agent identities. With the filter, you can show either or both of agent identity objects and agents using application service principals. See the list of columns in the [**All agent identities** list](agent-lists.md#select-viewing-options).

These agents using service principal behaves the same as application service principals, and don't have the same differences from application service principals as agent identities or agent identity blueprint principals.

## Key Differences from nonagent service principals

The following sections describe the key differences between agent service principals and nonagentic application service principals.

### Impersonation model

Nonagentic service principals operate using their own credentials and identity. Agent service principals use an impersonation model where the agent identity blueprint impersonates the agent identity to perform operations on the instance's behalf.

This impersonation model enables the agent identity blueprint to obtain tokens where the agent identity appears as the client, even though the agent identity blueprint is performing the actual token exchange. The resulting tokens maintain the agent identity's identity in audit logs while enabling the agent identity blueprint to orchestrate complex token flows.

### Multi-instance relationship

Nonagentic applications typically have a one-to-one relationship between application and service principal. The agent app model introduces a one-to-many relationship where a single agent identity blueprint can have multiple agent identity service principals across tenants and within tenants.

This multi-instance model enables scenarios like creating multiple agent identities per Teams channel, per project, or per organizational unit, all sourcing their protocol properties from the same parent agent identity blueprint.

### Runtime credential management

Nonagentic service principals manage their own credentials (certificates, secrets, and managed identities). The service principal presents these credentials to obtain tokens for itself or to perform On-Behalf-Of operations for users. Agent identities rely on credentials from the parent agent identity blueprint and can't manage credentials independently. Agent identity service principals don't perform direct authentication.

### Consent and permission model

Nonagentic service principals receive permissions through direct assignment or admin consent. Agent service principals support both direct permission assignment and inheritance from parent applications.

When inherit delegated permissions is enabled, an agent identity can inherit delegated permissions from their parent agent identity blueprint, reducing consent complexity for multi-instance scenarios. This inheritance applies when impersonation is used and enables efficient permission management across multiple instances.

## Permission and role assignment

Agent service principals support both application permissions (for app-only operations) and delegated permissions (for user-delegated operations). Permission assignment can be direct or inherited depending on the scenario requirements.

**Direct assignment**: Permissions can be assigned directly to an agent identity for instance-specific access requirements.

**Inherited assignment**: When `InheritDelegatedPermissions` is enabled on the service principal, agent identities inherit delegated permissions from their parent agent identity blueprint, simplifying permission management in multi-instance scenarios.

**Role assignment**: Agent identities can be assigned Azure Role Based Access Control (RBAC) roles and directory roles like nonagentic service principals, enabling resource access and administrative operations. Agent identity blueprints can't be assigned Azure RBAC roles

## Audit and logging

Agent service principals maintain distinct identities in audit logs and sign-in reports. When an agent identity performs operations, the logs show the agent identity as the acting client while indicating the relationship to the parent agent identity blueprint.

Sign-in logs differentiate between agent identity blueprints, agent identities, and agent users. This differentiation enables clear role identification (client, credential, subject) depending on the specific operation being performed. This enables audit trails for agent operations.
