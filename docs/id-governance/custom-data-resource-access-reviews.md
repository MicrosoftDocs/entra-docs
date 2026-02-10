---
title: Include custom data provided resource in the catalog for catalog user Access Reviews (Preview)
ms.reviewer: jgangadhar
description: Learn how to include custom data provided resource in Microsoft Entra catalogs to create user Access Reviews for disconnected applications.
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: "how-to" # Required; leave this attribute/value as-is
ms.date: 11/05/2025

#CustomerIntent: As an Identity Governance Administrator, I want to create a catalog in Microsoft Entra so that I can manage custom data provided resource for User Access Reviews..
---

# Include custom data provided resource in the catalog for catalog user Access Reviews (Preview)

Organizations often have applications that aren’t yet integrated with Microsoft Entra but still need to be governed. Using custom data provided resources, you can include these disconnected applications in Microsoft Entra ID access reviews by uploading their access data directly into a catalog.

This capability enables you to run user Access Reviews (UARs) across both Microsoft Entra-connected, and custom, resources within the same catalog. Reviewers can easily review and certify users’ access in the My Access portal, helping ensure consistent governance, improved visibility, and compliance across all resources whether or not they’re connected to Microsoft Entra.

## License requirements

This feature requires Microsoft Entra ID Governance or Microsoft Entra Suite subscriptions, for your organization's users. For more information, see the articles of each capability for more details. To find the right license for your requirements, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).


## Create a catalog

If you do not yet have a catalog, then create a new catalog. If you have a catalog already, then continue at the [next section](#add-a-custom-data-provided-resource-to-a-catalog).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) or catalog creator.
    > [!TIP]
    > Users who were assigned to the User Administrator role will no longer be able to create catalogs or manage access packages in a catalog they don't own. If users in your organization were assigned to the User Administrator role to configure catalogs, access packages, or policies in entitlement management, you should instead assign these users the Identity Governance Administrator role.
1. Browse to **ID Governance** > **Catalogs**.

1. Select **New catalog**.

1. Enter a unique name for the catalog and provide a description.

    Users see this information in an access package's details.
1. Select **Create** to create the catalog.

For more information on creating a catalog and adding resources, see [Create and manage a catalog of resources](entitlement-management-catalog-create.md).

## Add a custom data provided resource to a catalog

With a catalog created, you can add custom data provided resources to it by doing the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Catalogs**.

1. On the Catalogs page, open the catalog you created in the previous section.

1. On the left menu, select **Resources**.

1. Select **Add resources**.

1. Select the resource type:  **custom data provided resource**.
    :::image type="content" source="media/custom-data-resource-access-reviews/custom-data-provided-information.png" alt-text="Screenshot of adding custom access resource data extension information.":::
1. On the resource page, enter:
   - **Resource name** – A name for the resource. 
   - **Description** – A description for the resource.  
1. Select **Save**.

## Create a User Access Review

> [!IMPORTANT]
> Custom data resource reviews currently support **single-stage reviews** where **managers** are the only available reviewers.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews** > **new access review**.

1. On the Access reviews template screen, select **Review users access across multiple resource types within a catalog**, and select **catalog review template**.
    :::image type="content" source="media/catalog-access-reviews/access-review-templates.png" alt-text="Screenshot of the access review templates page.":::
1. Enter in [basic information](create-access-review.md) about the workflow and select **Next**. 

1. On the **resources** tab, select the catalog where you added the resources on and select **Next**.

1. On the **Reviewers and schedule** tab, select reviewers you want to conduct access reviews. Currently only single stage reviews where the managers of the users who the access reviews are for can be set as reviewers.

1. Select **Create**. 


You can also create an access review programmatically using Microsoft Graph. For more information, see [Create a single stage access review on a catalog](/graph/api/accessreviewset-post-definitions?view=graph-rest-beta&tabs=http#example-6-create-a-single-stage-access-review-on-a-catalog).

## Get Access Review Object and Instance ID

After creating the catalog access review, but before uploading your custom data, you must get both the Access Review object ID, and the Access Review instance object ID. To get this information, you'd do the following:

1. Browse to **ID Governance** > **Access Reviews**.

1. Select the catalog access review you created.

1. On the Access Review overview screen, copy the **Object ID**.
    :::image type="content" source="media/custom-data-resource-access-reviews/access-review-object-id.png" alt-text="Screenshot of finding the access review object ID.":::
1. Select the current instance of the access review on the access review overview screen.

1. On the access review instance screen, save the instance **Object ID**.
    :::image type="content" source="media/custom-data-resource-access-reviews/access-review-instance-object-id.png" alt-text="Screenshot of finding the access review instance object ID.":::



## Upload custom data

After copying both the Access review object, and access review instance object, IDs note that the status of the access review shows as **Initializing**.
    :::image type="content" source="media/custom-data-resource-access-reviews/initializing-access-review-status.png" alt-text="Initializing access review status.":::


1. Return to the catalog you created, and select **Resources**.

1. On the resource screen for the catalog, select the custom data access resource you created, and select **Upload custom access data**.
    :::image type="content" source="media/custom-data-resource-access-reviews/upload-custom-access-data.png" alt-text="Screenshot of the upload custom access data option.":::

1. On the Upload access data for custom resource screen under **Basics**, enter in both the access review object ID, and the Access review instance object ID found in the section [Get Access Review Object and Instance ID](custom-data-resource-access-reviews.md#get-access-review-object-and-instance-id).
    :::image type="content" source="media/custom-data-resource-access-reviews/upload-access-data-basics.png" alt-text="Screenshot of basic information for custom data access.":::
1. Under **Upload files** select up to 10 CSVs to include in the access data and select **Save**. 
    :::image type="content" source="media/custom-data-resource-access-reviews/upload-access-data-files.png" alt-text="Screenshot of uploading files to custom access data.":::
    > [!NOTE]
    > To confirm all CSVs were uploaded successfully, view the [audit logs](entitlement-management-logs-and-reporting.md).
1. You have **up to two hours** from the time the review enters the *Initializing* state to complete the upload.

## Custom data for access CSV fields

When uploading CSVs to be included in the access data, the following parameters are included in the template:

> [!NOTE]
> All columns are mandatory.

|Parameter  |Description  |
|---------|---------|
|PrincipalId     |    The **Microsoft Entra ID User ID** of the user whose access needs to be reviewed. This value must match a valid Microsoft Entra user.     |
|PrincipalType     |   Specifies the type of principal. For access reviews this will always be **EntraIdUser**.      |
|PermissionId     |   A unique identifier for the permission in the application that will be reviewed. This helps distinguish between different permissions within the same app.      |
|PermissionName     |   The display name of the permission that the user has in the application. Example: Read, Write, and Admin.     |
|PermissionDescription     |   A brief explanation of what this permission allows within the application. This provides reviewers with context when deciding whether access should be continued.     |
|PermissionType     |   Indicates the category of permission.      |


You can also upload custom data via Graph by creating an upload session and then uploading a CSV file. For more information, see [customDataProvidedResourceUploadSession](/graph/api/resources/customdataprovidedresourceuploadsession?view=graph-rest-beta).

## Active review state

At the **Active** stage:
- Reviewers receive an email notification.
- They can sign in to the [My Access portal](https://myaccess.microsoft.com) to view and complete their review decisions.


## Applying stage


In the **Applying** stage, you can get a list of denied users by making the [list decisions](/graph/api/accessreviewinstance-list-decisions?view=graph-rest-beta&tabs=http) API call:

``` http
GET https://graph.microsoft.com/beta/identityGovernance/accessReviews/definitions/{access review object ID}/instances/{access review instance object ID}/decisions?$filter=(decision eq 'Deny' and resourceId eq '<custom data provided resource ID>')
```

For each decision item: 

Remove access from your own system and then patch each decision item to indicate success or failure for removal by making the [update accessReviewInstanceDecisionItem](/graph/api/accessreviewinstancedecisionitem-update?view=graph-rest-beta&tabs=http) API call:

``` http
PATCH https://graph.microsoft.com/beta/identityGovernance/accessReviews/definitions/{access review object ID}/instances/{access review instance object ID}/decisions/{decision ID}
Content-Type: application/json

{
 "applyResult": "AppliedSuccessfully",
 "applyDescription": "ServiceNow ticket created"
}
```

The review transition to the **Applied** state once all the custom data provided decisions have been applied. For example, if you have five decisions that must be made from the data, you must apply using PATCH each of five decision items before the review transitions to **Applied**.




## Review status

As reviewers take actions, the review progresses through several states:

| Review Status | Description |
|--------------------|-----------------|
| Initializing | Review instance created; waiting for custom data upload. |
| Active | Reviewers can take decisions in the My Access portal. |
| Applying | Review decisions are being remediated. |
| Applied | All decisions are marked as applied. |



## Timeframes summary

| Action | When | Time limit |
|-------------|-----------|----------------|
| Upload custom data | During *Initializing* | Within two hours. |
| Review decisions | During *Active* | Until the review end date. |
| Apply decisions | During *Applying* | 30 days and review remain in applying status until all decisions are marked as applied.|



## Related content



- [Catalog Access Reviews (Preview)](catalog-access-reviews.md)
- [Create and manage a catalog of resources in entitlement management](entitlement-management-catalog-create.md)

