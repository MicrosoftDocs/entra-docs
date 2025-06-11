---
title: how to access workbooks
description: include file Microsoft Entra workbook instructions
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: include
ms.date: 03/04/2024
ms.author: sarahlipsey
ms.custom: include file
---

To use Azure Workbooks for Microsoft Entra ID, you need:

- A Microsoft Entra tenant with a [Premium P1 license](~/fundamentals/get-started-premium.md)
- A Log Analytics workspace *and* access to that workspace
- The appropriate roles for Azure Monitor *and* Microsoft Entra ID

### Log Analytics workspace

You must create a [Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace) *before* you can use Microsoft Entra Workbooks. several factors determine access to Log Analytics workspaces. You need the right roles for the workspace *and* the resources sending the data.

For more information, see [Manage access to Log Analytics workspaces](/azure/azure-monitor/logs/manage-access).

### Azure Monitor roles

Azure Monitor provides [two built-in roles](/azure/azure-monitor/roles-permissions-security#monitoring-reader) for viewing monitoring data and editing monitoring settings. Azure role-based access control (RBAC) also provides two Log Analytics built-in roles that grant similar access.

- **View**:
  - Monitoring Reader
  - Log Analytics Reader

- **View and modify settings**:
  - Monitoring Contributor
  - Log Analytics Contributor

### Microsoft Entra roles
<a name='azure-ad-roles'></a>

Read only access allows you to view Microsoft Entra ID log data inside a workbook, query data from Log Analytics, or read logs in the Microsoft Entra admin center. Update access adds the ability to create and edit diagnostic settings to send Microsoft Entra data to a Log Analytics workspace.

- **Read**:
  - Reports Reader
  - Security Reader
  - Global Reader

- **Update**:
  - Security Administrator

For more information on Microsoft Entra built-in roles, see [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md).


For more information on the Log Analytics RBAC roles, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles#log-analytics-contributor).