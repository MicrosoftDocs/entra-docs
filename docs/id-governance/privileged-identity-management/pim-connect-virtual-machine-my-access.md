---
title: Connect to an Azure Virtual Machine from the My Access portal
description: Use the My Access portal to view Azure Virtual Machine access, activate eligible roles, and connect with Microsoft Entra ID authentication.
author: tamimsangrar
ms.author: tamimsangrar
ms.topic: how-to
ms.date: 11/17/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As a user with access to an Azure Virtual Machine, I want to activate the access I need and connect from the My Access portal so that I can complete my task.
---

# Connect to an Azure Virtual Machine in the My Access portal (Preview)

<a name="connect-to-an-azure-virtual-machine-from-my-access"></a>

<a name="connect-to-an-azure-virtual-machine-from-the-my-access-portal"></a>

Use the My Access portal to view your access to an Azure Virtual Machine, activate eligible role assignments when required, and connect to the Virtual Machine with Microsoft Entra ID authentication. An eligible role assignment lets you request temporary role access for your signed-in identity.

## Prerequisites

Before you begin, confirm your access and ask the resource administrator to verify the connection setup.

### Your access

- Microsoft Entra ID Governance licensing is required for **Resource Connections**. See [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).
- You need an active or eligible **Virtual Machine Administrator Login** or **Virtual Machine User Login** role assignment for Microsoft Entra sign-in to the virtual machine. An Owner or Contributor **role assignment** alone will not grant the user the ability to sign-in.
- For Azure Bastion, you need read access to the virtual machine, its network interface, and the Bastion resource. You also need read access to the target virtual machine's virtual network when Bastion is deployed in a peered virtual network. Existing active role assignments can provide some of this access within their scopes. Ask your administrator to provide the required access where it is missing, for example through the **Reader** role. If this access isn't already active, you need existing eligible role assignments that cover the required resources and permissions.
- Use a client that meets the [Windows](~/identity/devices/howto-vm-sign-in-azure-ad-windows.md) or [Linux](~/identity/devices/howto-vm-sign-in-azure-ad-linux.md) sign-in requirements. Windows virtual machine connectivity doesn't support guest accounts.

### Administrator-managed setup

- The Azure Virtual Machine must be configured for Microsoft Entra sign-in. The resource administrator can follow the setup procedures for [Windows](~/identity/devices/howto-vm-sign-in-azure-ad-windows.md) or [Linux](~/identity/devices/howto-vm-sign-in-azure-ad-linux.md) virtual machines. For Azure Arc-enabled servers, this preview supports only Linux.
- For Azure Bastion connections, a Bastion host must have network connectivity to the virtual machine. Use [Deploy Azure Bastion](/azure/bastion/quickstart-host-portal) for deployment and [Microsoft Entra ID authentication with Azure Bastion](/azure/bastion/bastion-entra-id-authentication) for authentication setup and required resource access.
- An administrator manages the active or eligible role assignments. For role assignment setup, see [Assign Azure resource roles in PIM](pim-resource-roles-assign-roles.md).

<a name="find-your-virtual-machine"></a>

## Find your Azure Virtual Machine

In the [My Access portal](../my-access-portal-overview.md), locate the virtual machine you want to connect to and view its role assignments. Eligible role assignments need to be activated before you can use their permissions. If the role assignments you need are already active, you don't need to activate them again.

1. Sign in to the [My Access portal](https://myaccess.microsoft.com) in the tenant where you have access.
1. Under **My Access**, select [**Resource Connections**](https://aka.ms/pim/resource-connections).
1. Select **Virtual Machine** to view Azure Virtual Machines, or **Azure Arc VM** for supported Azure Arc-enabled Linux servers.
1. Find the resource and view its active and eligible role assignments. Select the resource name to view its details. To view it in the Azure portal, select **Open in Azure** from the resource details.

:::image type="content" source="media/pim-connect-virtual-machine-my-access/my-access-resource-connections.png" alt-text="Screenshot of My Access Resource Connections showing eligible role assignments and the Activate action for a virtual machine." lightbox="media/pim-connect-virtual-machine-my-access/my-access-resource-connections.png":::

## Activate the access you need

If you already have active access and **Connect** is available, continue to [Connect to the Azure Virtual Machine](#connect-to-the-vm). Otherwise, request role activation for the roles you need.

Dependent resources are resources used for the connection, such as the Azure Bastion host and the virtual machine's network interface. An existing eligible role assignment can cover dependent resources when it grants the required permissions at a scope that includes those resources. You don't need a separate eligible role assignment on every dependency. You can optionally select a lower-privileged role when the eligible role's policy allows it.

For example, if the virtual machine, network interface, Bastion host, and relevant virtual network are in the same resource group, the following eligible role assignments can provide the required access after activation:

| Existing eligible role assignment | Role assignment scope | Access after activation |
| --- | --- | --- |
| **Reader** | The resource group containing the resources. | Reader access to the virtual machine, network interface, Bastion host, and virtual network in that resource group. |
| **Virtual Machine User Login** | The virtual machine. | Microsoft Entra sign-in to the virtual machine as a regular user. |

Confirm the roles and scopes offered in the role activation dialog for your connection.

1. Select **Activate** at the Azure subscription, resource group, or resource scope where you need access. The scope you select is the activation scope.
1. In the role-selection dialog, select **Activate** for the eligible role assignment you need.

    :::image type="content" source="media/pim-connect-virtual-machine-my-access/resource-connection-role-selection.png" alt-text="Screenshot of available virtual machine sign-in role assignments and their Activate actions." lightbox="media/pim-connect-virtual-machine-my-access/resource-connection-role-selection.png":::

1. Under **Choose a connection path**, select an available path, such as **Azure Bastion**. Review **Role assignments to activate**, including access to dependent resources such as the Azure Bastion host or network interface.

    The roles shown depend on your existing eligibility. Review the roles and resources listed before you submit the request.

    :::image type="content" source="media/pim-connect-virtual-machine-my-access/resource-connection-activation.png" alt-text="Screenshot of a connection path, dependent-resource role assignments, and the Activate access action." lightbox="media/pim-connect-virtual-machine-my-access/resource-connection-activation.png":::

1. Review the **Duration** and enter a **Justification** for your task.
1. Optional: If **Allow least-privilege role activation** is enabled on the policy for the role you're eligible for, use **Change settings** in the activation dialog to select an available lower-privileged role. The eligible role's policy governs approval, authentication, justification, and activation maximum duration.
1. Complete the role activation requirements shown and select **Activate access**. Requirements depend on each eligible role's policy and can include approval or Conditional Access.
1. Select **Refresh** to check the request status. If the request is pending approval, wait for approval. Continue when access is **Active** and **Connect** is available.

:::image type="content" source="media/pim-connect-virtual-machine-my-access/resource-connection-active-access.png" alt-text="Screenshot of a virtual machine with an active role assignment and the Connect action available." lightbox="media/pim-connect-virtual-machine-my-access/resource-connection-active-access.png":::

<a name="connect-to-the-vm"></a>

## Connect to the Azure Virtual Machine

Use a connection method offered for the selected resource. The available options depend on the resource configuration.

If your organization requires a recording, check [Azure Bastion recording support and limitations](azure-pim-resource-rbac.md#azure-bastion-recording-support) before selecting a method. Microsoft Entra ID RDP in the Azure portal and native-client connections don't support Bastion graphical session recording.

1. Select **Connect** for the Azure Virtual Machine or supported Azure Arc-enabled Linux server.
1. In the connection dialog, choose an available method:

    - For Azure Bastion in-browser access, select **Azure Bastion** under **Choose a connection path**. Select **Browser** under **Choose a connection option**, and then select **Connect**.
    - For Azure Cloud Shell, select the offered Cloud Shell connection option.
    - For a native RDP or SSH connection, follow the instructions in the connection dialog. Use the applicable [Windows](~/identity/devices/howto-vm-sign-in-azure-ad-windows.md) or [Linux](~/identity/devices/howto-vm-sign-in-azure-ad-linux.md) guide for client requirements.

1. Complete the connection instructions and sign in with your Microsoft Entra ID credentials.

:::image type="content" source="media/pim-connect-virtual-machine-my-access/resource-connection-bastion-browser.png" alt-text="Screenshot of the Azure Bastion connection path, Browser connection option, and Connect action." lightbox="media/pim-connect-virtual-machine-my-access/resource-connection-bastion-browser.png":::

## Troubleshoot access and connection

Use the following checks when you can't connect. An administrator handles role assignment or activation issues. A resource administrator handles virtual machine and Bastion setup.

| Symptom | Next action |
| --- | --- |
| The virtual machine isn't listed. | Confirm that you're signed in to the tenant where you have access. Ask the administrator to verify your role assignment and its scope, and the resource administrator to verify the connection setup. |
| The required role assignment isn't listed for activation. | Ask the administrator to check whether you have an eligible role assignment with the required permissions and scope. My Access activation doesn't create eligibility. |
| Activation is pending approval. | Wait for approval before using the role. If you no longer need the request, [cancel it in My Access](pim-resource-roles-activate-your-roles.md?pivots=my-access#view-and-cancel-a-pending-request-in-my-access). |
| **Connect** is unavailable after activation. | Select **Refresh** and check the activation status in [**Resource Connections**](https://aka.ms/pim/resource-connections). If the request is pending approval, wait for approval. If the status is **Active** but **Connect** is still unavailable, ask your administrator to check the access and setup requirements in [Prerequisites](#prerequisites). |
| Sign-in fails after you start the connection. | Use the [Windows sign-in troubleshooting guide](~/identity/devices/howto-vm-sign-in-azure-ad-windows.md#troubleshoot-sign-in-problems) or [Linux sign-in troubleshooting guide](~/identity/devices/howto-vm-sign-in-azure-ad-linux.md#troubleshoot-sign-in-issues), with help from the resource administrator for configuration checks. |

## Finish your work

When you're finished, end your Azure Virtual Machine or Azure Arc-enabled server session and deactivate temporary access that you no longer need.

1. Sign out of the Azure Virtual Machine or Azure Arc-enabled server session.
1. In the [My Access portal](../my-access-portal-overview.md), review the active role assignment and select **Deactivate** where available.

Role deactivation removes the active role assignment. It isn't a procedure for disconnecting an existing Azure Virtual Machine or Azure Arc-enabled server session. For administrator session management in PIM, see [Monitor and disconnect Azure Bastion sessions](pim-manage-bastion-sessions.md). For session management on the Azure Bastion resource, see [Monitor active sessions](/azure/bastion/session-monitoring).

## Related content

- [Activate Azure resource roles in PIM](pim-resource-roles-activate-your-roles.md).
- [Connect to Azure Virtual Machines using Microsoft Entra ID authentication with Azure Bastion](/azure/bastion/bastion-entra-id-authentication).
- [Monitor Azure Bastion](/azure/bastion/monitor-bastion).
