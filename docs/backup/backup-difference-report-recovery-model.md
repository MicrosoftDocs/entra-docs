---
title: Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery
description: Understand how Microsoft Entra Backup and Recovery creates backups, generates difference reports, and recovers tenant objects to a previous state.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
---

# Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Microsoft Entra Backup and Recovery takes backups automatically. Only supported objects and their attributes are included in the backups. Supported objects include:

- Users
- Groups
- Applications
- Service principals
- Conditional access policies
- Named location policies
- Authentication method policy
- Authorization policy
- Organization

For a full list of supported attributes, see [Supported objects and attributes](scope-supported-objects-limitations.md).

## Difference reports

Create a difference report to compare the current state of your tenant with a backup snapshot. Only changed objects appear in the report. Apply filters to view changes for a specific object type or a specific object. If no filter is applied, all changed objects are included in the difference report.

Changes for users and groups synchronized from on-premises Active Directory appear in the difference report to help you track changed objects. However, you can't recover on-premises synced objects through Backup and Recovery, because the source of authority for these objects is on-premises Active Directory.

### First-time difference report generation

The first time you create a difference report, you might experience a delay as snapshot data transfers before the difference calculation starts. Check the progress of report generation in the **Difference Reports** section.

The second time you create a difference report against the same snapshot, the data loading step isn't needed, so the report finishes faster.

<!-- The following table is a placeholder. Time estimates to be confirmed by the feature team.

| Tenant size | Estimated time for first difference report |
|---|---|
| 1-50,000 objects | TBD |
| 50,000-300,000 objects | TBD |
| 300,000-1,000,000 objects | TBD |
| More than 1,000,000 objects | TBD |

-->

> [!NOTE]
> Time estimates vary based on concurrent network activities and resource availability.

## Recovery

When you recover your tenant, you can apply filters to control which objects are recovered:

- **By object type**: Recover only objects of a certain type, such as users, groups, or applications.
- **By object ID**: Supply the object type and object ID to recover a specific object.
- **All changes**: Recover all changed objects to the state captured in the selected backup.

Time needed to complete recovery depends on the number of changes to recover.

<!-- The following table is a placeholder. Time estimates to be confirmed by the feature team.

| Changed objects | Estimated time for recovery |
|---|---|
| 1-50,000 changes | TBD |
| 50,000-300,000 changes | TBD |
| 300,000-1,000,000 changes | TBD |
| More than 1,000,000 changes | TBD |

-->

> [!NOTE]
> Time estimates vary based on concurrent network activities and resource availability.

> [!IMPORTANT]
> Only one job can run at a time, including difference reports and recovery jobs. For example, if a difference report is running in your tenant, you can't start a recovery job. Wait until the current job finishes before starting a new one.

## Recovery model

Based on the type of change from the backup state, these recovery actions are taken:

| Change since backup | Recovery action |
|---|---|
| Object was added | Object is soft-deleted |
| Object was updated | Object is updated to the backup value |
| Object was soft-deleted | Object is restored |
| Object was restored | Object is soft-deleted |

Backup and Recovery doesn't create new objects or hard-delete objects from your tenant.

> [!WARNING]
> - Hard-deleted objects can't be recovered. Configure [protected actions](/entra/identity/role-based-access-control/protected-actions-overview) to prevent unwanted hard deletions.
> - On-premises synchronized objects can't be recovered through Backup and Recovery, because the source of authority is on-premises Active Directory. Recover these objects in on-premises Active Directory instead. Changes to synced objects still appear in difference reports.
> - Microsoft Entra Backup and Recovery is available for workforce tenants only. Microsoft Entra External ID tenants and B2C tenants aren't supported.

## Related content

- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
