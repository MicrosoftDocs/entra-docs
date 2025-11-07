---
title: Manage Agents with No Agent Identities
description: This article explains how to manage registry-only agents that don't have associated agent identities in Microsoft Entra ID.
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.date: 11/07/2025
ms.service: entra-id
ms.topic: how-to

#customer intent: As an IT administrator, I want to manage registry-only agents that don't have associated agent identities so that I can maintain visibility and oversight of all agents in my organization's registry.
ms.reviewer: jadedsouza
---

# Use Agent Registry to manage agents without agent identities

As an admin, you want to have a 360-degree view of your agent for security and operational efficiency. It isn't uncommon to have agents that are registered in the Agent Registry but don't have an associated agent identity (agent ID). These agents are referred to as registry-only agents. They might be in the process of being onboarded or maybe you registered them in the registry without needing to use Microsoft Entra ID as your agent's identity provider.

## Prerequisite

Agents only appear in the registry after you [register your agent to the agent registry](../identity-platform/agent-registry-register-agents.md).

## Locate agents without an agent ID

To get to your agent without an agent identity's page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Entra ID** > **Agent identities** > **Agent Registry**.
1. To view the agent card details of a specific agent, select the **View more** link. It reveals the agent's card details that include:

    - **Name**: The name of the agent.
    - **Registry ID**: The unique identifier for the agent in the registry.
    - **Platform**: The platform that created the agent.
    - **Skills**: The capabilities or functionalities of the agent.
    - **Logo**: The logo of the agent.