---
title: Include custom resource access data in the catalog for catalog User Access Reviews
ms.reviewer: jgangadhar
description: Learn how to include custom resource access data in Microsoft Entra catalogs to create User Access Reviews for disconnected applications.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: "how-to" # Required; leave this attribute/value as-is
ms.date: 11/05/2025

#CustomerIntent: As an Identity Governance Administrator, I want to create a catalog in Microsoft Entra so that I can manage custom resource access data for User Access Reviews..
---

# Include custom resource access data in the catalog for catalog User Access Reviews

Learn how to manage access to disconnected applications by including custom resource access data in Microsoft Entra catalogs. This guide walks you through creating a catalog, adding custom resource access data, and setting up User Access Reviews (UARs) for applications not integrated with Microsoft Entra. By using this process, organizations can ensure governance over access to custom applications, enabling managers to make informed access decisions through the My Access portal.

## License requirements

[!INCLUDE [active-directory-p2-governance-license.md](../includes/entra-p2-governance-license.md)]

## Create a catalog

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!TIP]
    > Other least privilege roles that can complete this task include the Catalog creator. Users who were assigned to the User Administrator role will no longer be able to create catalogs or manage access packages in a catalog they don't own. If users in your organization were assigned to the User Administrator role to configure catalogs, access packages, or policies in entitlement management, you should instead assign these users the Identity Governance Administrator role.
1. Browse to **ID Governance** > **Entitlement management** > **Catalogs**.

1. Select **New catalog**.

1. Enter a unique name for the catalog and provide a description.

    Users see this information in an access package's details.
1. Select **Create** to create the catalog.

## Add a custom resource access data to a catalog

With a catalog created, you can add custom resource access data to it by doing the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Catalogs**.

1. On the Catalogs page, open the catalog you created in the previous section.

1. On the left menu, select **Resources**.

1. Select **Add resources**.

1. Select the resource type:  **Custom resource access data**.
    :::image type="content" source="media/custom-resource-data-access-reviews/custom-resource-access-data-information.png" alt-text="Screenshot of adding custom access resource data extension information.":::
1. On the resource page, enter:
   - **Resource name** – Example: *FinanceApp_CSV*.  
   - **Description** – Example: *Custom BYOD application data provided via CSV upload.*  
1. Select **Save**.

## Create a User Access Review

> [!IMPORTANT]
> BYOD reviews currently support **single-stage reviews** where **managers** are the only available reviewers.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews** > **new access review**.

1. On the Access reviews template screen, select **Review users access across multiple resource types within a catalog**, and select **catalog review template**.
    :::image type="content" source="media/catalog-access-reviews/access-review-templates.png" alt-text="Screenshot of the access review templates page.":::
1. Enter in [basic information](create-access-review.md) about the workflow and select **Next**. 

1. On the **resources** tab, select the catalog where you added the resources on and select **Next**.

1. On the **Reviewers and schedule** tab, select reviewers you want to conduct access reviews. Currently only single stage reviews where the managers of the users who the access reviews are for can be set as reviewers.

1. Select **Create**. 


## Upload custom data

When the review is created, its **status** shows as **Initializing**.
    :::image type="content" source="media/custom-resource-data-access-reviews/initializing-access-review-status.png" alt-text="Initializing access review status.":::
1. On the resource screen for the catalog, select the custom data access resource you created and select **Upload custom access data**.
    :::image type="content" source="media/custom-resource-data-access-reviews/upload-custom-access-data.png" alt-text="Screenshot of the upload custom access data option.":::

1. On the Upload access data for custom resource screen under **Basics**, enter in both the access review object ID, and the Access review instance object ID. Both of these can be found under the essentials section when selecting either an access review, or access review instance.

1. Under **Upload files** select up to 10 CSVs to include in the access data and select **Save**. 
    > [!NOTE]
    > To confirm all CSVs were uploaded successfully, view the [audit logs](entitlement-management-logs-and-reporting.md).
1. You have **up to two hours** from the time the review enters the *Initializing* state to complete the upload. After two hours, the system transitions the review status to **Active**.

At the **Active** stage:
- Reviewers receive an email notification.
- They can sign in to the [My Access portal](https://myaccess.microsoft.com) to view and complete their review decisions.


## Complete and apply review decisions

As reviewers take actions, the review progresses through several states:

| Review Status | Description |
|--------------------|-----------------|
| Initializing | Review created; waiting for custom data upload. |
| Active | Reviewers can take decisions in the My Access portal. |
| Applying | Review decisions are being remediated. |
| Applied | All decisions are marked as applied. |

When the review status changes to **Applying**:
- Customers can mark **individual decisions** as *Applied*, or mark the **entire review** as *Applied*, to indicate all access decisions are remediated.  
- Once all decisions are applied, the review automatically updates to **Applied**, completing the review lifecycle.



## Timeframes summary

| Action | When | Time limit |
|-------------|-----------|----------------|
| Upload custom data | During *Initializing* | Within two hours. |
| Review decisions | During *Active* | Until the review end date. |
| Apply decisions | During *Applying* | 30 days and review remain in applying status until all decisions are marked as applied.|



## Related content



- [Catalog Access Reviews (Preview)](catalog-access-reviews.md)
- [Create and manage a catalog of resources in entitlement management](entitlement-management-catalog-create.md)

