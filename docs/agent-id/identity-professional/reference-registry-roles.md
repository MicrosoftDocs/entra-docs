---
title: Agent Registry Built-In Roles
description: Learn about the built-in roles available in Microsoft Entra Agent Registry for managing agents, collections, and role assignments.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: reference
ms.date: 11/07/2025
ms.author: sarahlipsey

---
# Microsoft Entra Agent Registry built-in roles

In the Microsoft Entra Agent Registry, you can assign built-in roles to administrators or other security principals to manage agents, agent cards, collections, and role assignments. These roles provide the permissions required to perform specific actions, such as creating or updating agent instances, managing collection membership, or configuring agent discoverability.

This article lists the Agent Registry built-in roles you can assign to manage Agent Registry resources. Agent Registry also requires the [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator) built-in Microsoft Entra role.

## Assign Agent Registry roles

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Entra ID** > **Agent ID** > **Agent Registry**.
1. Select **Access Control** > **Role assignments** > **Add principal**.
1. Select the principal you want to assign and select **Save**.
1. Choose the desired role and select **Entire application** as the scope.
1. Select **Create** to complete the role assignment.

## All roles

| Role | Description |
| --- | --- |
| [Agent Card Administrator](#agent-card-administrator) | Can view and update agent card properties and list associated agents. |
| [Agent Card Reader](#agent-card-reader) | Can read agent card properties and list agents associated with an agent card. |
| [Agent Administrator](#agent-administrator) | Can create, update, and delete agent instances and list associated collections. |
| [Agent Reader](#agent-reader) | Can view agent instance properties and list associated collections. |
| [Agent Creator](#agent-creator) | Can create agent instances as specified in the request body. |
| [Collection Discovery](#collection-discovery) | Can discover agent instances. |
| [Collection Administrator](#collection-administrator) | Can create, view, update, list, and delete collections, except for pre-defined collections. |
| [Collection Reader](#collection-reader) | Can view collection properties and list members. |
| [Collection Creator](#collection-creator) | Can create collections, except for pre-defined collections. |
| [Registry Administrator](#registry-administrator) | Can perform all operations in the Entra Agent Registry. |

## Agent Card Administrator

Can view and update agent card properties and list agents associated with a given agent card in the Entra Agent Registry.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/Read             | View agent card properties.        |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/Update           | Update agent card properties.      |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/agentInstances/Read | List agents associated with an agent card. |

## Agent Card Reader

Can read agent card properties and list agents associated with an agent card.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/Read           | View agent card properties.                 |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/agentInstances/Read | List agents associated with an agent card.  |

## Agent Administrator

Can create, update, and delete agent instances and list associated collections.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Create        | Create new agent instances in the Entra Agent Registry. |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Read          | View properties of existing agent instances.        |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/collections/Read | List collections associated with an agent instance. |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Update        | Modify properties of existing agent instances.      |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Delete        | Permanently delete agent instances from the registry.|

## Agent Reader

Can view agent instance properties and list associated collections.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Read          | View properties of existing agent instances.        |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/collections/Read | List collections associated with an agent instance. |

## Agent Creator

Can create agent instances as specified in the request body.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Create        | Create new agent instances in the Entra Agent Registry. |

## Collection Discovery

Can discover agent instances.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/DiscoverAgents   | Discover agent instances available for collaboration within the Entra Agent Registry. |

## Collection Administrator

Can create, view, update, list, and delete collections, except pre-defined collections.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Create           | Create new collections in the Entra Agent Registry. |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Read             | View collection properties and metadata.            |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ListMembers      | List all agents assigned to a collection.           |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Update           | Modify collection properties or membership.         |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Delete           | Delete custom collections from the Entra Agent Registry. |

## Collection Reader

Can view collection properties and list members.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Read             | View collection properties and metadata.            |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ListMembers      | List all agents that are members of a collection.   |

## Collection Creator

Can create collections, except pre-defined collections.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Create           | Create new custom collections in the Entra Agent Registry. |

## Registry Administrator

Can perform all operations in the Entra Agent Registry.

| Action | Description |
| --- |--- |
| Microsoft.AgentRegistry/beta/agentRegistry/roleDefinitions/Create       | Create new role definitions.                        |
| Microsoft.AgentRegistry/beta/agentRegistry/roleDefinitions/Read         | View role definitions.                              |
| Microsoft.AgentRegistry/beta/agentRegistry/roleDefinitions/Update       | Update role definitions.                            |
| Microsoft.AgentRegistry/beta/agentRegistry/roleDefinitions/Delete       | Delete role definitions.                            |
| Microsoft.AgentRegistry/beta/agentRegistry/roleAssignments/Create       | Create role assignments.                            |
| Microsoft.AgentRegistry/beta/agentRegistry/roleAssignments/Read         | View role assignments.                              |
| Microsoft.AgentRegistry/beta/agentRegistry/roleAssignments/Update       | Update role assignments.                            |
| Microsoft.AgentRegistry/beta/agentRegistry/roleAssignments/Delete       | Delete role assignments.                            |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Create           | Create collections.                                 |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Read             | View collection properties.                         |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ListMembers      | List members of collections.                        |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Update           | Update collection properties.                       |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/Delete           | Delete collections.                                 |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ReadGlobal       | View Global Collection properties.                  |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/UpdateGlobal     | Update Global Collection properties.                |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ListMembersGlobal| List members of the Global Collection.              |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ReadQuarantined  | View Quarantined Collection properties.             |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/UpdateQuarantined| Update Quarantined Collection properties.           |
| Microsoft.AgentRegistry/beta/agentRegistry/collections/ListMembersQuarantined | List members of the Quarantined Collection.    |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Create        | Create agent instances.                             |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Read          | View agent instance properties.                     |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/ListCollections | List collections associated with an agent instance.|
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Update        | Update agent instance properties.                   |
| Microsoft.AgentRegistry/beta/agentRegistry/agentInstances/Delete        | Delete agent instances.                             |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/Read              | View agent card properties.                         |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/Update            | Update agent card properties.                       |
| Microsoft.AgentRegistry/beta/agentRegistry/agentCards/AgentInstances/Read | List agents associated with an agent card.         |
