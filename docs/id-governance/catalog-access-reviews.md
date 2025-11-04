---
title: Catalog Access Reviews (Preview)
description: This article describes what Catalog access reviews are, how to create one, and how to complete a review for one.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/30/2025

#CustomerIntent: As an ID administrator, I want to create catalog access reviews so that set up access reviews for multiple resources within a catalog at once.
---

# Catalog Access Reviews (Preview)

Microsoft Entra ID Access reviews help organizations efficiently manage group memberships, enterprise application access, and role assignments. These reviews ensure that only the right people retain access over time. Historically, access reviews  were conducted on individual resources such as groups, applications, roles, and access packages. With catalog access reviews, access reviews can review multiple resource types such as apps and groups on a catalog level by the manager of users who are having their access reviewed. Currently, Multi-stage reviews are supported with catalog access reviews. The first stage is the manager of the user having their access reviews. The second stage is resource owners for the resources being reviewed for the user. For example, group resource owners are the group owners, and application resource owners are the application owners defined on the application object. Catalog access reviews allow you to quickly approve, or deny, access to many different resources within a catalog for users at once. This article walks you through completing a catalog access review.



## License requirements

[!INCLUDE [active-directory-p2-governance-license.md](../includes/entra-p2-governance-license.md)]


## Add resources to catalog

To complete access reviews at the catalog level, you must first add resources to a catalog. Groups and Applications are currently the two resources that can be reviewed by catalog. To add resources to a catalog, you'd do the following steps:


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Entitlement management** > **Catalogs**.

1. On the catalogs screen, select an existing catalog or select **New Catalog** to create a new one.

1. On the catalog overview page, select **Resources** > **Add resource**.

1. Choose the groups and applications you want to include in the catalog.

1. With the resources selected, select **Add** to save them in the catalog.


## Create a catalog access review

Once you add resources to a catalog, it's time to create a catalog access review so that you can review all of these resources at once for a user you manage. To create a catalog access review, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews** > **new access review**.

1. On the Access reviews template screen, select **Review users access across multiple resource types within a catalog**, and select **catalog review template**.
    :::image type="content" source="media/catalog-access-reviews/access-review-templates.png" alt-text="Screenshot of the access review templates page.":::
1. Enter in [basic information](create-access-review.md) about the workflow and select **Next**. 

1. On the **resources** tab, select the catalog where you added the resources on and select **Next**.

1. On the **Reviewers and schedule** tab, select reviewers you want to conduct access reviews. Currently only managers of the users who the access reviews are for can be set as reviewers. Multi-stage reviews are possible with managers of the users as primary approvers, and resource owners(Group owners for groups and Application owners for Applications) as fallback approvers.

1. Enter information about reviewer experience and upon completion settings and select **Next**.

1. Select **Create**. 


## Completing a catalog access review

When the catalog access review is created, Managers receive an email notification that directs them to the myaccess portal. They can also directly navigate to the myaccess portal where they can view their direct report's access to all resources in the catalog.

To complete a catalog access review, you'd do the following steps:

1. Sign in to the My Access portal at [https://myaccess.microsoft.com](https://myaccess.microsoft.com) as the manager of the users you want to complete the catalog access review for. 

1. In the left menu, select **Access reviews** to see a list of access reviews pending approval. 

1. Select an access review, choose whether to approve or deny access, and give a justification for your selection.

1. Select **Submit**. 

On the review end date, all decisions are automatically applied.

## Related content

- [Create an access review of groups and applications in Microsoft Entra ID ](create-access-review.md)


