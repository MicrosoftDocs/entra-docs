---
title: Event enrichment in Microsoft 365 enriched logs 
description: Global Secure Access includes Microsoft Entra Private Access and Microsoft Entra Internet Access. This article references event enrichment in Microsoft 365 enriched logs.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 03/04/2024
ms.service: global-secure-access
---

# Event enrichment in Microsoft 365 enriched logs

Event enrichment uses Microsoft 365 enriched logs to bring events across different workloads into sharper focus. The result is nuanced insights that are essential for improved security and improved efficiency. Events are carefully chosen and several factors are used to select them. These factors include priority ranking, relevance to security landscapes, and how useful these events are for Sentinel or Defender.

In the future, our coverage of events is set to broaden, increasing the scope of the security narrative.

## SharePoint Online (preview)

| #   | Workload   | Operation |
|----------|-----------|------------|
| 1 | OneDrive | `FileDeleted` |
| 2 | SharePoint | `FileDeleted` |
| 3 | SharePoint  | `FileDeletedFirstStageRecycleBin` |
| 4 | OneDrive | `FileDeletedFirstStageRecycleBin` |
| 5 | OneDrive | `FileDownloaded` |
| 6 | SharePoint | `FileDownloaded` |
| 7 | SharePoint | `FileRecycled` |
| 8 | OneDrive | `FileRecycled` |
| 9 | OneDrive | `FileUploaded` |
| 10 | SharePoint | `FileUploaded` |
| 11 | OneDrive | `ListItemDeleted` |
| 12 | SharePoint | `ListItemRecycled` |


## Teams (limited preview)

| #   | Workload   | Operation |
|----------|-----------|------------|
| 1 | Teams | `AppInstalled` |
| 2 | Teams | `BotAddedToTeam` |
| 3 | Teams | `MemberAdded` |
| 4 | Teams | `MemberRemoved` |
| 5 | Teams | `MemberRoleChanged` |
| 6 | Teams | `TeamDeleted` |
| 7 | Teams | `TeamsAdminAction` |


## Exchange (limited preview)

| #   | Workload   | Operation |
|----------|-----------|------------|
| 1 | Exchange | `New-InboxRule` |
| 2 | Exchange | `New-ManagementRoleAssignment` |
| 3 | Exchange | `New-TransportRule` |
| 4 | Exchange | `Set-AdminAuditLogConfig` |
| 5 | Exchange | `Set-AtpPolicyForO365` |
| 6 | Exchange | `Set-CrossTenantAccessPolicy` |
| 7 | Exchange | `Set-OrganizationConfig` |
| 8 | Exchange | `Set-SharingPolicy` |
| 9 | Exchange | `Set-TransportRule` |


> [!NOTE]
> This preview showcases a number of events pivotal to improving security postures and operational capabilities. While the coverage herein is preliminary, it is subject to change without notice as we continue to refine and expand our event enrichment repertoire for Microsoft 365 enriched logs.
