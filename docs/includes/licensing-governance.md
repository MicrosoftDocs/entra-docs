---
title: include file
description: include file
author: billmath
ms.service: entra-id
ms.topic: include
ms.date: 06/24/2024
ms.author: billmath
ms.custom: include file
---

The following table shows the licensing requirements for Microsoft Entra ID Governance features. Microsoft Entra Suite includes all features of Microsoft Entra ID Governance. Licensing information and example license scenarios for Entitlement management, Access reviews, and Lifecycle Workflows are provided following the table.

### Features by license

The following table shows what features associated with identity governance are available with each license. For more information on other features, see [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing). Not all features are available in all clouds; see [Microsoft Entra feature availability](~/identity/authentication/feature-availability.md) for Azure Government.

|Feature|Free|Microsoft Entra ID P1|Microsoft Entra ID P2|Microsoft Entra ID Governance| Microsoft Entra Suite |
|-----|:-----:|:-----:|:-----:|:-----:|:-----:|
|[Access Review Agent](~/id-governance/access-review-agent.md)|| | | :white_check_mark: | |
|[API-driven provisioning](~/identity/app-provisioning/inbound-provisioning-api-concepts.md)|| :white_check_mark:  | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[HR-driven provisioning](~/identity/app-provisioning/what-is-hr-driven-provisioning.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated user provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated group provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated provisioning to on-premises apps](~/identity/app-provisioning/on-premises-application-provisioning-architecture.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Conditional Access - Terms of use attestation](~/identity/conditional-access/terms-of-use.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management - Capabilities previously generally available in Microsoft Entra ID P2](~/id-governance/entitlement-management-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management - Conditional Access Scoping](~/id-governance/entitlement-management-external-users.md#review-your-conditional-access-policies)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management MyAccess Search](~/id-governance/my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management with Verified ID](~/id-governance/entitlement-management-verified-id-settings.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Custom Extensions (Logic Apps)](~/id-governance/entitlement-management-logic-apps-integration.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Auto Assignment Policies](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Directly Assign Any User (Preview)](~/id-governance/entitlement-management-access-package-assignments.md#directly-assign-any-user-preview)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Mark guest as governed](~/id-governance/entitlement-management-access-package-manage-lifecycle.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Manage the lifecycle of external users](~/id-governance/entitlement-management-external-users.md#manage-the-lifecycle-of-external-users)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[My Access portal](~/id-governance/my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management - Microsoft Entra Roles (Preview)](~/id-governance/entitlement-management-roles.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Request access packages on-behalf-of (Preview)](~/id-governance/entitlement-management-request-behalf.md)|||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Sponsors Policy](~/id-governance/entitlement-management-access-package-create.md)|||| :white_check_mark: | :white_check_mark: |
|[Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[PIM For Groups](~/id-governance/privileged-identity-management/concept-pim-for-groups.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[PIM Conditional Access Controls](../id-governance/privileged-identity-management/pim-how-to-change-default-settings.md#on-activation-require-microsoft-entra-conditional-access-authentication-context)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Access reviews - Capabilities previously generally available in Microsoft Entra ID P2](~/id-governance/access-reviews-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Access reviews - PIM For Groups (Preview)](~/id-governance/create-access-review-pim-for-groups.md)|||| :white_check_mark: | :white_check_mark: |
|[Access reviews - Inactive Users reviews](~/id-governance/create-access-review.md)|||| :white_check_mark: | :white_check_mark: |
|[Access Reviews - Inactive Users recommendations](~/id-governance/review-recommendations-access-reviews.md#inactive-user-recommendations)||| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Access reviews - Machine learning assisted access certifications and reviews](~/id-governance/review-recommendations-access-reviews.md#user-to-group-affiliation)|||| :white_check_mark: | :white_check_mark: |
|[Lifecycle Workflows (LCW)](~/id-governance/what-are-lifecycle-workflows.md)|||| :white_check_mark: | :white_check_mark: |
|[LCW + Custom Extensions (Logic Apps)](~/id-governance/lifecycle-workflow-extensibility.md)|||| :white_check_mark: | :white_check_mark: |
|[Identity governance dashboard](~/id-governance/governance-dashboard.md)| | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Insights and reporting - Inactive guest accounts](~/identity/users/clean-up-stale-guest-accounts.md)|||| :white_check_mark: | :white_check_mark: |
|[Cross-cloud synchronization](~/identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md?pivots=cross-cloud-synchronization)|||| :white_check_mark: | :white_check_mark: |

### Entitlement Management

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users. Some capabilities within this feature can operate with a Microsoft Entra ID P2 subscription.

#### Example license scenarios

Here are some example license scenarios to help you determine the number of licenses you must have.

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| An Identity Governance Administrator at Woodgrove Bank creates initial catalogs. One of the policies specifies that **All employees** (2,000 employees) can request a specific set of access packages. 150 employees request the access packages. | 2,000 employees who **can** request the access packages | 2,000 |
| An Identity Governance Administrator at Woodgrove Bank creates initial catalogs. They create an auto-assignment policy that grants **All members of the Sales department** (350 employees) access to a specific set of access packages. 350 employees are auto-assigned to the access packages. | 350 employees need licenses. | 351 |

### Access reviews

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users, including for all employees who are reviewing access or having their access reviewed. Some capabilities within this feature might operate with a Microsoft Entra ID P2 subscription.

#### Example license scenarios

Here are some example license scenarios to help you determine the number of licenses you must have.

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| An administrator creates an access review of Group A with 75 users and 1 group owner, and assigns the group owner as the reviewer. | 1 license for the group owner as reviewer, and 75 licenses for the 75 users. | 76 |
| An administrator creates an access review of Group B with 500 users and 3 group owners, and assigns the 3 group owners as reviewers. | 500 licenses for users, and 3 licenses for each group owner as reviewers. | 503 |
| An administrator creates an access review of Group B with 500 users. Makes it a self-review. | 500 licenses for each user as self-reviewers  | 500 |
| An administrator creates an access review of Group C with 50 member users. Makes it a self-review. | 50 licenses for each user as self-reviewers. | 50 |
| An administrator creates an access review of Group D with 6 member users. Makes it a self-review. | 6 licenses for each user as self-reviewers. No additional licenses are required.  | 6 |

### Lifecycle Workflows

With Microsoft Entra ID Governance licenses for Lifecycle Workflows, you can:

- Create, manage, and delete workflows up to the total limit of 50 workflows.
- Trigger on-demand and scheduled workflow execution.
- Manage and configure existing tasks to create workflows that are specific to your needs.
- Create up to 100 custom task extensions to be used in your workflows.

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users.

#### Example license scenarios

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| A Lifecycle Workflows Administrator creates a workflow to add new hires in the Marketing department to the Marketing teams group. 250 new hires are assigned to the Marketing teams group via this workflow once. Other 150 new hires are assigned to the Marketing teams group via this workflow later the same year. | 1 license for the Lifecycle Workflows Administrator, and 400 licenses for the users. | 401 |
| A Lifecycle Workflows Administrator creates a workflow to pre-offboard a group of employees before their last day of employment. The scope of users who will be pre-offboarded are 40 users once.  We offboard 40 licensed users.  Now, we can re-assign these 40 licenses and assign 10 more licenses later in the year to pre-offboard 50 more users.| 50 licenses for users, and 1 license for the Lifecycle Workflows Administrator. | 51 |
