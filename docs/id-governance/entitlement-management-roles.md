---
title: Assign Microsoft Entra Roles - entitlement management
description: Learn how to assign Microsoft Entra roles with access packages.
author: owinfreyatl
manager: amycolannino
editor: mamtakumar
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 03/11/2024
ms.author: owinfrey
ms.reviewer: mamkumar

#Customer intent: As an admin, I want steps for how to add a Microsoft Entra role as a resource in an access packages so that I can assign Microsoft Entra roles using access packages.
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

# Assign Microsoft Entra Roles

Entitlement Management supports access lifecycle for various resource types, such as SharePoint sites, Groups, Teams. Sometimes users need additional permissions to utilize these resources in specific ways.

For instance, a user may have access to your organization’s Power BI dashboards but would need the Power BI Administrator role to see org-wide metrics.  

Although other Microsoft Entra ID functionalities, such as role-assignable groups, might support these Entra ID role assignments, the access granted through those methods is less explicit. For example, you would be managing a group’s membership rather than managing users' role assignments directly.  

By assigning Entra ID Roles to employees and guests using Entitlement Management, you can look at a user's entitlements and quickly determine which roles are assigned to that user. When you include an Entra ID role as a resource in an access package, you can also specify whether that role assignment is “eligible” or “active.”

Assigning Entra ID roles through access packages helps to efficiently manage role assignments at scale and improves the role assignment lifecycle.

## Scenarios for Microsoft Entra role assignment using access packages

Let’s imagine that your organization recently hired 50 new employees for the Support team and that you are tasked with giving new employees access to the resources they need. These employees need access to the Support Group and SharePoint site, and to certain support-related applications. They also need 3 Entra ID roles, including the Helpdesk Administrator role, to do their jobs. Instead of individually assigning each of the 50 employees to all the resources and roles, you can set up an access package containing the SharePoint site, Group and Entra ID roles. Then, you can configure the access package to have managers as approvers and share the link with the Support team.

:::image type="content" source="media/entitlement-management-roles/helpdesk-role-package.png" alt-text="Screenshot of adding a resource role to new access package.":::

Now, new members joining the Support team can request access to this access package in My Access and get access to everything they need as soon as their manager approves the request. This is going to save you a lot of time and energy because the Support team is planning on expanding globally, hiring ~1,000 new employees, but you don’t have to manually assign each person to an access package. 

> [!NOTE]
> We recommend that you use Privileged Identity Management to provide just-in-time access to a user to perform a task that requires elevated permissions. These permissions are provided through the Entra ID Roles that are tagged as *“privileged”* in our documentation: [Microsoft Entra built-in roles](../identity/role-based-access-control/permissions-reference.md).
> Entitlement Management is better suited for assigning users a bundle of resources, which may include an Entra ID role, necessary to do one’s job. Users assigned to access packages tend to have more longstanding access to resources. While we recommend that you manage high-privileged roles through Privileged Identity Management, you can set up eligibility for those roles through access packages in Entitlement Management.  

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

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

## Add a Microsoft Entra role as a resource in an access package 

**Prerequisite role:** Global Administrator, Identity Governance Administrator, Catalog owner or Access package manager

Follow these steps to change the list of incompatible groups or other access packages for an existing access package: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **Identity governance** > **Entitlement management** > **Access packages**.

1. On the Access packages page, open the access package you want to add resource roles to and select **Resource roles**. 

1. On the **Add resource roles to access package page**, select **Microsoft Entra roles (Preview)** to open the Select Microsoft Entra roles pane. 

1. Select the Microsoft Entra roles you want to include in the access package.
    :::image type="content" source="media/entitlement-management-roles/select-role-access-package.png" alt-text="Screenshot of selecting role for access package.":::  

1. In the **Role** list, select **Eligible** or **Member**. 
    :::image type="content" source="media/entitlement-management-roles/access-package-role.png" alt-text="Screenshot of choosing role for resource role in access package.":::
1. Select **Add**.

> [!NOTE]
> If you select **Eligible**, users will become eligible for that role and can activate their assignment using Privileged Identity Management in the Microsoft Entra Portal. If you select **Active**, users will have an active role assignment until they no longer have access to the access package. 
 
## Add a Microsoft Entra role as a resource in an access package using Graph

You can add Microsoft Entra roles as resources in an access package using Microsoft Graph. A user in an appropriate role with an application that has the delegated `EntitlementManagement.ReadWrite.All permission`, or an application with the `EntitlementManagement.ReadWrite.All` application permission, can call the API to create an access package containing Microsoft Entra roles and assign users to that access package. 

## Add a Microsoft Entra role as a resource in an access package using PowerShell 

You can also add Microsoft Entra roles as resources in access packages in PowerShell with the cmdlets from the [Microsoft Graph PowerShell cmdlets for Identity Governance](https://www.powershellgallery.com/packages/Microsoft.Graph.Identity.Governance/2.15.0) module version 1.16.0 or later. 

The following script illustrates using the `v1.0` profile of Graph to add a Microsoft Entra role as a resource in an access package: 

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [View, add, and remove assignments for an access package](../id-governance/entitlement-management-access-package-assignments.md)
> [View reports and logs](entitlement-management-reports.md)
