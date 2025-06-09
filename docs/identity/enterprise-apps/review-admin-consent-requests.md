---
title: Review and take action on admin consent requests
description: Learn how to review and take action on admin consent requests that were created after you were designated as a reviewer.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 04/08/2025
ms.author: jomondi
ms.reviewer: ergreenl
ai-usage: ai-assisted
ms.custom: enterprise-apps, sfi-image-nochange
#customer intent: As a designated reviewer, I want to review and take action on admin consent requests, so that I can approve, deny, or block access to applications based on the requests.
---
# Review and take action on admin consent requests

In this article, you learn how to review and take action on admin consent requests. To review and act on consent requests, you must be designated as a reviewer. For more information, check out the [Configure the admin consent workflow](configure-admin-consent-workflow.md) article. As a reviewer, you can view all admin consent requests but you can only act on those requests that were created after you were designated as a reviewer.

When reviewing admin consent requests, you have several options to choose from:

- **Review**: This option allows administrators to evaluate the request and grant consent if deemed appropriate.
- **Deny**: Selecting this option will reject the request for consent, preventing the application from accessing the requested permissions. This action does not provide feedback to the user who made the request.
- **Block**: This option not only denies the current request but also prevents future requests for the same application from being submitted. This is useful for applications that are deemed untrustworthy or unnecessary for the organization.

For instance, if an application is found to be non-compliant with company policies, an administrator might choose to 'Block' it. Conversely, if an application is legitimate but requires further review, the administrator may opt to 'Deny' the request temporarily while seeking more information.

## Prerequisites

To review and take action on admin consent requests, you need:

- An Azure account. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- An administrator role or a designated reviewer with the appropriate role to [review admin consent requests](grant-admin-consent.md#prerequisites).

## Review and take action on admin consent requests

To review the admin consent requests and take action:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) who is a designated reviewer.
1. Browse to **Entra ID** > **Enterprise apps**.
1. Under **Activity**, select **Admin consent requests**.
1. Select **My Pending** tab to view and act on the pending requests. 
1. Select the application that is being requested from the list.
1. Review details about the request:
   - To see what permissions are being requested by the application, select **Review permissions and consent**.
   - To view the application details, select the **App details** tab.
   - To see who is requesting access and why, select the **Requested by** tab.  
1. Evaluate the request and take the appropriate action:
   - **Approve the request**. To approve a request, grant admin consent to the application. Once a request is approved, all requestors are notified that their request for access is granted. Approving a request allows all users in your tenant to access the application unless otherwise restricted with user assignment. 
   - **Deny the request**. To deny a request, you must provide a justification that is provided to all requestors. Once a request is denied, all requestors are notified that their request for access is denied. Denying a request won't prevent users from requesting admin consent to the application again in the future. 
   - **Block the request**. To block a request, you must provide a justification that is provided to all requestors. Once a request is blocked, all requestors are notified that their request to access the application is denied. Blocking a request creates a service principal object for the application in your tenant in a disabled state. Users won't be able to request admin consent to the application in the future.

## Review admin consent requests using Microsoft Graph

To review the admin consent requests programmatically, use the [`appConsentRequest` resource type](/graph/api/resources/appconsentrequest) and [`userConsentRequest` resource type](/graph/api/resources/userconsentrequest) and their associated methods in Microsoft Graph. You can't approve or deny consent requests using Microsoft Graph.

## Related content

- [Review permissions granted to apps](manage-application-permissions.md)
- [Grant tenant-wide admin consent](grant-admin-consent.md)
