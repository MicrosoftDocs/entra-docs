---
title: Microsoft Entra Backup and Recovery overview
description: Compare Microsoft Entra Backup and Recovery Standard and Premium plans, including retention, performance, billing, and object recovery.
ms.date: 10/19/2026
ms.service: entra-id
ms.topic: overview
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-assisted

#customer intent: As an identity administrator, I want to understand Microsoft Entra Backup and Recovery plans so that I can choose the backup retention and performance that my organization needs.
---

# Microsoft Entra Backup and Recovery overview

Microsoft Entra Backup and Recovery is a built-in solution that lets you recover critical Microsoft Entra directory objects to a previously known good state after accidental changes or security compromises. This overview explains how daily backups work, the differences between the Standard and Premium plans, and the prerequisites for each plan.

Supported objects include users, groups, apps, service principals, Conditional Access policies, named locations, authentication method policy, authentication strength policies, and authorization policy (selected properties). The solution also supports agent identities, which consist of users, apps, and service principals with distinct types and characteristics.

## How backups work

The Standard plan takes backups of supported objects automatically, once a day, and retains up to seven days of backup history. The Standard plan is included with Microsoft Entra ID P1 and P2 licenses. The solution helps restore your tenant to a productive and secure state. Microsoft regularly improves and expands the solution to support more directory objects and more attributes.

Microsoft creates Standard plan backups automatically and makes them available to administrators with sufficient permissions. No signed-in user or application, even with the highest admin privileges, can turn off, delete, or modify Standard plan backups in the tenant. Backup data resides securely in the same [geo-location as the Microsoft Entra tenant](/entra/fundamentals/data-residency), determined during tenant creation.

## Standard and Premium plans

- **Standard**: Included with Microsoft Entra ID P1 and P2 licenses and retains up to 7 days of backup history.
- **Premium (preview)**: An optional, consumption-based plan that retains up to 30 days of backup history. It offers faster initial difference report generation and recovery by skipping the one-time data loading phase for each backup.

Premium charges depend on the number of protected directory objects captured in each backup. Configure billing and turn on Premium in the Microsoft 365 admin center. Microsoft Entra Backup Administrator is the least-privileged role that can turn on Premium for your tenant. For setup instructions, see [Set up Microsoft 365 Backup](/microsoft-365/backup/backup-setup?view=o365-worldwide).

For plan features and what happens when you turn Premium on or off, see [Microsoft Entra Backup and Recovery plans](backup-recovery-plans.md).

## Key capabilities

Microsoft Entra Backup and Recovery lets you:

- **View available backups**: See a list of backups available in your Microsoft Entra tenant.
- **Create difference reports**: Before recovering objects to a previous state, compare the current state of your tenant with a backup and review changed attributes and links.
- **Recover objects**: Recover all supported objects, selected object types, or specific object IDs.
- **Review recovery history**: View completed and in-progress recovery operations for your tenant.
- **Configure Hard Deletion Protection (preview)**: Protect supported objects from permanent deletion during the first seven days after they're soft deleted.

> [!TIP]
> To ensure you recover to the right backup, always run a difference report, review the changes, and then decide what to recover. The time to recover mostly depends on the number of changes in the recovery job.

## Get started

To get started, browse to the [Microsoft Entra admin center](https://entra.microsoft.com) and select **Backup and recovery** in the left navigation pane. These pages are available:

- **Overview**: View a summary of the backup and recovery feature.
- **Backups**: Browse available backups. The Standard plan retains up to 7 days of backup history, and the Premium plan retains up to 30 days.
- **Difference Reports**: Create and review reports that compare a backup with the current tenant state.
- **Recovery History**: View completed and in-progress recovery operations for your tenant.
- **Settings**: View the current plan.
- **Hard deletion protection (preview)**: Enable permanent protection for supported objects and view protected-object counts.

To turn on the Premium plan, see [Set up Microsoft 365 Backup](/microsoft-365/backup/backup-setup?view=o365-worldwide).

## Prerequisites

To use Microsoft Entra Backup and Recovery, your tenant must meet these requirements:

- The tenant is a **workforce tenant**. External ID and Azure AD B2C tenants aren't supported.
- To use the Standard plan, the tenant has **Microsoft Entra ID P1 or P2** licenses.
- To use the Premium plan, the tenant has at least one [SharePoint license or a license that includes SharePoint](/microsoft-365/commerce/services/pay-as-you-go-setup-billing-node?view=o365-worldwide#before-you-begin). Microsoft Entra ID P1 or P2 licenses aren't required.
- You're signed in with one of these roles:
  - **Microsoft Entra Backup Reader**: Can view backups, view comparisons of changed objects between the backup state and the current state, and review recovery history.
  - **Microsoft Entra Backup Administrator**: Has all the permissions of Microsoft Entra Backup Reader, plus can initiate difference reports, trigger recovery for changed objects, and set up the Premium plan. All the permissions of Microsoft Entra Backup Administrator are included in the Global Administrator role.

## Hybrid identity and broader recoverability

Organizations that use hybrid identity with Microsoft Entra ID can create difference reports to identify changes to objects synchronized from Active Directory Domain Services (AD DS). For certain object types, such as groups, you can move the source of authority from AD DS to the cloud. This makes all Microsoft Entra Backup and Recovery functionality available for those converted objects. Use an alternative solution to back up and recover objects managed in AD DS.

Soft-deleted users, Microsoft 365 Groups, cloud security groups, application registrations, and service principals can be restored for 30 days. For more information about how soft deletion relates to Backup and Recovery, see [Soft deletion in Microsoft Entra Backup and Recovery](soft-deletion.md). Backup and Recovery restores supported properties and links from retained backups and complements soft-delete recovery.

Microsoft Entra Backup and Recovery doesn't support the recovery or re-creation of hard-deleted objects.

Use Microsoft Entra Backup and Recovery as part of a broader approach to recoverability that helps your organization be more resilient. For more information about limitations, hybrid scenarios, and recoverability best practices, see [Supported objects and recoverable properties](scope-supported-objects-limitations.md).

## Related content

- [Compare Standard and Premium plans](backup-recovery-plans.md)
- [Estimate Premium pricing](backup-recovery-premium-pricing.md)
- [Configure Hard Deletion Protection](configure-hard-deletion-protection.md)
- [View available backups](view-available-backups.md)
- [Create and review difference reports](create-review-difference-reports.md)
- [Recover objects](recover-objects.md)
- [Review recovery history](review-recovery-history.md)
- [Supported objects and recoverable properties](scope-supported-objects-limitations.md)
- [Troubleshoot Microsoft Entra Backup and Recovery](troubleshooting.md)
