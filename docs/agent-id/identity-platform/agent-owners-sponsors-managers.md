---
title: Administrative relationships in Microsoft Entra Agent ID (Owners, sponsors, and managers) 
description: Learn about the administrative model for agents in Microsoft Entra, including the roles of owners, sponsors, and managers in maintaining secure operations, business accountability, and compliance oversight.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: jawoods

#customer-intent: As an IT administrator or business stakeholder, I want to understand the administrative model for agents, so that I can properly assign owners, sponsors, and managers to ensure secure operations, business accountability, and compliance oversight.
---

# Administrative relationships in Microsoft Entra Agent ID (Owners, sponsors, and managers) 

The Microsoft agent identity platform introduces an administrative model that separates technical administration from business accountability, ensuring operational control and compliance oversight without excessive permissions. This document explains the administrative relationships for Microsoft Entra Agent ID identity types. This guidance applies to [agent identities](/graph/api/resources/agentidentity?view=graph-rest-beta), [agent identity blueprints](/graph/api/resources/agentidentityblueprint?view=graph-rest-beta), [agent identity blueprint principals](/graph/api/resources/agentidentityblueprintprincipal?view=graph-rest-beta), and [agent users](/graph/api/resources/agentuser?view=graph-rest-beta). The article covers owners, sponsors, and managers and their importance in maintaining secure operations.

The administrative relationships available in Agent ID include:

- **Owners**: Technical administrators responsible for operational management of agent blueprints and agent identities, including setup, configuration, and credential management.
- **Sponsors**: Business representatives accountable for the agent's purpose and lifecycle decisions, including access reviews and incident response, without technical administrative access.
- **Managers**: User responsible for the agent within the organization's hierarchy, able to request access packages for their reporting agents.

These administrative relationships must be configured for each Agent ID object and are separate from the administrative rights granted by Microsoft Entra Role Based Access Control (RBAC) roles, like Agent ID Administrator.

## Owners

Owners usually serve as technical administrators for agents, handling operational and configuration aspects. Service principals can also be set as owners, enabling automated management of agent identities.

### Owner responsibilities

Owners can modify properties that the sponsor can't, like authentication properties. Owners can also add or update other owners and sponsors for the agent identities. Like sponsors, they can disable and delete agent identities that are no longer needed. Unlike sponsors, owners can re-enable an agent identity that is disabled and restore soft deleted identities.

### Owner access and permissions

Owners have administrative privileges scoped to their assigned agent blueprint or agent identity. They can edit settings, manage credentials, change configurations, and assign more owners.

### Owner typical personas

Owners are typically developers or IT professionals with technical knowledge to manage application identities. They might be agent creators, technical application owners, or IT administrators for critical agents. Multiple owners can be assigned for backup coverage.

Service principals can also be set as owners when some other managing service needs the ability to modify or delete specific agent identities without user intervention.

## Sponsors

Sponsors provide business accountability for agents, making lifecycle decisions without technical administrative access. They understand the business purpose of the agent, and they can determine whether an agent is still needed or requires access.

Sponsorship should be maintained ensuring succession when an employee who's a sponsor moves or leaves. Both users and groups can be assigned as sponsors. When a group is assigned, all users who are direct members of the group have sponsor rights over the Agent ID object.

### Sponsor responsibilities

Sponsors make decisions about the agent lifecycle, including renewal, extension, or removal based on business need. They request access packages on behalf of agents, and they provide business justification for access requests. During security incidents, sponsors might determine whether agent behavior is expected and authorize appropriate responses including suspension or permission adjustments.

### Sponsor access and permissions

Sponsors operate under least-privilege with limited administrative permissions. They can't modify application settings on agent blueprints or agent identities. Access is limited to nondestructive lifecycle operations: enabling and disabling agents.

### Sponsor typical personas

Sponsors are usually business owners, product managers, team leads, or stakeholders who understand the agent's purpose. For unpublished agents, creators often serve as sponsors. For published agents, sponsors typically come from teams using the agent.

## Manager

Managers are individual users responsible for an agent identity within the organizational hierarchy. For agents that are active in user scenarios, consider setting a manager on the agent user. Managers can request access packages for their agent users, and will see agents designated as reporting to them in the Microsoft Entra admin center. Managers don't have authorization to modify or delete agents; owners, sponsors, or administrators are required to take those actions.

## Requirements and constraints

The administrative model enforces specific requirements and constraints to ensure effective oversight and accountability.

### Creation requirements

A sponsor is required when creating an agent identity or agent blueprint. Agent blueprint principals are exempt from the sponsor requirement during creation. Owners and managers are always optional.

### Assignment policies

For delegated creation requests where both an application and user context exist, the calling user automatically becomes the sponsor if no sponsors are explicitly specified. However, if one or more other sponsors are designated during creation, the calling user isn't automatically added. Users with Agent ID admin roles aren't made sponsor automatically during creation. This avoids unintentionally overburdening admins with direct responsibility for individual agents.

For app-only create requests, the creating service must set one or more users or groups as the sponsor.
