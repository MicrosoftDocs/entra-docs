---
title: include file
description: include file
author: owinfreyATL
ms.service: entra-id
ms.topic: include
ms.date: 03/27/2026
ms.author: owinfrey
ms.custom: include file
---

The following table shows the licensing requirements for Microsoft Entra ID Governance features for member users. Microsoft Entra Suite includes all features of Microsoft Entra ID Governance. Microsoft 365 E7 also includes all ID Governance features through the Entra Suite and Agent 365. Licensing information for Entitlement management, Access reviews, and Lifecycle Workflows are provided following the table.

### Features by license

The following table shows what features associated with identity governance are available with each license. For more information on other features, see [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing). Not all features are available in all clouds; see [Microsoft Entra feature availability](~/identity/authentication/feature-availability.md) for Azure Government.

|Feature|Free|Microsoft Entra ID P1|Microsoft Entra ID P2|Microsoft Entra ID Governance|Microsoft Entra Suite|Microsoft Agent 365|Microsoft 365 E7|
|-----|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
|**Provisioning**||||||||
|[API-driven provisioning](~/identity/app-provisioning/inbound-provisioning-api-concepts.md)|| :white_check_mark:  | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[HR-driven provisioning](~/identity/app-provisioning/what-is-hr-driven-provisioning.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Account Discovery](~/identity/app-provisioning/how-to-account-discovery.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Automated user provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Automated group provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Automated provisioning to on-premises apps](~/identity/app-provisioning/on-premises-application-provisioning-architecture.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Cross-tenant synchronization for users (same cloud)](~/identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md?pivots=cross-cloud-synchronization)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Cross-tenant synchronization for groups (same cloud)](~/identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md?pivots=cross-cloud-synchronization)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Cross-cloud synchronization](~/identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md?pivots=cross-cloud-synchronization)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**Lifecycle Workflows (LCW)**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[LCW + Custom Extensions (Logic Apps)](~/id-governance/lifecycle-workflow-extensibility.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[LCW + Agent Sponsorship tasks](~/id-governance/agent-sponsor-tasks.md)|||||| :white_check_mark: | :white_check_mark: |
|**Access reviews (AR)**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** | **Microsoft 365 E7**|
|[AR - Capabilities previously generally available in Microsoft Entra ID P2](~/id-governance/access-reviews-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - PIM For Groups (Preview)](~/id-governance/create-access-review-pim-for-groups.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - Reviews scoped to inactive users without active users in the review](~/id-governance/create-access-review.md#scope)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - Reviews scoped to active and inactive users with review decision helpers for inactive users for the reviewer](~/id-governance/review-recommendations-access-reviews.md#inactive-user-recommendations)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - Machine learning assisted access certifications and reviews](~/id-governance/review-recommendations-access-reviews.md#user-to-group-affiliation)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - Catalog Access Reviews](~/id-governance/catalog-access-reviews.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[AR - Custom data provided resource](~/id-governance/custom-data-resource-access-reviews.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**Entitlement management (EM)**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[EM - Capabilities previously generally available in Microsoft Entra ID P2](~/id-governance/entitlement-management-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Users assigned to access packages](~/id-governance/entitlement-management-access-package-create.md#allow-users-service-principals-and-agent-identities-in-your-directory-to-request-the-access-package)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Agents and service principals assigned to access packages](~/id-governance/entitlement-management-access-package-create.md#allow-users-service-principals-and-agent-identities-in-your-directory-to-request-the-access-package)|||||| :white_check_mark: | :white_check_mark: |
|[EM - Users request access for themselves](~/id-governance/entitlement-management-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Admins directly assign a user assignments(including guests)](~/id-governance/entitlement-management-access-package-assignments.md#directly-assign-an-identity)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Admins directly assign agents and service principals](../id-governance/entitlement-management-access-package-assignments.md#directly-assign-any-identity)|||||| :white_check_mark: | :white_check_mark: |
|[EM - Admins directly assign any user - via email address for users not yet in your directory](~/id-governance/entitlement-management-access-package-assignments.md#directly-assign-any-identity)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Managers requesting on behalf of employees](~/id-governance/entitlement-management-request-behalf.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Owners and sponsors request access on behalf of their agents or service principals](~/id-governance/entitlement-management-request-behalf.md#scenarios-for-requesting-on-behalf-of-agent-identities)|||||| :white_check_mark: | :white_check_mark: |
|**EM - Supported resources**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[EM - Groups and teams in access packages](~/id-governance/entitlement-management-access-package-resources.md#add-a-group-or-team-resource-role)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Eligible group ownerships and memberships in access packages (PIM for Groups)](~/id-governance/entitlement-management-access-package-eligible.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Applications in access packages](~/id-governance/entitlement-management-access-package-resources.md#add-an-application-resource-role)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - SharePoint sites in access packages](~/id-governance/entitlement-management-access-package-resources.md#add-a-sharepoint-site-resource-role)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Microsoft Entra Roles (Preview)](~/id-governance/entitlement-management-roles.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - SAP Identity Access Governance (IAG) business roles (Preview)](~/id-governance/entitlement-management-sap-integration.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - API permissions in access packages](~/id-governance/entitlement-management-access-package-resources.md#add-an-api-permission)|||||| :white_check_mark: | :white_check_mark: |
|**EM - Approval options**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[EM - Multi-stage approvals with alternate approvers if no action is taken](~/id-governance/entitlement-management-access-package-approval-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[EM - Specific approvers](~/id-governance/entitlement-management-access-package-approval-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[EM - Managers as approvers](~/id-governance/entitlement-management-access-package-approval-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Internal sponsors as approvers (from assignees' connected organizations)](~/id-governance/entitlement-management-access-package-approval-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - External sponsors as approvers (from assignees' connected organizations)](~/id-governance/entitlement-management-access-package-approval-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Sponsors as approvers (from assignees' user profile)](~/id-governance/entitlement-management-access-package-approval-policy.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Agent Sponsors as approvers](~/id-governance/entitlement-management-access-package-approval-policy.md)|||||| :white_check_mark: | :white_check_mark: |
|[EM - Externally determine approval requirements using custom extensions](~/id-governance/entitlement-management-dynamic-approval.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Collect additional requestor information for approval](~/id-governance/entitlement-management-access-package-approval-policy.md#collect-additional-requestor-information-for-approval)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**EM - Lifecycle**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[EM - Expiration of access package assignments](~/id-governance/entitlement-management-access-package-lifecycle-policy.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[EM - Manage the lifecycle of external users](~/id-governance/entitlement-management-external-users.md#manage-the-lifecycle-of-external-users)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Mark guest as governed](~/id-governance/entitlement-management-access-package-manage-lifecycle.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**EM - Additional capabilities**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[EM - Separation of duties](~/id-governance/entitlement-management-access-package-incompatible.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Custom Extensions (Logic Apps)](~/id-governance/entitlement-management-logic-apps-integration.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Auto Assignment Policies](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Verified ID integration](~/id-governance/entitlement-management-verified-id-settings.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Microsoft Entra ID Protection integration](~/id-governance/entitlement-management-configure-id-protection-approvals.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Microsoft Purview Insider Risk Management integration](~/id-governance/entitlement-management-configure-insider-risk-management-approvals.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Conditional Access Scoping](~/id-governance/entitlement-management-external-users.md#review-your-conditional-access-policies)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**My Access**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[My Access portal](~/id-governance/my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[EM - My Access Search](~/id-governance/my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[EM - Suggested access packages in My Access](~/id-governance/entitlement-management-suggested-access-packages.md)||| | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Configure whether requestors can see approver details in My Access (Preview)](~/id-governance/my-access-approver-details.md)||| | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[EM - Delegate approvals in My Access (Preview)](~/id-governance/my-access-portal-overview.md)||| | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**Privileged Identity Management (PIM)**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[PIM For Groups](~/id-governance/privileged-identity-management/concept-pim-for-groups.md)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[PIM Conditional Access Controls](../id-governance/privileged-identity-management/pim-how-to-change-default-settings.md#on-activation-require-microsoft-entra-conditional-access-authentication-context)||| :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[PIM - Custom extensions for role activation (Preview)](/entra/id-governance/privileged-identity-management/privileged-identity-management-custom-extensions)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|**Other**|**Free**|**Microsoft Entra ID P1**|**Microsoft Entra ID P2**|**Microsoft Entra ID Governance**| **Microsoft Entra Suite** | **Microsoft Agent 365** |**Microsoft 365 E7**|
|[Identity governance dashboard](~/id-governance/governance-dashboard.md)| | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Insights and reporting - Inactive guest accounts](~/identity/users/clean-up-stale-guest-accounts.md)|||| :white_check_mark: | :white_check_mark: || :white_check_mark: |
|[Conditional Access - Terms of use attestation](~/identity/conditional-access/terms-of-use.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: || :white_check_mark: |

### Entitlement Management

Using this feature requires a Microsoft Entra ID Governance subscription for your organization's member users. Some capabilities within this feature can operate with a Microsoft Entra ID P2 subscription. Some capabilities within this feature require guest billing.

### Access reviews

Using this feature requires a Microsoft Entra ID Governance subscription for your organization's member users, including for all employees who are reviewing access or having their access reviewed. Some capabilities within this feature might operate with a Microsoft Entra ID P2 subscription. Some capabilities within this feature require guest billing.

### Lifecycle Workflows

With Microsoft Entra ID Governance licenses for Lifecycle Workflows, you can:

- Create, manage, and delete workflows up to the total limit of 50 workflows.
- Trigger on-demand and scheduled workflow execution.
- Manage and configure existing tasks to create workflows that are specific to your needs.
- Create up to 100 custom task extensions to be used in your workflows.

Using this feature requires a Microsoft Entra ID Governance subscription for your organization's member users. Some capabilities within this feature require guest billing.
