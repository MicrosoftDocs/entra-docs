---
title: Manage Agents with No Agent Identities
description: This article explains how to manage registry-only agents that don't have associated agent identities in Microsoft Entra ID.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.service: entra-id
ms.topic: how-to

#customer intent: As an IT administrator, I want to manage registry-only agents that don't have associated agent identities so that I can maintain visibility and oversight of all agents in my organization's registry.
ms.reviewer: jadedsouza
---

# Manage agents with no agent identities

As an admin, you want to have a 360-degree view of your agents for both security and operational efficiency.  Some agents will be represented in Microsoft Entra with an agent identity blueprint principal and agent identities, or as a service principal. It isn't uncommon to also have agents that are registered in the agent registry but don't have an associated Microsoft Entra agent identity. These agents are referred to as registry-only agents. They might be in the process of being onboarded or they may have registered in the registry without needing to use Microsoft Entra Agent ID as the agent's identity provider.

## Prerequisite

Agents only appear in the registry after you [publish your agent to the agent registry](../identity-platform/publish-agents-to-registry.md).

## Navigate to your agent without an agent identity

To get to your agent without an agent identity's page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. In the left-hand navigation pane, select **Entra ID** > **Agent identities** > **Agent Registry**.
1. To view the agent card details of a specific agent, select the **View more** link. It reveals the agent's card details that include:

    - **Name**: The name of the agent.
    - **Registry ID**: The unique identifier for the agent in the registry.
    - **Platform**: The platform that created the agent.
    - **Skills**: The capabilities or functionalities of the agent.
    - **Logo**: The logo of the agent.
