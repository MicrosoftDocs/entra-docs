---
title: 'Quickstart: Create and assign a user account'
description: Create a user account and assign it to an enterprise application in your Microsoft Entra tenant. Begin managing access efficiently today
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: quickstart
ms.date: 03/21/2025
ms.author: jomondi
ms.reviewer: alamaral
ms.custom: mode-other, enterprise-apps, sfi-image-nochange
#customer intent: As an IT admin managing user accounts in Microsoft Entra, I want to create a new user account and assign it to an enterprise application, so that I can provide access to the application for the user.
---

# Quickstart: Create and assign a user account

In this quickstart, you use the Microsoft Entra admin center to create a user account in your Microsoft Entra tenant. After you create the account, you can assign it to the enterprise application that you added to your tenant.

We recommend that you use a nonproduction environment to test the steps in this quickstart.

## Prerequisites

To create a user account and assign it to an enterprise application, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, or owner of the service principal. You need the User Administrator role to manage users.
- Completion of the steps in [Quickstart: Add an enterprise application](add-application-portal.md).

## Create a user account


To create a user account in your Microsoft Entra tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**
1. Select **New user** at the top of the pane and then, select **Create new user**.  
1. In the **User principal name** field, enter the username of the user account. For example, `b.simon@contoso.com`. Be sure to change `contoso.com` to the name of your tenant domain.
1. In the **Display name** field, enter the name of the user of the account. For example, `B.Simon`.
1. Enter the details required for the user under the **Groups and roles**, **Settings**, and **Job info** sections.
1. Select **Create**.

## Assign a user account to an enterprise application

To assign a user account to an enterprise application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**. For example, the application that you created in the previous quickstart named **Microsoft Entra SAML Toolkit 1**.
1. In the left pane, select **Users and groups**, and then select **Add user/group**.

    :::image type="content" source="media/add-application-portal-assign-users/assign-user.png" alt-text="Assign user account to an application in your Microsoft Entra tenant." lightbox="media/add-application-portal-assign-users/assign-user.png":::

1. On the **Add Assignment** pane, select **None Selected** under **Users and groups**.
1. Search for and select the user that you want to assign to the application. For example, `b.simon@contoso.com`.
1. Select **Select**.
1. Select **None Selected** under **Select a role** and then select the role that you want to assign to the user. For example, **Standard User**.
1. Select **Select**.
1. Select **Assign** at the bottom of the pane to assign the user to the application.

After you assign the user to the application, ensure you set the application to be visible to the user. To make it visible to assigned users, select **Properties** in the left pane, and then set **Visible to users?** to **Yes**.

## Clean up resources

If you're planning to complete the next quickstart, keep the application that you created. Otherwise, you can consider deleting it to clean up your tenant.

## Next steps

Learn how to set up single sign-on for an enterprise application.
> [!div class="nextstepaction"]
> [Enable single sign-on](what-is-single-sign-on.md)


