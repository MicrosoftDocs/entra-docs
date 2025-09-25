---
title: Microsoft Graph PowerShell monitoring and health cmdlets
description: Reference information for Microsoft Graph PowerShell cmdlets for Microsoft Entra monitoring and health.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 02/06/2024
ms.author: sarahlipsey
ms.reviewer: dhanyahk
---

# Microsoft Graph PowerShell cmdlets for Microsoft Entra monitoring and health

With Microsoft Entra monitoring and health, you can get details on activities around all the write operations in your directory (audit logs) and authentication data (sign-in logs). Although the information is available by using the Microsoft Graph API, now you can retrieve the same data by using the Microsoft Graph PowerShell cmdlets for Identity monitoring and health.

This article gives you an overview of the Microsoft Graph PowerShell cmdlets to use for audit logs and sign-in logs. [Get started with Microsoft Graph PowerShell](/powershell/microsoftgraph/get-started).

## Audit logs

[Audit logs](concept-audit-logs.md) provide traceability through logs for all changes done by various features within Microsoft Entra ID. Examples of audit logs include changes made to any resources within Microsoft Entra ID like adding or removing users, apps, groups, roles, and policies.

You get access to the audit logs using the `Get-MgAuditLogDirectoryAudit` cmdlet.

| Scenario                      | PowerShell command |
| :--                           | :--                |
| Application Display Name      | `Get-MgAuditLogDirectoryAudit -Filter "initiatedBy/app/displayName eq 'Azure AD Cloud Sync'"` |
| Category                      | `Get-MgAuditLogDirectoryAudit -Filter "category eq 'ApplicationManagement'"` |
| Activity Date Time            | `Get-MgAuditLogDirectoryAudit -Filter "activityDateTime gt 2019-04-18"` |
| All of the above              | `Get-MgAuditLogDirectoryAudit -Filter "initiatedBy/app/displayName eq 'Azure AD Cloud Sync' and category eq 'ApplicationManagement' and activityDateTime gt 2019-04-18"` |

## Sign-in logs

The [sign-ins](concept-sign-ins.md) logs provide information about the usage of managed applications and user sign-in activities.

You get access to the sign-in logs using the `Get-MgAuditLogSignIn` cmdlet. Use the following table for more scenarios.

| Scenario                      | Microsoft Graph PowerShell command |
| :--                           | :--                |
| User Display Name             | `Get-MgAuditLogSignIn -Filter "userDisplayName eq 'Timothy Perkins'"` |
| Create Date Time              | `Get-MgAuditLogSignIn -Filter "createdDateTime gt 2023-04-18T17:30:00.0Z"` (Everything since 5:30 pm on 4/18) |
| Status                        | `Get-MgAuditLogSignIn -Filter "status/errorCode eq 50105"` |
| Application Display Name      | `Get-MgAuditLogSignIn -Filter "appDisplayName eq 'StoreFrontStudio [wsfed enabled]'"` |
| All of the above              | `Get-MgAuditLogSignIn -Filter "userDisplayName eq 'Timothy Perkins' and status/errorCode ne 0 and appDisplayName eq 'StoreFrontStudio [wsfed enabled]'"` |

## Next steps

- [Analyze activity logs with Microsoft Graph](howto-analyze-activity-logs-with-microsoft-graph.md)
