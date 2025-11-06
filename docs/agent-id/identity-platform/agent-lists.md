---
title: View agent IDs in your tenant
titleSuffix: Microsoft Entra Agent ID
description: Access Microsoft Entra admin center to effortlessly view and filter agent IDs. Streamline tenant oversight and take charge now.
author: SHERMANOUKO
manager: mwongerapk
ms.service: entra-id
ms.subservice: 
ms.topic: how-to
ms.date: 11/04/2025
ms.author: shermanouko
ms.reviewer: alamaral

#Customer intent: As an administrator, I want to view and search for agent identity blueprints / applications in the Microsoft Entra admin center, so that I can manage and configure the applications in my tenant effectively.
---

# View agent IDs in your tenant

The **Agent identities** pane allows admins to view all agent identities in their tenant and perform various actions like searching, filtering, sorting, selecting multiple agents for bulk operations, and disabling agents. All core information for each agent identity is displayed in a table that supports management capabilities.

## Prerequisites

To view agent identities in your Microsoft Entra tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or Global Administrator.

## Access the agent identities pane

To view agent identities in your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 

1. Browse to **Entra ID** > **Agent identities** > **Agent with identities**.

    You see a table containing a list of agent identities in your tenant. Not all columns are visible. To see all available columns, select the **Edit column** button. The table columns are as follows:

    | Column Name | Description | Sortable | Filterable | Special Features | Availability |
    |-------------|-------------|:--------:|:----------:|------------------|-------------|
    | **Name** | Display name of the agent identity | ✓ | ✓ | Primary search field; clickable to view details | All agents |
    | **Status** | Current operational state (Active, Disabled, or Inactive) | ✓ | ✓ | Disabled status always takes precedence over the Inactive status | Agent ID only |
    | **Sponsors** | Sponsors assigned to the agent | ✗ | ✓ | | All agents |
    | **Object ID** | Unique identifier for agent identity blueprint or identity | ✓ | ✓ | Copy button available | All agents |
    | **Last Used** | Date when agent ID was last active | ✓ | ✗ | | Agent ID only |
    | **Created On** | Date when the agent was created | ✓ | ✓ | Filter by "Last N days" | All agents |
    | **View Access** | Direct link to agent's permissions | ✗ | ✗ | Navigates to the agent's Access pane on Permissions tab | Agent ID only |
    | **Agent Blueprint ID** | Unique identifier (AgentAppId) for the agent | ✓ | ✓ | Copy button available | Agent ID only |
    | **Owners** | Administrators with ownership rights over the agent | ✗ | ✓ | | Agent ID only |
    | **Has Agent User** | Indicates whether agent has an associated agent user | ✓ | ✓ | | Agent ID only |
    | **Platform** | Identifies agent's creation platform (planned feature) | ✓ | ✓ | | Agent ID only |

1. To view more agent identities, select **Load more** at the bottom of the list.

1. Use the **Download** button in the toolbar to export the list of agents to a CSV file.

## Disable an agent ID

To disable an agent ID while in this page:

1. Select one or more agents from the list by checking the box next to their logo.
1. Select the **Disable** button in the toolbar.

## Search for an agent identity

The search bar enables you to find specific agents by their **display name** or **object ID**. You can further refine the list using filters based on various criteria.

## Manage agents

Use the **View agent blueprints** tab to switch to the agent identity blueprints view, which displays all agent identity blueprints in your tenant. Agents without an identity (registry-only agents) are accessible through the **View agents without an identity** tab.
