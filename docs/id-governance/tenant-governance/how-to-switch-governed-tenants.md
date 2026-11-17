---
title: Switch between governed tenants (Preview)
description: Learn how to find and switch to governed tenants in the Microsoft Entra admin center using existing delegated access.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a delegated administrator, I want to find and switch to governed tenants without opening each governance relationship.
---

# Switch between governed tenants (Preview)

The **Governed tenants** view in **Manage tenants** helps you find tenants you can administer through Microsoft Entra Tenant Governance. It uses active governance relationships and your active membership in their delegated-role groups.

You can select a target without opening each governance relationship individually. Switching uses your existing access: it doesn't create a relationship, invite a guest, or grant additional permissions.

## Prerequisites

- Start with your member account in the governing tenant. Your home tenant is where this account originates, not whichever tenant the admin center currently displays.
- Have an active direct governance relationship with the target tenant and active membership in a group referenced by its delegated role assignments.
- Have the delegated role required for the task you want to perform in the target tenant.

If your group membership is eligible through Privileged Identity Management (PIM), activate it before using the governed-tenant discovery view. Eligible membership alone doesn't qualify. See [Use cross-tenant delegated administration](how-to-delegated-administration.md).

## Find your governed tenants

Use the discovery view to identify the tenant you intend to administer.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using your governing-tenant member account.
1. Browse to **Entra ID** > **Overview** > **Manage tenants**.
1. Select **Governed tenants**.
1. Find the target tenant and verify its **Organization ID**.

The list reflects qualifying active relationships and group membership. A terminated relationship doesn't contribute access. A tenant can remain listed if another active relationship still qualifies your account.

Use the existing directory list for ordinary tenant membership and B2B guest access. A B2B invitation alone doesn't place a tenant in **Governed tenants**.

## Switch to a governed tenant

Check the target identity before switching or making administrative changes.

1. In **Governed tenants**, compare the target's **Organization ID** with the tenant you intend to administer.
1. Select **Switch** for that tenant.
1. Complete any sign-in prompts.
1. Verify the tenant identity in the admin center before performing administrative tasks.

> [!IMPORTANT]
> A discovery result isn't a guarantee that every sign-in or operation will succeed. Target permissions and sign-in requirements still apply. Your actions remain limited to the access already granted.

Don't rely on a display name or a domain-name column as the only identity check.

## Return to your home tenant

You can return to your home tenant to choose another governed tenant.

1. In the governed tenant, open **Entra ID** > **Overview** > **Manage tenants**.
1. Select **View home tenant**.
1. Verify that the admin center is in your home tenant, open **Governed tenants**, and select the next target.

## Understand the access boundary

Multi-tier relationships don't add indirect targets. If A governs B and B governs C, a user in A doesn't gain access to C through that chain. A needs a separately approved direct relationship with C and the user needs qualifying group membership.

The **Governed tenants** view isn't a combined inventory of every B2B, CSP, or Partner Center relationship. It reflects access through Tenant Governance.

## Troubleshooting

| Issue | What to check |
| --- | --- |
| **Governed tenants** isn't available | Verify the account and tenant context and the availability of the preview in your environment. Don't assign Global Administrator solely to reveal the view. |
| The list is empty or a target is missing | Check the active direct relationship, active group membership, and current tenant context. Clear filters, refresh, or sign in again after access changes. |
| The tenant is listed but switching fails | Ask the target administrator to review delegated grants and sign-in requirements. |
| Access was recently removed | Refresh or sign in again after changes propagate. Check whether another active relationship still grants access. |
| Tenant names are similar or details appear unexpected | Verify the **Organization ID** and actual assigned permissions before making changes. |

For support, record the current tenant, target tenant ID, account context, failing step, UTC time, and error or correlation ID. Don't share access tokens, cookies, or credentials.

## Related content

- [Use cross-tenant delegated administration](how-to-delegated-administration.md).
- [Governance relationships](governance-relationships.md).
- [Set up multi-tier governance relationships](how-to-set-up-multi-tier-governance.md).
- [Monitor governing tenant activity](how-to-monitor-governing-activity.md).
