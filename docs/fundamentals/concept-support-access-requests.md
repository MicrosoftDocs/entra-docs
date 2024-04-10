---
title: Support access requests in Microsoft Entra ID
description: Learn how Microsoft Support engineers can access identity diagnostic information in Microsoft Entra ID.
author: shlipsey3
manager: amycolannino
ms.author: sarahlipsey
ms.reviewer: jeffsta
ms.service: entra
ms.topic: conceptual
ms.subservice: fundamentals
ms.date: 02/20/2024

# Customer intent: As an IT admin, I need to understand how Microsoft Support engineers can access diagnostic data in Microsoft Entra ID so that I can manage access to my tenant's data.
---

# What are Microsoft Support access requests (preview)?

Microsoft Support requests are automatically assigned to a support engineer with expertise in solving similar problems. To expedite solution delivery, our support engineers use diagnostic tooling to read [identity diagnostic data](/troubleshoot/azure/active-directory/support-data-collection-diagnostic-logs) for your tenant.

Microsoft Support's access to your identity diagnostic data is granted only with your approval, is read-only, and lasts only as long as we're actively working with you to solve your problem.

For many support requests created in the Microsoft Entra admin center, you can manage the access to your identity diagnostic data by enabling the "Allow collection of advanced diagnostic information" property. If this setting is set to "no" our support engineers must ask *you* to collect the data needed to solve your problem, which could slow down your problem resolution.

## Microsoft Support access requests

Sometimes support engineers need explicit approval from you to access identity diagnostic data to solve your problem. For example, if a support engineer needs to access identity diagnostic data in a different Microsoft Entra tenant than the one in which you created the support request, the engineer must ask you to grant them access to that data.

Microsoft Support access requests (preview) enable you to manage Microsoft Support's access to your identity diagnostic data for support requests where you can't manage that access in the Microsoft Entra admin center's support request management experience.

## Scenarios and workflow

A support access request might be needed when a support request is submitted to Microsoft Support from a tenant that is different from the tenant where the issue is occurring. This scenario is known as a *cross-tenant* scenario. The *resource tenant* is the tenant where the issue is occurring and the tenant where the support request was created is known as the *support request tenant*.

Let's take a closer look at the workflow for this scenario:

- A support request is submitted from a tenant that is different from the tenant where the issue is occurring.
- A Microsoft Support engineer creates a support access request to access identity diagnostic data for the *resource tenant*.
- An administrator of *both* tenants approves the Microsoft Support access request.
- With approval, the support engineer has access to the data only in the approved *resource tenant*.
- When the support engineer closes the support request, access to your identity data is automatically revoked.

This cross-tenant scenario is the primary scenario where a support access request is necessary. In these scenarios, Microsoft approved access is visible only in the resource tenant. To preserve cross-tenant privacy, an administrator of the *support request tenant* is unable to see whether an administrator of the *resource tenant* has manually removed this approval.

## Support access role permissions

To manage Microsoft Support access requests, you must be assigned to a role that has full permission to manage Microsoft Entra support tickets for the tenant. This role permission is included in Microsoft Entra built-in roles with the action `microsoft.azure.supportTickets/allEntities/allTasks`. You can see which Microsoft Entra roles have this permission in the [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md) article.

## Next steps

- [Approve and manage Microsoft Support access requests](how-to-manage-support-access-requests.md)
- [View Microsoft Support access request logs](how-to-view-support-access-request-logs.md)
- [Learn how Microsoft uses data for Azure Support](https://azure.microsoft.com/support/legal/support-diagnostic-information-collection/)
