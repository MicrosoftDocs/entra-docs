---
title: Approve and manage support access requests (preview)
description: Learn how to approve and manage the Microsoft Support access requests to Microsoft Entra identity data
author: shlipsey3
manager: amycolannino
ms.author: sarahlipsey
ms.reviewer: jeffsta
ms.service: entra
ms.topic: how-to
ms.subservice: fundamentals
ms.date: 09/27/2024

# Customer intent: As an IT admin, I want to learn how to approve and manage Microsoft Support access requests to Microsoft Entra identity data so that I can troubleshoot issues with Microsoft Support.
---

# Approve and manage Microsoft Support access requests (preview)

In many situations, enabling the collection of **Advanced diagnostic information** during the creation of a support access request is sufficient for Microsoft Support to troubleshoot your issue. In some situations though, a separate approval might be needed to allow Microsoft Support to access your identity diagnostic data. For more information on applicable scenarios and the overall workflow, see [What are Microsoft Support access requests?](concept-support-access-requests.md).

Microsoft Support access requests (preview) enable you to [give Microsoft Support engineers access to diagnostic data](concept-support-access-requests.md) in your identity service to help solve support requests you submitted to Microsoft. You can use the Microsoft Entra admin center and the Azure portal to manage Microsoft Support access requests.

This article describes how to approve and manage Microsoft Support access requests.

## Prerequisites

Only authorized users in your tenant can view and manage Microsoft Support access requests. To view, approve, and reject Microsoft Support access requests, a role must have the permission `microsoft.azure.supportTickets/allEntities/allTasks`. To see which roles have this permission, search the [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md) for the required permission.

## View all support access requests

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Service Support Administrator](~/identity/role-based-access-control/permissions-reference.md#service-support-administrator).

1. Browse to **Learn & support** > **Diagnose and solve problems**.

1. Scroll to the bottom of the page to the **Microsoft Support Access Requests (Preview)** section.

1. Select **Manage pending requests** to approve or deny pending requests or select **Approved access** to review previously approved requests.

    :::image type="content" source="media/how-to-manage-support-access-requests/diagnose-solve-problems-access-requests.png" alt-text="Screenshot of the Diagnose and solve problems page with the Manage pending requests link highlighted." lightbox="media/how-to-manage-support-access-requests/diagnose-solve-problems-access-requests-expanded.png":::

## Approve or reject a support request

You can approve or reject a support request from the Microsoft Support Access Requests (Preview) section. If you have a pending request, a banner message appears at the top of the page with a link to the manage pending requests.

:::image type="content" source="media/how-to-manage-support-access-requests/diagnose-solve-problems-banner.png" alt-text="Screenshot of the Diagnose and solve problems page with the banner notification highlighted.":::

To view pending support requests:

1. Select the **View and approve** link from the banner message or select **Manage pending requests** from the **Microsoft Support Access Requests (Preview)** section.

1. Select the **Support request ID** link for the request you need to approve.

   :::image type="content" source="media/how-to-manage-support-access-requests/pending-request-view-details-links.png" alt-text="Screenshot of the pending request with links to view details highlighted.":::

When viewing the details of a pending support access request, you can approve or reject the request.

- To approve the support access request, select the **Approve** button.
    - Microsoft Support now has *read-only* access to your identity diagnostic data until your support request is completed.
- To reject the support access request, select the **Reject** button.
    - Microsoft Support does *not* have access to your identity diagnostic data.
    - A message appears, indicating this choice might result in slower resolution of your support request.
    - Your support engineer might ask you for data needed to diagnose the issue, and you must collect and provide that information to your support engineer.

:::image type="content" source="media/how-to-manage-support-access-requests/pending-request-details.png" alt-text="Screenshot of the Support Access requests details page with the Reject and Approve buttons highlighted.":::

## Revoke access to an approved support access request

Closing a support request automatically revokes the support engineer's access to your identity diagnostic data. You can manually revoke Microsoft Support's access to identity diagnostic data for the support request *before* your support request is closed.

To revoke access to an approved support access request:

1. Select **Approved access** from the **Microsoft Support Access Requests (Preview)** section.

1. Select the **Support request ID** link for the request you need to revoke.

   :::image type="content" source="media/how-to-manage-support-access-requests/approved-access.png" alt-text="Screenshot of approved requests with links to view details highlighted.":::

1. Select the **Remove access** button to revoke access to an approved support access request.

    :::image type="content" source="media/how-to-manage-support-access-requests/remove-approved-access.png" alt-text="Screenshot of the Support access requests history with the Revoke button highlighted.":::

When your support request is closed, the status of an approved Microsoft Support access request is automatically set to **Completed.** Microsoft Support access requests remain in the **Approved access** list for 30 days.

## Next steps

- [How to create a support request](how-to-get-support.md)
- [View Microsoft Support access request logs](how-to-view-support-access-request-logs.md)
- [Learn how Microsoft uses data for Azure Support](https://azure.microsoft.com/support/legal/support-diagnostic-information-collection/)
