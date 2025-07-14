---
title: Microsoft Entra ID Governance operations reference guide
description: This operations reference guide describes the checks and actions you should take to secure governance management
author: martincoetzer
manager: travisgr
ms.service: entra
ms.topic: conceptual
ms.subservice: architecture
ms.date: 08/25/2024
ms.author: martinco
---

# Microsoft Entra ID Governance operations reference guide

This section of the [Microsoft Entra operations reference guide](ops-guide-intro.md) describes the checks and actions you should take to assess and attest the access granted nonprivileged and privileged identities, audit, and control changes to the environment.

> [!NOTE]
> These recommendations are current as of the date of publishing but can change over time. Organizations should continuously evaluate their governance practices as Microsoft products and services evolve over time.

## Key operational processes

### Assign owners to key tasks

Managing Microsoft Entra ID requires the continuous execution of key operational tasks and processes, which might not be part of a rollout project. It's still important you set up these tasks to optimize your environment. The key tasks and their recommended owners include:

| Task | Owner |
| :- | :- |
| Archive Microsoft Entra audit logs in SIEM system | InfoSec Operations Team |
| Discover applications that are managed out of compliance | IAM Operations Team |
| Regularly review access to applications | InfoSec Architecture Team |
| Regularly review access to external identities | InfoSec Architecture Team |
| Regularly review who has privileged roles | InfoSec Architecture Team |
| Define security gates to activate privileged roles | InfoSec Architecture Team |
| Regularly review consent grants | InfoSec Architecture Team |
| Design Catalogs and Access Packages for applications and resources based for employees in the organization | App Owners |
| Define Security Policies to assign users to access packages | InfoSec team + App Owners |
| If policies include approval workflows, regularly review workflow approvals | App Owners |
| Review exceptions in security policies, such as Conditional Access policies, using access reviews | InfoSec Operations Team |

As you review your list, you might find you need to either assign an owner for tasks that are missing an owner or adjust ownership for tasks with owners that aren't aligned with the recommendations provided.

#### Owner recommended reading

- [Assigning administrator roles in Microsoft Entra ID](~/identity/role-based-access-control/permissions-reference.md)

### Configuration changes testing

There are changes that require special considerations when testing, from simple techniques such as rolling out a target subset of users to deploying a change in a parallel test tenant. If you have yet to implement a testing strategy, you should define a test approach based on the guidelines in the table:

| Scenario| Recommendation |
|-|-|
|Change the authentication type from federated to PHS/PTA or vice-versa| Use [staged rollout](~/identity/hybrid/connect/how-to-connect-staged-rollout.md) to test the effect of changing the authentication type.|
|Rolling out a new Conditional Access policy |Create a new Conditional Access policy and assign to test users.|
|Onboard a test environment of an application|Add the application to a production environment, hide it from the MyApps panel, and assign it to test users during the quality assurance (QA) phase.|
|Change of sync rules|Perform the changes in a test Microsoft Entra Connect with the same configuration that is currently in production, also known as staging mode, and analyze Export Results. If satisfied, swap to production when ready.|
|Change of branding|Test in a separate test tenant.|
|Rolling out a new feature|If the feature supports rollout to a target set of users, identify pilot users and build out. For example, self-service password reset and multifactor authentication can target specific users or groups.|
|Move to an application from an on-premises Identity provider (IdP), for example, Active Directory, to Microsoft Entra ID|If the application supports multiple IdP configurations, for example, Salesforce, configure both and test Microsoft Entra ID during a change window (in case the application introduces a page). If the application doesn't support multiple IdPs, schedule the testing during a change control window and program downtime.|
|Update rules for dynamic membership groups|Create a parallel dynamic group with the new rule. Compare against the calculated outcome, for example, run PowerShell with the same condition.<br>If test pass, swap the places where the old group was used (if feasible).|
|Migrate product licenses|Refer to [Change the license for a single user in a licensed group in Microsoft Entra ID](~/identity/users/licensing-groups-change-licenses.md).|
|Change AD FS rules such as Authorization, Issuance, MFA|Use group claim to target subset of users.|
|Change AD FS authentication experience or similar farm-wide changes |Create a parallel farm with same host name, implement config changes, test from clients using HOSTS file, NLB routing rules, or similar routing.<br> If the target platform doesn't support HOSTS files (for example mobile devices), control change.|

## Access reviews

### Access reviews to applications

Over time, users might accumulate access to resources as they move throughout different teams and positions. It's important that resource owners review the access to applications regularly. This review process can involve removing privileges that are no longer needed throughout the lifecycle of users. Microsoft Entra [access reviews](~/id-governance/access-reviews-overview.md) enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignments. Resource owners should review users' access regularly to make sure only the right people continue to have access. Ideally, you should consider using Microsoft Entra access reviews for this task.

![Access reviews start page](./media/ops-guide-auth/ops-img15.png)

> [!NOTE]
> Each user who interacts with access reviews must have a paid Microsoft Entra ID P2 license.

### Access reviews to external identities

It's crucial to keep access to external identities constrained only to resources that are needed, during the time that is needed. Establish a regular automated access review process for all external identities and application access using Microsoft Entra [access reviews](~/id-governance/access-reviews-overview.md). If a process already exists on-premises, consider using Microsoft Entra access reviews. Once an application is retired or no longer used, remove all the external identities that had access to the application.

> [!NOTE]
> Each user who interacts with access reviews must have a paid Microsoft Entra ID P2 license.

## Privileged account management

### Privileged account usage

Hackers often target admin accounts and other elements of privileged access to rapidly gain access to sensitive data and systems. Since users with privileged roles tend to accumulate over time, it's important to review and manage admin access regularly and provide just-in-time privileged access to Microsoft Entra ID and Azure resources.

If no process exists in your organization to manage privileged accounts or you currently have admins who use their regular user accounts to manage services and resources, you should immediately begin using separate accounts. For example, one for regular day-to-day activities, and the other for privileged access and configured with MFA. Better yet, if your organization has a Microsoft Entra ID P2 subscription, then you should immediately deploy [Microsoft Entra Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md#license-requirements). In the same token, you should also review those privileged accounts and [assign less privileged roles](~/identity/role-based-access-control/security-planning.md) if applicable.

Another aspect of privileged account management that should be implemented is in defining [access reviews](~/id-governance/access-reviews-overview.md) for those accounts, either manually or [automated through PIM](~/id-governance/privileged-identity-management/pim-perform-roles-and-resource-roles-review.md).

#### Privileged account management recommended reading

- [Roles in Microsoft Entra Privileged Identity Management](~/id-governance/privileged-identity-management/pim-roles.md)

### Emergency access accounts

[!INCLUDE [emergency-access-accounts](../includes/definitions/emergency-access-accounts.md)]

### Privileged access to Azure EA portal

The [Azure Enterprise Agreement (Azure EA) portal](https://azure.microsoft.com/blog/create-enterprise-subscription-experience-in-azure-portal-public-preview/) enables you to create Azure subscriptions against a main Enterprise Agreement, which is a powerful role within the enterprise. It's common to bootstrap the creation of this portal before even getting Microsoft Entra ID in place. In this case, it's necessary to use Microsoft Entra identities to lock it down, remove personal accounts from the portal, ensure that proper delegation is in place, and mitigate the risk of lockout.

To be clear, if the EA portal authorization level is currently set to "mixed mode", you must remove any [Microsoft accounts](https://support.skype.com/en/faq/FA12059/what-is-a-microsoft-account) from all privileged access in the EA portal and configure the EA portal to use Microsoft Entra accounts only. If the EA portal delegated roles aren't configured, you should also find and implement delegated roles for departments and accounts.

#### Privileged access recommended reading

- [Administrator role permissions in Microsoft Entra ID](~/identity/role-based-access-control/permissions-reference.md)

## Entitlement management

[Entitlement management (EM)](~/id-governance/entitlement-management-overview.md) allows app owners to bundle resources and assign them to specific personas in the organization (both internal and external). EM allows self-service signup and delegation to business owners while keeping governance policies to grant access, set access durations, and allow approval workflows. 

> [!NOTE]
> Microsoft Entra Entitlement Management requires Microsoft Entra ID P2 licenses.

## Summary

There are eight aspects to a secure Identity governance. This list helps you identify the actions you should take to assess and attest the access granted to nonprivileged and privileged identities, audit, and control changes to the environment.

- Assign owners to key tasks.
- Implement a testing strategy.
- Use Microsoft Entra access reviews to efficiently manage group memberships, access to enterprise applications, and role assignments.
- Establish a regular, automated access review process for all types of external identities and application access.
- Establish an access review process to review and manage admin access regularly and provide just-in-time privileged access to Microsoft Entra ID and Azure resources.
- Provision emergency accounts to be prepared to manage Microsoft Entra ID for unexpected outages.
- Lock down access to the Azure EA portal.
- Implement Entitlement Management to provide governed access to a collection of resources.

## Next steps

Get started with the [Microsoft Entra operational checks and actions](ops-guide-ops.md).
