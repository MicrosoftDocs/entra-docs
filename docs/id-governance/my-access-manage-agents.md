---
title: Manage Agent ID Access using the My Access Portal (Preview)
description: This article walks you through managing agent IDs you sponsor and own using the My Access portal.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/20/2025

#CustomerIntent: As an owner or sponsor of an agent I want to manage its lifecycle and access using the My Access Portal.
---

# Manage Agent ID Access using the My Access Portal (Preview)


The My Access portal is used by users to review or request access to resources within Microsoft Entra for themselves, or on behalf of other identities they have the appropriate permissions for. These identities include agent identities (IDs), which are accounts within Microsoft Entra ID that provide unique identification and authentication capabilities for AI agents. Agent IDs have sponsors, or human users, who are responsibile for access and lifecycle decisions about them. Managing the lifecycle and access of agent identities (IDs) you sponsor, or own, is a critical part of maintaining secure and efficient operations within your environment. The My Access portal provides a centralized platform to help you manage agents, view their access, and take necessary actions such as enabling or extending their access. This article guides you through the steps to effectively use the My Access portal to manage agent IDs.


[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]
[!INCLUDE [entra-agent-id-license](../includes/entra-agent-id-license.md)]
 
Super basic note about the Microsoft Entra Agent ID license. Basically, if an article covers capabilities included under the yellow bar in this graphic, drop it where it makes sense in your article.


## Manage agent IDs using the My Access portal
 
To manage agent IDs you own or sponsor using the My Access portal, do the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com) as either an owner or sponsor of an agent ID.

1. On the My Access Portal page, select **Manage agents**.

1. On the manage agents page, there are two tabs showing **Agents you sponsor** and **Agents you own**.
    :::image type="content" source="media/my-access-manage-agents/manage-agents-list.png" alt-text="Screenshot of the managed agents page in the My Access portal.":::
1. Select the agent you want to manage to get more information.
    :::image type="content" source="media/my-access-manage-agents/manage-agent-view.png" alt-text="Agent information overview page where it can be managed.":::
1. On the agent overview page, you're able to either **Enable** or **Extend** the agent.


## View agent IDs access using the My Access portal

To view a specific agent ID's, that you own or sponsor, assigned access using the My Access portal, do the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com) as either an owner or sponsor of an agent ID. For US Government, the domain in the My Access portal link is `myaccess.microsoft.us`.

1. On the My Access Portal page, select **Manage agents**.

1. On the manage agents page, select either **Agents you sponsor** or **Agents you own** depending on your relationship with the agent who's access you want to view, and select the agent ID.

1. On the agent overview page, select **Access**.

1. On the access page you can view an agent ID's granted permissions, roles, resources, and who can access the agent ID.
    :::image type="content" source="media/my-access-manage-agents/agent-access-view.png" alt-text="Screenshot of the access overview of an agent ID in the My Access portal.":::


## Next steps

- [Approve or deny access requests in entitlement management](entitlement-management-request-approve.md)
- [Review access of an access package in entitlement management](entitlement-management-access-reviews-review-access.md)

