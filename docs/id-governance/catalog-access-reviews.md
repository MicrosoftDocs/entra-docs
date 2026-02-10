---
title: Catalog Access Reviews (Preview)
description: This article describes what Catalog Access Reviews are, how to create one, and how to complete a review for one.
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/30/2025

#CustomerIntent: As an ID administrator, I want to create catalog access reviews so that set up access reviews for multiple resources within a catalog at once.
---

# Catalog Access Reviews (preview)

Catalog access reviews in Microsoft Entra ID Governance enables organizations to simplify how managers can review users access to multiple resource types, such as groups, applications and custom disconnected resource at once. This helps ensure only the right people retain access, while enabling managers and resource owners to review access efficiently through a multi-stage process.

## License requirements

This feature requires Microsoft Entra ID Governance or Microsoft Entra Suite subscriptions, for your organization's users. For more information, see the articles of each capability for more details. To find the right license for your requirements, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).



## Add resources to catalog

To enable access reviews across multiple resources in a single reviewer experience, you must first add those resources to a catalog. Groups, Applications and custom data provided resources are currently the three resources that can be reviewed by catalog. To add resources to a catalog:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) or catalog creator, and as the owner or administrator of the resources.

1. Browse to **Entitlement management** > **Catalogs**.

1. On the catalogs screen, select an existing catalog or select **New Catalog** to create a new one.

1. On the catalog overview page, select **Resources** > **Add resources**.

1. To review memberships of groups or teams, select **Groups and Teams** and choose the groups you want to include in the catalog. To review app role assignments, select **Applications** and choose the applications you want to include in the catalog.
    > [!NOTE]
    > In catalog access reviews, only groups, applications, and [custom data provided resources](custom-data-resource-access-reviews.md) are supported.
1. With the resources selected, select **Add** to save them in the catalog.
1. To enable the review to also include data from custom data providers, select **Custom Data Provided Resource (Preview)**, and provide the name and description of the resource. For more information, see [custom data provided resource](custom-data-resource-access-reviews.md).

For more information on creating a catalog and adding resources, see [Create and manage a catalog of resources](entitlement-management-catalog-create.md).

## Create a catalog access review

Once you add resources to a catalog, you can then create a catalog access review so that managers can then review access across all of these resources at once for the users they manage. To create a catalog access review, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews** > **New access review**.

1. On the Access reviews template screen, select **Review users access across multiple resource types within a catalog** to select the **catalog review template**.
    :::image type="content" source="media/catalog-access-reviews/access-review-templates.png" alt-text="Screenshot of the access review templates page.":::
1. Enter in [basic information](create-access-review.md) about the workflow and select **Next**. 

1. On the **resources** tab, select the catalog where you added the resources on and select **Next**.

1. On the **Reviewers and schedule** tab, Choose reviewers. Currently, managers of the users are the primary reviewers.

1. Optionally, you can configure [multi-stage reviews](using-multi-stage-reviews.md), where the resource owners (group or application owners) serve as secondary reviewers.

1. Configure **reviewer experience** options (email notifications, reminders, justification requirements) and **completion settings**.

1. Select **Create** to finalize the access review. 

You can also create an access review programmatically using Microsoft Graph. For more information, see [Create a single stage access review on a catalog](/graph/api/accessreviewset-post-definitions?view=graph-rest-beta&tabs=http#example-6-create-a-single-stage-access-review-on-a-catalog).

## Upload data from custom data resources

If you have added custom data provided resources to the catalog, then you must upload the data while the review instance is initializing. For more information, see [get access review object and instance ID](custom-data-resource-access-reviews.md#get-access-review-object-and-instance-id).

## Completing a catalog access review

When the catalog access review is created, managers receive an email notification that directs them to the myaccess portal. They can also directly navigate to the My Access portal where they can view their direct report's access to all resources in the catalog.

To complete a catalog access review, you'd do the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com) as the manager of the users you want to complete the catalog access review for. 

1. In the left menu, select **Access reviews** to see a list of access reviews pending approval. 

1. Select the **Multi-resource** tab to see a list of pending catalog access reviews. 

1. For each access item, choose **Approve** or **Deny**, and provide a justification if required.

1. Select **Submit** to record your decisions.

On the review end date, all decisions, excluding custom disconnected resources, are automatically applied. 

## Related content

- [Create an access review of groups and applications in Microsoft Entra ID](create-access-review.md)


