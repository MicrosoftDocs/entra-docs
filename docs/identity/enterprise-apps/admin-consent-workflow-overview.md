---
title: Overview of admin consent workflow
description: Learn how to manage the admin consent workflow, email notifications and audit logs related to consent requests.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: concept-article
ms.date: 11/29/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps

#customer intent: As an admin, I want to understand how the admin consent workflow works, so that I can configure it to allow users to request access to applications and track and respond to those requests through the Microsoft Entra admin center.
---

# Overview of admin consent workflow

There might be situations where your end-users need to consent to permissions for applications that they're creating or using with their work accounts. However, nonadmin users aren't allowed to consent to permissions that require admin consent. Also, users can’t consent to applications when [user consent](configure-user-consent.md) is disabled in the user’s tenant.

In such situations where user consent is disabled, an admin can grant users the ability to make requests for gaining access to applications by enabling the admin consent workflow. In this article, you learn about the user and admin experience when the admin consent workflow is on vs when it's off.

When attempting to sign in,  users might see a consent prompt like the one in the following screenshot:

:::image type="content" source="media/configure-admin-consent-workflow/admin-consent-workflow-off.png" alt-text="Screenshot of consent prompt when workflow is disabled.":::

If the user doesn’t know who to contact to grant them access, they might be unable to use the application. This situation also requires administrators to create a separate workflow to track requests for applications if they're open to receiving them.
As an admin, the following options exist for you to determine how users consent to applications:

- Disable user consent. For example, a high school might want to turn off user consent so that the school IT administration has full control over all the applications in their tenant.
- Allow users to consent to the required permissions. The best practice is to keep user consent open if you have sensitive data in your tenant.
- If you still want to retain admin-only consent for certain permissions but want to assist your end-users in onboarding their application, you can use the admin consent workflow to evaluate and respond to admin consent requests. This way, you can have a queue of all the requests for admin consent for your tenant and can track and respond to them directly through the Microsoft Entra admin center.
To learn how to configure the admin consent workflow, see [Configure the admin consent workflow](configure-admin-consent-workflow.md).

## How the admin consent workflow works

When you configure the admin consent workflow, your end users can request for consent directly through the prompt. The users might see a consent prompt like the one in the following screenshot:

:::image type="content" source="media/configure-admin-consent-workflow/consent prompt-workflow-on.png" alt-text="Screenshot of consent prompt when workflow is enabled.":::

When an administrator responds to a request, the user receives an email alert informing them that the request is processed.

When the user submits a consent request, the request shows up in the admin consent request page in the Microsoft Entra admin center. Administrators and designated reviewers sign in to [view and act on the new requests](review-admin-consent-requests.md). Reviewers only see consent requests that were created after they were designated as reviewers. Requests show up in the following two tabs in the admin consent requests pane:

- My pending: This tab shows any active requests that have the signed-in user designated as a reviewer. Although reviewers can block or deny requests, only people with the correct RBAC permissions to consent to the requested permissions can do so.
- All(Preview): All requests, active or expired, that exist in the tenant.
Each request includes information about the application and the users requesting the application.

## Email notifications

If configured, all reviewers receive email notifications when:

- A new request is created
- A request expires
- A request is nearing the expiration date.

Requestors receive email notifications when:

- They submit a new request for access
- Their request expires
- Their request is denied or blocked
- Their request is approved

## Audit logs

The following table outlines the scenarios and audit values available for the admin consent workflow.

|Scenario  |Audit Service  |Audit Category  |Audit Activity  |Audit Actor  |Audit log limitations  |
|---------|---------|---------|---------|---------|---------|
|Admin enabling the consent request workflow        |Access Reviews           |UserManagement           |Create governance policy template          |App context            |Currently you can’t find the user context            |
|Admin disabling the  consent request workflow       |Access Reviews           |UserManagement           |Delete governance policy template          |App context            |Currently you can’t find the user context           |
|Admin updating the consent workflow configurations        |Access Reviews           |UserManagement           |Update governance policy template          |App context            |Currently you can’t find the user context           |
|End user creating an admin consent request for an app       |Access Reviews           |Policy         |Create request           |App context            |Currently you can’t find the user context           |
|Reviewers approving an admin consent request       |Access Reviews           |UserManagement           |Approve all requests in business flow          |App context            |Currently you can’t find the user context or the app ID that was granted admin consent.           |
|Reviewers denying an admin consent request       |Access Reviews           |UserManagement           |Approve all requests in business flow          |App context            | Currently you can’t find the user context of the actor that denied an admin consent request          |

## Next steps

- [Enable the admin consent request workflow](configure-admin-consent-workflow.md)
- [Review admin consent request](review-admin-consent-requests.md)
- [Manage consent requests](manage-consent-requests.md)
