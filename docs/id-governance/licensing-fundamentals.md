---
title: 'Microsoft Entra ID Governance licensing fundamentals'
description: This article describes shows the licensing requirements for Microsoft Entra ID Governance features.
services: active-directory
documentationcenter: ''
author: billmath
manager: amycolannino
editor: ''
ms.service: active-directory
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.workload: identity
ms.date: 11/10/2023
ms.subservice: hybrid
ms.author: billmath
---

# Microsoft Entra ID Governance licensing fundamentals

The following tables show the licensing requirements for Microsoft Entra ID Governance features.

## Types of licenses

The following licenses are available for use with Microsoft Entra ID Governance in the commercial cloud.  The choice of licenses you need in a tenant depends on the features you're using in that tenant.

- **Free** - Included with Microsoft cloud subscriptions such as Microsoft Azure, Microsoft 365, and others.
- **Microsoft Entra ID P1** - Microsoft Entra ID P1 is available as a standalone product or included with Microsoft 365 E3 for enterprise customers and Microsoft 365 Business Premium for small to medium businesses. 
- **Microsoft Entra ID P2** - Microsoft Entra ID P2 is available as a standalone product or included with Microsoft 365 E5 for enterprise customers.
- **Microsoft Entra ID Governance** - Microsoft Entra ID Governance is an advanced set of identity governance capabilities available for Microsoft Entra ID P1 and P2 customers, as two products **Microsoft Entra ID Governance** and **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2**.  These products contain the basic identity governance capabilities that were in Microsoft Entra ID P2, and additional advanced identity governance capabilities. 

>[!NOTE]
>Some Microsoft Entra ID Governance scenarios can be configured to depend upon other features that aren't covered by Microsoft Entra ID Governance.  These features might have additional licensing requirements.  See [Governance capabilities in other Microsoft Entra features](identity-governance-overview.md#governance-capabilities-in-other-microsoft-entra-features) for more information on governance scenarios that rely on additional features.

Microsoft Entra ID Governance products aren't yet available in the US government or US national clouds.

### Governance products and prerequisites

The Microsoft Entra ID Governance capabilities are currently available in two products in the commercial cloud. These two products provide the same identity governance capabilities. The difference between the two products is that they have different prerequisites.

- A subscription to **Microsoft Entra ID Governance**, listed in the product terms as the **Entra ID Governance (User SL)** license, requires that the tenant also have an active subscription to another product, one that contains the `AAD_PREMIUM` or `AAD_PREMIUM_P2` service plan. Examples of products meeting this prerequisite include **Microsoft Entra ID P1**, **Microsoft 365 E3/E5/A3/A5/G3/G5**, **Enterprise Mobility + Security E3/E5** or **Microsoft 365 F1/F3**.
- A subscription to **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2**, listed in the product terms as the **Entra ID Governance P2** license, requires that the tenant also have an active subscription to another product, one that contains the `AAD_PREMIUM_P2` service plan.  Examples of products meeting this prerequisite include **Microsoft Entra ID P2**, **Microsoft 365 E5/A5/G5**, **Enterprise Mobility + Security E5**, **Microsoft 365 E5/F5 Security** or **Microsoft 365 F5 Security + Compliance**.

The [product names and service plan identifiers for licensing](~/identity/users/licensing-service-plan-reference.md) lists additional products that include the prerequisite service plans.

>[!NOTE]
>A subscription to a prerequisite for a Microsoft Entra ID Governance product must be active in the tenant. If a prerequisite is not present, or the subscription expires, then Microsoft Entra ID Governance scenarios might not function as expected.  

To check if the prerequisite products for a Microsoft Entra ID Governance product are present in a tenant, you can use the Microsoft Entra admin center or the Microsoft 365 admin center to view the list of products.

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as a global administrator.

1. In the **Identity** menu, expand **Billing** and select **Licenses**.

1. In the **Manage** menu, select **Licensed features**.  The information bar indicates the current Microsoft Entra ID license plan.

1. To view the existing products in the tenant, in the **Manage** menu, select **All products**.

## Starting a trial

A global administrator in a tenant that has an appropriate prerequisite product, such as Microsoft Entra ID P1, already purchased, and isn't already using or has previously trialed Microsoft Entra ID Governance, can request a trial of Microsoft Entra ID Governance in their tenant.

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home) as a global administrator.

1. In the **Billing** menu, select **Purchase services**.

1. In the **Search all product categories** box, type `"Microsoft Entra ID Governance"`.

1. Select **Details** below **Microsoft Entra ID Governance** to view the trial and purchase information for the product.  If your tenant has Microsoft Entra ID P2, then select  **Details** below **Microsoft Entra ID Governance Step-Up for Microsoft Entra ID P2**.

1. In the product details page, select **Start free trial**.


## Features by license

The following table shows what features are available with each license.  Not all features are available in all clouds; see [Microsoft Entra feature availability](~/identity/authentication/feature-availability.md) for Azure Government.

|Feature|Free|Microsoft Entra ID P1|Microsoft Entra ID P2|Microsoft Entra ID Governance|
|-----|:-----:|:-----:|:-----:|:-----:|
|[API-driven provisioning](../identity/app-provisioning/inbound-provisioning-api-concepts.md)|| :white_check_mark:  | :white_check_mark: | :white_check_mark: |
|[HR-driven provisioning](~/identity/app-provisioning/what-is-hr-driven-provisioning.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated user provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)| :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated group provisioning to SaaS apps](~/identity/saas-apps/tutorial-list.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Automated provisioning to on-premises apps](~/identity/app-provisioning/on-premises-application-provisioning-architecture.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Conditional Access - Terms of use attestation](~/identity/conditional-access/terms-of-use.md)|| :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Entitlement management - Basic entitlement management](entitlement-management-overview.md)||| :white_check_mark: | :white_check_mark: |  
|[Entitlement management - Conditional Access Scoping](entitlement-management-external-users.md#review-your-conditional-access-policies)||| :white_check_mark: | :white_check_mark: |
|[Entitlement management MyAccess Search](my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: |  
|[Entitlement management with Verified ID](entitlement-management-verified-id-settings.md)|||| :white_check_mark: |  
|[Entitlement management + Custom Extensions (Logic Apps)](entitlement-management-logic-apps-integration.md)|||| :white_check_mark: |  
|[Entitlement management + Auto Assignment Policies](entitlement-management-access-package-auto-assignment-policy.md)|||| :white_check_mark: |
|[Entitlement management - Directly Assign Any User(Preview)](entitlement-management-access-package-assignments.md#directly-assign-any-user-preview)|||| :white_check_mark: |
|[Entitlement management - Guest Conversion API](entitlement-management-access-package-manage-lifecycle.md)|||| :white_check_mark: |
|[Entitlement management - Grace Period(Preview)](entitlement-management-external-users.md#manage-the-lifecycle-of-external-users)||| :white_check_mark: | :white_check_mark: |  
|[My Access portal](my-access-portal-overview.md)||| :white_check_mark: | :white_check_mark: |
|[Entitlement management - Sponsors Policy(Preview)](entitlement-management-access-package-approval-policy.md)|||| :white_check_mark: |
|[Privileged Identity Management (PIM)](./privileged-identity-management/pim-configure.md)||| :white_check_mark: | :white_check_mark: |
|[PIM For Groups](./privileged-identity-management/concept-pim-for-groups.md)||| :white_check_mark: | :white_check_mark: |
|[PIM CA Controls](./privileged-identity-management/pim-configure.md)||| :white_check_mark: | :white_check_mark: |
|[Access Reviews - Basic access certifications and reviews](access-reviews-overview.md)||| :white_check_mark: | :white_check_mark: |
|[Access reviews - PIM For Groups(Preview)](create-access-review-pim-for-groups.md)|||| :white_check_mark: |
|[Access reviews - Inactive Users reviews](create-access-review.md)|||| :white_check_mark: |
|[Access Reviews - Inactive Users recommendations](review-recommendations-access-reviews.md#inactive-user-recommendations)||| :white_check_mark: | :white_check_mark: |
|[Access reviews - Machine learning assisted access certifications and reviews](review-recommendations-access-reviews.md#user-to-group-affiliation)|||| :white_check_mark: |
|[Lifecycle Workflows (LCW)](what-are-lifecycle-workflows.md)|||| :white_check_mark: |
|[LCW + Custom Extensions (Logic Apps)](lifecycle-workflow-extensibility.md)|||| :white_check_mark: |
|[Identity governance dashboard (Preview)](governance-dashboard.md)| | :white_check_mark: | :white_check_mark: | :white_check_mark: |
|[Insights and reporting - Inactive guest accounts(Preview)](~/identity/users/clean-up-stale-guest-accounts.md)|||| :white_check_mark: |

## Entitlement Management

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users. Some capabilities within this feature can operate with a Microsoft Entra ID P2 subscription.

### Example license scenarios

Here are some example license scenarios to help you determine the number of licenses you must have.

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| An Identity Governance Administrator at Woodgrove Bank creates initial catalogs. One of the policies specifies that **All employees** (2,000 employees) can request a specific set of access packages. 150 employees request the access packages. | 2,000 employees who **can** request the access packages | 2,000 |
| An Identity Governance Administrator at Woodgrove Bank creates initial catalogs. One of the policies specifies that **All employees** (2,000 employees) can request a specific set of access packages. 150 employees request the access packages. | 2,000 employees need licenses. | 2,000 |
| An Identity Governance Administrator at Woodgrove Bank creates initial catalogs. They create an auto-assignment policy that grants **All members of the Sales department** (350 employees) access to a specific set of access packages. 350 employees are auto-assigned to the access packages. | 350 employees need licenses. | 351 |

## Access reviews

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users, including for all employees who are reviewing access or having their access reviewed. Some capabilities within this feature may operate with a Microsoft Entra ID P2 subscription.

### Example license scenarios

Here are some example license scenarios to help you determine the number of licenses you must have.

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| An administrator creates an access review of Group A with 75 users and 1 group owner, and assigns the group owner as the reviewer. | 1 license for the group owner as reviewer, and 75 licenses for the 75 users. | 76 |
| An administrator creates an access review of Group B with 500 users and 3 group owners, and assigns the 3 group owners as reviewers. | 500 licenses for users, and 3 licenses for each group owner as reviewers. | 503 |
| An administrator creates an access review of Group B with 500 users. Makes it a self-review. | 500 licenses for each user as self-reviewers  | 500 |
| An administrator creates an access review of Group C with 50 member users. Makes it a self-review. | 50 licenses for each user as self-reviewers. | 50 |
| An administrator creates an access review of Group D with 6 member users. Makes it a self-review. | 6 licenses for each user as self-reviewers. No additional licenses are required.  | 6 |

## Lifecycle Workflows


With Microsoft Entra ID Governance licenses for Lifecycle Workflows, you can:

- Create, manage, and delete workflows up to the total limit of 50 workflows.
- Trigger on-demand and scheduled workflow execution.
- Manage and configure existing tasks to create workflows that are specific to your needs.
- Create up to 100 custom task extensions to be used in your workflows.

Using this feature requires Microsoft Entra ID Governance subscriptions for your organization's users.

### Example license scenarios

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| A Lifecycle Workflows Administrator creates a workflow to add new hires in the Marketing department to the Marketing teams group. 250 new hires are assigned to the Marketing teams group via this workflow. | 1 license for the Lifecycle Workflows Administrator, and 250 licenses for the users. | 251 |
| A Lifecycle Workflows Administrator creates a workflow to pre-offboard a group of employees before their last day of employment. The scope of users who will be pre-offboarded are 40 users. | 40 licenses for users, and 1 license for the Lifecycle Workflows Administrator. | 41 |

## Privileged Identity Management

### Example license scenarios

Here are some example license scenarios to help you determine the number of licenses you must have.

| Scenario | Calculation | Number of licenses |
| --- | --- | --- |
| Woodgrove Bank has 10 administrators for different departments and 2 Identity Governance Administrators that configure and manage PIM. They make five administrators eligible. | Five licenses for the administrators who are eligible | 5 |
| Graphic Design Institute has 25 administrators of which 14 are managed through PIM. Role activation requires approval and there are three different users in the organization who can approve activations. | 14 licenses for the eligible roles + three approvers | 17 |
| Contoso has 50 administrators of which 42 are managed through PIM. Role activation requires approval and there are five different users in the organization who can approve activations. Contoso also does monthly reviews of users assigned to administrator roles and reviewers are the users’ managers of which six aren't in administrator roles managed by PIM. | 42 licenses for the eligible roles + five approvers + six reviewers | 53 |

## API-driven provisioning

This feature is available with Microsoft Entra ID P1, P2 and Microsoft Entra ID Governance subscriptions. A subscription license is required for every identity that is sourced using the [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API and provisioned to either on-premises Active Directory or Microsoft Entra ID.

### License scenarios


|Customer License  |Usage limits enforced at tenant level for API-driven provisioning  |
|---------|---------|
|Microsoft Entra ID P1 or P2      |   Daily usage quota (number of user records that can be uploaded over 24-hour period): **100K user records (2000 /bulkUpload API calls with each request containing max of 50 records)**.<br><br>Max number of API-driven provisioning jobs for each flow: 2<br>o Max 2 apps for API-driven provisioning to on-premises Active Directory.<br>o Max 2 apps for API-driven provisioning to Microsoft Entra ID.      |
|Microsoft Entra ID Governance alongside Microsoft Entra ID P1 or P2     | Daily usage quota (number of user records that can be uploaded over 24-hour period): **300K user records  (6000 /bulkUpload API calls with each request containing max of 50 records)**.<br><br>Max number of API-driven provisioning jobs for each flow: 20<br>o Max 20 apps for API-driven provisioning to on-premises Active Directory.<br>o Max 20 apps for API-driven provisioning to Microsoft Entra ID.        |



## Licensing FAQs

### Do licenses need to be assigned to users to use Identity Governance features?

Users don't need to be assigned a Microsoft Entra ID Governance license, but there needs to be as many license seats to include all users in scope of, or who configures, the Identity Governance features.

### How can I license usage of Microsoft Entra ID Governance features for business guests?

All users who are in scope of Microsoft Entra ID Governance features, including business guests such as contractors, partners, and external collaborators, need a license.  We're creating a new Microsoft Entra ID Governance license for business guests. This license will operate on a monthly active usage (MAU) model. Customers will be able to acquire licenses matching their anticipated business guest MAU.

We anticipate making these licenses available in spring 2024. In the interim, organizations that govern the identities of their employees with Microsoft Entra ID Governance can govern the identities of their business guests for no additional cost. At this time, existing customers of Microsoft Entra ID P1 or P2 with Microsoft Entra External ID can continue using the subset of features that are included in P1 or P2 with their business guests through their Microsoft Entra External ID license.

For more information, see: [Microsoft Entra ID Governance licensing for business guests](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/microsoft-entra-id-governance-licensing-for-business-guests/ba-p/3575579).


### What happens when a PIM license expires?

If a Microsoft Entra ID P2, Microsoft Entra ID Governance, or trial license expires, Privileged Identity Management features will no longer be available in your directory:

- Permanent role assignments to Azure AD roles are unaffected.
- The Privileged Identity Management service in the Azure portal, and the Graph API cmdlets and PowerShell interfaces of Privileged Identity Management, will no longer be available for users to activate privileged roles, manage privileged access, or perform access reviews of privileged roles.
- Eligible role assignments of Azure AD roles will be removed, as users will no longer be able to activate privileged roles.
- Any ongoing access reviews of Azure AD roles will end, and Privileged Identity Management configuration settings are removed.
- Privileged Identity Management will no longer send emails on role assignment changes.


## Next steps

- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)
