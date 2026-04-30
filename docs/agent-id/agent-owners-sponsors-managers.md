---
title: Administrative relationships in Microsoft Entra Agent ID (Owners, sponsors, and managers) 
description: Learn about the administrative model for agents in Microsoft Entra, including the roles of owners, sponsors, and managers in maintaining secure operations, business accountability, and compliance oversight.
titleSuffix: Microsoft Entra Agent ID
ms.topic: concept-article
ms.date: 04/16/2026
ms.reviewer: jawoods

#customer-intent: As an IT administrator or business stakeholder, I want to understand the administrative model for agents, so that I can properly assign owners, sponsors, and managers to ensure secure operations, business accountability, and compliance oversight.
---

# Administrative relationships in Microsoft Entra Agent ID (Owners, sponsors, and managers) 

Microsoft Entra Agent ID introduces an administrative model that separates technical administration from business accountability, ensuring operational control and oversight without excessive permissions. This document explains the administrative relationships for Microsoft Entra Agent ID identity types. This guidance applies to [agent identities](/graph/api/resources/agentidentity?view=graph-rest-beta&preserve-view=true), [agent identity blueprints](/graph/api/resources/agentidentityblueprint?view=graph-rest-beta&preserve-view=true), [agent identity blueprint principals](/graph/api/resources/agentidentityblueprintprincipal?view=graph-rest-beta&preserve-view=true), and [agents' user accounts](/graph/api/resources/agentuser?view=graph-rest-beta&preserve-view=true). The article covers owners, sponsors, and managers and their importance in maintaining secure operations.

The administrative relationships available in Agent ID include:

- **Owners**: Technical administrators responsible for operational management of agent identity blueprints and agent identities, including setup, configuration, and credential management.
- **Sponsors**: Business representatives accountable for the agent's purpose and lifecycle decisions, including access reviews and agent retention, without technical administrative access. At least one sponsor is required for each agent identity and agent identity blueprint.
- **Managers**: User responsible for the agent within the organization's hierarchy, able to request access packages for their reporting agents.

These administrative relationships must be configured for each Agent ID object and are separate from the administrative rights granted by Microsoft Entra Role Based Access Control (RBAC) roles, like Agent ID Administrator.

## Owners

Owners usually serve as technical administrators for agents, handling operational and configuration aspects. Individual users and service principals can be set as owners. Groups aren't supported as owners. Service principals as owners enable automated management of agent identities. Owners are optional for agent identity blueprints and agent identities.

### Owner responsibilities

Owners can modify properties that the sponsor can't, like authentication properties. Owners can also add or update other owners and sponsors for the agent identities. Like sponsors, they can disable and delete agent identities that are no longer needed. Unlike sponsors, owners can re-enable an agent identity that is disabled and restore soft deleted identities.

### Owner access and permissions

Owners have administrative privileges scoped to their assigned agent identity blueprint or agent identity. They can edit settings, manage credentials, change configurations, and assign more owners.

Owners of an agent identity blueprint or agent identity blueprint principal can also create agent identities from that blueprint using delegated permissions, without needing an Agent ID Administrator or Agent ID Developer role. The calling application must be granted one of the following delegated permissions: `AgentIdentity.Create.All`, `AgentIdentity.ReadWrite.All`, or `AgentIdentity.ReadWrite.ManagedBy`.

### Owner typical personas

Owners are typically developers or IT professionals with technical knowledge to manage application identities. They might be agent creators, technical application owners, or IT administrators for critical agents. Multiple owners can be assigned for backup coverage.

Service principals can also be set as owners when some other managing service needs the ability to modify or delete specific agent identities without user intervention.

## Sponsors

Sponsors provide business accountability for agents, making lifecycle decisions without technical administrative access. They understand the business purpose of the agent, and they can determine whether an agent is still needed or requires access. Sponsors are required for agent identity blueprints and agent identities, ensuring every agent has a designated business owner.

Sponsorship should be maintained ensuring succession when an employee who's a sponsor moves or leaves. Both users and groups can be assigned as sponsors. When a group is assigned, all members of the group have sponsor rights over the Agent ID object. Not all group types are supported as sponsors. The following group types are allowed:

- Dynamic membership groups (security or Microsoft 365)
- Assigned membership groups (Microsoft 365)

The following group types aren't allowed as sponsors:

- Role-assignable groups (security or Microsoft 365)
- Assigned membership groups (security)

### Sponsor responsibilities

Sponsors make decisions about the agent lifecycle, including renewal, extension, or removal based on business need. They request access packages on behalf of agents, and they provide business justification for access requests. During security incidents, sponsors might determine whether agent behavior is expected and authorize appropriate responses including suspension or permission adjustments.

### Sponsor access and permissions

Sponsors operate under least-privilege with limited administrative permissions. They can't modify application settings on agent blueprints or agent identities. Access is limited to nondestructive lifecycle operations: enabling and disabling agents.

### Sponsor typical personas

Sponsors are usually business owners, product managers, team leads, or stakeholders who understand the agent's purpose. For unpublished agents, creators often serve as sponsors. For published agents, sponsors typically come from teams using the agent.

### Agent identity sponsors vs. agent's user account sponsors

In Microsoft Agent ID, agents can have an [agent's user account](https://learn.microsoft.com/en-us/entra/agent-id/agent-users) created in order to access user-oriented services. The user account and the agent's identity, blueprint, and blueprint principal may all have sponsors associated with them. There are differences between the user account sponsors and sponsors of the agent identity, blueprint, or blueprint principal. 

Agent user account sponsors are the same as normal [user sponsors](https://learn.microsoft.com/en-us/entra/external-id/b2b-sponsors). They are not authorized to make any changes to their sponsored users, but they can request access on the user's behalf and may be involved in approval flows. In contrast, sponsors of agent identities, blueprints, and blueprint principals have limited access to manage those identities directly and can also request access or give approvals in lifecycle workflows.

| | Agent user account sponsors | Agent identity, blueprint, blueprint principal sponsors |
|--|--|--|
| **Allowed types** | Users, groups (any) | Users, select groups (dynamic membership, Microsoft 365). Role-assignable groups not supported. |
| **Limits** | Maximum 5 sponsors | Maximum 100 sponsors, with no more than 5 groups |
| **Authorization** | No direct authorization to modify sponsors users | Delete or disable the agent identity and modify its sponsors |
| **Required** | Not required | Required on create for agent identities and agent blueprints |

When an agent is represented by both an agent identity object and an agent user account, we recommend maintaining the agent identity sponsor as the primary user or group responsible for the agent. 

Different scenarios may require different types of access or authorization for an agent identity and its associated user account. Sponsors for each object can [request access packages](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-request-access) on behalf of the identity they sponsor. In most cases, the same the user or group should be set as the sponsor on both objects to ensure they can request the appropriate access for both the agent identity and the agent's user account as needed.

## Managers

Managers are individual users responsible for an agent identity within the organizational hierarchy. For agents that are active in user scenarios, consider setting a manager on the agent's user account. Managers can request access packages for their agents' user accounts, and will see agents designated as reporting to them in the Microsoft Entra admin center. Managers don't have authorization to modify or delete agents; owners, sponsors, or administrators are required to take those actions.

## Requirements and constraints

The administrative model enforces specific requirements and constraints to ensure effective oversight and accountability.

### Creation requirements

A sponsor is required when creating an agent identity or agent blueprint. Agent identity blueprint principals are exempt from the sponsor requirement during creation. Owners and managers are always optional.

### Assignment policies

For delegated creation requests where both an application and user context exist, the calling user automatically becomes the sponsor if no sponsors are explicitly specified. However, if one or more other sponsors are designated during creation, the calling user isn't automatically added. Users with Agent ID admin roles aren't made sponsor automatically during creation. This avoids unintentionally overburdening admins with direct responsibility for individual agents.

For app-only create requests, the creating service must set one or more users or [supported groups](#sponsors) as the sponsor.
