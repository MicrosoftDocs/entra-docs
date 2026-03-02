---
title: Microsoft Entra Backup and Recovery overview
description: Learn how Microsoft Entra Backup and Recovery helps you recover from malicious attacks or accidental changes by reverting tenant objects to a previous state.
ms.date: 03/02/2026
ms.service: entra-id
ms.topic: overview
ai-usage: ai-assisted
---

# Microsoft Entra Backup and Recovery overview (Preview)

Microsoft Entra Backup and Recovery is a native backup and recovery solution that enables you to quickly recover critical Microsoft Entra directory objects to a previously known good state after accidental changes or security compromises. Supported objects include users, groups, apps, service principals, conditional access policies, named locations, authentication method policies, authorization policy, and Agent ID.

## How backups work

Microsoft Entra Backup and Recovery takes backups of supported objects automatically, once a day, retaining up to five days of backup history during public preview. The current scope of the solution aims to bring your tenant back to a productive and secure state. The solution is continuously improved and expanded to support more directory objects and more attributes.

Backups are made automatically available in your tenant. Backup settings can't be turned off, and backups can't be deleted or modified. No signed-in user or application, even with the highest admin privileges, can turn off backup settings, or delete or modify backups in the tenant.

## What you can do

Microsoft Entra Backup and Recovery allows you to:

- **View available backups**: See a list of backups available in your Microsoft Entra tenant.
- **Create difference reports**: Before recovering objects to a previous state, compare the current state with a snapshot state by initiating a difference report.
- **Recover objects**: Choose to recover all objects or select objects by object type or object ID.
- **Review recovery history**: View completed and in-progress recovery operations for your tenant.

> [!TIP]
> To ensure you recover to the right snapshot, always run a difference report, review the changes, and then decide what to recover. The time to recover mostly depends on the number of changes in the recovery job.

## Get started

To get started, navigate to the [Microsoft Entra admin center](https://entra.microsoft.com) and select **Backup and recovery** in the left navigation pane. The following pages are available:

- **Overview (Preview)**: View a summary of the backup and recovery feature.
- **Backups (Preview)**: Browse available backup snapshots from the last five days.
- **Difference Reports (Preview)**: Create and review reports that compare a backup with the current tenant state.
- **Recovery History (Preview)**: View completed and in-progress recovery operations for your tenant.

## Prerequisites

To use Microsoft Entra Backup and Recovery, your tenant must meet the following requirements:

- The tenant is a **workforce tenant**. External ID and B2C tenants aren't supported.
- The tenant has **Microsoft Entra ID P1 or P2** licenses.
- You're signed in with one of the following roles:
  - **Entra Backup Reader**: Can view backups, view comparisons of changed objects between the snapshot state and the current state, and review recovery history.
  - **Entra Backup Administrator**: Has all the permissions of Entra Backup Reader, plus can initiate difference reports and trigger recovery for changed objects. All the permissions of Entra Backup Administrator are included in the Global Administrator role.

## Related content

- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
- [Review recovery history](review-recovery-history.md)
- [Supported objects and recoverable properties](scope-supported-objects-limitations.md)
- [Troubleshoot Microsoft Entra Backup and Recovery](troubleshooting.md)
