---
title: Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery
description: Understand how Microsoft Entra Backup and Recovery creates backups, generates difference reports, and recovers tenant objects to a previous state
ms.date: 10/19/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1026
#customer intent: As an identity administrator, I want to understand how backups, difference reports, and recovery work so that I can compare tenant changes and recover supported objects.
---

# Backup, difference report, and recovery model in Microsoft Entra Backup and Recovery

Microsoft Entra Backup and Recovery automatically backs up supported tenant objects so you can compare changes and recover to a previous state. Supported objects include:

- Users, including agents' user accounts
- Groups
- Applications, including agent identity blueprints
- Service principals, including agent identities and agent identity blueprint principals
- Conditional access policies
- Named location policies
- Authentication method policy
- Authorization policy
- Organization

For a full list of supported attributes, see [Supported objects and attributes](scope-supported-objects-limitations.md).

Backups are created automatically once per day. Select from retained backups when you create a difference report or start recovery.

## Difference reports

Create a difference report to compare the current state of your tenant with a selected backup. Only changed objects appear in the report, with changed attributes and links shown for review. Apply filters to view changes for a specific object type or a specific object. If you don't apply a filter, all changed objects are included in the difference report.

Changes for users and groups synchronized from on-premises Active Directory appear in the difference report to help you track changed objects. However, you can't recover on-premises synced objects through Backup and Recovery, because the source of authority for these objects is on-premises Active Directory.

### First-time difference report generation

When you create a difference report against a Standard backup whose data hasn't already been loaded, the backup data loads before the difference calculation starts. A difference report against a Premium backup skips data loading and starts with difference calculation. Check the progress of report generation in the **Difference Reports** section.

For Standard backups that require data loading, use the following estimates:

| Tenant size | Estimated data loading time for Standard backups |
|---|---|
| 1-50,000 objects | Up to 1 hour |
| 50,001-300,000 objects | Up to 1 hour 30 minutes |
| 300,001-1,000,000 objects | Up to 2 hours |
| More than 1,000,000 objects | Up to 2 hours and 30 minutes |

After data loading, difference calculation time depends on the number of changes between the backup state and the current state. For 100,000 object and/or link changes, the calculation can take approximately 45 minutes.

### Example: First difference report performance

The following example compares first-time difference report generation for Standard and Premium. The selected backup contains 300,000 objects, and 100,000 objects have changed since it was taken. For Standard, assume no previous operation has loaded the backup data.

| Plan | Data loading | Difference calculation | Total report generation |
|---|---|---|---|
| **Standard** | Up to 1 hour 30 minutes | Up to 45 minutes | Up to 2 hours 15 minutes |
| **Premium** | Skipped | Up to 45 minutes | Up to 45 minutes |

After data loads for a Standard backup, subsequent difference reports and recovery operations against the same backup don't repeat the data loading phase.

> [!NOTE]
> Time estimates are approximate and provided for general planning purposes only. Actual performance might differ significantly based on concurrent network activities, resource availability, and tenant size.

## Recovery

When you recover your tenant, apply filters to control which objects to recover:

- **By object type**: Recover only objects of a certain type, such as users, groups, applications, service principals, or Conditional Access policies.
- **By object ID**: Supply the object type and object ID to recover a specific object.
- **All changes**: Recover all changed objects to the state captured in the selected backup.

If no previous operation has loaded a backup, recovery under the Standard plan begins with data loading. Under the Premium plan, recovery skips this phase.

Recovery performance depends on the number of changes to be recovered. Recovering 500,000 changes can take up to 30 hours, excluding any time required for data loading.

> [!NOTE]
> Time estimates are approximate and provided for general planning purposes only. Actual performance might differ significantly based on concurrent network activities, resource availability, and tenant size.

> [!IMPORTANT]
> Only one job can run at a time, including difference reports and recovery jobs. For example, if a difference report is running in your tenant, you can't start a recovery job. Wait until the current job finishes or cancel it before starting a new one.

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
> Hard-deleted objects can't be recovered. [Configure Hard Deletion Protection](configure-hard-deletion-protection.md) to block permanent deletion of supported objects during the first seven days after they're soft deleted. You can also configure [protected actions](/entra/identity/role-based-access-control/protected-actions-overview) to protect hard-deletion permissions.

For soft-deleted users, Microsoft 365 Groups, cloud security groups, application registrations, and service principals, you can also use [soft deletion](soft-deletion.md) within the 30-day retention window.

On-premises synchronized objects can't be recovered through Backup and Recovery, because the source of authority is on-premises Active Directory. Recover these objects in on-premises Active Directory instead. Changes to synced objects still appear in difference reports.

Microsoft Entra Backup and Recovery is available for workforce tenants only. Microsoft Entra External ID tenants and Azure AD B2C tenants aren't supported.

Microsoft Entra Backup and Recovery backs up and recovers Microsoft Entra directory objects. Microsoft 365 resources, such as mailboxes, OneDrive, or SharePoint sites, and Azure resources aren't backed up by Microsoft Entra Backup and Recovery.

## Related content

- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
