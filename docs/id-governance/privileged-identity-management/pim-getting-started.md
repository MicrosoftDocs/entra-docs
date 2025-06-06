---
title: Start using PIM
description: Learn how to enable and get started using Privileged Identity Management (PIM) in the Microsoft Entra admin center.
author: barclayn
manager: pmwongera
ms.service: entra-id-governance
ms.subservice: privileged-identity-management
ms.topic: how-to
ms.date: 01/06/2025
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim, sfi-ga-nochange
---
# Start using Privileged Identity Management

Use Privileged Identity Management (PIM) to manage, control, and monitor access within your Microsoft Entra organization. With PIM you can provide as-needed and just-in-time access to Azure resources, Microsoft Entra resources, and other Microsoft online services like Microsoft 365 or Microsoft Intune.

This article describes how to enable Privileged Identity Management (PIM) and get started using it.

## Prerequisites

To use Privileged Identity Management, you must have a Microsoft Entra ID P2 or Microsoft Entra ID Governance license. For more information on licensing, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).

## Activation of role assignments 
 
When a Microsoft Entra tenant has a Microsoft Entra ID P2 or Microsoft Entra ID Governance license, users with active role assignments can do the following:
- Open the **Roles and administrators** page in Microsoft Entra ID and select a role;
- Open the **Privileged Identity Management** page;
- Make calls to PIM using the [Microsoft Entra roles API](/graph/identity-network-access-overview/).

 Microsoft Entra enables PIM for the tenant in the following ways:
- Starting immediately, you can create eligible or time-bound assignments for Microsoft Entra roles; 
- Global Administrators or Privileged Role Administrators may start receiving other emails, such as the PIM weekly digest; 
- The PIM service principal name (MS–PIM) may get mentioned in audit log events related to role assignment management. 

These behaviors are expected and shouldn't affect your workflows.

<a name='prepare-pim-for-azure-ad-roles'></a>

## Prepare PIM for Microsoft Entra roles

Here are the tasks we recommend for you to prepare Privileged Identity Management to manage Microsoft Entra roles:

1. [Configure Microsoft Entra role settings](pim-how-to-change-default-settings.md)
1. [Give eligible assignments](pim-how-to-add-role-to-user.md)
1. [Allow eligible users to activate their Microsoft Entra role just-in-time](pim-how-to-activate-role.yml)

## Prepare PIM for Azure roles

Here are the tasks we recommend for you to prepare Privileged Identity Management to manage Azure roles for a subscription:

1. [Discover Azure resources](pim-resource-roles-discover-resources.md)
1. [Configure Azure role settings](pim-resource-roles-configure-role-settings.md)
1. [Give eligible assignments](pim-resource-roles-assign-roles.md)
1. [Allow eligible users to activate their Azure roles just-in-time](pim-resource-roles-activate-your-roles.yml)

## Navigate to your tasks

Once Privileged Identity Management is set up, you can learn your way around.

:::image type="content" source="./media/pim-getting-started/pim-quickstart-tasks.png" alt-text="Screenshot showing the navigation window in Privileged Identity Management showing Tasks and Manage options." lightbox="./media/pim-getting-started/pim-quickstart-tasks.png":::

| Task + Manage | Description |
| --- | --- |
| **My roles**  | Displays a list of eligible and active roles assigned to you. **My roles** is where you can activate any assigned eligible roles. |
| **My requests** | Displays your pending requests to activate eligible role assignments. |
| **Approve requests** | Displays a list of requests to activate eligible roles by users in your directory that you can approve. |
| **Review access** | Lists active access reviews you are assigned to complete, whether you're reviewing access for yourself or someone else. |
| **Microsoft Entra roles** | Displays a dashboard and settings for Privileged Role Administrators to manage Microsoft Entra role assignments. This dashboard is disabled for anyone who isn't a Privileged Role Administrator. These users have access to a special dashboard titled My view. The My view dashboard only displays information about the user accessing the dashboard, not the entire organization. |
| **Groups** | Manage just-in-time membership in the group or just-in-time ownership of the group. Groups can be used to provide access to Microsoft Entra roles, Azure roles, and various other scenarios. To manage a Microsoft Entra group in PIM, you must bring it under management in PIM. |
| **Azure resources** | Displays a dashboard and settings for Privileged Role Administrators to manage Azure resource role assignments. This dashboard is disabled for anyone who isn't a Privileged Role Administrator. These users have access to a special dashboard titled My view. The My view dashboard only displays information about the user accessing the dashboard, not the entire organization.|
| **General settings** | Select applications that are allowed to make app-only calls to Microsoft Graph API for PIM. |

## Next steps

- [Assign Microsoft Entra roles in Privileged Identity Management](pim-how-to-add-role-to-user.md)
- [Manage Azure resource access in Privileged Identity Management](pim-resource-roles-discover-resources.md)