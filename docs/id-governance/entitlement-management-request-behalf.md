---
title: Request access packages on-behalf-of other users
description: This article describes how to set up an access package so that managers can approve, or deny, requests for users reporting to them.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to 
ms.date: 06/18/2025

#CustomerIntent: As an administrator, I want to set up policies that allow managers to approve access package requests on behalf of their employees, and show show them how they would do act on these policies.
---


# Request access package on-behalf-of other users

Entitlement Management enables admins to create access packages to manage their organization’s resources. Admins can either directly assign users to an access package, or configure an access package policy that allows users and group members to request access. This option to create self-service processes is useful, especially as organizations scale and hire more employees. However, new employees joining an organization might not always know what they need access to, or how they can request access. In this case, a new employee would likely rely on their manager to guide them through the access request process.

Instead of having new employees navigate the request process, managers can request access packages for their employees, making onboarding faster and more seamless. To enable this functionality for managers, admins can select an option when setting up an access package policy that allows managers to request access on their employees' behalf.

Expanding self-service request flows to allow requests on behalf of employees ensures that users have timely access to necessary resources, and increases productivity.


## Scenarios for managers requesting on behalf of employees

Imagine your organization hires hundreds of new employees each year, and you're being tasked with training new hires on IT processes, including how to request access for resources in My Access. Training sessions are only at the beginning of each month, so managers of new hires who start later in the month often reach out for ad-hoc training. This is becoming increasingly common.

Instead of conducting numerous ad-hoc training sessions to ensure new hires know how to request access in their first week or weeks at the organization, you can set up access package policies that allow managers to request access on behalf of their employees.

:::image type="content" source="media/entitlement-management-request-behalf/enable-manager-requests.png" alt-text="Screenshot of request on behalf of options." lightbox="media/entitlement-management-request-behalf/enable-manager-requests.png":::

Now, managers are empowered to request access on behalf of new hires who haven't gone through the IT training. This ensures that employees have the tools and resources necessary to start on day one, and increases new hire satisfaction as they don’t need to wait for access or navigate the request process on their own.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## Configure an access package policy allowing on behalf of requests

Follow these steps to edit the policies, allowing on behalf of requests, for an existing access package:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access packages**. 

1. Select the access package you want to set up for on behalf of requests.  

1. Select the policy you wish to edit or create a new policy. 

1. On the **Requests** tab, set **Enable new requests** to Yes. This should show you the option **Allow managers to request on behalf of employees**. Set that option to Yes.  
    :::image type="content" source="media/entitlement-management-request-behalf/edit-request-policy-behalf.png" lightbox="media/entitlement-management-request-behalf/edit-request-policy-behalf.png" alt-text="Screenshot of editing an access package;s request on behalf of policy.":::
1. Save your policy. 

## Request an access package on behalf of an employee
 
As a manager, you can request an access package for a direct report by doing the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com). For US Government, the domain in the My Access portal link is `myaccess.microsoft.us`.

1. On the My Access Portal page, select **Access packages**.

1. On the Access packages page, locate the access package you want to request for a direct report and select **Request**.
    
1. On the Request pane under **Request details**, select requesting for **Someone else**.
    :::image type="content" source="media/entitlement-management-request-behalf/manager-request-package.png" alt-text="Screenshot of manager requesting access package for direct employee.":::
1. Fill in additional information needed to request an access package for the direct report.
    :::image type="content" source="media/entitlement-management-request-behalf/manager-request-questions.png" alt-text="Screenshot of justification questions for requesting an access package for a direct report.":::
1. Select **Submit request**.

## Approve access on behalf of employee requested by manager

When a manager requests an access package on behalf of their employee, you'd do the following steps to approve access:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com). For US Government, the domain in the My Access portal link is `myaccess.microsoft.us`.

1. In the left menu, select **Approvals** to see a list of access requests pending approval.

1. On the **Pending** tab, find the request.
    :::image type="content" source="media/entitlement-management-request-behalf/myaccess-approval-request.png" lightbox="media/entitlement-management-request-behalf/myaccess-approval-request.png" alt-text="Screenshot of the pending approval requests in my access.":::

1. Either approve, or deny, the request on behalf of the employee.

## Manage team assignments using the My Access portal

Managers can also manage access package assignments of their direct reports using the My Access portal. Management capabilities include:

- The ability to see active access package assignment of all of their direct reports.
- The ability to remove assignments for reports if the policy supports on behalf of requests.

To manage your team assignments using the My Access portal, you'd do the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com) as a the direct manager of the team who you want to manage access package assignments for. For US Government, the domain in the My Access portal link is `myaccess.microsoft.us`.

1. In the left menu, select **Manage team** to see a list of your direct reports.
    :::image type="content" source="media/entitlement-management-request-behalf/manage-team-reviews.png" alt-text="Screenshot of managing team in the my access portal.":::
1. On the team page you can select a report to seea list of their current access package assignments, or select **Remove access** to end the access package assignment for the user.

## Next steps

- [Approve or deny access requests - entitlement management](entitlement-management-request-approve.md)
- [Request process and email notifications](entitlement-management-process.md)
