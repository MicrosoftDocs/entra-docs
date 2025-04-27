---
title: Externally determine the approval requirements for an Entitlement management access package
description: An how-to guide on dynamically determining the approval requirements for an access package externally using a custom extension.
author: owinfreyATL
manager: femila
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to 
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

# Create a custom extension to externally determine the approval requirements for an entitlement management access package.



Scenario: Use custom extensibility and an Azure Logic App to externally determine the approval requirements of an Entitlement Management access package request. 

In this tutorial, you'll:

> [!div class="checklist"]

> * Create the custom extension and its underlying Logic App.
> * Reference the custom extension in an access package assignment policy.
> * Configure the Logic App and corresponding business logic.

## License requirements

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]

## Prerequisites

- A Microsoft Entra user account with an active Azure subscription. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- At least the [Microsoft Entra role](../identity/role-based-access-control/permissions-reference.md) of [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
- At least the [Azure built-in role](/azure/role-based-access-control/built-in-roles) of [Logic App Contributor](/azure/role-based-access-control/built-in-roles/integration#logic-app-contributor) on the Logic App itself or on the resource group, subscription, or management group that the workflow is in. 

For more information on required Entitlement Management licenses, see [License requirements](entitlement-management-overview.md#license-requirements).

<!-- 6. Account sign in --------------------------------------------------------------------

Required: If you need to sign in to the portal to do the Tutorial, this H2 and link are required.

-->

## Create the custom extension and its underlying logic App.

To create a custom extension and its underlying Azure Logic App, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Catalog owner](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) of the catalog where the custom extension will be located.

1. Browse to **Identity governance** > **Entitlement management** > **Catalogs**.

1. On the Catalogs overview screen, you can select an existing catalog to create your custom extension in, or create a new catalog.

1. On the specific catalog screen where you want to create your custom extension, select **Custom extensions**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extensibility-catalog-screen.png" alt-text="Screenshot of catalog screen where custom extension is being added.":::
1. Select “Add a custom extension” and add a name and description for the custom extension. When finished, select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/custom-extension-basics.png" alt-text="Screenshot of custom extension basics.":::
1. On the **Extension Type** screen, select **Request workflow (triggered when an access package is request, approved, granted or removed)**, then select **Next**.
    :::image type="content" source="media/entitlement-management-dynamic-approval/extension-type.png" alt-text="Screenshot of selecting the extension type for a custom extension.":::
1. On the **Extension Configuration screen**, for Behavior select **Launch and wait**, for Response data select **Approval Stage (Preview)**, and then select **Next**.

1. On the **Details** screen, choose a subscription, resource group, and name for the logic App being created. Once you have entered in this information, select **Create a logic app**. Once the logic app is created, select **Next**.

1. On the **Review + create** screen, make sure all your details are correct then select **Create**. 


## Reference the custom extension in an access package assignment policy.

Once you've created the custom extension and logic app, you can reference the custom extension in an access package assignment policy by doing the following steps:

1. Select the catalog in which the custom extension was created.

1. On the catalog screen, select **Access packages**, and select the access package for the policy you want to update.

1. On the access package overview page, select **Policies**, and select the policy to edit.
    :::image type="content" source="media/entitlement-management-dynamic-approval/access-package-policies-list.png" alt-text="Screenshot of the policies list for an access package.":::
1.  On the **Edit policy** screen under **Requests**, set the **Require approval* box to yes, and you are able to add your custom extension as the first approver.
  :::image type="content" source="media/entitlement-management-dynamic-approval/custom-extension-approver.png" alt-text="Screenshot of the custom extension as first approver in access package policy.":::  
1. Select **Update**.

Once updated, you can go to the edited policy, and confirm the change by selecting **Approval stage details**:
:::image type="content" source="media/entitlement-management-dynamic-approval/access-package-approval-stage-details.png" alt-text="Screenshot of edited approval stage details.":::  

## Configure the Azure Logic App and corresponding business logic.

With the Azure logic app created, you must edit the logic app so that it can communicate with Microsoft Entra. To edit the logic app, you'd do the following steps:


1. Sign in to the Azure portal and go to the subscription, resource group, or logic app itself with the [Azure built-in role](/azure/role-based-access-control/built-in-roles) of at least [Logic App Contributor](/azure/role-based-access-control/built-in-roles/integration#logic-app-contributor).

1. On the logic app created, go to **Development Tools** > **Logic app designer**.

1. On the designer screen, remove everything under the **manual** trigger, and select the **Add an action** button.
    :::image type="content" source="media/entitlement-management-dynamic-approval/logic-app-add-action.png" alt-text="Screenshot of  adding action in logic app designer.":::
1. 

## Related content

- [Tutorial: Integrating Microsoft Entra Entitlement Management with Microsoft Teams using Custom Extensibility and Logic Apps](entitlement-management-custom-teams-extension.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->
