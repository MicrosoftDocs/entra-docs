---
title: Assign Azure RBAC Roles - Entitlement management (Preview)
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 01/20/2026

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

How-to is a procedure-based article pattern that show the user how to complete a task in their own environment. A task is a work activity that has a definite beginning and ending, is observable, consist of two or more definite steps, and leads to a product, service, or decision.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "<verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the task the user will complete.

For example: "Migrate data from regular tables to ledger tables" or "Create a new Azure SQL Database".

* Include only a single H1 in the article.
* Don't start with a gerund.
* Don't include "Tutorial" in the H1.

-->

# Assign Azure RBAC roles in Entitlement Management (Preview)


Entitlement Management supports access lifecycle for various resource types such as Applications, SharePoint sites, Groups, Teams, and [Microsoft Entra Roles](entitlement-management-roles.md). To manage access to Azure resources, the ability to assign access to Azure RBAC roles directly to Access packages and Catalogs have been introduced.

By assigning Azure RBAC roles to employees, and guests, using Entitlement Management, you can look at an identity's entitlements to quickly determine which azure roles are assigned to that identity.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]


## Add an Azure RBAC role to a Catalog

To assign an azure RBAC role to a catalog within entitlement management, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) or [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) with Catalog Owner permissions.

1. Browse to **ID Governance** > **Catalogs**.

1. On the Catalogs page, open the catalog you want to add the Azure resource role to and select **Add Resources**.

1. On the add resources page, select **Azure Resources (Preview)**.
    :::image type="content" source="media/entitlement-management-azure-role-assignments/azure-resources-catalog.png" alt-text="Screenshot of Azure resources within the available resources on the catalog add resources page.":::
1. On the **Select Azure Resources** pane, select either **Subscription** or **Management Group**.
    :::image type="content" source="media/entitlement-management-azure-role-assignments/select-azure-resource-type.png" alt-text="Screenshot of selecting the azure resource type.":::
1. From the list, select which Azure subscription or management group that you want to add to the catalog.
    :::image type="content" source="media/entitlement-management-azure-role-assignments/azure-subscription-list.png" alt-text="Screenshot of list of available azure subscriptions.":::
1. If choosing subscription, under Scope, choose where the role assignment applies.
    :::image type="content" source="media/entitlement-management-azure-role-assignments/azure-scope.png" alt-text="Screenshot of azure scope.":::
1. For role type, you can select the following:
    **Active**: For roles that should be permanently assigned. <br>
    **Eligible**: For roles that require elevation via [Privileged Identity Management (PIM)]() when needed. 
    :::image type="content" source="media/entitlement-management-azure-role-assignments/azure-role-type.png" alt-text="Screenshot of selecting the role type for the Azure role.":::
1. Select the Azure RBAC Role to assign. Both built-in roles and Azure Custom roles are available.
    :::image type="content" source="media/entitlement-management-azure-role-assignments/azure-role-list.png" alt-text="Screenshot of selecting the Azure role.":::

1. With the resource selected, select **Add**.

> [!NOTE]
> The identity governance administrator adding a subscription to the catalog must be the resource owner for the subscription.


## Add an Azure RBAC role to an access package

Azure RBAC roles can also be assigned to both new, and existing, access packages directly for more specific assignments. To add an Azure RBAC role to an existing  access package, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
    > [!TIP]
    > Other least privilege roles that can complete this task include the Catalog owner or Access Package manager.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select an existing access package you want to add the Azure RBAC roles to.

1. On the access package overview page, select **Resources**.
     :::image type="content" source="media/entitlement-management-azure-role-assignments/access-package-resource-roles.png" alt-text="Screenshot of resource role option on an existing access package.":::
1. On the add resources page, select **Azure Resources (Preview)**.

## Related content



- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->
