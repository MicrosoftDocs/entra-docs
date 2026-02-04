---
title: How are agent identities created?
description: Learn the channels and roles involved in creating Microsoft Entra agent identity blueprints, agent identities, and agent users. Monitor and control their introduction into your tenant.
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
author: omondiatieno
ms.author: jomondi
ms.reviewer: dastrock

#customer intent: As an IAM or security administrator, I want to understand how agent identities are created so that I can monitor and control their introduction into my tenant.
---


# How are agent identities created?

Identity and Access Management (IAM) and security administrators need clear visibility into how AI agent identities enter the tenant, which roles can create them, and monitor agent identity activities. This article describes the various channels through which agent identities can be created in your Microsoft Entra tenant, the roles and permissions required for each channel, and strategies for monitoring and controlling agent identity creation. It covers the following concepts:

- The object types that make up the agent identity model (agent identity blueprints, agent identities, agent users)
- All creation channels (portal, APIs, SDK, automation, integrated Microsoft products)
- Built‑in Microsoft Entra roles and tenant settings that enable or restrict each action
- Monitoring, auditing, and control strategies

For foundational concepts, see [What is Microsoft Entra Agent ID?](../identity-platform/what-is-agent-id.md).

## Overview of creation channels

**Agent identity blueprints** can enter your directory through multiple channels. Each channel implies different monitoring and control points:

| Channel | Typical Actors | Who can control it? |
|---------|----------------|-----------------|
| Microsoft Entra admin center / Azure portal | Developers, Administrators | Directory role assignments | 
| Microsoft Graph API | Automation, DevOps pipelines, integration services | Microsoft Graph permission grants |
| CLI, PowerShell, Infrastructure as Code | DevOps, Administrators | Directory role assignments | 
| Microsoft product integrations | Users of Microsoft agent platforms | Administrative controls for each product |
| Microsoft Entra ID consent experience | Employees, members of organization | App consent policies | 

When an agent identity blueprint (agent identity blueprint) is added to your tenant via one of these channels, an **agent identity blueprint principal** object is created in the tenant. This principal is assigned privileges to create agent identities and agent users in the tenant. Therefore, in addition to the channels listed in the previous table, any system with an agent identity blueprint principal in your tenant becomes a channel for agent identity and agent user creation:

| Channel | Typical Actors | Can be controlled by | 
|---------|----------------|-----------------|
| Agent identity blueprint principals | Microsoft-built agents and third-party agents added to your tenant | Microsoft Entra application permissions |

The following sections provide more details on each of these channels.

## Agent identity creation workflows

The following table gives three examples of ways that agent identities are added to a tenant, using one of the channels described in the previous sections.

| Example 1: Agent built in Copilot Studio | Example 2: Agent built by development team | Example 3: Third-party sales assistant agent | 
| -------------------------------------- | ---------------------------------------- | -------------------------------------| 
| 1. Customer enables Copilot Studio in tenant. | 1. Developer creates agent identity blueprint via Microsoft Entra admin center. | 1. Third-party publishes agent to catalog or website.
| 2. Copilot Studio blueprint added to tenant. | 2. Developer writes code using blueprint. | 2. Employee purchases / acquires agent from catalog or website.
| 3. Employee creates agent in Copilot Studio. | 3. Code creates agent identities via Microsoft Graph. | 3. Employee grants consent to agent. Agent identity blueprint principal is added to tenant. | 
| 4. Copilot Studio creates agent identity in tenant. | | 4. Third-party agent creates agent identity via Microsoft Graph. |

## Microsoft Entra admin center, Microsoft Graph, and CLI tools

Developers and other members of your organization can be given rights to create agent identity blueprints via the Microsoft Entra admin center, Azure portal, Microsoft Graph PowerShell / CLI, Bicep / ARM templates, and other tools. These tools all create agent identity blueprints by calling Microsoft Graph APIs.

Creating agent identity blueprints via these tools requires one of the following permissions:

| Scenario | Permissions required |
| --- | --- |
| User creates blueprint via Microsoft Entra admin center, CLIs | User must be assigned **Agent ID Developer** or **Agent ID Administrator** directory roles. |
| Client creates blueprint via Microsoft Graph, using delegated permissions | User must have the directory roles mentioned in the previous row. Client must be granted **AgentIdentityBlueprint.Create** delegated permission. |
| Client creates blueprint via Microsoft Graph, using application permissions | Client must be granted **AgentIdentityBlueprint.Create** application permission. |

Creating agent identities via these tools requires one of the following permissions:

| Scenario | Permissions required |
| --- | --- |
| User creates identity via Microsoft Entra admin center, CLIs | User must be assigned **Agent ID Administrator** directory role. |
| Client creates identity via Microsoft Graph, using delegated permissions | User must have the directory roles mentioned in the previous row. Client must be granted **AgentIdentity.Create.All** delegated permission. |
| Client creates agent identity blueprint via Microsoft Graph, using application permissions | Client must be granted **AgentIdentity.Create.All** application permission. |

Creating agent users via these tools requires one of the following permissions:

| Scenario | Permissions required |
| --- | --- |
| User creates identity via Microsoft Entra admin center, CLIs | User must be assigned **Agent ID Administrator** or **User Administrator** directory role. |
| Client creates identity via Microsoft Graph, using delegated permissions | User must have the directory roles in the previous row. Client must be granted **AgentIdUser.ReadWrite.All** delegated permission. |
| Client creates agent identity blueprint via Microsoft Graph, using application permissions | Client must be granted **AgentIdUser.ReadWrite.All** application permission. |

Administrators can control agent identity creation via these channels by constraining which users and clients are assigned the permissions in the previous table. For more information, see [Agent identity permissions reference](authorization-agent-id.md#microsoft-graph-permissions-for-agent-ids).

## Microsoft product integrations

Employees can create agents via many Microsoft products. These products are integrated with Microsoft Entra Agent identity platform and can create agent identity blueprints, agent identities, and agent users in tenants. Microsoft products integrated with Microsoft Entra Agent ID include:

| Product | Documentation |
| ------- | ---- |
| Microsoft Copilot Studio   | [Copilot Studio documentation](/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) |
| Microsoft Security Copilot | [Security Copilot documentation](/copilot/security/microsoft-security-copilot) |
| Azure AI Foundry           | [Azure AI Foundry documentation](/azure/ai-foundry/what-is-azure-ai-foundry) |


Administrators can control agent identity creation via these channels by using the administrative tools for each respective product.

## Microsoft Entra ID consent experience

When users sign in for the first time to third-party agents, the Microsoft Entra ID sign-in experience displays a "consent" page to the user. The consent page allows the employee to add the agent to their tenant, which results in the creation of an agent identity blueprint principal.

## Agent identity blueprint principals

Once an agent identity blueprint principal is created in your tenant, the principal is assigned privileges to create agent identities and agent users. The principal can also update and delete any of the identities it creates. The following table describes permissions that can be given to these principals:

| Entity | Permission | Comments |
| ------ | ---------- | -------- |
| Agent identity | `AgentIdentity.CreateAsManager` (application permission) | This permission is automatically granted to any agent identity blueprint principal in the tenant. It allows the principal to create agent identities, and update and delete the agent identities it creates. This permission can't be revoked. To prevent a principal from creating agent identities, you must disable it or remove the principal from the tenant. Principals are limited to a maximum of 250 agent identity creations. |
| Agent user | `AgentIdUser.ReadWrite.IdentityParentedBy` (application permission) | A Microsoft Entra ID administrator must grant this permission to an agent identity blueprint principal. Once granted, the principal can create agent users, and update and delete any users it creates. The permission can be revoked. |

Administrators can control agent identity creation via this channel by limiting which agent identity blueprints are added to their tenant as agent identity blueprint principals. For more information on these permissions, see [Agent identity permissions reference](authorization-agent-id.md).

## Auditing and monitoring agent identity creation

All agent identity creations are recorded in Microsoft Entra audit logs. Using audit logs, you can determine which channel was used to create an agent identity blueprint, agent identity blueprint principal, agent identity, or agent user.

| Objective | How to Implement | Tooling / Source |
|-----------|------------------|------------------|
| Detect new agent identity creations | Subscribe to directory audit events filtering on agent identity object type / creation operations | [Microsoft Entra audit logs](sign-in-audit-logs-agents.md) |
| Inventory all agent identities | Use Microsoft Graph APIs to query all agent identity objects by object type. | Microsoft Graph docs |

## Related content

- [Create and delete agent identities](../identity-platform/create-delete-agent-identities.md)
- [Create agent identity blueprints](../identity-platform/create-blueprint.md)
