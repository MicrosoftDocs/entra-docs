---
title: Microsoft Entra ID Governance deployment guide to govern privileged identities
description: Learn how to govern privileged identities and their access in Microsoft Entra ID Governance.
author: gargi-sinha
manager: martinco
ms.service: entra-id-governance
ms.topic: concept-article
ms.date: 03/25/2025
ms.author: gasinh

#customer intent: I want to understand how to deploy Microsoft Entra ID Governance in my test and production environments.
---

# Microsoft Entra ID Governance deployment guide to govern privileged identities 

Deployment scenarios are guidance on how to combine and test Microsoft Security products and services. You can discover how capabilities work together to improve productivity, strengthen security, and more easily meet compliance and regulatory requirements. 

Use this scenario to help determine the need for Microsoft Entra ID Governance to create and grant access for your organization. Learn how to manage privileged identities and the access they request. 

The following products and services appear in this guide: 

* [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md)
* [Microsoft Entra ID](../fundamentals/whatis.md)
* [Microsoft Entra](../fundamentals/what-is-entra.md)
* [Privileged Identity Management (PIM)](../id-governance/privileged-identity-management/pim-configure.md)
* [PIM for Groups](../id-governance/privileged-identity-management/concept-pim-for-groups.md)
* [Discovery and insights](../id-governance/privileged-identity-management/pim-security-wizard.md)
* [Resource dashboards](../id-governance/privileged-identity-management/pim-resource-roles-overview-dashboards.md)
* [Microsoft Entra Conditional Access](../identity/conditional-access/overview.md)
* [Access reviews](../id-governance/access-reviews-overview.md)
* [Microsoft Azure](/azure/?product=popular)

## Timelines

Timelines show approximate delivery stage duration and are based on scenario complexity. Times are estimations and vary depending on the environment. 

1. Discovery and insights - 1 hour
2. Microsoft Entra ID roles - 1 hour
3. Azure roles - 1 hour
4. PIM for Groups - 1 hour
5. Access reviews - 1 hour
6. PIM and Conditional Access - 1 hour  

## Requirements

Ensure the following requirements are met.

* Identities with privileged roles that want services on-demand
* Approval-based just-in-time (JIT) administrative access activation to Azure resources
* Microsoft Entra ID roles and apps with group memberships
* Upon role activation, and privileged roles health check, require compliant devices, or authentication strengths 

### User lifecycle discovery

To prepare for the scenario, perform a discovery of current user lifecycle processes. 

* Collect available architectural diagrams
* Use a pilot user group
* Identify technical owners for remediation or investigation
* Enable an account on the target tenant with:
  * User Administrator,
  * Identity Governance Administrator,
  * Privileged Role Administrator, or 
  * Global Administrator

Learn more about [privileged roles and permissions in Microsoft Entra ID](../identity/role-based-access-control/privileged-roles-permissions.md).

## Privileged Identity Management

To manage, control, and monitor access to resources in your organization, use the Privileged Identity Management (PIM) service in Microsoft Entra ID: Microsoft Entra ID, Microsoft Azure, and other services such as [Microsoft 365](/microsoft-365/security/?view=o365-worldwide&preserve-view=true) or [Microsoft Intune](/mem/intune/). Also, you can manage and audit administrator roles. 

* See users assigned to privileged roles
* Enable on-demand, JIT administrative access
* Set up approval flows for privilege activation
* Get alerts and view administrator activation and actions, over time
* Use PIM for:
  * **Microsoft Entra ID directory roles** - Privileged roles manage Microsoft Entra ID and other Microsoft 365 online services
  * **Azure resource roles** - The role-based access control (RBAC) role that grants access to management groups, subscriptions, resource groups, and resources.
  * **Privileged access groups** - Use PIM for Groups to set up JIT access to members and owners in Microsoft Entra ID security groups, **or** 
  * Use the groups for Microsoft Entra ID role and Azure role assignments, also other permissions 

Learn how to [start using Privileged Identity Management](../id-governance/privileged-identity-management/pim-getting-started.md). 

### PIM assignment types

The two assignment types are eligible and active.  

* **Eligible** - Require members to activate the role before use or perform certain actions before role activation. Actions include multifactor authentication (MFA), business justification, or approval from approvers.
* **Active** - Don't require members to activate the role before use. Active members have privileges assigned ready to use. Use this assignment type for customers without PIM. 

Learn how to [assign roles in PIM](../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md). 

### Plan for PIM deployment

To mitigate risks of excessive, unnecessary, or misused access, use PIM for role activation. 

Learn how to [plan a PIM deployment](../id-governance/privileged-identity-management/pim-deployment-plan.md). 

### Discovery and insights

[Discovery and insights](../id-governance/privileged-identity-management/pim-security-wizard.md) in PIM are an analysis and action feature that shows privileged role assignments. Use it to change permanent role assignments into JIT assignments. Move users to Eligible status or you can remove them, as needed. Create access reviews for Global Administrators. Configure role settings such as: 

* Activation maximum duration
* MFA on activation
* Require Conditional Access authentication
* Require justification, ticket information, approval, and more
* Assign duration 

Learn how to [manage Microsoft Entra role assignments with PIM APIs](/graph/api/resources/privilegedidentitymanagementv3-overview?view=graph-rest-1.0&preserve-view=true).

### PIM for Azure roles

Azure resource role settings define role assignment properties. These properties include multifactor authentication and approval requirements for activation, assignment maximum duration, and notification settings. 

Learn to [configure Azure resource role settings in PIM](../id-governance/privileged-identity-management/pim-resource-roles-configure-role-settings.md), then how to [activate them](../id-governance/privileged-identity-management/pim-resource-roles-activate-your-roles.yml). 

## PIM for Groups

Use the discovery process to bring groups under management. Select eligible users for member or owner roles. Users activate eligible roles in the [Microsoft Entra admin center](https://entra.microsoft.com). 

### Role-assignable and non-role-assignable

You can enable PIM to manage administrative access to resources with role-assignable groups or Microsoft Entra roles. To manage privileged access risk, limit active access, manage access scope, and provide an auditable log of privileged access.  

**Role assignable**

* The Global Administrator, 
* Privileged Role Administrator, or
* Group Owner that manages the group
* No other roles can change active member credentials

**Non-role-assignable**

* More Microsoft Entra ID roles can manage the group
* Various roles can change active member credentials 

You can [assign administrative roles with PIM for Microsoft Entra roles](/graph/tutorial-assign-azureadroles?tabs=http&preserve-view=true).

### PIM for Groups considerations

Read the following details about using PIM for Groups:

* Role-assignable groups can't nest other groups
* Groups are a Microsoft Entra ID security group or a Microsoft 365 Group
* One group can be an eligible member of another group, even if one group is role-assignable
* A user is an active member of Group A, which is an eligible member of Group B, therefore users can activate membership in Group B.
  * Activation is for the user that requested the activation
  * Group A doesn't become a member of Group B 

### Resource dashboards

Use resource dashboards for access reviews in PIM.  

* Graphical representations of resource role activations
* Charts with distribution of role assignments by assignment type
* A data area with new role assignments 

Learn about [using a resource dashboard to perform an access review in PIM](../id-governance/privileged-identity-management/pim-resource-roles-overview-dashboards.md).  

### Access reviews in PIM

Use access reviews to: 

* Govern access to critical app, Microsoft Teams, and Office 365 groups
* Reduce access risk of Azure AD B2B guests
* Ensure users in privileged roles require permissions
* Review machine accounts with excessive access
* Manage Conditional Access policy exception lists 

In PIM, use access reviews to: 

* Automate discovery of stale roles assignments
* Review Azure and Microsoft Entra ID roles
* Remove users from a role after the access review 

Azure roles: 

* **Azure AD roles** - Assign role-assignable groups. When a review is created with role-assignable groups, the group name appears in the review without group membership expanded.
  * Approve or deny access for the group. When review results are applied, denied groups lose role assignment. 
* **Azure resource roles** - Assign a security group to the role. When a review is created with a security group assigned, the assigned user is expanded and visible to the reviewer.
  * Deny users assigned to the role, via the security group
  * Users aren't removed from the group, and the deny result is unsuccessful 

## PIM and Conditional Access integration

You can require eligible users to satisfy Conditional Access policy requirements using Conditional Access authentication context. Administrators can add security requirements through Conditional Access policies:  

* Require elevation only from [Intune-compliant device](/mem/intune/protect/compliance-policy-monitor)
* Enforce strong authentication methods, like phishing resistance 

For more information: 

* [Developer guide for Conditional Access authentication context](../identity-platform/developer-guide-conditional-access-authentication-context.md)
* [Require Conditional Access authentication context](/azure/active-directory/privileged-identity-management/pim-how-to-change-default-settings)
* [Monitor results of your Intune device-compliance policies](/mem/intune/protect/compliance-policy-monitor)

## Deploy PIM

1. [Discover Azure resources you want to manage in PIM](/azure/active-directory/privileged-identity-management/pim-resource-roles-discover-resources)
2. [Bring groups into PIM](/azure/active-directory/privileged-identity-management/groups-discover-groups)
3. [Learn role settings for Microsoft Entra ID roles](/azure/active-directory/privileged-identity-management/pim-how-to-change-default-settings)
4. [Learn role settings for Azure resource roles](/azure/active-directory/privileged-identity-management/pim-resource-roles-configure-role-settings)
5. [Enable group settings for PIM](/azure/active-directory/privileged-identity-management/groups-role-settings)
6. [Assign Microsoft Entra ID roles in PIM](/azure/active-directory/privileged-identity-management/pim-how-to-add-role-to-user)
7. [Assign Azure resources in PIM](/azure/active-directory/privileged-identity-management/pim-resource-roles-assign-roles)
8. [Assign Groups in PIM](/azure/active-directory/privileged-identity-management/groups-assign-member-owner)
9. [Activate Microsoft Entra ID roles in PIM](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role)
10. [Activate Azure resources in PIM](/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles)
11. [Activate groups in PIM](/azure/active-directory/privileged-identity-management/groups-activate-roles)
12. [Approve Microsoft Entra ID roles in PIM](/azure/active-directory/privileged-identity-management/pim-approval-workflow)
13. [Approve Azure resources in PIM](/azure/active-directory/privileged-identity-management/pim-resource-roles-approval-workflow)
14. [Approve Groups in PIM](/azure/active-directory/privileged-identity-management/groups-approval-workflow)
15. [Extend Microsoft Entra ID roles in PIM](/azure/active-directory/privileged-identity-management/pim-how-to-renew-extend)
16. [Extend Azure resources in PIM](/azure/active-directory/privileged-identity-management/pim-resource-roles-renew-extend)
17. [Extend groups in PIM](/azure/active-directory/privileged-identity-management/groups-renew-extend)
18. [Create an access review](/azure/active-directory/privileged-identity-management/pim-create-roles-and-resource-roles-review)
19. [Perform an access review](/azure/active-directory/privileged-identity-management/pim-perform-roles-and-resource-roles-review)

## Next steps

  * [Introduction to Microsoft Entra ID Governance deployment guide](governance-deployment-intro.md)
  * [Scenario 1: Employee lifecycle automation](governance-deployment-employee-lifecycle.md)
  * [Scenario 2: Assign employee access to resources](governance-deployment-employee-access.md)
  * [Scenario 3: Govern guest and partner access](governance-deployment-guest-access.md)
  * Scenario 4: Govern privileged identities and their access
