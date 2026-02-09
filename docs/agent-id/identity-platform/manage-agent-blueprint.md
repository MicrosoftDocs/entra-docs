---
title: Manage Agent Blueprints in Microsoft Entra Admin Center
titleSuffix: Microsoft Entra Agent ID
description: This article explains how to manage agent blueprints and registry-only agents using the Microsoft Entra Admin Center.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.topic: how-to

#customer intent: As an IT administrator, I want to manage agent identity blueprints through the Microsoft Entra admin center so that I can monitor their status, configure permissions, and maintain proper governance oversight.
ms.reviewer: alamaral

---

# View and manage agent identity blueprints in your tenant

Microsoft Entra Admin Center allows you to view all agent identity blueprint principals in your tenant. You can perform various actions like searching, filtering, sorting, and selecting multiple agent identity blueprint principals to disable. 

## Navigate to your agent identity blueprint principal list

To view your agent identity blueprint principals, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. In the left-hand navigation pane, select **Entra ID** > **Agent identities** > **All agent identities**. 
1. Select **View agent blueprint** in the upper right of the command bar.
1. Select any agent identity blueprint principal you want to manage.

## Search for an agent identity blueprint principal

1. Enter either the **name** or **object ID** of the agent identity blueprint principal you want to find in the search box.
1. To look up an agent identity by its **Agent Blueprint ID**, add the **Agent Blueprint ID** filter.
1. You can further refine the list using filters based on various criteria.

## Select viewing options

To customize your view of agent identity blueprint principals, you can change filters or select which columns are shown for each agent identity. To see all available columns and edit shown columns, select the **Choose columns** button. The table columns and their filter options are as follows:

| Column Name | Description | Sortable | Filterable | Special notes
|-------------|-------------|:--------:|:----------:|------------------|
| **Name** | Display name of the agent identity blueprint principal | ✓ | ✓ | Primary search field; clickable to view details of the agent identity blueprint principal |
| **Agent identities** | The number of child agent identities created by the agent blueprint principal| ✗ | ✗ | Select this to see a list of linked child agent identities for that agent identity blueprint principal| 
| **Status** | Current operational state (Active, or Disabled) | ✓ | ✓ |  | 
| **Agent Blueprint ID** | Unique identifier for the agent identity blueprint of this agent identity blueprint principal | ✗ | ✓ | | 
| **Object ID** | Unique identifier for agent identity | ✗ | ✓ | | 

## Manage agent identity blueprint principals

Use the following steps to manage an agent identity blueprint principal in your tenant:

1. Select the agent identity blueprint principal you want to manage. It opens the agent identity blueprint principal's management page.
1. View your agent identity blueprint principal details. The page provides you with information about your app pulled from the agent registry. This information includes:
    - Your agent identity blueprint principal name and logo
    - Your agent description
    - Your agent status. It indicates whether your agent is active or disabled
    - Your agent blueprint ID and object ID
1. To manage this agent identity blueprint principal, this page provides you with several tabs to manage different aspects of your agent identity blueprint principal. These tabs include:
    - **Linked agent identities**: View and manage the agent identities associated with the agent identity blueprint principal. 
    - **Blueprint's access**: View, manage, and revoke the permissions assigned to the agent identity blueprint principal.
    - **Owners and sponsors**: View and manage the owners and sponsors of the agent identity blueprint principal. Owners are technical administrators responsible for operational management, while sponsors are business owners accountable for the agent's purpose and lifecycle decisions. For more information, see [owners, sponsors, and managers](agent-owners-sponsors-managers.md).
    - **Audit logs**: View the audit logs related to the agent identity blueprint principal. It includes actions taken on the agent, such as changes to permissions, access reviews, and other administrative activities. It helps you monitor and track changes for security and compliance purposes. For more information, see [view audit logs for agents](../identity-professional/sign-in-audit-logs-agents.md).
    - **Sign-in logs**. View the sign-in logs for the agent identity blueprint principal. For more information, see [view sign-in logs for agents](../identity-professional/sign-in-audit-logs-agents.md).
1. To disable an agent identity blueprint principal, select the **Disable** button in the top command bar.
