---
title: Include custom resource access data in the catalog for catalog User Access Reviews
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 11/05/2025

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

# Include custom resource access data in the catalog for catalog User Access Reviews


<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

This article describes how to include  custom resource access data in a catalog and use it to create catalog User Access Reviews (UAR) applications which are not yet integrated with Microsoft Entra

Including these custom resource access data in UAR reviews allow organizations to govern access to disconnected applications by providing custom application data through an upload process. Reviewers (currently managers) can then attest access decisions through the My Access portal.


<!---Avoid notes, tips, and important boxes. Readers tend to skip over them. Better to put that info directly into the article text.

-->

<!-- 3. Prerequisites --------------------------------------------------------------------

Required: Make Prerequisites the first H2 after the H1. 

* Provide a bulleted list of items that the user needs.
* Omit any preliminary text to the list.
* If there aren't any prerequisites, list "None" in plain text, not as a bulleted item.

-->

## License requirements

[!INCLUDE [active-directory-p2-governance-license.md](../includes/entra-p2-governance-license.md)]

<!-- 4. Task H2s ------------------------------------------------------------------------------

Required: Multiple procedures should be organized in H2 level sections. A section contains a major grouping of steps that help users complete a task. Each section is represented as an H2 in the article.

For portal-based procedures, minimize bullets and numbering.

* Each H2 should be a major step in the task.
* Phrase each H2 title as "<verb> * <noun>" to describe what they'll do in the step.
* Don't start with a gerund.
* Don't number the H2s.
* Begin each H2 with a brief explanation for context.
* Provide a ordered list of procedural steps.
* Provide a code block, diagram, or screenshot if appropriate
* An image, code block, or other graphical element comes after numbered step it illustrates.
* If necessary, optional groups of steps can be added into a section.
* If necessary, alternative groups of steps can be added into a section.

-->

## Create a catalog

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!TIP]
    > Other least privilege roles that can complete this task include the Catalog creator. Users who were assigned the User Administrator role will no longer be able to create catalogs or manage access packages in a catalog they don't own. If users in your organization were assigned the User Administrator role to configure catalogs, access packages, or policies in entitlement management, you should instead assign these users the Identity Governance Administrator role.
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

1. Select the resource type:  **custom resource access data**.

1. On the resource page enter:Enter:
   - **Resource name** – Example: *FinanceApp_CSV*.  
   - **Description** – Example: *Custom BYOD application data provided via CSV upload.*  
1. Select **Save**.

> [!NOTE]
> A custom data resource represents a custom access resource dataset that customers later upload through the Upload API.

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

When the review is created, its **status** will show as **Initializing**.

1. While the review status is **Initializing**, call the **Upload API** to upload your BYOD data ( CSV file).  

1. You have **up to 2 hours** from the time the review enters the *Initializing* state to complete the upload. After 2 hours, the system transitions the review status to **Active**.

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
| Applied | All decisions have been marked as applied. |

When the review status changes to **Applying**:
- Customers can mark **individual decisions** as *Applied*, or mark the **entire review** as *Applied*, to indicate all access decisions have been remediated.  
- Once all decisions are applied, the review automatically updates to **Applied**, completing the review lifecycle.



<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

