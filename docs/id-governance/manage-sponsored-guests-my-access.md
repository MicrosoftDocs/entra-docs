---
title: Manage sponsored guests in My Account
description: Learn how sponsors can review, extend, end, and establish sponsorship for Microsoft Entra guest users in My Account.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 09/30/2026
ai-usage: ai-assisted
#Customer Intent: As a guest sponsor, I want to manage the guests I sponsor so that their access aligns with their continued business need.
---

# Manage sponsored guests in My Account (preview)

> [!IMPORTANT]
> Sponsored guest management in My Account is currently in preview. Preview features are provided without a service-level agreement and aren't recommended for production workloads. Certain features might not be supported or might have limited capabilities.

A sponsor helps manage a Microsoft Entra guest user's lifecycle and continued access to organizational resources. Sponsors are typically familiar with why a guest collaborates with the organization and whether that access is still needed.

In My Account, you can review the guests you sponsor, use activity and access information to assess continued need, extend sponsorship, end your sponsorship, and sponsor an eligible unsponsored guest. Your tenant's guest lifecycle policy determines how often sponsorship must be extended, which notifications and grace periods apply, and what enforcement can occur when policy requirements aren't met.

## Key capabilities

- Review all guests you currently sponsor.
- Prioritize guests who require extensions for continued access.
- View guest details, activity signals, and sponsors.
- Extend access for guests you sponsor.
- End your sponsorship when the business relationship no longer requires it.
- Search for and sponsor an eligible unsponsored guest.

## Before you begin

### Requirements

- Your organization must have guest lifecycle policies configured in Lifecycle Workflows within Microsoft Entra ID Governance.
- You must be signed in with a work or school account that is permitted to act as a guest sponsor.

### Understand policy-driven behavior

My Account is the sponsor-facing experience. Administrators configure guest lifecycle policies, including how often guest access must be extended, activity requirements, minimum sponsor count, notifications, grace periods, and enforcement actions. You can't change these guest policy settings in My Account.

Extending sponsorship records your attestation that the guest still has a business need for access. It doesn't guarantee continued access or confirm that the guest satisfies every other lifecycle policy rule.

## Open Sponsored guests

1. Sign in to [My Account](https://myaccount.microsoft.com).
1. In the left navigation, select **Sponsored guests**.
1. Use the available views and search to find a guest by display name or email address.

The page shows the guests you sponsor. Information can include the guest's name, email address, attestation status, and last sign-in.

Choose the action that matches your goal. Review a guest before making a decision, extend sponsorship when the guest still needs access, end sponsorship when you can no longer confirm that need, or sponsor an eligible guest who currently has no sponsor.

### Review a guest

1. Open the guest's overflow menu, and then select **View details**.
1. Review the available profile and lifecycle information, such as work location, date invited, last sign-in, current sponsors, and last attested date.
1. Review assigned access packages and their included resources, when available.
1. Decide whether to extend access for the guest or end your sponsorship.

## Extend sponsorship for a guest

Use this action when you confirm that the guest still requires access for an ongoing business relationship.

1. On the **Sponsored guests** page, find the guest.
1. Open the guest's overflow menu or the guest details page.
1. Select **Extend sponsorship**.
1. Confirm that My Account shows the updated attestation status or date.

If **Extend sponsorship** isn't available, the guest might not yet require an extension, the tenant policy might not permit the action, or the guest's current state might limit the available options. Review the guest details for status information. If the reason remains unclear, contact your organization's Microsoft Entra administrator or identity governance support team.

## End your sponsorship

End sponsorship when you're no longer responsible for the guest's business relationship or can't confirm their continued need for access.

1. On the **Sponsored guests** page, find the guest.
1. Open the guest's overflow menu or the guest details page.
1. Select **End sponsorship**.
1. Review the impact shown in the confirmation dialog, and then confirm.

Ending sponsorship removes only your sponsor relationship. It doesn't immediately remove the guest or their access. If other sponsors remain, their relationships continue. If your action leaves the guest without the minimum number of sponsors, the organization's guest lifecycle policy might begin account disablement or deletion, depending on its settings. Individual access package assignments remain unless the applicable policy or another governance process removes them.

## Sponsor an unsponsored guest

1. On the **Sponsored guests** page, select **Sponsor a guest**.
1. Search for the guest by name or email address.
1. Select the correct guest from the results.
1. Select **Sponsor**.
1. Verify that the guest appears in your sponsored guest list.

Search results show only guests that your organization permits you to discover and sponsor. If a guest doesn't appear, they might be ineligible, already have the required sponsorship, or fall outside your permitted search scope.

After you complete an action, refresh the **Sponsored guests** page and verify the expected change:

- For an extension, confirm the attestation status or date.
- After you end sponsorship, confirm that you're no longer listed as a sponsor.
- After you sponsor a guest, confirm that the guest appears in your sponsored guest list.

If the change doesn't appear, wait briefly and refresh the page again before you contact your organization's support team.

## How guest lifecycle policy affects your actions

| Sponsor action or state | Possible policy behavior |
| --- | --- |
| **Extend sponsorship completed** | The last attestation date is updated. Other policy rules, such as activity or access package requirements, are evaluated separately. |
| **Extend sponsorship overdue** | The policy can notify the sponsor or guest and begin a configured grace period before disabling or deleting the guest account. |
| **Sponsorship ended, but other sponsors remain** | Your sponsor relationship is removed. The guest remains sponsored by the other assigned sponsors. |
| **Guest has fewer than the required sponsors** | The guest might become noncompliant with the minimum sponsor requirement and might be disabled or deleted according to the organization's policy. |

## Recommended practices

- Review guests promptly when My Account or your organization sends an extension reminder.
- Use last sign-in, access package assignments, and your knowledge of the business relationship together. Don't rely on one signal alone.
- End sponsorship when you no longer have enough context to attest continued need.
- If another employee owns the relationship, coordinate sponsorship coverage before you end yours.

## Related content

- [Guest lifecycle policies in Lifecycle Workflows](guest-lifecycle-policies.md)
- [Sponsors field for B2B users](../external-id/b2b-sponsors.md)
