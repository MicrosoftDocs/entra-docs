---
title: Monitor and disconnect Azure Bastion sessions in PIM
description: Learn how to find active Azure Bastion sessions in Microsoft Entra Privileged Identity Management and disconnect a selected session.
author: tamimsangrar
ms.author: tamimsangrar
ms.topic: how-to
ms.date: 11/17/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to find and disconnect active Azure Bastion sessions so that I can manage privileged sessions in the selected Azure scope.
---

# Monitor and disconnect Azure Bastion sessions in PIM (Preview)

<a name="monitor-and-disconnect-azure-bastion-sessions-in-pim"></a>

Use Microsoft Entra Privileged Identity Management (PIM) to find active Azure Bastion sessions in an Azure subscription or resource group and disconnect a selected session.

Session Management in PIM is in preview and supports RDP and SSH sessions.

## Prerequisites

- Microsoft Entra ID Governance licensing is required for Session Management. See [Microsoft Entra ID Governance licensing fundamentals](../licensing-fundamentals.md).
- A deployed Azure Bastion host and an active session in the scope you want to manage. For deployment, see [Deploy Azure Bastion](/azure/bastion/quickstart-host-portal).
- The **Network Contributor** role on the resource group containing the Azure Bastion host, for viewing and disconnecting sessions.

## Find and disconnect a session

Find the session before you disconnect it so that you act on the intended user and Azure Virtual Machine.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Open **Privileged Identity Management**, select **Azure resources**, and select the Azure subscription or resource group you want to manage.
1. Under **Activity**, select **Session Management (Preview)**.
1. Search for the user, Azure Virtual Machine, Bastion host, protocol, or IP address.

    :::image type="content" source="media/pim-manage-bastion-sessions/session-management-active-session.png" alt-text="Screenshot of Session Management with an active SSH session selected and the Disconnect action available." lightbox="media/pim-manage-bastion-sessions/session-management-active-session.png":::

1. Select the session, and then select **Disconnect**.

    In the confirmation dialog, select **Disconnect** to confirm, or **Cancel** to keep the session connected.

    After a successful disconnection, the session automatically disappears from the list.

1. Optional: Select **Refresh** to reload the session list. Use **Load more** to scan additional hosts.

Selecting **Disconnect** ends the selected Azure Bastion connection without deactivating the user’s role assignments. The user can reconnect if they still meet the connection requirements. For more information, see [Azure Bastion session monitoring and management](/azure/bastion/session-monitoring).

## Related content

- [Connect to an Azure Virtual Machine from My Access](pim-connect-virtual-machine-my-access.md).
- [View activity and audit history for Azure resource roles](azure-pim-resource-rbac.md).
