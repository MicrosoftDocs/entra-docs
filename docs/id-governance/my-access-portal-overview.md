---
title: What is the My Access portal? - Microsoft Entra
description: Learn how the My Access portal helps you request and review access, activate eligible roles, and connect to supported resources in Microsoft Entra.
ms.author: tamimsangrar
ms.topic: overview
ms.date: 11/17/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-assisted


#customer intent: As a user, I want to understand the My Access portal so that I can manage my access to resources within Microsoft Entra.
---


# What is the My Access portal?

My Access is a web-based portal used by users to review or request access to resources within Microsoft Entra, and by Administrators to configure this access. Depending on who is using the My Access portal, a different set of actions can be taken.

Users access the My Access portal to:

- Request access for themselves
- Approve or deny access for themselves or direct reports
- Review access for themselves
- Review access for users
- Manage and review access for agents managed
- Activate eligible role assignments with Microsoft Entra Privileged Identity Management (PIM).
- View active and eligible role assignments, activate eligible roles when needed, and connect to Azure Virtual Machines and supported Azure Arc-enabled Linux servers.

Administrators, via the Microsoft Entra admin center, can configure:

- Access packages that users can request, or that can be assigned to agents
- Access reviews for access packages
- Access reviews for groups and applications
- The overview page

## License requirements

[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]
[!INCLUDE [licensing-agent-id-governance](../includes/licensing-agent-id-governance.md)]

## Overview page

The Overview page shows you key tasks that need your attention such as pending requests and reviews. It's the landing page for the My Access portal.

## Discover access packages

In the My Access portal, you can view the access packages you can request by selecting **Access packages** in the left-hand menu and the **Available** tab. Find the access package you want to request access to in the list. You can search for an access package by name, description, or resources via the search bar. Once you locate the access package, select the row. You might have to answer questions and provide business justification for your request.

Select Request history in the left-hand menu to see a list of your requests and the status.

For more information, see [Request an access package - entitlement management](entitlement-management-request-access.md).


## Approve or deny a request

In the My Access portal, you can view your pending requests by selecting **Approvals** in the left-hand menu. Select a pending request and review the details. Based on the information provided, approve or deny the request.  

For more information, see [Approve or deny access requests - entitlement management](entitlement-management-request-approve.md).

## Review access

In the My Access portal, you can view your pending access reviews by selecting **Access reviews** in the left-hand menu. On this page, select the specific review, and make a decision based on the information provided.

Microsoft Entra ID will also send you an email with instructions shortly after the review starts. Follow the instructions in the email to complete the review.

For more information about self-reviews, see: [Review your access to resources in access reviews](self-access-review.md).

For more information about reviews for others, see: [Review access to groups & applications in access reviews](perform-access-review.md).

<a name="activate-eligible-roles"></a>

<a name="activate-eligible-role-assignments"></a>

## Activate eligible role assignments (Preview)

Use [**Roles**](https://aka.ms/pim/roles) in the My Access portal to activate your eligible role assignments in Microsoft Entra Privileged Identity Management (PIM). You can activate Microsoft Entra roles, Azure resource roles, and group membership or ownership when you need access.

Role activation through **Roles** is in preview.

For activation instructions, see:

- [Activate eligible Microsoft Entra roles](privileged-identity-management/pim-how-to-activate-role.md?pivots=my-access#activate-a-microsoft-entra-role-in-my-access).
- [Activate eligible Azure resource roles](privileged-identity-management/pim-resource-roles-activate-your-roles.md?pivots=my-access#activate-an-azure-resource-role-in-my-access).
- [Activate group membership or ownership](privileged-identity-management/groups-activate-roles.md?pivots=my-access#activate-group-membership-or-ownership-in-my-access).

<a name="connect-to-resources"></a>

## Connect to resources (Preview)

Use [**Resource Connections**](https://aka.ms/pim/resource-connections) in the My Access portal to view your active and eligible role assignments for Azure Virtual Machines and supported Azure Arc-enabled Linux servers, activate eligible roles when needed, and connect using an available connection method.

For setup requirements and connection instructions, see [Connect to an Azure Virtual Machine](privileged-identity-management/pim-connect-virtual-machine-my-access.md).

## Manage agents

In the My Access portal, you can view a list of agent identities that you own and sponsor. For more about managing and sponsoring agent identities, see: [Administrative relationships for agent identities (Owners, sponsors, and managers)](../agent-id/agent-owners-sponsors-managers.md).


You're able to manage, approve, review, and enable the agent identities. For all agent identities you own or sponsor you're also able to see general information such as level of access, and agent identities activity. For more information on managing agent identities using the My Access portal, see: [Manage Agent](../agent-id/manage-agent-identities-end-user.md).

<a name="next-step"></a>

## Next steps

- [What are access reviews? - Microsoft Entra](access-reviews-overview.md)
