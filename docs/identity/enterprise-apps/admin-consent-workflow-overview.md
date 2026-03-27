---
title: Overview of Admin Consent Workflow
description: Learn how to manage the admin consent workflow, email notifications, and audit logs related to consent requests.

ms.topic: concept-article
ms.date: 11/29/2024
ms.reviewer: ergreenl
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps

#customer intent: As an admin, I want to understand how the admin consent workflow works, so that I can configure it to allow users to request access to applications and track and respond to those requests through the Microsoft Entra admin center.
---

# Overview of admin consent workflow

In some situations, your users might need to consent to permissions for applications that they're creating or using with their work accounts. However, non-admin users aren't allowed to consent to permissions that require admin consent. Also, users can't consent to applications when [user consent](configure-user-consent.md) is turned off in the user's tenant.

When user consent is turned off, an admin can grant users the ability to make requests for gaining access to applications by turning on the admin consent workflow. In this article, you learn about the user and admin experience when the admin consent workflow is on versus when it's off.

When users attempt to sign in, they might see a consent prompt like the one in the following screenshot.

:::image type="content" source="media/configure-admin-consent-workflow/admin-consent-workflow-off.png" alt-text="Screenshot of a consent prompt when the admin consent workflow is turned off.":::

If the user doesn't know who can grant them access, they might be unable to use the application. This situation also requires administrators to create a separate workflow to track requests for applications if they're open to receiving them.

As an admin, you can use the following options to determine how users consent to applications:

- Turn off user consent. For example, a high school might want to turn off user consent so that the school IT administration has full control over all the applications in their tenant.
- Allow users to consent to the required permissions. The best practice is to keep user consent open if you have sensitive data in your tenant.
- If you still want to retain admin-only consent for certain permissions but want to assist your users in onboarding their application, you can use the admin consent workflow to evaluate and respond to admin consent requests. This way, you can have a queue of all the requests for admin consent for your tenant. You can track and respond to these requests directly through the Microsoft Entra admin center.

  To learn how to configure the admin consent workflow, see [Configure the admin consent workflow](configure-admin-consent-workflow.md).

## How the admin consent workflow works

When you configure the admin consent workflow, your users can request consent directly through the prompt. The users might see a consent prompt like the one in the following screenshot.

:::image type="content" source="media/configure-admin-consent-workflow/consent prompt-workflow-on.png" alt-text="Screenshot of consent prompt when the admin consent workflow is turned on.":::

When an administrator responds to a request, the user receives an email alert that says the request is processed.

When the user submits a consent request, the request appears in the pane for admin consent requests in the Microsoft Entra admin center. Administrators and designated reviewers sign in to [view and act on the new requests](review-admin-consent-requests.md).

Reviewers can view and act on all pending admin consent requests in the tenant, including requests that were created before they were designated as reviewers. Any request that's still pending remains visible to newly assigned reviewers, so they can review and take action on existing requests based on their assigned permissions.

Requests appear on the following two tabs in the pane for admin consent requests:

- **My pending**. This tab shows any active requests that have the signed-in user designated as a reviewer. Although reviewers can block or deny requests, only people with the correct role-based access control (RBAC) permissions to consent to the requested permissions can do so.
- **All (Preview)**. This tab shows all requests, active or expired, that exist in the tenant. Each request includes information about the application and the users who requested the application.

## Email notifications

If email notifications are configured, all reviewers receive the notifications when:

- A new request is created.
- A request expires.
- A request is nearing the expiration date.

Requestors receive email notifications when:

- They submit a new request for access.
- Their request expires.
- Their request is denied or blocked.
- Their request is approved.

## Audit logs

The following table outlines the scenarios and audit values available for the admin consent workflow.

|Scenario  |Audit service  |Audit category  |Audit activity  |Audit actor  |Audit log limitations  |
|---------|---------|---------|---------|---------|---------|
|Admin turning on the consent request workflow        |Access Reviews           |UserManagement           |Create governance policy template          |App context            |Currently you can't find the user context            |
|Admin turning off the  consent request workflow       |Access Reviews           |UserManagement           |Delete governance policy template          |App context            |Currently you can't find the user context           |
|Admin updating the consent workflow configurations        |Access Reviews           |UserManagement           |Update governance policy template          |App context            |Currently you can't find the user context           |
|User creating an admin consent request for an app       |Access Reviews           |Policy         |Create request           |App context            |Currently you can't find the user context           |
|Reviewer approving an admin consent request       |Access Reviews           |UserManagement           |Approve all requests in business flow          |App context            |Currently you can't find the user context or the app ID that was granted admin consent           |
|Reviewer denying an admin consent request       |Access Reviews           |UserManagement           |Approve all requests in business flow          |App context            | Currently you can't find the user context of the actor that denied an admin consent request          |

## Related content

- [Configure the admin consent request workflow](configure-admin-consent-workflow.md)
- [Review an admin consent request](review-admin-consent-requests.md)
- [Manage consent requests](manage-consent-requests.md)
