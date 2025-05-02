---
title: 'Access Reviews FAQs'
description: Frequently asked questions about Access Reviews.
author: owinfreyATL
manager: femila
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: faq
ms.date: 05/02/2025
ms.author: owinfrey
ms.reviewer: jgangadhar
ms.custom: template-tutorial
---

# Access Reviews - FAQs

In this article, you find questions to commonly asked questions about [access reviews](access-reviews-overview.md). Check back to this page frequently as changes happen often, and answers are continually being added.

## Frequently asked questions

### Can I stop a recurring access review series at any time?

While there's no direct "**Stop**" button for a series, you can edit the series to set an earlier end date. This prevents new review instances from being generated after that date.


### Do access reviews reflect real-time changes to users or access during the review period?

No. Access reviews capture a snapshot of access at the start of each review instance. Any changes made to user assignments, group membership, or reviewer configuration after the review begins will not be reflected in that instance.
These updates will instead be captured in the next instance of the review (if it's a recurring review). At the start of each recurrence, the system re-evaluates and retrieves the latest information about users, resources, and reviewers.

### I completed an access review but don’t see any changes yet. Why?

When a reviewer completes an access review, it means they’ve submitted their decisions. However, changes to access won’t be applied until the review reaches its scheduled end date.

If the review is set to **auto-apply**, the system will apply the decisions shortly after the end date. **If auto-apply is not enabled**, an administrator must manually apply the results. You can confirm whether auto-apply is enabled in the review’s configuration settings.

> [!NOTE]
> Even if a reviewer completes their review early (e.g., on day 1 of a 10-day review), access changes still won’t take effect until the end of the review period.

### What happens if reviewers miss the review deadline?

If reviewers don’t take action by the review end date, system will automatically apply the admin configured default decision (e.g., approve, deny, or take recommendations) for users who weren’t reviewed.

### How can admins view upcoming reviews in a recurring series?

There are several scenarios where system is unable to apply review outcomes, especially for denied users: Reviewing members of a synced on-premises Windows Server AD group: If the group is synced from on-premises Windows Server AD, the group cannot be managed in Microsoft Entra ID and therefore membership cannot be changed.

- Reviewing a resource (role, group, or application) with nested groups assigned: For users who have membership through a nested group, we will not remove their membership to the nested group and therefore they will retain access to the resource being reviewed.
- User not found / other errors can also result in an apply result not being supported.
- Reviewing the members of mail enabled group: The group cannot be managed in Microsoft Entra ID, so membership cannot be changed.
- Reviewing an Application that uses group assignment will not remove the members of those groups, so they will retain the existing access from the group relationship for the application assignment.  

### Why don’t new group owners appear as reviewers during an ongoing group access review?

When a group or team access review starts, only the group owners at the time the review begins are assigned as reviewers.
If group ownership changes during the review (e.g., new owners are added or existing ones are removed), those changes do not affect the current instance — the original reviewers remain unchanged.
However, for recurring reviews, any updates to group ownership will be reflected in the next review instance.

### How can I see which reviewers were notified for an access review?

Once an access review has started, you can use the [contactedReviewers](/graph/api/resources/accessreviewreviewer?view=graph-rest-1.0) API to retrieve the list of all users who were (or would have been) notified via email to perform reviews.
This includes scenarios where notifications were turned off — the API still provides the list of reviewers along with timestamps indicating when they were notified.


## Next steps

- [What are access reviews?](access-reviews-overview.md)
