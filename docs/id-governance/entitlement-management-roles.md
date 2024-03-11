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

# Assign Microsoft Entra Roles (Preview)

Entitlement Management supports access lifecycle for various resource types, such as SharePoint sites, Groups, Teams. Sometimes users need additional permissions to utilize these resources in specific ways.

For instance, a user might need to have access to your organization’s Power BI dashboards, but would need the Power BI Administrator role to see org-wide metrics.  

Although other Microsoft Entra ID functionalities, such as role-assignable groups, might support these Microsoft Entra ID role assignments, the access granted through those methods is less explicit. For example, you would be managing a group’s membership rather than managing users' role assignments directly.  

By assigning Microsoft Entra ID Roles to employees and guests using Entitlement Management, you can look at a user's entitlements and quickly determine which roles are assigned to that user. When you include a Microsoft Entra ID role as a resource in an access package, you can also specify whether that role assignment is “*eligible*” or “*active*”.

Assigning Microsoft Entra ID roles through access packages helps to efficiently manage role assignments at scale and improves the role assignment lifecycle.

## Scenarios for Microsoft Entra role assignment using access packages

Let’s imagine that your organization recently hired 50 new employees for the Support team, and that you're tasked with giving new employees access to the resources they need. These employees need access to the Support Group, SharePoint site, and to certain support-related applications. They also need three Microsoft Entra ID roles, including the Helpdesk Administrator role, to do their jobs. Instead of individually assigning each of the 50 employees to all the resources and roles, you can set up an access package containing the SharePoint site, Group, and Microsoft Entra ID roles. Then, you can configure the access package to have managers as approvers and share the link with the Support team.

:::image type="content" source="media/entitlement-management-roles/helpdesk-role-package.png" alt-text="Screenshot of adding a resource role to new access package.":::

Now, new members joining the Support team can request access to this access package in My Access and get access to everything they need as soon as their manager approves the request. This is going to save you time and energy because the Support team is planning on expanding globally, hiring ~1,000 new employees, but you don’t have to manually assign each person to an access package. 

> [!NOTE]
> We recommend that you use Privileged Identity Management to provide just-in-time access to a user to perform a task that requires elevated permissions. These permissions are provided through the Microsoft Entra ID Roles that are tagged as *“privileged”* in our documentation: [Microsoft Entra built-in roles](../identity/role-based-access-control/permissions-reference.md).
> Entitlement Management is better suited for assigning users a bundle of resources, which may include a Microsoft Entra ID role, necessary to do one’s job. Users assigned to access packages tend to have more longstanding access to resources. While we recommend that you manage high-privileged roles through Privileged Identity Management, you can set up eligibility for those roles through access packages in Entitlement Management.  

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

## Add a Microsoft Entra role as a resource in an access package 

**Prerequisite role:** Global Administrator, Identity Governance Administrator, Catalog owner, or Access package manager

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

> [!div class="nextstepaction"]
> [View, add, and remove assignments for an access package](../id-governance/entitlement-management-access-package-assignments.md)
> [View reports and logs](entitlement-management-reports.md)
