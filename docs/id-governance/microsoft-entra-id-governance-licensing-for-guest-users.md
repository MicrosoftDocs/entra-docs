---
title: Microsoft Entra ID Governance Licensing for Guest Users 
description: Learn how Microsoft Entra ID is licensed for guest users.
author: owinfreyatl
manager: dougeby
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: reference
ms.date: 06/05/2025
ms.author: owinfrey
ms.reviewer: jercon
---

# Microsoft Entra ID Governance Licensing for Guest Users

This article outlines the pricing structure for Microsoft Entra Governance ID for guests add-on and describes how to link your tenant to an Azure subscription to ensure correct billing and feature access.

## Monthly active users (MAU) billing model

Microsoft Entra ID Governance utilizes Monthly Active User (MAU) licensing for guest users which is different than licensing for employees. See [Microsoft Entra ID Governance licensing fundamentals](/entra/id-governance/licensing-fundamentals) for complete details on licensing for employees.

Under the guest billing model, guests are identified by a userType of **Guest** regardless of where the user authenticates. A userType of **Guest** is the default userType for all B2B invitation methods and can also be set by an Identity administrator. The bill for each month will include a record for each guest user with one or more governance actions in that month. See the Azure pricing page for pricing details.

## Billable governance features

Guest users are only billed when they actively use features that are exclusive to Microsoft Entra ID Governance. Features included with Microsoft Entra P2 are not billed. Additionally, if a guest does not take any active governance-related action during a month—such as in cases where access was auto-assigned in a prior month—they will not be billed for that month.

You can identify actions that will be billed to the Microsoft Entra ID Governance for guests add-on by looking at your audit logs. Specifically, each billable action will have these properties included:

1. TargetId: object ID of the target user

1. TargetUserType: Guest

1. GovernanceLicenseFeatureUsed: True

Below is a list of currently billable actions for **guest users**. Note that this list may change as additional features are added to Microsoft Entra ID Governance.


| Service  | Action | Billable event & API  | Audit Log Where TargetUserType is Guest and GovernanceLicenseFeatureUsed is True  |
|----------|----------|----------|----------|
| Entitlement Management  | [Request access package on-behalf-of other users](entitlement-management-request-behalf.md)  | Bill on successful request creation. User requests or updates an access package assignment on-behalf-of another user.<br> **API**<br> https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/assignmentRequests when the requestor (manager) is extracted from the token, and the target object is determined by the id of the direct employee who is receiving access.  | User requests access package assignment, Create access package assignment user update request   |
| Entitlement Management  | [Guest is assigned to an Entra role assignment](entitlement-management-roles.md)  | Bill on successful request creation when a Microsoft Entra role is included in the access package.<br>**API**<br> https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/assignmentRequests when the access package contains a Microsoft Entra role.   | User requests access package assignment, Create access package assignment user update request   |
| Entitlement Management  | [Sponsor policy is applied to assignment](entitlement-management-access-package-create.md)  | Row 3C3  | User requests access package assignment, Create access package assignment user update request   |
| Entitlement Management  | [EM – PIM for groups](create-access-review-pim-for-groups.md) | Row 4C3  | User requests access package assignment, Create access package assignment user update request.  |
| Entitlement Management  | [Guest uses verified ID for request](entitlement-management-verified-id-settings.md)  | Row 5C3  | User requests access package assignment, Create access package assignment user update request.  |
| Entitlement Management  | [Guest policy assigned with custom extension](entitlement-management-logic-apps-integration.md) | Row 6C3  | User requests access package assignment, Create access package assignment user update request.  |
| Entitlement Management| [Guest is granted an auto-assignment policy](entitlement-management-access-package-auto-assignment-policy.md)  | Row 7C3  | Entitlement Management creates access package assignment request for user.  |
| Entitlement Management  | [Directly assign any user](entitlement-management-access-package-assignments.md#directly-assign-any-user-preview)  | Row 8C3  | Administrator directly assigns user to access package.  |
| Entitlement Management |[Mark guest as governed](entitlement-management-access-package-manage-lifecycle.md)  | Row 9C3  | Update access package user lifecycle. |
| Lifecycle Workflows   | [Workflow is run for guest](what-are-lifecycle-workflows.md) | Row 10C3 | Workflow execution started for user.  |
| Access Reviews   | [Access Review – machine learning assisted access reviews](review-recommendations-access-reviews.md#user-to-group-affiliation) | Row 11C3 | Available after 8/1/2025  |
| Access Reviews    | [Access Review – inactive users](review-recommendations-access-reviews.md#inactive-user-recommendations) | Row 12C3 | Available after 8/1/2025  |


## Guest billing in multi-tenant organizations

Governance guest billing will only apply for users with a userType of
**guest**, so if Entra ID Governance licensed member users are brought
into additional organization tenants with a userType of **member**, they
will not accrue to the billing meter.

If these users are brought in with a userType of **guest** they will
accrue to the meter, however you can avoid being charged by setting up
or joining a multitenant organization. If the guest user is from a
participating organizational tenant, the guest will not accrue to the
billing meter. See [Set up a multitenant org in Microsoft
365](/microsoft-365/enterprise/set-up-multi-tenant-org?view=o365-worldwide).

## Billing examples

### **Scenario 1: Automating access package assignments**

**March**: 

- Contoso creates an auto-assignment policy that assigns an access package to 500 guest users.

- Contoso IT runs the guest conversion API for another set of 500 guest users.

- Billing: For March, Contoso will be billed for 1,000 total guest users: 500 users for the auto-assignment policy and 500 users for the guest conversion API.  

**April**: 

- The 500 guest users who were auto-assigned an access package in March retain their assignments but are not billed since there was not an explicit action taken on these users in April. 

- Additionally, Contoso IT runs an inactive access review on 100 guests.

- Billing: For April, Contoso is billed for 100 users for the inactive access review.  

### **Scenario 2: Lifecycle workflow and access review for inactive users**

**March**:

- Fabrikam executes a lifecycle workflow for 300 guest users.

- They also perform an access review for inactive users, targeting 100 of the same guests as above, plus a different set of 200 guests.

- Billing: For March, Fabrikam is billed for 300 users for the lifecycle workflow and 200 users for the inactive access review.Note that since 100 of the guest users already incurred a charge for the lifecycle workflow, they did not incur any additional charge for the inactive user review, since each guest user will only be charged once for one or more governance actions in the month. 

**April**:

- From the second group of 200 guest users in March, 150 guests receive an auto-assigned access package that grants access to an app and have the same inactive user access review that was run in March, repeated in April.

- Billing: For April, Fabrikam is billed for 150 users and they are not charged for the access package auto-assignment action, since these 150 guests have already been charged for April.

### Link your tenant to a subscription

Your tenants must be linked to an Azure subscription for proper billing
and access to features. To link your tenant to a sweubscription, follow
these steps.

1.  Sign in to the [Microsoft Entra admin
    center](https://entra.microsoft.com/) with an account that has at
    least the Contributor role within the subscription or a resource
    group within the subscription.

2.  Select the directory you want to link: In the Microsoft Entra admin
    center toolbar, select the **Settings** icon in the portal toolbar.
    Then on the **Portal settings \| Directories + subscriptions** page,
    find your workforce tenant in the **Directory name** list, and then
    select **Switch**.

3.  Browse to **Entra ID** > **Identity Governance** > **Dashboard**.

4.  On the governance dashboard, locate the guest governance panel and
    select **Get Started**.

5.  In the **Link a subscription** pane, select a **Subscription** and
    a **Resource group**. Then select **Turn on**.

After you complete these steps, your Azure subscription is billed based
on your Azure Direct or Enterprise Agreement details, if applicable.

## What if I can't find a subscription?

If no subscriptions are available in the **Link a subscription** pane,
here are some possible reasons:

- You don't have the appropriate permissions. Be sure to sign in with an
  Azure account that has at least the Contributor role within the
  subscription or a resource group within the subscription.

- A subscription exists, but it isn't associated with your directory
  yet. You can [associate an existing subscription to your
  tenant](https://learn.microsoft.com/en-us/entra/fundamentals/how-subscriptions-associated-directory) and
  then repeat the steps for [linking it to your
  tenant](https://learn.microsoft.com/en-us/entra/external-id/external-identities-pricing#link-your-azure-ad-tenant-to-a-subscription).

- No subscription exists. In the **Link a subscription** pane, you can
  create a subscription by selecting the link **if you don't already
  have a subscription you may create one here**. After you create a new
  subscription, you'll need to [create a resource
  group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal) in
  the new subscription, and then repeat the steps for [linking it to
  your
  tenant](https://learn.microsoft.com/en-us/entra/external-id/external-identities-pricing#link-your-azure-ad-tenant-to-a-subscription).

## Turn off guest billing

You can turn off governance guest billing by returning to the governance
dashboard and selecting **Edit** on the guest governance panel. In the
Edit Guest Access panel, select “Turn Off” to disable billing and Entra
ID Governance features for your guest users.

## Guest user licensing FAQs

**Do I need to have a subscription to Microsoft Entra ID Governance or
Microsoft Entra Suite if I only want to govern guests?**

Yes. While you don’t need a subscription for your guest users, you will
need to have at least one Microsoft Entra ID Governance or Microsoft
Entra Suite license for an administrator in the tenant.

**I have been using access reviews and entitlement management features
included in Microsoft Entra P2 for my guest users. Will I start getting
billed for this usage?**

Governance features included with Microsoft Entra P2 including basic
access reviews and entitlement management capabilities will not be
billed to the governance guest add-on. Only governance features that are
exclusive to Entra Suite or standalone Entra ID Governance will be
billed to the meter. See the table above for details.
