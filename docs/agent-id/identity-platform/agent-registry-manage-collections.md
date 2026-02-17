---
title: Manage Collections in Microsoft Entra Agent Registry
description: Learn how to navigate, create, and manage agent collections in Microsoft Entra Agent Registry.
author: shlipsey3
ms.author: sarahlipsey
ms.date: 11/07/2025
ms.service: entra-id
ms.topic: how-to
ms.reviewer: jadedsouza
#customer intent: As an IT administrator, I want to create and manage agent collections so that I can organize my agents into logical groups and apply consistent policies across them.

---

# Manage collections in Microsoft Entra Agent Registry

Agent collections provide a way to organize your agent identities. Collections allow administrators to group agents based on various criteria such as function, security requirements, or business context, and then apply consistent policies across those groups. This article explains how to navigate, create, and manage agent collections, including adding agents to both predefined and custom collections.

## Navigate to agent collections

To get to your agent ID blueprint page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Entra ID** > **Agent ID** > **Agent Collections (Preview)**.
1. In the **Agent collections** view, you see a tabbed section containing two options:
    - Select **Predefined** tab to view agents added to the **Global** collection.
    - Select **Custom** tab to view agents added to custom collections. This tab displays any custom collections that you created in your tenant. Selecting a custom collection shows the agents that are part of that collection.
    
    :::image type="content" source="media/agent-registry-manage-collections/agent-collections.png" alt-text="Screenshot of the Agent collections view showing predefined and custom tabs.":::
    
## Create a custom collection

To create a custom collection, follow these steps:

1. In the **Agent collections** view, select the **Custom** tab.
1. Select **+ Create collection**.
1. Provide a descriptive and meaningful **Name** and **Description** of the collection.

    :::image type="content" source="media/agent-registry-manage-collections/custom-collections.png" alt-text="Screenshot of the create custom collection dialog view.":::

## Add an agent to predefined collections

Use the following steps to add an agent to a predefined collection.

1. Select the **Predefined** tab to view the predefined collections.
1. Select the predefined collection you want to add the agent to. It opens a view listing all the agents in that collection and their publisher (builder platform).
1. To add an agent to the collection, select **+ Add**, then choose the agents you want to add.

    :::image type="content" source="media/agent-registry-manage-collections/predefined-add-agents.png" alt-text="Screenshot of view showing how to add agents to a predefined collection.":::

## Add an agent to custom collections

Use the following steps to add an agent to a custom collection.

1. Select the **Custom** tab to view the custom collections.
1. Select the custom collection you want to add the agent to. A list of all agents and their publisher (builder platform) appears.
1. To add an agent to the collection, select **+ Add**, then choose the agents you want to add.

## Configure Zero Trust Policies for agents

The Microsoft Entra Agent Registry follows [Zero Trust principles](/security/zero-trust/zero-trust-overview). For collections, Zero Trust principles are applied by configuring access and discovery policies.

**Access policies** determine whether an agent can access Microsoft Entra-protected resources, such as other agents, authentication endpoints, or APIs protected by conditional access.

1. Ensure the agent can obtain a [Microsoft Entra access token](../../identity-platform/access-tokens.md) and complies with all access policy requirements.
1. Apply [conditional access policies for agents](../../identity/conditional-access/agent-id.md) to enforce access controls based on the agent's context.
1. Use [identity protection for agents](../../id-protection/concept-risky-agents.md) to monitor and respond to risky agent behaviors.

**Discovery policies** define which agents can be discovered through the registry. You can use system-defined policies provided by Microsoft or create admin-defined policies to suit your organization's needs.