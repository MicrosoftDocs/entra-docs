---
title: Manage relationship expiration and renewal (Preview)
description: Learn how to create, renew, and end time-bound governance relationships in Microsoft Entra Tenant Governance.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to limit the lifetime of governance relationships and renew approved access before it ends.
---

# Manage relationship expiration and renewal (Preview)

Relationship expiration and renewal lets you make access through a Microsoft Entra Tenant Governance relationship time-bound. The governing tenant proposes a lifetime in a governance policy template, and the governed tenant reviews and approves it.

Expiration is optional. A relationship without a configured lifetime doesn't expire automatically. For a time-bound relationship, the governed tenant must approve renewal before expiration to keep the relationship active.

> [!IMPORTANT]
> A pending renewal doesn't pause expiration. When a relationship expires, Tenant Governance terminates it and removes access granted only through that relationship. Maintain independent administrative access in each tenant.

## Prerequisites

- Have the **Tenant Governance Administrator** role in each tenant where you perform setup or approval.
- Review the applicable [Tenant Governance licensing requirements](licensing.md).
- Create or select a [governance policy template](governance-policy-templates.md) in the governing tenant.
- For delegated administration, have a role-assignable security group in the governing tenant and configure its approved roles in the template. For application access, configure the required multitenant applications in the template.

## Create a time-bound relationship

Configure the lifetime before sending the governance request.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) in the governing tenant.
1. Browse to **Tenant governance** > **Templates** and create or select a governance policy template.
1. Configure the delegated administration roles and multitenant applications that the relationship requires.
1. Set **Relationship lifetime** to a whole number from **1 to 730 days**, and save the template.
1. [Send a governance request](how-to-set-up-governance-relationship.md) using the template. Complete the invitation step first unless the tenant pair qualifies for the two-step handshake.
1. In the governed tenant, browse to **Tenant governance** > **Governing tenants** > **Received requests**. Open the request and review its permissions and lifetime.
1. Accept the request to establish the relationship.
1. Verify that the relationship is **Active** and **Expires on** shows the expected date in both tenants.

The initial expiration date is the request acceptance time plus the approved lifetime, not the date when the request was sent. The lifetime comes from the template and isn't overridden when sending or accepting the request.

If you leave **Relationship lifetime** unset, the relationship is non-expiring. There's no default lifetime or expiration reminder for that relationship. Invitation validity and request validity are separate from the relationship lifetime.

## Add or change expiration on an active relationship

An accepted relationship uses a policy snapshot. Editing its template doesn't automatically change that snapshot or the relationship's expiration.

1. In the governing tenant, edit the governance policy template used by the active relationship. Set the intended lifetime and save the template.
1. Send a new **Initial** governance request for the same tenant using the **same template ID**.
1. In the governed tenant, review and accept the request.
1. Verify that the existing relationship keeps its ID and receives the updated policy snapshot and expiration.

Use this process to add expiration to an active, non-expiring relationship or to apply different terms. A request using a different template ID can create a separate relationship.

> [!NOTE]
> **Request renewal** doesn't apply an updated template. Renewal preserves the active relationship's existing lifetime, permissions, and policy snapshot.

## Request and approve renewal

The governing tenant can request renewal any time before expiration. Renewal isn't restricted to the 30-day reminder window.

1. In the governing tenant, browse to **Tenant governance** > **Governed tenants** and open the active relationship. You can also open it from the expiration card on **Overview**.
1. Select **Request renewal**, review the current expiration and lifetime, and submit the request.
1. In the governed tenant, open the renewal-request card on **Tenant governance** > **Overview** and select **View renewal request**.
1. Review the request and accept or reject it.
1. Reopen the relationship and check **Expires on**.

An accepted renewal keeps the same relationship ID, approved permissions, and policy snapshot. The new expiration is **renewal acceptance time + the lifetime stored in the active relationship**. It isn't the old expiration date plus another full lifetime.

For example, a relationship with a 30-day lifetime expires on November 19. If renewal is accepted on November 10 at 12:00 UTC, the new expiration is December 10 at 12:00 UTC, not December 19.

Submitting or rejecting a renewal doesn't change the current expiration. After rejection, the governing tenant can request renewal again while the relationship remains active.

## Monitor expiration and notifications

The **Overview** page shows relationships due to expire within 30 days. A tenant that both governs and is governed has separate expiration cards for each direction. A warning doesn't itself terminate a relationship, and it can remain visible while renewal awaits approval.

Tenant Governance targets the following recipients for expiration and renewal notifications:

| Notification | Recipients |
| --- | --- |
| Expiration reminders | Global Administrator recipients in both tenants. |
| Renewal request awaiting approval | Global Administrator recipients in the governed tenant. |
| Renewal approved or rejected | Global Administrator recipients in the governing tenant. |
| Expiration or termination completion | Global Administrator recipients in both tenants. |

Review **Expires on** and pending requests in the admin center rather than relying only on email. A role assignment doesn't by itself provision a mailbox. The recipient roles in this table describe notification routing, not a requirement to use Global Administrator for the setup steps.

## Understand expiration and cleanup

If renewal isn't accepted before expiration, the relationship is automatically terminated. Its Microsoft Graph status is `terminated`, not a separate `expired` state. An old renewal request can't reactivate a terminated relationship.

Cleanup removes access that was provided only through the terminated relationship and preserves access required by other relationships.

| Resource | Cleanup behavior |
| --- | --- |
| Delegated role assignments | Remove assignments used only by the terminated relationship. Preserve assignments required by another relationship. The source group and its membership aren't removed. |
| Applications and permissions | Remove relationship-exclusive grants and injected applications that qualify for cleanup. Preserve shared or preexisting applications, grants required by surviving relationships, unrelated or manually configured grants, and the source application registration. |
| Cross-tenant access settings | Disable the service-provider setting when no other relationship for the same tenant pair needs GDAP access. Preserve unrelated partner and B2B settings; don't delete the entire partner policy. |

An application remaining visible doesn't necessarily mean the terminated relationship still grants access. Review the actual role assignments and permission grants, and use a fresh sign-in when verifying access.

## Reconnect after a relationship ends

Create a new approved relationship instead of renewing the terminated relationship.

1. Confirm that the governing tenant is eligible to send a request. Use a valid invitation or another qualifying basis, such as a related-tenant billing signal. Otherwise, have the governed tenant send a new invitation.
1. Send a new **Initial** governance request with the intended template.
1. Have the governed tenant review and accept the request.
1. Verify the active relationship and its expiration.

Expired or manually terminated relationships don't appear in the **Governed tenants** tab within **Request to govern**. This doesn't mean their records are removed from every relationship view.

## Limitations

- Relationships created automatically during add-on tenant creation are excluded from expiration. A lifetime in the default template's policy snapshot doesn't by itself create an expiration date or schedule expiration for that flow.
- Renewal doesn't adopt a newer template or change permissions. Use a new **Initial** request with the same template ID to update an active relationship.
- A pending renewal doesn't preserve access beyond the existing deadline.

## Troubleshooting

| Issue | What to check |
| --- | --- |
| Editing a template didn't change expiration | Send a new **Initial** request using the same template ID, and have the governed tenant accept it. |
| Renewal is pending but the warning remains | The current expiration still applies until the governed tenant approves renewal. |
| An expired relationship can't be renewed | Reconnect using a new governance request and the applicable invitation or eligibility requirements. |
| Access remains after termination | Check whether another active relationship or an unrelated grant still provides that access. |
| A setup or renewal operation fails | Record the tenant context, relationship/request ID, UTC time, and error or correlation ID for support. Don't include access tokens or credentials. |

## Related content

- [Governance relationships](governance-relationships.md).
- [Governance policy templates](governance-policy-templates.md).
- [Update a governance relationship](how-to-update-governance-relationship.md).
- [Terminate a governance relationship](how-to-terminate-governance-relationship.md).
