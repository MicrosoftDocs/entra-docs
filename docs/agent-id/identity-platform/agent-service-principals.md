---
title: Agent identities, service principals, and applications
description: Learn about agent service principals in Microsoft Entra and how they differ from traditional service principals in authentication, permissions, and lifecycle management.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 04/03/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer or IT administrator, I want to understand how agent service principals work and how they differ from traditional service principals, so that I can effectively implement authentication, and permissions for agent applications in my organization.
---

# Agent identities, service principals, and applications

Agent identities are built on the same service principal infrastructure that applications use throughout Microsoft Entra, but they're a distinct object type. Standard service principals were designed for static, deterministic workloads and operate using their own credentials directly. Agent identities add a delegation model where the blueprint acquires tokens on behalf of each agent identity, support a one-to-many blueprint relationship, require an assigned sponsor, and generate agent-specific audit entries.

This article explains the following concepts:
- The service principal types in the agent app model
- How they relate to agent identity blueprints
- How they differ from standard application service principals

## Agent identity blueprint principal

Agent identity blueprint principals are created automatically when an agent identity blueprint is instantiated in a tenant. These service principals provide the runtime *representation* of the agent identity blueprint within the tenant's directory and enable the agent identity blueprint to perform operations, such as creating instances and managing lifecycle operations.

The creation process involves consent operations that require permissions like `AgentIdentity.Create` and `ServicePrincipal.Manage.OwnedBy`. The agent identity blueprint principal enables the agent identity blueprint to obtain app-only tokens for Microsoft Graph calls necessary to create and manage agent identities. This process is essential because agent blueprints themselves can't directly obtain tokens for Microsoft Graph operations.

## Agent identity as service principal

Agent identities are modeled as single-tenant service principals with a new "agent" subtype classification. This design uses existing Microsoft Entra ID service principal infrastructure while adding agent-specific behaviors and constraints.

Agent identities inherit their protocol properties from their parent agent identity blueprint through the ParentID relationship. Unlike standard service principals that operate independently, agent identities require their parent agent identity blueprint for impersonation and token exchange operations.

Agent identities can be granted permissions directly and appear in sign-in logs when tokens are issued for agent operations. They serve as the primary identity that customers reason about when managing agent permissions and access.

The agent identity blueprint principal creates agent identity service principals using Microsoft Graph calls with app-only tokens and appropriate roles. The creation process establishes the parent-child relationship and configures the necessary Federated Identity Credential (FIC) relationships for impersonation.

## Agents built using application service principals

Before the Microsoft agent identity platform was introduced, some Microsoft applications, including earlier versions of Microsoft Copilot Studio and Azure AI Foundry, used standard application service principals to secure their agents. These service principals appear alongside agent identity objects in the Microsoft Entra admin center.

You can distinguish them by filtering the **All agent identities** list. Agents using standard service principals behave identically to other application service principals and don't have the agent-specific behaviors described in this article. For filtering options, see [Select viewing options](agent-lists.md#select-viewing-options).

## Key differences

The following sections describe how the agent app model differs from standard application service principals.

### Impersonation model

Standard service principals operate using their own credentials and identity. Agent service principals use an impersonation model: the agent identity blueprint acquires tokens on behalf of each agent identity, so the agent identity appears as the client in the resulting token and in audit logs, even though the blueprint performed the actual token exchange.

This separation means the blueprint holds the authentication credentials while the agent identity holds the permissions and the audit identity. A compromise of the blueprint's credentials affects all agent identities under it, which is why blueprint count is a security boundary decision.

### Multi-instance relationship

Standard applications have a one-to-one relationship between application and service principal. The agent app model is one-to-many: a single agent identity blueprint can produce multiple agent identity service principals within a tenant or across tenants. Each agent identity sources its protocol properties from the blueprint but can hold its own permissions on downstream resources.

### Credential management

Standard service principals manage their own credentials (certificates, secrets, or managed identities) and use them to obtain tokens directly. Agent identities don't manage credentials. The blueprint holds all credentials and uses them to impersonate each agent identity.

Managed identities are a supported credential type on blueprints (the most secure option for agents running on Azure), but they're a credential *on the blueprint*, not a replacement for the agent identity itself.

### Permissions and role assignment

Agent service principals support both application permissions (for autonomous operations) and delegated permissions (for interactive, on-behalf-of operations). Permissions can be assigned directly to an agent identity or inherited from the blueprint.

When `InheritDelegatedPermissions` is enabled, agent identities inherit delegated permissions from the blueprint, which simplifies consent management across many agent identities. Use inherited permissions for the shared baseline and direct assignment for role-specific access.

Agent identities can be assigned Azure RBAC roles and Microsoft Entra built-in roles, the same as standard service principals. Agent identity blueprints can't be assigned Azure RBAC roles.

### Audit and logging

Agent service principals maintain distinct identities in audit logs and sign-in reports. When an agent identity performs an operation, logs show it as the acting client and indicate the relationship to its blueprint. Sign-in logs differentiate between agent identity blueprints, agent identities, and agents' user accounts, enabling clear identification of the credential source, the acting identity, and the subject of each operation.
