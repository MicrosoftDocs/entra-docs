---
title: View reports & logs in entitlement management
description: Learn how to view the user assignments report and audit logs in entitlement management.
author: owinfreyatl
manager: dougeby
editor: jocastel-MSFT
ms.service: entra-id-governance
ms.subservice: entitlement-management
ms.topic: how-to
ms.date: 03/10/2025
ms.author: owinfrey
ms.reviewer: jocastel
ms.custom: sfi-ga-nochange, sfi-image-nochange
#Customer intent: As an administrator, I want view resources a user has access to and view request logs for auditing purposes.
---

# View reports and logs in entitlement management

The entitlement management reports and Microsoft Entra audit log provide more details about what resources users have access to. As an administrator, you can view the access packages and resource assignments for a user and view request logs for auditing purposes or  determining the status of a user's request. This article describes how to use the entitlement management reports and Microsoft Entra audit logs.

This article outlines how to view reports on current objects in entitlement management. To retain and report on historical Microsoft Entra objects, such as users or application role assignments, see [Customized reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID](custom-entitlement-report-with-adx-and-entra-id.md).

Watch the following video to learn how to view what resources users have access to in entitlement management:

>[!VIDEO https://www.youtube.com/embed/omtNJ7ySjS0]

## View users assigned to an access package


This report enables you to list all of the users who are assigned to an access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access packages**.

1. On the Access packages page, select the access package of interest.

1. In the left menu, select **Assignments**, then select **Download**.

1. Confirm the file name and then select **Download**.

## View access packages for a user

This report enables you to list all of the access packages a user can request and the access packages that are currently assigned to the user.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Reports**.

1. Select **Access packages for a user**.

1. Select **Select users** to open the Select users pane.

1. Find the user in the list and then select **Select**.

    The **Can request** tab displays a list of the access packages the user can request. This list is determined by the [request policies](entitlement-management-access-package-request-policy.md#for-users-in-your-directory) defined for the access packages. 

    ![Access packages for a user](./media/entitlement-management-reports/access-packages-report.png)

1. If there are more than one resource roles or policies for an access package, select the resource roles or policies entry to see selection details.

1. Select the **Assigned** tab to see a list of the access packages currently assigned to the user. When an access package is assigned to a user, it means that the user has access to all of the resource roles in the access package.

## View resource assignments for a user

This report enables you to list the resources currently assigned to a user in entitlement management. This report is for resources managed with entitlement management. The user might have access to other resources in your directory outside of entitlement management.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Reports**.

1. Select **Resource assignments for a user**.

1. Select **Select users** to open the Select users pane.

1. Find the user in the list and then select **Select**.

    A list of the resources currently assigned to the user is displayed. The list also shows the access package and policy they got the resource role from, along with start and end date for access.
    
    If a user got access to the same resource in two or more packages, you can select an arrow to see each package and policy.

    ![Resource assignments for a user](./media/entitlement-management-reports/resource-assignments-report.png)

## Determine the status of a user's request

To get extra details on how a user requested and received access to an access package, you can use the Microsoft Entra audit log. In particular, you can use the log records in the `EntitlementManagement` and `UserManagement` categories to get more details on the processing steps for each request.  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Audit logs**.

1. At the top, change the **Category** to either `EntitlementManagement` or `UserManagement`, depending on the audit record you're looking for.  

1. Select **Apply**.

1. To download the logs, select **Download**.

When Microsoft Entra ID receives a new request, it writes an audit record, in which the **Category** is `EntitlementManagement` and the **Activity** is typically `User requests access package assignment`. If a direct assignment created in the Microsoft Entra admin center, the **Activity** field of the audit record is `Administrator directly assigns user to access package`, and the user performing the assignment is identified by the **ActorUserPrincipalName**.

Microsoft Entra ID writes extra audit records while the request is in progress, including:

| Category | Activity | Request status |
| :---- | :------------ | :------------ |
| `EntitlementManagement` | `Auto approve access package assignment request` | Request doesn't require approval |
| `UserManagement` | `Create request approval` | Request requires approval |
| `UserManagement` | `Add approver to request approval` | Request requires approval |
| `EntitlementManagement` | `Approve access package assignment request` | Request approved |
| `EntitlementManagement` | `Ready to fulfill access package assignment request` |Request approved, or doesn't require approval |

When a user is assigned access, Microsoft Entra ID writes an audit record for the `EntitlementManagement` category with **Activity** `Fulfill access package assignment`. The user who received the access is identified by **ActorUserPrincipalName** field.

If access wasn't assigned, then Microsoft Entra ID writes an audit record for the `EntitlementManagement` category with **Activity** either `Deny access package assignment request`, if the request was denied by an approver, or `Access package assignment request timed out (no approver action taken)`, if the request timed out before an approver could approve.

When the user's access package assignment expires, is canceled by the user, or removed by an administrator, then Microsoft Entra ID writes an audit record for the `EntitlementManagement` category with **Activity** of `Remove access package assignment`.

## Download the list of connected organizations

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Connected organizations**.

1. On the Connected organizations page, select **Download**.

## Identify users who have or will have incompatible access with separation of duties

With the separation of duties settings on an access package, you can configure that a user who is a member of a security group or who already has an assignment to one access package can't request another access package, by marking those as incompatible. You can then [view access packages that are configured as incompatible](entitlement-management-access-package-incompatible.md#view-other-access-packages-that-are-configured-as-incompatible-with-this-one), and [list users who will have incompatible access to another access package](entitlement-management-access-package-incompatible.md#identifying-users-who-will-have-incompatible-access-to-another-access-package). You can also [list users who already have incompatible access to another access package](entitlement-management-access-package-incompatible.md#identifying-users-who-already-have-incompatible-access-to-another-access-package) in the Microsoft Entra Admin Center, [using Microsoft Graph](entitlement-management-access-package-incompatible.md#identifying-users-who-already-have-incompatible-access-programmatically), or [using PowerShell](entitlement-management-access-package-incompatible.md#identifying-users-who-already-have-incompatible-access-using-powershell).

## View events for an access package  

If you have configured to send audit log events to [Azure Monitor](entitlement-management-logs-and-reporting.md), then you can use the built-in workbooks and custom workbooks to view the audit logs retained in Azure Monitor. 

To view events for an access package, you must have access to the underlying Azure monitor workspace (see [Manage access to log data and workspaces in Azure Monitor](/azure/azure-monitor/logs/manage-access#azure-rbac) for information) and in one of the following roles: 

- Global Administrator  
- Security Administrator  
- Security Reader  
- Reports Reader  
- Application Administrator  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader). Make sure you have access to the resource group containing the Azure Monitor workspace.

1. Browse to **Entra ID** > **Monitoring & health** > **Workbooks**.  

1. If you have multiple subscriptions, select the subscription that contains the workspace.  

1. Once you have selected the subscription, or if you only have one subscription, select the workbook named *Access Package Activity*.

1. In that workbook, select a time range (change to **All** if not sure), and select an access package ID from the drop-down list of all access packages that had activity during that time range. The events related to the access package that occurred during the selected time range will be displayed.

    [ ![View access package events](./media/entitlement-management-logs-and-reporting/view-events-access-package-sml.png) ](./media/entitlement-management-logs-and-reporting/view-events-access-package-lrg.png#lightbox)

    Each row includes the time, access package ID, the name of the operation, the object ID, UPN, and the display name of the user who started the operation. More details are included in JSON.

## View historical application role assignments not made by Entitlement Management

If you have configured to send audit log events to [Azure Monitor](entitlement-management-logs-and-reporting.md), then you can use the built-in workbooks and custom workbooks to view the audit logs retained in Azure Monitor.

The workbook *Application role assignment activity* shows if there have been changes to application role assignments for an application that weren't due to access package assignments, such as by a Global Administrator directly assigning a user to an application role.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader). Make sure you have access to the resource group containing the Azure Monitor workspace.

1. Browse to **Entra ID** > **Monitoring & health** > **Workbooks**.  

1. If you have multiple subscriptions, select the subscription that contains the workspace.

1. Once you have selected the subscription, or if you only have one subscription, select the workbook named *Access Package Activity*.

    [ ![View app role assignments](./media/entitlement-management-access-package-incompatible/workbook-ara-sml.png) ](./media/entitlement-management-access-package-incompatible/workbook-ara-lrg.png#lightbox)

1. If you select to omit entitlement activity, then only changes to application roles that weren't made by entitlement management are shown. For example, you would see a row if a Global Administrator had directly assigned a user to an application role.

## Next steps

- [Archive reports and Logs](entitlement-management-logs-and-reporting.md)
- [Troubleshoot entitlement management](entitlement-management-troubleshoot.md)
- [Create custom alerts for entitlement management](governance-custom-alerts.md)
- [Customized reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID](custom-entitlement-report-with-adx-and-entra-id.md)
