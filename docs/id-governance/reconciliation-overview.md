---
title: Reconciliation overview - Microsoft Entra ID Governance
description: Learn how reconciliation in Microsoft Entra ID Governance provides visibility, enforcement, and remediation for access drift.
author: arvinh
ms.author: arvinh
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: concept-article
ai-usage: ai-generated
ms.custom: msecd-doc-authoring-1026
ms.date: 08/31/2026

#customer intent: As an Identity Governance administrator, I want to understand reconciliation and drift detection so that I can ensure organizational access matches governance policies.
---

# Reconciliation overview

Reconciliation is an identity governance capability that helps ensure access to applications, groups, and directories stays aligned with your governance policies.

In Microsoft Entra ID Governance, [access policies](identity-governance-applications-define.md) define who should have access to resources through access packages and entitlement management assignments. Changes can still occur outside those policies when administrators assign users directly to groups, when application owners create local accounts, or when scripts modify directory permissions. Reconciliation helps administrators understand where access is out of alignment, prevent drift where enforcement is available, and determine how to bring access back under governance.

## Access drift

Access drift is the divergence between governed access policies and actual resource assignments. Over time, unmanaged changes can create gaps where users retain access they no longer require or have permissions without policy authorization.

Access drift typically occurs through these patterns:

- **Unmanaged resource assignments**: A user is added directly to a group or enterprise application without an associated access package assignment or approval process.
- **Missing resource assignments**: A user has an active access package assignment, but the corresponding group membership or application assignment was removed or failed to apply.
- **Orphan and local accounts**: An account exists in a target application or directory without a corresponding identity or assignment in Microsoft Entra ID.

Unaddressed drift can undermine governance controls, complicate compliance auditing, and increase security risks across organizational resources.

## Reconciliation capabilities

Reconciliation capabilities help you answer two questions: where access is out of alignment, and how to bring access back into alignment.

- **Visibility** capabilities help you discover and monitor access that doesn't match your governance policies.
- **Enforcement and remediation** capabilities help you keep access aligned by preventing unauthorized changes or correcting drift after it occurs.

These categories aren't always sequential, and the right approach can vary by organization and by resource. An organization might use visibility to understand existing drift across many resources, use enforcement to prevent drift on sensitive resources, and use remediation when drift can't be prevented at the source.

## Visibility capabilities

Visibility capabilities show where actual access doesn't match governed access. Use visibility capabilities to find unmanaged access, missing assignments, and drift between governance policy and resource state.

### Account discovery in target applications

Account discovery evaluates target applications to find existing user accounts created before or outside of Microsoft Entra ID provisioning. The discovery process scans the target system and classifies accounts into three categories:

- **Local accounts**: Accounts in the target application that have no matching identity in Microsoft Entra ID.
- **Unassigned users**: Accounts that match a Microsoft Entra ID user who isn't currently assigned to the application.
- **Assigned users**: Accounts that match a Microsoft Entra ID user who is assigned and managed by the provisioning service.

Categorizing discovered accounts helps administrators onboard unmanaged accounts into governance workflows or remove obsolete access. For details on configuring account discovery, see [Discover identities in target applications with account discovery](../identity/app-provisioning/how-to-account-discovery.md).

### Access package drift detection

Access package drift detection evaluates entitlement management policies against the current state of directory objects. The report surfaces discrepancies across groups and enterprise applications, including:

- Microsoft Entra groups containing members who lack a corresponding access package assignment.
- Applications with application role assignments that lack a corresponding access package assignment.
- Active access package assignments where the expected group membership or application assignment is missing.

Administrators can review drift summaries in the Microsoft Entra admin center or export detailed reports for tenant-wide analysis. To learn how to review drift reports, see [View reports and logs in entitlement management](entitlement-management-reports.md#view-access-package-drift).

## Enforcement and remediation capabilities

Enforcement and remediation capabilities help keep actual access aligned with governance policies. These capabilities can work in two ways:

- **Preventive enforcement** blocks or audits unauthorized changes before drift occurs.
- **Corrective remediation** helps restore governed access after drift is detected in systems where direct prevention isn't available.

### Active Directory group enforcement

Active Directory group enforcement provides preventive reconciliation for on-premises groups synced through Microsoft Entra Cloud Sync. Instead of detecting drift after changes occur, group enforcement restricts write operations at the domain controller level.

When group enforcement is configured:

- The Active Directory domain controller validates Lightweight Directory Access Protocol (LDAP) write operations against policy security identifiers (SIDs).
- Unauthorized modifications to marked groups are blocked in Enforced mode or logged in Audit mode.
- Changes to designated groups must originate from the Microsoft Entra provisioning service.

Preventing direct modifications eliminates drift for protected on-premises groups. For configuration requirements, see [Configure Active Directory group enforcement in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-ad-group-enforcement.md).

## Next step

> [!div class="nextstepaction"]
> [View reports and logs in entitlement management](entitlement-management-reports.md#view-access-package-drift)

## Related content

- [What is entitlement management?](entitlement-management-overview.md)
- [Discover identities in target applications with account discovery](../identity/app-provisioning/how-to-account-discovery.md)
- [Configure Active Directory group enforcement in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-ad-group-enforcement.md)
