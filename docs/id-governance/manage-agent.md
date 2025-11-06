---
title: Manage Agents in Microsoft Entra ID (Preview)
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: owinfreyATL
ms.author: owinfrey
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/05/2025

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

# Manage Agents in Microsoft Entra ID (Preview)

The Manage agents feature in Microsoft Entra ID lets you view, and control, [agent identities you own or sponsor](/agentic-identity-platform/agentic-governance-roles). [Agents identities](/agentic-identity-platform/what-is-agent-id) are special identities, such as bots or automated processes, that act on behalf of users or teams. With the manage agents feature, you can easily see which agents you’re responsible for, review their details, and take action to enable, disable, or request access for them.

> [!NOTE]
> This feature is in public preview. Functionality might change before general availability.


## License requirements

[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]
[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

## Manage agents as an agent identity owner or sponsor

1.	Sign in to the [end user portal](https://myaccount.microsoft.com/) as either an owner or sponsor of at least one agent ID.

1.	In the left menu, select **Manage agents (Preview)**.
    > [!NOTE]
    > This will only appear if you're an owner or sponsor of at least one agent identity.

1.	Choose either the **Agents you sponsor** or **Agents you own tab** to view your agents.

1.	Select an agent to view details about it.

## Enable or Disable an agent

1. To disable an agent, select it from the list and choose **Disable agent**. This blocks users from being able to access it and prevents it from being issued tokens.

1. To re-enable, select the agent that is disabled and choose **Enable agent**. This allows users to access it, and allows it to be issued tokens.

## Next Steps

- If an agent needs other access packages, [Request access package on-behalf-of other users](entitlement-management-request-behalf.md)