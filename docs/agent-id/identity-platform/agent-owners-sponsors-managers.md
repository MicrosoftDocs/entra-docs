---
title: Administrative relationships for agent IDs (Owners, sponsors, and managers)
description: Learn about the administrative model for agentic applications in Microsoft Entra, including the roles of owners, sponsors, and managers in maintaining secure operations, business accountability, and compliance oversight.

author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.reviewer: jawoods

#customer-intent: As an IT administrator or business stakeholder, I want to understand the administrative model for agentic applications, so that I can properly assign owners, sponsors, and managers to ensure secure operations, business accountability, and compliance oversight.
---

# Administrative relationships for agent IDs (Owners, sponsors, and managers)

The agentic platform introduces an administrative model that separates technical administration from business accountability, ensuring operational control and compliance oversight without excessive permissions. This document explains the administrative relationships for agentic applications, covering owners, sponsors, and managers and their importance in maintaining secure operations.

The administrative relationships for agent IDs are as follows:

- **Owners**: Technical administrators responsible for operational management of agentic applications, including setup, configuration, and credential management.
- **Sponsors**: Business owners accountable for the agent's purpose and lifecycle decisions, including access reviews and incident response, without technical administrative access.
- **Managers**: Oversight role ensuring continuity during sponsor transitions and organizational changes, facilitating sponsorship transfers and maintaining awareness of agent portfolios.

## Owners

Owners serve as technical administrators for agentic applications, handling operational and configuration aspects. A sponsor is provided at agent identity creation time. Sponsorship should be maintained ensuring succession when an employee who's a sponsor moves or leaves.

### Owner responsibilities

Owners can modify properties that the Sponsor can't, like modifying authentication properties. Owners can add or update sponsors for the agent identities. They can also update the lifecycle settings, and can disable and delete agent identities that are no longer needed. Owners can also re-enable an agent identity that is in disabled state and restore an agent identity that is soft deleted.

### Owner access and permissions

Owners have administrative privileges scoped to their assigned applications. They can edit settings, manage credentials, change configurations, and assign more owners.

### Owner typical personas

Owners are typically developers or IT professionals with technical knowledge to manage application identities. It includes agent creators, technical application owners, or IT administrators for critical agents. Multiple owners can be assigned for backup coverage.

## Sponsors

Sponsors provide business accountability for agentic applications, making lifecycle decisions without technical administrative access. They understand the business purpose and determine continued existence and access requirements.

### Sponsor responsibilities

Sponsors make decisions about agent lifecycle including renewal, extension, or removal based on business need. They request access packages on behalf of agents, and provide business justification for access requests. During security incidents, sponsors determine if agent behavior is expected and authorize appropriate responses including suspension or permission adjustments.

### Sponsor access and permissions

Sponsors operate under least-privilege with limited administrative permissions. They can't modify application settings. Access is limited to nondestructive lifecycle operations: enabling, disabling, soft deleting, restoring agents, and extending lifetimes.

### Sponsor typical personas

Sponsors are business owners, product managers, team leads, or stakeholders who understand the agent's purpose. For unpublished agents, creators often serve as sponsors. For published agents, sponsors typically come from teams using the agent.

## Manager

A Manager is used in context of agent users. A manager is a human user who is designated as the hiring manager or operational owner for an agent user. This role is set during the agent hiring flow. It also reflects in the manager attribute of the agent user object in Microsoft Entra ID.

## Requirements and constraints

The governance model enforces specific requirements and constraints to ensure effective oversight and accountability.

### Creation requirements

Every agentic application must have clearly defined governance roles established during creation. At least one owner or sponsor is required during creation of Agent identity blueprint and agent identity (agent ID). For agent users, at least one manager or sponsor must be designated. Agent identity blueprint principals are exempt from the standard owner or sponsor requirements during creation.

### Assignment policies

For delegated creation requests where both an application and user context exist, the calling user automatically becomes the sponsor if no sponsors are explicitly specified. However, if one or more other sponsors are designated during creation, the calling user isn't automatically added. 

For app-only create requests, the creating service must set one or more users or groups as the sponsor. For this scenario, the organization can configure agent managers as default sponsors.
