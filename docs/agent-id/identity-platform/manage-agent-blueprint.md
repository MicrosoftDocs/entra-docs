---
title: Manage Agent Blueprints in Microsoft Entra Admin Center
titleSuffix: Microsoft Entra Agent ID
description: This article explains how to manage agent blueprints and registry-only agents using the Microsoft Entra Admin Center.
author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.date: 11/04/2025
ms.service: entra-id
ms.topic: how-to

#customer intent: As an IT administrator, I want to manage agent identity blueprints through the Microsoft Entra admin center so that I can monitor their status, configure permissions, and maintain proper governance oversight.
ms.reviewer: alamaral

---

# Manage an agent identity blueprint using Microsoft Entra admin center

As an admin, you want to have a 360-degree view of your agent for both security and operational efficiency. Microsoft Entra admin center provides an interface to manage your agents. Through the portal, you get access to the relevant information about your agent including its linked identities, access management, and logs.

## Navigate to your agent identity blueprint

To get to your agent identity blueprint's page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. In the left-hand navigation pane, select **Entra ID** > **Agent identities** > **All agent identities**.
1. Select the agents you want to manage.

## Manage agent identity blueprints

Use the following steps to manage your agent identity blueprints:

1. After selecting the **View agent blueprints** tab, you'll see a list of all the agent blueprints in your tenant. This table contains the following columns:

    - **Name**: The display name of the agent blueprint.
    - **Agent identities**: The number of Agent IDs associated with the agent blueprint.
    - **Status**: The current status of the agent blueprint. It can be active, disabled, or inactive.
    - **Blueprint ID**: The unique identifier for the agent blueprint.

1. Select the agent ID blueprint you want to manage. It opens the agent ID blueprint's management page.

1. View your agent ID blueprint details. The page provides you with information about your app pulled from the agent registry. This information includes:

    - Your agent ID blueprint name and logo
    - Your agent description
    - Your agent status. It indicates whether your agent is active, inactive, or disabled
    - Your agent ID blueprint's agent identity usage over the last seven days
    - The platform that created your agent such as Microsoft 365 Copilot or Azure Foundry.
    - Your agent blueprint ID and object ID

1. Manage your agent ID blueprint. Additionally, this page provides you with several tabs to manage different aspects of your agent ID blueprint. These tabs include:

    - **Linked agent identities**: View and manage the agent IDs associated with the agent ID blueprint.
    - **Blueprint's access**: View and manage the permissions assigned to the agent ID blueprint. In this page you can configure permissions, roles, and resources that are available to the agent ID blueprint. As an admin, you can grant permissions on behalf of all users (delegated) or directly to the agent (app roles) via this tab.
    - **Who can access**: View and manage entities that have access to the agent ID blueprint. It could be users, groups, or other apps / agents.
    - **Owners and sponsors**: View and manage the owners and sponsors of the agent ID blueprint. Owners are technical administrators responsible for operational management, while sponsors are business owners accountable for the agent's purpose and lifecycle decisions.
    - **Audit logs**: View the audit logs related to the agent ID blueprint. It includes actions taken on the agent, such as changes to permissions, access reviews, and other administrative activities. It helps you monitor and track changes for security and compliance purposes. For more information, see [view audit logs for agents](https://entra.microsoft.com).
    - **Sign-in logs**. View the sign-in logs for the agent ID blueprint. Agent ID blueprints themselves don't sign in, but you can see sign-in activity for the Agent IDs associated with the agent ID blueprint. For more information, see [view sign-in logs for agents](https://entra.microsoft.com).

1. To disable an agent ID blueprint, select the **Disable** button in the top right.
