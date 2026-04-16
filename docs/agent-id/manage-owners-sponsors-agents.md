---
title: Add and manage owners and sponsors for agent identities
titleSuffix: Microsoft Entra Agent ID
description: Learn how to add and manage owners and sponsors for agent identity blueprints and agent identities in the Microsoft Entra admin center.
author: omondiatieno
ms.author: jomondi
ms.topic: how-to
ms.date: 04/16/2026
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer intent: As an IT administrator, I want to assign owners and sponsors to agent identity blueprints and agent identities so that I can establish clear accountability and governance for my organization's AI agents.
---

# Add and manage owners and sponsors for agent identities

Owners and sponsors play distinct governance roles for agent identity blueprints and agent identities in Microsoft Entra. Owners are technical administrators who can manage the configuration and operations of an agent. Sponsors are business owners who are accountable for the agent's purpose, lifecycle decisions, and access reviews.

This article walks you through adding and removing owners and sponsors using the Microsoft Entra admin center. For more information about the roles and responsibilities of owners and sponsors, see [owners, sponsors, and managers](agent-owners-sponsors-managers.md).

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Prerequisites

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

To manage owners and sponsors, you need one of the following:

- [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) role.
- Existing owner of the blueprint or agent identity you want to manage.

## Add an owner to a blueprint

Add an owner to grant a user the ability to manage the agent identity blueprint.

:::image type="content" source="media/manage-owners-sponsors-agents/blueprint-owners-sponsors.png" alt-text="Screenshot of the owners and sponsors page for a blueprint showing the list of owners and sponsors with their roles." lightbox="media/manage-owners-sponsors-agents/blueprint-owners-sponsors.png":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Agent ID** > **Agent blueprints**.
1. Select the blueprint you want to manage.
1. Select **Owners and sponsors** from the left menu.
1. Select **Add** > **Add owner**.
1. In the **Add owner** panel, search for and select the users you want to add as owners.
1. Select **Add**.

## Add a sponsor to a blueprint

Add a sponsor to assign a responsible party for the blueprint and to allow that user or group to manage lifecycle workflows and access.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Agent ID** > **Agent blueprints**.
1. Select the blueprint you want to manage.
1. Select **Owners and sponsors** from the left menu.
1. Select **Add** > **Add sponsor**.
1. In the **Add sponsor** panel, search for and select the users you want to add as sponsors.
1. Select **Add**.

## Add an owner or sponsor to an agent identity

The process for adding owners and sponsors to individual agent identities is similar to blueprints.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Agent ID** > **Agent identities**.
1. Select the agent identity you want to manage.
1. Select **Owners and sponsors** from the left menu.
1. Select **Add** > **Add owner** or **Add** > **Add sponsor**.
1. Search for and select the users you want to add.
1. Select **Add**.

## Remove an owner or sponsor

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Agent ID** > **Agent blueprints** or **Agent ID** > **Agent identities**.
1. Select the blueprint or agent identity you want to manage.
1. Select **Owners and sponsors** from the left menu.
1. Select the checkbox next to the owner or sponsor you want to remove.
1. Select **Remove**.

## Related content

- [Owners, sponsors, and managers](agent-owners-sponsors-managers.md)
- [View and manage agent identity blueprints](manage-agent-blueprint.md)
- [Create an agent identity blueprint](create-blueprint.md)
