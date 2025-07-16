---
title: Microsoft Entra Permissions Management roles and permissions
description: Review roles and the level of permissions assigned in Microsoft Entra Permissions Management.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-permissions-management
ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
ms.custom: sfi-ga-nochange
# customerintent: As a cloud administrator, I want to understand Permissions Management role assignments, so that I can effectively assign the correct permissions to users.
---


# Microsoft Entra Permissions Management roles and permissions levels

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

In Microsoft Azure and Microsoft Entra Permissions Management role assignments grant users permissions to monitor and take action in multicloud environments.

- **Global Administrator**: Manages all aspects of Microsoft Entra admin center and Microsoft services that use Microsoft Entra admin center identities. 
- **Permissions Management Administrator**: Manages all aspects of Microsoft Entra Permissions Management.
- **Billing Administrator**: Performs common billing related tasks like updating payment information. 
 

See [Microsoft Entra built-in roles to learn more.](https://go.microsoft.com/fwlink/?linkid=2247090)

## Enabling Permissions Management
- To activate a trial or purchase a license, you must have [Billing Administrator](../identity/role-based-access-control/permissions-reference.md#billing-administrator) permissions.

## Onboarding your Amazon Web Service (AWS), Microsoft Entra, or Google Cloud Platform (GCP) environments

- To configure data collection, you must be a [Permissions Management Administrator](../identity/role-based-access-control/permissions-reference.md#permissions-management-administrator). 
- A user with the [Permissions Management Administrator](../identity/role-based-access-control/permissions-reference.md#permissions-management-administrator) role is required for AWS and GCP onboarding.

## Notes on permissions and roles in Permissions Management

- Users can have the following permissions:
    - Admin for all authorization system types
    - Admin for selected authorization system types
    - Fine-grained permissions for all or selected authorization system types
- If a user isn't an admin, they're assigned Microsoft Entra security group-based, fine-grained permissions for all or selected authorization system types:
    - Viewers: View the specified AWS accounts, Azure subscriptions, and GCP projects
    - Controller: Modify Cloud Infrastructure Entitlement Management (CIEM) properties and use the Remediation dashboard.
    - Approvers: Able to approve permission requests
    - Requestors: Request permissions in the specified AWS accounts, Microsoft Entra subscriptions, and GCP projects.

## Permissions Management actions and required roles

Remediation
- To view the **Remediation** tab, you must have *Viewer*, *Controller*, or *Approver* permissions.
- To make changes in the **Remediation** tab, you must have *Controller* or *Approver* permissions.

Autopilot
- To view and make changes in the **Autopilot** tab, you must be a *Permissions Management Administrator*.

Alert
- Any user (admin, nonadmin) can create an alert. 
- Only the user who creates the alert can edit, rename, deactivate, or delete the alert.

Manage users or groups
- Only the owner of a group can add or remove a user from the group.
- Managing users and groups is only done in the Microsoft Entra admin center.


## Next steps

For information about managing roles, policies and permissions requests in your organization, see [View roles/policies and requests for permission in the Remediation dashboard](ui-remediation.md).
