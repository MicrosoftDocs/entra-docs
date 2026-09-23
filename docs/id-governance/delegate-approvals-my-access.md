---
title: Delegate approvals and access reviews in My Access (Preview)
description: Learn how to delegate approvals and access reviews to another user in My Access.
ms.topic: how-to
ms.date: 06/03/2026

#Customer Intent: As an access package approver or access reviewer, I want to delegate approvals and access reviews so that designated individuals can respond when I'm not available.
---

# Delegate approvals and access reviews in My Access (Preview)

Approval delegation in My Access allows approvers to assign another individual to respond to access package approval requests and multi-resource access reviews on their behalf. This feature helps maintain productivity when approvers are unavailable due to leave, travel, or other commitments.

## License requirements

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

## How delegation works

When an approver sets a delegate, the following happens:

- All approvals explicitly assigned to an approver (not through a group) after delegation are routed to the specified delegate.
- Multi-resource access reviews assigned after delegation are routed to the specified delegate.
- The original approver can still respond to approvals and access reviews during the delegation period.
- Delegations can be time-bound or indefinite.
- Delegates are notified when they're assigned.
- Requestors are notified when their request is approved by a delegate.
- Delegation is always bulk; approvers can't delegate specific approvals or reviews.

> [!NOTE]
> Delegation for access reviews applies only to multi-resource (catalog) access reviews. Single-resource access reviews (such as those for a single group or application) aren't included in delegation.

### What delegates can see

**Delegates can**:

- View approvals and multi-resource access reviews assigned to them.
- See who delegated the items.
- Respond to approvals and access reviews during the specified time period.

**Delegates can't**:

- Redelegate approvals or access reviews.
- See items assigned before the delegation was set.

## Limitations

- Delegation is limited to one level. If User A delegates to User B, and User B delegates to User C, User C won't receive approvals from User A.
- Delegation only applies to approvals explicitly assigned to an approver, not those assigned through a group.
- Delegation applies only to items assigned after the delegation is configured.
- Access review delegation applies only to multi-resource access reviews.

## Enable delegate approvals preview

To enable approvers to delegate in My Access, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement Management** > **Preview Features**.

1. Select **Allow users to delegate approvals and access reviews in My Access**.

## Restrict who users can delegate to

Administrators can control who users are allowed to select as a delegate. Configure these restrictions in the Microsoft Entra admin center.

| Restriction | Behavior |
|---|---|
| **Direct manager only** | Users can only delegate to their direct manager as defined in Microsoft Entra ID. |
| **Specific groups** | Users can only delegate to members of one or more administrator-defined groups. |
| **Unrestricted** | Users can delegate to any user in the directory. |
| **Limit delegation duration** | Administrators can set a maximum duration for new and updated delegations. Delegations without an expiration date are rejected. |

> [!NOTE]
> When both a manager restriction and a group restriction are configured, a user can delegate to anyone who meets either restriction. For example, if an admin sets direct manager and a specific group, the user can delegate to their manager or to any member of that group.

To configure delegation restrictions:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement Management** > **Settings**.

1. Under **Delegate restrictions**, choose the restriction type and configure the allowed groups if applicable.

1. Select **Save**.

## Set up a delegate

With the delegate option enabled, you can set up a delegate to approve access and respond to multi-resource access reviews on your behalf. To set up a delegate, follow these steps:

1. Sign in to the [My Access portal](https://myaccess.microsoft.com).

1. On the left menu, select **Approvals** or **Access reviews**.

1. Select **Delegate approvals and access reviews**.

1. In the dialog box that opens:
    1. In the **User** field, enter the name or email of the person you want to delegate to.
    1. Set the **Start date** for the delegation.
    1. Set the **End date** for the delegation, or select the **No end date** checkbox for an indefinite delegation.

1. Select **Delegate**.

The active delegation appears on both the **Approvals** page and the **Access reviews** page.

### Edit or remove a delegate

#### Edit the delegate

1. Sign in to the [My Access portal](https://myaccess.microsoft.com).

1. On the left menu, select **Approvals** or **Access reviews**.

1. Select the active delegate display that shows your current delegate's name.

1. In the **Edit delegate** dialog box, update the delegate, start date, or end date as needed.

1. Select **Save and apply**.

#### Remove the delegate

1. Sign in to the [My Access portal](https://myaccess.microsoft.com).

1. On the left menu, select **Approvals** or **Access reviews**.

1. Select the active delegate display that shows your current delegate's name.

1. In the **Edit delegate** dialog box, select **Remove delegate**.

1. Select **Confirm**.

After you confirm, the delegate can no longer respond to your approvals and access reviews.

## Related content

- [What is the My Access portal?](my-access-portal-overview.md)
