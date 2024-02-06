---
title: How to analyze activity logs with Microsoft Graph
description: Learn how to anaylze sign-in and audit logs with Microsoft Graph
author: shlipsey3
manager: amycolannino
ms.service: active-directory
ms.topic: how-to
ms.subservice: report-monitor
ms.date: 02/06/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to be able to view and analyze sign-in and audit logs with the Microsoft Graph API so I can monitor and troubleshoot user activity in my organization programmatically.

---
# How to analyze activity logs with Microsoft

The Microsoft Entra [reporting APIs](/graph/api/resources/azure-ad-auditlog-overview) provide you with programmatic access to the data through a set of REST APIs. You can call these APIs from many programming languages and tools. The Microsoft Graph API isn't designed for pulling large amounts of activity data. Pulling large amounts of activity data using the API might lead to issues with pagination and performance.

This article describes how to get started analyzing Microsoft Entra activity logs with Microsoft Graph.

## Prerequisites

To get access to the reporting data through the API, you need to have one of the following roles and permissions:

- Security Reader
- Security Administrator
- Global Administrator
- `AuditLog.Read.All` or `Directory.Read.All` permissions for Microsoft Graph API access

To make requests to the Microsoft Graph API, you must first:

- [Register your app](/graph/auth-register-app-v2)
- [Get authentication tokens for a user](/graph/auth-v2-user) or [service](/graph/auth-v2-service)

## Access reports using Microsoft Graph Explorer

With all the prerequisites configured, you can run activity log queries in Microsoft Graph. For more information on Microsoft Graph queries for activity logs, see [Activity reports API overview](/graph/api/resources/azure-ad-auditlog-overview)

1. Sign in to https://graph.microsoft.com using the **Security Reader** role.

1. Use one of the following queries to start using Microsoft Graph for accessing activity logs:
    - GET `https://graph.microsoft.com/v1.0/auditLogs/directoryAudits`
    - GET `https://graph.microsoft.com/v1.0/auditLogs/signIns`

    ![Screenshot of an activity log GET query in Microsoft Graph.](media/howto-configure-prerequisites-for-reporting-api/graph-sample-get-query.png)

### Related APIs

- [Identity Protection APIs](/graph/api/resources/identityprotection-overview).
- [Provisioning logs API](/graph/api/resources/provisioningobjectsummary).

## Access reports using Microsoft Graph PowerShell

You can use PowerShell to access the Microsoft Entra reporting API. For more information, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview). 

Microsoft Graph PowerShell cmdlets:

- **Audit logs:** `Get-MgAuditLogDirectoryAudit`
- **Sign-in logs:** `Get-MgAuditLogSignIn`
- **Provisioning logs:** `Get-MgAuditLogProvisioning`
- Explore the full list of [reporting-related Microsoft Graph PowerShell cmdlets](/powershell/module/microsoft.graph.reports/).


## Troubleshoot errors in Microsoft Entra reporting API
<a name='troubleshoot-errors-in-azure-active-directory-reporting-api'></a>

**500 HTTP internal server error while accessing Microsoft Graph beta endpoint**: We don't currently support the Microsoft Graph beta endpoint - make sure to access the activity logs using the Microsoft Graph v1.0 endpoint.

- GET `https://graph.microsoft.com/v1.0/auditLogs/directoryAudits`
- GET `https://graph.microsoft.com/v1.0/auditLogs/signIns`
- GET `https://graph.microsoft.com/v1.0/auditLogs/provisioning`

**Error: Neither tenant is B2C or tenant doesn't have premium license**: Accessing sign-in reports requires a Microsoft Entra ID P1 or P2 license. If you see this error message while accessing sign-ins, make sure that your tenant is licensed with a Microsoft Entra ID P1 license.

**Error: User isn't in the allowed roles**: If you see this error message while trying to access audit logs or sign-ins using the API, make sure that your account is part of the **Security Reader** or **Reports Reader** role in your Microsoft Entra tenant.

**Error: Application missing Microsoft Entra ID 'Read directory data' or 'Read all audit log data' permission**: The application must have either the `AuditLog.Read.All` or `Directory.Read.All` permission to access the activity logs with Microsoft Graph.

## Next steps

- [Get started with Microsoft Entra ID Protection and Microsoft Graph](../../id-protection/howto-identity-protection-graph-api.md)
- [Audit API reference](/graph/api/resources/directoryaudit)
- [Sign-in API reference](/graph/api/resources/signin)