---
title: Set up multi-tier governance relationships (Preview)
description: Learn how a Microsoft Entra tenant can be governed by another tenant while governing downstream tenants, with independent approvals and permissions.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to set up multi-tier governance without granting inherited access across the tenant chain.
---

# Set up multi-tier governance relationships (Preview)

Multi-tier governance lets a Microsoft Entra tenant be governed by another tenant while governing its own downstream tenants. For example, a central IT tenant can govern a regional tenant that separately governs project tenants.

Each direct relationship has its own approval, permissions, policy snapshot, and lifecycle. Multi-tier governance uses existing governance policy templates, invitations, and requests. You don't create a separate hierarchy object.

> [!IMPORTANT]
> Access doesn't flow through a chain. If tenant A governs tenant B and tenant B governs tenant C, users in A don't automatically gain access to C. A needs a separately approved direct relationship with C.

## Prerequisites

- Have the **Tenant Governance Administrator** role in each tenant where you perform setup or approval.
- Review [Tenant Governance licensing](licensing.md) for each governing tenant.
- Keep independent administrative access in every participating tenant.
- Prepare role-assignable security groups in each governing tenant and governance policy templates that define only the required delegated roles and applications.
- Use separate browser profiles for the tenants, or verify the current tenant ID each time you switch.

## Example: Central, regional, and project tenants

This walkthrough creates **A governs B** and **B governs C**. The arrows `A -> B -> C` describe separate, directional relationships.

| Tenant | Preparation |
| --- | --- |
| A: central IT | A role-assignable group named `A-Admins-for-B` and an A-owned template defining the access B will approve. |
| B: regional IT | An administrator to approve A's request, plus a separate group named `B-Admins-for-C` and a B-owned template for C. |
| C: project | An administrator to review and accept B's request. C doesn't grant access to A's group by approving B. |

You can establish A-to-B or B-to-C first. Each relationship is approved independently.

## Establish A-to-B

Use the standard governance handshake to establish A's access to B.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) in A.
1. Browse to **Tenant governance** > **Templates**. Create a template that maps `A-Admins-for-B` to the required Microsoft Entra roles.
1. In A, enable receiving invitations under **Tenant governance** > **Settings**.
1. In B, browse to **Tenant governance** > **Governing tenants** > **Sent invitations** and send an invitation to A.
1. In A, open **Governed tenants** > **Received invitations**. Send a governance request to B using the A-to-B template.
1. In B, open **Governing tenants** > **Received requests**, review the permissions, and accept the request.
1. Verify that the relationship is **Active** in both tenants. A lists B under **Governed tenants**, and B lists A under **Governing tenants**.
1. Disable receiving invitations in A when you no longer need it.

If the pair qualifies for the two-step handshake, follow [Set up a governance relationship](how-to-set-up-governance-relationship.md) without the invitation step. Check that eligibility separately for each pair.

## Establish B-to-C

Keep A-to-B active. Use B's own authorized administrator account to establish B-to-C; don't assume that A's delegated access in B provides the permissions needed for this operation.

1. In B, create a template under **Tenant governance** > **Templates**. Map `B-Admins-for-C` to the roles C will approve.
1. In B, enable receiving invitations under **Tenant governance** > **Settings**.
1. In C, open **Governing tenants** > **Sent invitations** and send an invitation to B.
1. In B, open **Governed tenants** > **Received invitations** and send C a request using the B-to-C template.
1. In C, open **Governing tenants** > **Received requests**, review the permissions, and accept.
1. Verify that B-to-C is **Active** and has its own relationship ID and accepted policy snapshot.
1. Disable receiving invitations in B when you no longer need it.

In B, A now appears under **Governing tenants** and C under **Governed tenants**.

## Verify permissions and visibility

An active member of `A-Admins-for-B` can use the roles approved in B. An active member of `B-Admins-for-C` can use the roles approved in C. Membership in A's group doesn't grant access to C through the chain.

| Tenant context | Direct relationships in this example |
| --- | --- |
| A | A-to-B. A doesn't automatically see B-to-C or gain C as a governed tenant. |
| B | A-to-B and B-to-C. |
| C | B-to-C. |

If A also needs to administer C, establish a separate A-to-C relationship using an A-owned template and C's approval. That relationship has its own ID and permissions; it doesn't change B-to-C.

Reciprocal relationships, such as A-to-B and B-to-A, also require separate approval for each direction. The same independent-approval and no-inherited-access rules apply to cycles.

## Manage each relationship independently

Updating a template doesn't silently update accepted relationships. Use the existing [request and approval process](how-to-update-governance-relationship.md) to apply new terms to the affected relationship.

If you configure [expiration and renewal](how-to-manage-relationship-expiration.md), each direct relationship retains its own lifetime. Renewing or expiring A-to-B doesn't renew or expire B-to-C.

To terminate A-to-B:

1. In A, open **Tenant governance** > **Governed tenants**, select B, and select **Terminate governance**.
1. In B, open **Governing tenants**, filter **Relationship status** to **Termination requested**, select A, and select **Confirm termination**.
1. Verify that A-to-B is **Terminated** and B-to-C remains **Active**.

B can instead terminate A-to-B directly as its governed tenant. That action doesn't require A's approval. For details, see [Terminate a governance relationship](how-to-terminate-governance-relationship.md).

Cleanup removes relationship-exclusive access and preserves resources still required by other relationships or unrelated grants. Keep local administrative access available when testing termination.

## Troubleshooting

| Issue | What to check |
| --- | --- |
| A can't administer C through B | This is expected. Establish and approve a direct A-to-C relationship if that access is required. |
| An invitation or request isn't available | Check the current tenant, receiving-invitation setting, invitation validity, and request validity. Invitations are valid for 30 days and requests for 14 days. |
| A relationship isn't visible in another tenant's list | Each tenant sees its own direct relationships. Multi-tier governance doesn't expose every downstream relationship. |
| Ending A-to-B appears to affect B-to-C | Verify the two relationship IDs, the approved groups, and any independent access required by the users. Record the tenant context and error details for support. |

## Related content

- [Governance relationships](governance-relationships.md).
- [Set up a governance relationship](how-to-set-up-governance-relationship.md).
- [Use delegated administration](how-to-delegated-administration.md).
- [Manage relationship expiration and renewal](how-to-manage-relationship-expiration.md).
