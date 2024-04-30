---
title: Prerequisites to use PowerShell or Graph Explorer for Microsoft Entra roles
description: Prerequisites to use PowerShell or Graph Explorer for Microsoft Entra roles.

author: rolyon
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: role-based-access-control
ms.date: 10/10/2023
ms.author: rolyon
ms.reviewer: anandy
ms.custom: oldportal, it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---

# Prerequisites to use PowerShell or Graph Explorer for Microsoft Entra roles

If you want to manage Microsoft Entra roles using PowerShell or Graph Explorer, you must have the required prerequisites. This article describes the PowerShell and Graph Explorer prerequisites for different Microsoft Entra role features.

## Microsoft Graph PowerShell

To use PowerShell commands to do the following:

- Add users, groups, or devices to an administrative unit
- Create a new group in an administrative unit

You must have the Microsoft Graph PowerShell SDK installed:

- [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation)

<a name='azuread-module'></a>

## Graph Explorer

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To manage Microsoft Entra roles using the [Microsoft Graph API](/graph/overview) and [Graph Explorer](/graph/graph-explorer/graph-explorer-overview), you must do the following:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **Applications** > **Enterprise applications**.

1. In the applications list, find and select **Graph explorer**.

1. Select **Permissions**.

1. Select **Grant admin consent for Graph explorer**.

    ![Screenshot showing the "Grant admin consent for Graph explorer" link.](./media/prerequisites/select-graph-explorer.png)

1. Use [Graph Explorer tool](https://aka.ms/ge).

## Next steps

- [Microsoft Graph PowerShell documentation](/powershell/microsoftgraph/)
- [Graph Explorer](/graph/graph-explorer/graph-explorer-overview)
