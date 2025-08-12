---
title: Delegate Approvals in My Access (Preview)
description: A how-to article explaining how system admins can delegate approvals using My Access
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/11/2025

#CustomerIntent: As an access package approver, I want to delegate approvals so that designated individuals can approve when I am not available to.
---

# Delegate Approvals in My Access (Preview)

Approval delegation in My Access allows approvers to assign another individual to respond to access package approval requests on their behalf. This feature helps maintain productivity when approvers are unavailable due to leave, travel, or other commitments.

> [!NOTE]
> This feature applies only to approvals. Access review delegation isn't supported.

## License requirements

[!INCLUDE [entra-p2-governance-license.md](../includes/entra-p2-governance-license.md)]

## How delegation works

When an approver sets a delegate, the following happens:

- All approvals assigned after the delegation are routed to the delegate.
- The original approver can still respond to approvals during the delegation period.
- Delegation can be time-bound or indefinite.
- Delegates are notified when they're assigned.
- Requestors are notified when their request is approved by a delegate.
- Delegation is always bulk; approvers can't delegate specific types of approvals.


### What delegates can see

**Delegates can**:
- View approvals assigned to them.
- See who delegated the approvals.
- Respond to approvals during the specified time period.

**Delegates cannot**:
- Redelegate approvals.
- See approvals assigned before the delegation was set.


## Limitations


- Delegation is limited to one level. If User A delegates to User B, and User B delegates to User C, User C won't receive approvals from User A.
- Delegation isn't restricted. Any user can be selected as a delegate.
- Delegation applies only to approvals assigned after the delegation is configured.


## Enable Delegate Approvals preview

To enable approvers to delegate in My Access, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement Management** > **Preview Features**.

1. Select **“Enable approvers to delegate in MyAccess”**.

### Set up a delegate

With the delegate approvers option enabled, you can set up a delegate to approve access on your behalf. To set up a delegate, you'd do the following steps:

1.	Sign in to the My Access portal.

1.	Select the Approvals page.

1.	Select Delegate approvals.

1.	In the modal:
    1.	Enter the name, or email, of the delegate.
    1.	Set the start and end time (or select No end date).

1.	Select Delegate.

1.	A toast notification confirms the action. The active delegation is reflected on the Overview page and the Approvals page.


### Edit or remove a delegate

To edit the delegate, you'd: 

1. Select Edit delegate on the Approvals page.

1. Update the details listed on the page.

1. Select Save and apply.

To remove the delegate, you'd: 

1. Select Remove delegate. 

1. Confirm the action. 

Once confirmed, the delegate is no longer be able to respond to approvals.


## Related content

- [What is the My Access portal?](my-access-portal-overview.md)


