---
title: Add and manage owners and sponsors for agent identities and blueprints
titleSuffix: Microsoft Entra Agent ID
description: Learn how to add and manage owners and sponsors for agent identity blueprints and agent identities in the Microsoft Entra admin center.
author: omondiatieno
ms.author: jomondi
ms.topic: how-to
ms.date: 04/28/2026
ms.reviewer: arluca
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to assign owners and sponsors to agent identity blueprints and agent identities so that I can establish clear accountability and governance for my organization's AI agents.
---

# Add and manage owners and sponsors for agent identities and blueprints

Owners and sponsors play distinct governance roles for agent identity blueprints and agent identities in Microsoft Entra ID. Owners are technical administrators who can manage the configuration and operations of an agent. Sponsors are business owners who are accountable for the agent's purpose, lifecycle decisions, and access reviews.

This article walks you through adding and removing owners and sponsors using the Microsoft Entra admin center. For more information about the roles and responsibilities of owners and sponsors, see [owners, sponsors, and managers](agent-owners-sponsors-managers.md).

## Prerequisites

To manage owners and sponsors, you must:

- Have the [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) role.
- Be an existing owner of the agent identity blueprint or agent identity you want to manage.

## Important considerations

> [!NOTE]
> When you use a dynamic membership group as a sponsor, it can take up to 24 hours after a membership rule change or a user property change before the authorization check on sponsorship succeeds. Plan accordingly when assigning dynamic groups as sponsors for agent identities or blueprints.

## Add an owner or sponsor to an agent blueprint

When managing agent identity blueprint owners and sponsors, you can assign them to either the agent identity blueprint or the agent blueprint principal using the respective tabs.

:::image type="content" source="media/manage-owners-sponsors-agents/blueprint-owners-sponsors.png" alt-text="Screenshot of the owners and sponsors page for a blueprint showing the list of owners and sponsors with their roles." lightbox="media/manage-owners-sponsors-agents/blueprint-owners-sponsors.png":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) or owner of the agent identity blueprint.
1. Browse to **Entra ID** > **Agents** > **Agent blueprints**.
1. Select the blueprint you want to manage.
1. Under **Access** select **Owners and sponsors**.
1. Select either the **Agent blueprint** or **Agent blueprint principal** tab, depending on which you want to manage.
1. Select **Add** > **Add owner** or **Add sponsor**, depending on which you want to add.
1. Search for and select the users and groups (for sponsors only) you want to add.
1. Select **Add**.

## Add an owner or sponsor to an agent identity

The process for adding owners and sponsors to individual agent identities is similar to blueprints.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) or owner of the agent identity.
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Select the agent identity you want to manage.
1. Under **Access** select **Owners and sponsors**.
1. Select **Add** > **Add owner** or **Add sponsor** depending on which you want to add.
1. Search for and select the users and groups (for sponsors only) you want to add.
1. Select **Add**.

## Remove an owner or sponsor

### Remove from blueprints

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) or owner of the agent identity blueprint.
1. Browse to **Entra ID** > **Agents** > **Agent blueprints**.
1. Select the blueprint you want to manage.
1. Select **Owners and sponsors** from the left menu.
1. Select either the **Agent blueprint** or **Agent blueprint principal** tab, depending on which you want to manage.
1. Select the checkbox next to the owner or sponsor you want to remove.
1. Select **Remove**.

### Remove from agent identities

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent ID Administrator](../identity/role-based-access-control/permissions-reference.md#agent-id-administrator) or owner of the agent identity.
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Select the agent identity you want to manage.
1. Under **Access** select **Owners and sponsors**.
1. Select the checkbox next to the owner or sponsor you want to remove.
1. Select **Remove**.

## Related content

- [Owners, sponsors, and managers](agent-owners-sponsors-managers.md)
- [View and manage agent identity blueprints](manage-agent-blueprint.md)
- [Create an agent identity blueprint](create-blueprint.md)
