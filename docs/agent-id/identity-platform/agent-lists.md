---
title: View and manage agent identities in your tenant
titleSuffix: Microsoft Entra Agent ID
description: Access Microsoft Entra admin center to effortlessly view and filter agent identities. Streamline tenant oversight and take charge now.
author: SHERMANOUKO
ms.service: entra-id
ms.subservice: 
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: alamaral

#Customer intent: As an administrator, I want to view and search for agent identity blueprints / applications in the Microsoft Entra admin center, so that I can manage and configure the applications in my tenant effectively.
---

# View and manage agent identities in your tenant

Microsoft Entra admin center provides you with a centralized interface to view and manage your agent identities. This comes with the ability to perform various actions like searching, filtering, sorting, and selecting multiple agent identities to disable.

- To view and manage your agent identity blueprint principals, see [View and manage agent identity blueprints using Microsoft Entra admin center](manage-agent-blueprint.md).
- To view and manage agents registered in the Agent Registry without an identity, see [manage agent identity blueprints with no identities](../identity-professional/manage-agents-without-identity.md).

## Prerequisites

To view agent identities in your Microsoft Entra tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

To manage agent identities in your Microsoft Entra tenant, you need:

- Agent ID Administrator or Cloud Application Administrator role
- You can also manage your agent identity if you're the owner of that agent identity, with or without the above roles.

## View a list of agent identities

To view agent identities in your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com)
1. Browse to **Entra ID** > **Agent ID** > **All agent identities**.
1. Select any agent identity you'd like to manage.

  This page contains a list of all agent identities in your organization. This includes both [agent identity objects](agent-identities.md) and [agents using a service principal](agent-service-principals.md).

## Search for an agent identity

- To search for an agent identity, enter either the **name** or **object ID** of the agent identity you want to find in the search box.
- To look up an agent identity by its **Agent Blueprint ID**, add the **Agent Blueprint ID** filter. You can further refine the list using filters based on various criteria.

You can select an agent identity from this list to see information like:

- An overview of the agent identity, including:
  - The name, description, and logo for your agent identity
  - The status of that agent identity, and the ability to enable/disable a given agent identity
  - The link to the parent agent identity blueprint
- The list of owners and sponsors for that agent identity
- The agent's access via this agent identity's granted permissions and Microsoft Entra roles 
- Audit logs and sign-in logs for that agent identity

## Select viewing options

To customize your view of agent identities, you can change filters or select which columns are shown for each agent identity. Not all columns are shown by default. To see all available columns and edit shown columns, select the **Choose columns** button. The table columns and their filter options are as follows:

| Column Name | Description | Sortable | Filterable | Special notes
|-------------|-------------|:--------:|:----------:|------------------|
| **Name** | Display name of the agent identity | ✓ | ✓ | Primary search field; clickable to view details of the agent identity |
| **Created On** | Date when the agent was created | ✓ | ✓ | Filter by "Last N days" | 
| **Status** | Current operational state (Active, or Disabled) | ✓ | ✓ |  | 
| **Object ID** | Unique identifier for agent identity | ✗ | ✓ | | 
| **View Access** | Direct link to agent identity's permissions | ✗ | ✗ | Navigates to the Agent's Access pane, on Permissions tab | 
| **Agent Blueprint ID** | Unique identifier for the agent identity blueprint of this agent identity | ✗ | ✓ | Will be blank for [agents using service principals](agent-service-principals.md) | 
| **Owners** | Direct link to the owners and sponsors for a given agent identity | ✗ | ✗ | | 
| **Uses agent identity** | Represents whether or not this agent has an agent identity object, or utilizes a service principal | ✗ | ✗ | If the answer is "yes," then it uses an agent identity object. If "no" this agent utilizes a service principal

## Disable an agent identity

To disable an agent identity while in this page:

1. Select one or more agents from the list by checking the box next to their logo.
1. Select the **Disable** button in the toolbar.

You might also navigate into a single agent identity, and disable it there.
