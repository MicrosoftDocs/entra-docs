---
title: Manage Collections in Microsoft Entra Agent Registry
description: Learn how to navigate, create, and manage agent collections in Microsoft Entra Agent Registry.
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.date: 11/07/2025
ms.service: entra-id
ms.topic: how-to

#customer intent: As an IT administrator, I want to create and manage agent collections so that I can organize my agents into logical groups and apply consistent policies across them.
ms.reviewer: jadedsouza
---

# Manage collections in Microsoft Entra Agent Registry

Agent collections provide a way to organize your agent identities. Collections allow administrators to group agents based on various criteria such as function, security requirements, or business context, and then apply consistent policies across those groups. This article explains how to navigate, create, and manage agent collections, including adding agents to both predefined and custom collections.

## Navigate to agent collections

To get to your agent ID blueprint page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Entra ID** > **Agent identities** > **Agent Collections**.
1. In the **Agent collections** view, you see a tabbed section containing two options:
    1. Select **Predefined** tab to view agents added to the predefined collection. There are two options to choose from: **Global** and **Quarantined**. Selecting either option displays the agents included in that specific collection.
    1. Select **Custom** tab to view agents added to custom collections. This tab displays any custom collections that you created in your tenant. Selecting a custom collection shows the agents that are part of that collection.

## Create a custom collection

To create a custom collection, follow these steps:

1. In the **Agent collections** view, select the **Custom** tab.
1. Select **+ Create collection**.
1. Fill the multi-stage form that appears. The form is divided into three sections:
    1. In the **Basic** stage, provide **Name** and **Description** of the collection. Use a meaningful name and description.
    1. In the **Agents** stage, select the agents you want to add to the collection. Select the **Add** button. 
    1. After you select the **Add** button, a list of the selected agents will appear. Select the delete (bin) icon if you want to remove an agent.
    1. In the **Review and create** stage, review the information you provided. If everything looks good, select **Create collection**. 
    1. Select the **Edit** link if you realize you want to update something.

## Add an agent to predefined collections

Use the following steps to add an agent to a predefined collection.

1. Select the **Predefined** tab to view the predefined collections.
1. Select the predefined collection you want to add the agent to. It opens a view listing all the agents in that collection and their source (builder platform).
1. To add an agent to the collection, select **+ Add**.

## Add an agent to custom collections

Use the following steps to add an agent to a custom collection.

1. Select the **Custom** tab to view the custom collections.
1. Select the custom collection you want to add the agent to. It opens a view listing all the agents in that collection and their source (builder platform).
1. To add an agent to the collection, select **+ Add**.