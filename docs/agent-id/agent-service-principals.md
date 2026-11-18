---
title: Agent identities, service principals, and applications
description: Learn about agent service principals in Microsoft Entra Agent ID and how they differ from traditional service principals in authentication, permissions, and lifecycle management.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 11/03/2026
ms.reviewer: dastrock
ai-usage: ai-assisted

#customer-intent: As a developer or IT administrator, I want to understand how agent service principals work and how they differ from traditional service principals, so that I can effectively implement authentication, and permissions for agent applications in my organization.
---

# Agent identities, service principals, and applications

Agent identities are built on the same service principal infrastructure that applications use throughout Microsoft Entra, but they're a distinct object type. Standard service principals were designed for static, deterministic workloads and operate using their own credentials directly. Agent identities support one-to-one and one-to-many blueprint relationships, require an assigned sponsor, and generate agent-specific audit entries. Multi-instance blueprints also add a delegation model where the blueprint acquires tokens on behalf of an Agent ID.

This article explains the following concepts:
- The service principal types in the agent app model
- How they relate to agent identity blueprints
- How they differ from standard application service principals

## Agent identity blueprint principal

A multi-instance blueprint needs an agent identity blueprint principal in each tenant where it operates. Managed creation experiences can create it automatically. When you create the blueprint through Microsoft Graph, [create an agent blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal). This service principal provides the runtime *representation* of the blueprint within the tenant's directory and enables it to create Agent IDs and manage their lifecycle. A single-instance blueprint doesn't have this principal.

The creation process involves consent operations that require permissions like `AgentIdentity.Create` and `ServicePrincipal.Manage.OwnedBy`. The agent identity blueprint principal enables the agent identity blueprint to obtain app-only tokens for Microsoft Graph calls necessary to create and manage agent identities. This process is essential because agent blueprints themselves can't directly obtain tokens for Microsoft Graph operations.

## Agent identity as service principal

Agent identities are modeled as single-tenant service principals with a new "agent" subtype classification. This design uses existing Microsoft Entra ID service principal infrastructure while adding agent-specific behaviors and constraints.

Agent identities inherit their protocol properties from their parent agent identity blueprint through the ParentID relationship. Agent IDs created from multi-instance blueprints require the blueprint for impersonation and token exchange operations. A single-instance Agent ID instead shares the blueprint's OAuth client ID and requests tokens directly. It can operate as a confidential client with a credential on the blueprint or as a public client without a client credential.

Agent identities can be granted permissions directly and appear in sign-in logs when tokens are issued for agent operations. They serve as the primary identity that customers reason about when managing agent permissions and access.

For multi-instance blueprints, the agent identity blueprint principal creates Agent ID service principals by using Microsoft Graph calls with app-only tokens and appropriate roles. The creation process establishes the parent-child relationship and configures the necessary federated identity credential relationships for impersonation.

## Agents built using application service principals

Before the Microsoft agent identity platform was introduced, some Microsoft applications, including earlier versions of Microsoft Copilot Studio and Azure AI Foundry, used standard application service principals to secure their agents. These service principals appear alongside agent identity objects in the Microsoft Entra admin center.

You can distinguish them by filtering the **All agent identities** list. Agents using standard service principals behave identically to other application service principals and don't have the agent-specific behaviors described in this article. For filtering options, see [Select viewing options](agent-lists.md#select-viewing-options).

## Key differences

The following sections describe how the agent app model differs from standard application service principals.

### Impersonation model

Standard service principals operate using their own credentials and identity. Multi-instance Agent IDs use an impersonation model: the agent identity blueprint acquires tokens on behalf of each child identity, so the agent identity appears as the client in the resulting token and in audit logs, even though the blueprint performed the initial token exchange.

This separation means the blueprint holds the authentication credentials while the agent identity holds the permissions and the audit identity. A compromise of the blueprint's credentials affects all agent identities under it, which is why blueprint count is a security boundary decision.

A single-instance Agent ID doesn't use this impersonation step. It requests a token with the shared client ID, using a blueprint credential when the flow requires client authentication. For request examples, see [Authenticate a single-instance agent identity](authenticate-single-instance-agent.md).

### Multi-instance relationship

In multi-instance mode, the agent app model is one-to-many: a single agent identity blueprint can produce multiple Agent ID service principals within a tenant or across tenants. Each Agent ID sources its protocol properties from the blueprint but can hold its own permissions on downstream resources.

In [single-instance mode](agent-blueprint.md#instance-modes-preview), the relationship is one-to-one in each tenant. The blueprint and its Agent ID service principals share one OAuth client ID, and no blueprint principal is created.

### Credential management

Standard service principals manage their own credentials (certificates, secrets, or managed identities) and use them to obtain tokens directly. For confidential Agent IDs, the blueprint holds the credentials. Multi-instance blueprints use them for impersonation; single-instance Agent IDs use them directly. Public-client Agent IDs don't send a client credential.

Managed identities are a supported credential type on blueprints (the most secure option for agents running on Azure), but they're a credential *on the blueprint*, not a replacement for the agent identity itself.

### Permissions and role assignment

Agent service principals support both application permissions (for autonomous operations) and delegated permissions (for interactive, on-behalf-of operations). Permissions can be assigned directly to an Agent ID. Multi-instance Agent IDs can also inherit permissions from the blueprint principal.

When `InheritDelegatedPermissions` is enabled, agent identities inherit delegated permissions from the blueprint, which simplifies consent management across many agent identities. Use inherited permissions for the shared baseline and direct assignment for role-specific access.

Agent identities can be assigned Azure RBAC roles and Microsoft Entra built-in roles, the same as standard service principals. Agent identity blueprints can't be assigned Azure RBAC roles.

### Audit and logging

Agent service principals maintain distinct identities in audit logs and sign-in reports. When an agent identity performs an operation, logs show it as the acting client and indicate the relationship to its blueprint. Sign-in logs differentiate between agent identity blueprints, agent identities, and agents' user accounts, enabling clear identification of the credential source, the acting identity, and the subject of each operation.
