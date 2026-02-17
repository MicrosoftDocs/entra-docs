---
title: Manage Agents in end user experience (Preview)
description: Learn how to manage agent identities in the end user experience within Microsoft Entra (Preview). View, control, and take action on agents you own or sponsor with ease.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/05/2025

#CustomerIntent: As an agent identity owner, I want to manage the agents I own so that I can control their access and functionality.
---

# Manage Agents in end user experience (Preview)

The Manage Agents feature in Microsoft Entra lets you view, and control, [agent identities you own or sponsor](agent-owners-sponsors-managers.md). [Agents identities](what-is-agent-id.md) are special identities, such as bots or automated processes, that act on behalf of users or teams. With the manage agents feature, you can easily see which agents you’re responsible for, review their details, and take action to enable, disable, or request access for them.

> [!NOTE]
> This feature is in public preview. Functionality might change before general availability.

## License requirements

[!INCLUDE [entra-agent-id-license](../../includes/entra-agent-id-license-note.md)]

## Manage agents as an agent identity owner or sponsor

1.	Sign in to the [My Account end user portal](https://myaccount.microsoft.com/) as either an owner or sponsor of at least one agent identity.

1.	If you haven’t opted in to the new homepage yet, select **Use new version** in the banner.
    > [!NOTE]
    > If you’re already using the new homepage, the banner still appears with the message "You’re using the new version of the account homepage" and a **Use previous version** button.
   
1.	In the left menu, select **Manage agents (Preview)**.
    > [!NOTE]
    > This menu item will only appear if you're an owner or sponsor of at least one agent identity.

1.	Choose either the **Agents you sponsor** or **Agents you own tab** to view your agents.
    :::image type="content" source="media/manage-agent/manage-agents-list.png" alt-text="Screenshot of the managed agents page in the My Account portal.":::

1.	Select an agent to view details about it.
    :::image type="content" source="media/manage-agent/manage-agent-view.png" alt-text="Screenshot of the manage agent view.":::

## Enable or Disable an agent

1. To disable an agent, select it from the list and choose **Disable agent**. This blocks users from being able to access it and prevents it from being issued tokens.

1. To re-enable, select the agent that is disabled and choose **Enable agent**. This allows users to access it, and allows it to be issued tokens.



[!INCLUDE [entitlement-management-request-behalf-agent](../../includes/governance/entitlement-management-request-behalf-agent.md)]

## Next Steps

- If an agent needs other access packages, [Request an access package on behalf of an agent identity (Preview)](../../id-governance/entitlement-management-request-behalf.md#request-an-access-package-on-behalf-of-an-agent-identity-preview)
