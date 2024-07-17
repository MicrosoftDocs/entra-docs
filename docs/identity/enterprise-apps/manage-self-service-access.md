---
title: Enable self-service application assignment
description: Enable self-service application access to allow users to find their own applications from their My Apps portal
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 01/04/2024
ms.author: jomondi
ms.collection: M365-identity-device-management
ms.reviewer: ergreenl
ms.custom: enterprise-apps

#customer intent: As an IT admin, I want to enable self-service application access for my users, so that they can discover and request access to applications without IT intervention. Additionally, I want to have the option to allow business approvers to approve access requests and manage user roles and passwords.
---

# Enable self-service application assignment

In this article, you learn how to enable self-service application access using the Microsoft Entra admin center.

Before your users can self-discover applications from the [My Apps portal](./myapps-overview.md), you need to enable **Self-service application access** for the applications. This functionality is available for applications that were added from the Microsoft Entra Gallery, [Microsoft Entra application proxy](/entra/identity/app-proxy), or were added using [user or admin consent](~/identity-platform/application-consent-experience.md).

Using this feature, you can:

- Let users self-discover applications from the My Apps portal without bothering the IT group.

- Add those users to a preconfigured group so you can see who requests access, remove access, and manage the roles assigned to them.

- Optionally allow a business approver to approve application access requests so the IT group doesn’t have to.

- Optionally configure up to 10 individuals who might approve access to this application.

- Optionally allow a business approver to set the passwords those users can use to sign in to the application, right from the business approver’s My Apps portal

- Optionally automatically assign self-service assigned users to an application role directly.

## Prerequisites

To enable self-service application access, you need:

- A Microsoft Entra user account. If you don't already have one, [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, or Application Administrator.
- A Microsoft Entra ID P1 or P2 license is required for users to request to join a self-service app and for owners to approve or deny requests. Without a Microsoft Entra ID P1 or P2 license, users can't add self-service apps.

## Enable self-service application access to allow users to find their own applications

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Self-service application access is a great way to allow users to self-discover applications, and optionally allow the business group to approve access to those applications. For password single-sign on applications, you can also allow the business group to manage the credentials assigned to those users from their own My Apps portal.

To enable self-service application access to an application, undertake the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. In the left navigation menu, select **Self-service**.
    > [!NOTE]
    > The **Self-service** menu item isn't available if the corresponding app registration's setting for public client flows is enabled. To access this setting, the app registration needs to exist in your tenant. Locate the app registration, select **Authentication** in the left navigation, then locate **Allow public client flows**.
1. To enable Self-service application access for this application, set **Allow users to request access to this application?** to **Yes.**
1. Next to **To which group should assigned users be added?**, select **Select group**. Choose a group, and then select **Select**. When a user's request is approved, they're added to this group. When viewing this group's membership, you're able to see who has access to the application through self-service access.
  
    > [!NOTE]
    > This setting doesn't support groups synchronized from on-premises.

1. **Optional:** To require business approval before users are allowed access, set **Require approval before granting access to this application?** to **Yes**.
1. **Optional:** Next to **Who is allowed to approve access to this application?** Select **Select approvers** to specify the business approvers who are allowed to approve access to this application. Select up to 10 individual business approvers, and then select **Select**.

    >[!NOTE]
    >Groups are not supported. You can select up to 10 individual business approvers. If you specify multiple approvers, any single approver can approve an access request.

1. **Optional:** Next to **To which role should users be assigned in this application?**, select **Select Role** to assign self-service approved users to a role. Choose the role to which these users should be assigned, and then select **Select**. This option is for applications that expose roles.

1. Select the **Save** button at the top of the pane to finish.

Once you complete self-service application configuration, users can navigate to their My Apps portal, and select **Request new apps** to find the apps that are enabled with self-service access. Business approvers also see a notification in their My Apps portal. You can enable an email notifying them when a user requests access to an application that requires their approval.

## Next steps

[Setting up Microsoft Entra ID for self-service group management](~/identity/users/groups-self-service-management.md)
