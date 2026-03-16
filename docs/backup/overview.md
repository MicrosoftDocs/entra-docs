---
title: Microsoft Entra Backup and Recovery overview
description: Learn how Microsoft Entra Backup and Recovery helps you recover from malicious attacks or accidental changes by reverting tenant objects to a previous state.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: overview
ai-usage: ai-assisted
---

# Microsoft Entra Backup and Recovery overview (Preview)

> [!IMPORTANT]
> Microsoft Entra Backup and Recovery is currently in public preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Microsoft Entra Backup and Recovery is a built-in backup and recovery solution that lets you recover critical Microsoft Entra directory objects to a previously known good state after accidental changes or security compromises. Supported objects include users, groups, apps, service principals, Conditional Access policies, named locations, authentication method policies, and partial authorization policy. The solution also supports Agent ID because it consists of user and service principal objects with distinct types and characteristics.

## How backups work

Microsoft Entra Backup and Recovery takes backups of supported objects automatically, once a day, retaining up to five days of backup history. The solution helps restore your tenant to a productive and secure state. Microsoft regularly improves and expands the solution to support more directory objects and more attributes.

Microsoft creates backups automatically and makes them available to administrators with sufficient permissions. No signed-in user or application, even with the highest admin privileges, can turn off, delete, or modify backups in the tenant. Backup data resides securely in the same [geo-location as the Microsoft Entra tenant](/entra/fundamentals/data-residency), determined during tenant creation.

## Key capabilities

Microsoft Entra Backup and Recovery lets you:

- **View available backups**: See a list of backups available in your Microsoft Entra tenant.
- **Create difference reports**: Before recovering objects to a previous state, compare the current state of your tenant with a snapshot state by initiating a difference report.
- **Recover objects**: Choose to recover all objects or select objects by object type or object ID.
- **Review recovery history**: View completed and in-progress recovery operations for your tenant.

> [!TIP]
> To ensure you recover to the right snapshot, always run a difference report, review the changes, and then decide what to recover. The time to recover mostly depends on the number of changes in the recovery job.

## Get started

To get started, browse to the [Microsoft Entra admin center](https://entra.microsoft.com) and select **Backup and recovery** in the left navigation pane. These pages are available:

- **Overview (Preview)**: View a summary of the backup and recovery feature.
- **Backups (Preview)**: Browse available backup snapshots from the last five days.
- **Difference Reports (Preview)**: Create and review reports that compare a backup with the current tenant state.
- **Recovery History (Preview)**: View completed and in-progress recovery operations for your tenant.

## Prerequisites

To use Microsoft Entra Backup and Recovery, your tenant must meet these requirements:

- The tenant is a **workforce tenant**. External ID and B2C tenants aren't supported.
- The tenant has **Microsoft Entra ID P1 or P2** licenses.
- You're signed in with one of these roles:
  - **Microsoft Entra Backup Reader**: Can view backups, view comparisons of changed objects between the snapshot state and the current state, and review recovery history.
  - **Microsoft Entra Backup Administrator**: Has all the permissions of Microsoft Entra Backup Reader, plus can initiate difference reports and trigger recovery for changed objects. All the permissions of Microsoft Entra Backup Administrator are included in the Global Administrator role.

## Hybrid identity and broader recoverability

Organizations that use hybrid identity with Microsoft Entra ID can create difference reports to identify changes to objects synchronized from Active Directory Domain Services (AD DS). For certain object types, such as groups, you can move the source of authority from AD DS to the cloud. This makes all Microsoft Entra Backup and Recovery functionality available for those converted objects. Use an alternative solution to back up and recover objects managed in AD DS.

Microsoft Entra Backup and Recovery doesn't support the recovery or re-creation of hard-deleted objects.

Use Microsoft Entra Backup and Recovery as part of a broader approach to recoverability that helps your organization be more resilient. For more information about limitations, hybrid scenarios, and recoverability best practices, see [Supported objects and recoverable properties](scope-supported-objects-limitations.md).

## Related content

- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
- [Review recovery history](review-recovery-history.md)
- [Supported objects and recoverable properties](scope-supported-objects-limitations.md)
- [Troubleshoot Microsoft Entra Backup and Recovery](troubleshooting.md)
