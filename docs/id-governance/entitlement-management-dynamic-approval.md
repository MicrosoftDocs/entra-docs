---
title: Externally determine the approval requirements for an Entitlement management access package
description: A tutorial on determining the approval requirements for an entitlement access package using a custom extension.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: tutorial #Required; leave this attribute/value as-is
ms.date: 04/12/2025

#CustomerIntent: As a < type of user >, I want < what? > so that < why? > .
---

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a Tutorial - General article pattern. See the
[instructions - Tutorial](../level4/article-tutorial.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

Tutorial is an article pattern that leads a user through a common scenario showing them how a product or service can address their needs.

You only use tutorials to show the single best procedure for completing a top customer task.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "Tutorial: <verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the scenario the user will complete.

For example: "Tutorial: Create a Node.js and Express app in Visual Studio".

* Include only a single H1 in the article.
* If the Tutorial is part of a numbered series, don't include the number in the H1.
* Don't start with a gerund.
* Don't add "Tutorial:" to the H1 of any article that's not a Tutorial.

-->

# Tutorial: Externally determine the approval requirements for an Entitlement management access package

<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what common scenario the 
customer will accomplish in the Tutorial. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don’t link away from the article to other content.
* Don't use a bulleted list of article H2 sections.

Example: Azure Monitor alerts proactively notify you when important conditions are found in your monitoring data. Metric alert rules create an alert when a metric value from an Azure resource exceeds a threshold.

-->

Scenario: Use custom extensibility and an Azure Logic App to externally determine the approval requirements of an Entitlement Management access package request. 

In this tutorial, you'll:

> [!div class="checklist"]

> * Create the custom extension and its underlying Logic App.
> * Reference the custom extension in an access package assignment policy.
> * Configure the Logic App and corresponding business logic.

## Prerequisites

- A Microsoft Entra user account with an active Azure subscription. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- At least the [Microsoft Entra role](../identity/role-based-access-control/permissions-reference.md) of [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
- At least the [Azure built-in role](/azure/role-based-access-control/built-in-roles) of [Logic App Contributor](/azure/role-based-access-control/built-in-roles/integration#logic-app-contributor) on the Logic App itself or on the resource group, subscription, or management group that the workflow is in. 

For more information on required Entitlement Management licenses, see [License requirements](entitlement-management-overview.md#license-requirements).

<!-- 6. Account sign in --------------------------------------------------------------------

Required: If you need to sign in to the portal to do the Tutorial, this H2 and link are required.

-->

## Create the custom extension and its underlying Logic App.

To create a custom extension and its underlying Logic App, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Identity governance** > **Entitlement management** > **Catalogs**.

1. On the Catalogs screen, you can select an existing catalog to create your custom extension in, or create a new catalog.

1. On the catalog screen where you want to create your custom extension, select **Custom extensions**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extensibility-catalog-screen.png" alt-text="Screenshot of catalog screen where custom extension is being added.":::
1. Select “Add a custom extension” and add a name and description for the custom extension. When finished, select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/custom-extension-basics.png" alt-text="Screenshot of custom extension basics.":::
1. On the **Extension Type** screen, select **Request workflow (triggered when an access package is request, approved, granted or removed)**, then select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extension-type.png" alt-text="Screenshot of selecting the extension type for a custom extension.":::
1. On the **Extension Confirugation screen**, for Behavior select **Launch and wait**, for Response data select **Approval Stage (Preview)**, and then select **Next**.

1. On the **Details** screen, choose a subscription, resource group, and name for the Logic App being created. Once you have entered in this information, select **Create a logic app**. Once the logic app is created, select **Next**.

1. On the **Review + create** screen, make sure all your details are correct then select **Create**. 


## Reference the custom extension in an access package assignment policy.
TODO: Add introduction sentence(s)
[Include a sentence or two to explain only what is needed to complete the procedure.]
TODO: Add ordered list of procedure steps
1. Step 1
1. Step 2
1. Step 3

## Configure the Logic App and corresponding business logic.
TODO: Add introduction sentence(s)
[Include a sentence or two to explain only what is needed to complete the procedure.]
TODO: Add ordered list of procedure steps
1. Step 1
1. Step 2
1. Step 3

## Related content

- [Tutorial: Integrating Microsoft Entra Entitlement Management with Microsoft Teams using Custom Extensibility and Logic Apps](entitlement-management-custom-teams-extension.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->
