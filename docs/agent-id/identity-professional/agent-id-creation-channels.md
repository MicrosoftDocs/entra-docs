---
title: How are agent IDs created?
titleSuffix: Microsoft Entra Agent ID
description: Learn the channels and roles involved in creating Microsoft Entra Agent ID blueprints, agent identities, and agent users so you can monitor and control their introduction into your tenant.
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
author: omondiatieno
ms.author: jomondi
manager: pmwongera
ms.reviewer: dastrock

#customer intent: As an IAM or security administrator, I want to understand how agent IDs are created so that I can monitor and control their introduction into my tenant.
---


# How are agent IDs created?

Identity and Access Management (IAM) and security administrators need clear visibility into **how AI agent identities enter the tenant**, **which roles can create them**, and **what governance levers exist to monitor or restrict creation**. This article describes the various channels through which agent identities (agent ID) can be created in your Microsoft Entra ID tenant, the roles and permissions required for each channel, and strategies for monitoring and controlling agent ID creation. It covers the following concepts:

- The object types that make up the Agent ID model (agent identity blueprints, agent identities, agent users)
- All creation channels (portal, APIs, SDK, automation, integrated Microsoft products)
- Built‑in Microsoft Entra roles and tenant settings that enable or restrict each action
- Monitoring, auditing, and control strategies

## Overview of creation channels

**Agent identity blueprints** can enter your directory through multiple channels. Each channel implies different monitoring and control points:

| Channel | Typical Actors | Who can control it? |
|---------|----------------|-----------------|
| Microsoft Entra admin center / Azure portal | Developers, Administrators | Directory role assignments | 
| Microsoft Graph API | Automation, DevOps pipelines, integration services | Microsoft Graph permission grants |
| CLI, PowerShell, Infrastructure as Code | DevOps, Administrators | Directory role assignments | 
| Microsoft product integrations | Users of Microsoft agent platforms | Administrative controls for each product |
| Microsoft Entra ID consent experience | Employees, members of organization | App consent policies | 

When an agent identity blueprint (agent ID blueprint) is added to your tenant via one of these channels, an **agent identity blueprint principal** object is created in the tenant. This principal is assigned privileges to create agent identities and agent users in the tenant. Therefore, in addition to the channels listed in the previous table, any system with an agent identity blueprint principal in your tenant becomes a channel for agent identity and agent user creation:

| Channel | Typical Actors | Can be controlled by | 
|---------|----------------|-----------------|
| Agent identity blueprint principals | Microsoft-built agents and third-party agents added to your tenant | Microsoft Entra application permissions |

The following sections provide more details on each of these channels.

## Agent ID creation workflows

The following table gives three examples of ways that agent IDs are added to a tenant, using one of the channels described in the previous sections.

| Example 1: Agent built in Copilot Studio | Example 2: Agent built by development team | Example 3: Third-party sales assistant agent | 
| -------------------------------------- | ---------------------------------------- | -------------------------------------| 
| 1. Customer enables Copilot Studio in tenant. | 1. Developer creates agent ID blueprint via Microsoft Entra admin center. | 1. Third-party publishes agent to catalog or website.
| 2. Copilot Studio blueprint added to tenant. | 2. Developer writes code using blueprint. | 2. Employee purchases / acquires agent from catalog or website.
| 3. Employee creates agent in Copilot Studio. | 3. Code creates agent identities via Microsoft Graph. | 3. Employee grants consent to agent. Agent identity blueprint principal is added to tenant. | 
| 4. Copilot Studio creates agent identity in tenant. | | 4. Third-party agent creates agent identity via Microsoft Graph. |

## Microsoft entra admin center, Microsoft Graph, and CLI tools

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
| Client creates agent ID blueprint via Microsoft Graph, using application permissions | Client must be granted **AgentIdentity.Create.All** application permission. |

Creating agent users via these tools requires one of the following permissions:

| Scenario | Permissions required |
| --- | --- |
| User creates identity via Microsoft Entra admin center, CLIs | User must be assigned **Agent ID Administrator** or **User Administrator** directory role. |
| Client creates identity via Microsoft Graph, using delegated permissions | User must have the directory roles in the previous row. Client must be granted **AgentIdUser.ReadWrite.All** delegated permission. |
| Client creates agent ID blueprint via Microsoft Graph, using application permissions | Client must be granted **AgentIdUser.ReadWrite.All** application permission. |

Administrators can control agent ID creation via these channels by constraining which users and clients are assigned the permissions in the previous table.

## Microsoft product integrations

Employees can create agents via many Microsoft products. These products are integrated with Microsoft Entra Agent ID and can create agent identity blueprints, agent identities, and agent users in tenants. At the time of this writing, Microsoft products integrated with Microsoft Entra Agent ID include:

| Product | Documentation |
| ------- | ---- |
| Microsoft Copilot Studio | Link to Copilot Studio documentation |
| Microsoft Security Copilot | Link to Security Copilot documentation |
| Azure AI Foundry | Link to AI Foundry documentation |
| Microsoft Teams | Link to Teams documentation |

Administrators can control agent ID creation via these channels by using the administrative tools for each respective product.

## Microsoft Entra ID consent experience

When users sign in for the first time to third-party agents, the Microsoft Entra ID sign-in experience displays a "consent" page to the user. The consent page allows the employee to add the agent to their tenant, which results in the creation of an agent identity blueprint principal.

## Agent identity blueprint principals

Once an agent identity blueprint principal is created in your tenant, the principal is assigned privileges to create agent identities and agent users. The principal can also update and delete any of the identities it creates. The following table describes permissions that can be given to these principals:

| Entity | Permission | Comments |
| ------ | ---------- | -------- |
| Agent identity | `AgentIdentity.CreateAsManager` (application permission) | This permission is automatically granted to any agent identity blueprint principal in the tenant. It allows the principal to create agent identities, and update and delete the agent identities it creates. This permission can't be revoked. To prevent a principal from creating agent identities, you must disable it or remove the principal from the tenant. At the time of this writing, principals are limited to a maximum of 250 agent identity creations. |
| Agent user | `AgentIdUser.ReadWrite.IdentityParentedBy` (application permission) | A Microsoft Entra ID administrator must grant this permission to an agent identity blueprint principal. Once granted, the principal can create agent users, and update and delete any users it creates. The permission can be revoked. |

Administrators can control agent ID creation via this channel by limiting which agent identity blueprints are added to their tenant as agent identity blueprint principals.

## Auditing and monitoring agent ID creation

All agent ID creations are recorded in Microsoft Entra audit logs. Using audit logs, you can determine which channel was used to create an agent ID blueprint, agent ID blueprint principal, agent identity, or agent user.

| Objective | How to Implement | Tooling / Source |
|-----------|------------------|------------------|
| Detect new agent identity creations | Subscribe to directory audit events filtering on agent identity object type / creation operations | Microsoft Entra audit logs |
| Inventory all agent IDs | Use Microsoft Graph APIs to query all agent ID objects by object type. | Microsoft Graph docs |
