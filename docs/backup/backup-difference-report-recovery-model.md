---
title: Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery
description: Understand how Microsoft Entra Backup and Recovery creates backups, generates difference reports, and recovers tenant objects to a previous state
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
---

# Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Microsoft Entra Backup and Recovery automatically backs up supported tenant objects so you can compare changes and recover to a previous state. Supported objects include:

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

Create a difference report to compare the current state of your tenant with a backup. Only changed objects appear in the report. Apply filters to view changes for a specific object type or a specific object. If you don't apply a filter, all changed objects are included in the difference report.

Changes for users and groups synchronized from on-premises Active Directory appear in the difference report to help you track changed objects. However, you can't recover on-premises synced objects through Backup and Recovery, because the source of authority for these objects is on-premises Active Directory.

### First-time difference report generation

The first time you create a difference report, you might experience a delay as backup data loads before the difference calculation starts. Check the progress of report generation in the **Difference Reports** section.

The second time you create a difference report against the same backup, the report doesn't need the data loading step, so it finishes faster.


> [!NOTE]
> Time estimates are approximate and provided for general planning purposes only. Actual performance might differ significantly based on concurrent network activities, resource availability, and tenant size.

## Recovery

When you recover your tenant, apply filters to control which objects to recover:

- **By object type**: Recover only objects of a certain type, such as users, groups, or applications.
- **By object ID**: Supply the object type and object ID to recover a specific object.
- **All changes**: Recover all changed objects to the state captured in the selected backup.

Time needed to complete recovery depends on the number of changes to recover.


Time estimates are approximate and provided for general planning purposes only. Actual performance might differ significantly based on concurrent network activities, resource availability, and tenant size.

> [!IMPORTANT]
> Only one job can run at a time, including difference reports and recovery jobs. For example, if a difference report is running in your tenant, you can't start a recovery job. Wait until the current job finishes before starting a new one.

## Recovery model

The type of change from the backup state determines the recovery action:

| Change since backup | Recovery action |
|---|---|
| Object was added | Backup and Recovery soft-deletes the object |
| Object was updated | Backup and Recovery updates the object to the backup value |
| Object was soft-deleted | Backup and Recovery restores the object |
| Object was restored | Backup and Recovery soft-deletes the object |

Backup and Recovery doesn't create new objects or hard-delete objects from your tenant.

> [!WARNING]
> Hard-deleted objects can't be recovered. Configure [protected actions](/entra/identity/role-based-access-control/protected-actions-overview) to prevent unwanted hard deletions.

On-premises synchronized objects can't be recovered through Backup and Recovery, because the source of authority is on-premises Active Directory. Recover these objects in on-premises Active Directory instead. Changes to synced objects still appear in difference reports.

Microsoft Entra Backup and Recovery is available for workforce tenants only. Microsoft Entra External ID tenants and Azure AD B2C tenants aren't supported.

## Related content

- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
