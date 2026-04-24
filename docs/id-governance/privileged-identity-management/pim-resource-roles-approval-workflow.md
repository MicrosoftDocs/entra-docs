---
title: Approve requests for Azure resource roles in PIM
description: Learn how to approve or deny requests for Azure resource roles in Privileged
  Identity Management (PIM).
ms.topic: how-to
ms.date: 04/02/2026
ms.reviewer: shaunliu
ms.custom: pim
---

# Approve or deny requests for Azure resource roles in Privileged Identity Management

> [!div class="op_single_selector"]
> - **Customer intent:** As an approver, I want to review and approve or deny activation requests for Azure resource roles to control access to Azure subscriptions and resources.

## Overview

Microsoft Entra Privileged Identity Management (PIM) enables you to configure roles so that they require approval for activation, and choose users or groups from your Microsoft Entra organization as delegated approvers. Select two or more approvers for each role to reduce workload for the Privileged Role Administrator. Delegated approvers have 24 hours to approve requests. If a request isn't approved within 24 hours, then the eligible user must resubmit a new request. The 24-hour approval time window isn't configurable.

Follow the steps in this article to approve or deny requests for Azure resource roles.


## View pending requests

As a delegated approver, you receive an email notification when an Azure resource role request is pending your approval. You can view these pending requests in Privileged Identity Management.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Approve requests**.

    In the **Requests for role activations** section, you see a list of requests pending your approval.


## Approve requests

1. Find and select the request that you want to approve. An approve or deny page appears.
1. In the **Justification** box, enter the business justification.
1. Select **Approve**. You receive an Azure notification of your approval.


## Approve pending requests with the Microsoft Azure Resource Manager API

> [!NOTE]
> Approval for **extend and renew** requests is currently not supported by the Microsoft ARM API.

### Get IDs for the steps that require approval

To get the details of any stage of a role assignment approval, you can use [Role Assignment Approval Step - Get By ID](/rest/api/authorization/role-assignment-approval-step/get-by-id?tabs=HTTP) REST API.

#### HTTP request

````HTTP
GET https://management.azure.com/providers/Microsoft.Authorization/roleAssignmentApprovals/{approvalId}/stages/{stageId}?api-version=2021-01-01-preview
````


### Approve the activation request step

To approve the activation request step, make the following API call.

#### HTTP request

````HTTP
PATCH https://management.azure.com/providers/Microsoft.Authorization/roleAssignmentApprovals/{approvalId}/stages/{stageId}?api-version=2021-01-01-preview
{ 
    "reviewResult": "Approve", // or "Deny"
    "justification": "Trusted User" 
} 
 ````

#### HTTP response

Successful PATCH calls generate an empty response.

For more information, see [Use Role Assignment Approvals to approve PIM role activation requests with REST API](/rest/api/authorization/privileged-approval-sample).

## Deny requests

1. Find and select the request that you want to deny. An approve or deny page appears.
1. In the **Justification** box, enter the business justification.
1. Select **Deny**. A notification appears with your denial.

## Workflow notifications

Here's some information about workflow notifications:

- Approvers are notified by email when a request for a role is pending their review. Email notifications include a direct link to the request, where the approver can approve or deny.
- Requests are resolved by the first approver who approves or denies.
- When an approver responds to the request, all approvers are notified of the action.
- Resource administrators are notified when an approved user becomes active in their role.

> [!NOTE]
> A resource administrator who believes that an approved user shouldn't be active can remove the active role assignment in Privileged Identity Management. Although resource administrators aren't notified of pending requests unless they're an approver, they can view and cancel pending requests for all users by viewing pending requests in Privileged Identity Management.

## Next steps

- [Email notifications in Privileged Identity Management](pim-email-notifications.md)
- [Approve or deny requests for Microsoft Entra roles in Privileged Identity Management](./pim-approval-workflow.md)
