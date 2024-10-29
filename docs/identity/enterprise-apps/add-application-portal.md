---
title: 'Quickstart: Add an enterprise application'
description: Add an enterprise application in Microsoft Entra ID.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: quickstart

ms.date: 03/18/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: mode-other, enterprise-apps
#customer intent: As an IT admin, I want to add an enterprise application to my Microsoft Entra tenant, so that I can provide my organization with access to pre-integrated applications from the gallery.
---

# Quickstart: Add an enterprise application

In this quickstart, you use the Microsoft Entra admin center to add an enterprise application to your Microsoft Entra tenant. Microsoft Entra ID has a gallery that contains thousands of enterprise applications that are already preintegrated. Many of the applications your organization uses are probably already in the gallery. This quickstart uses the application named **Microsoft Entra SAML Toolkit** as an example, but the concepts apply for most [enterprise applications in the gallery](~/identity/saas-apps/tutorial-list.md).

We recommend that you use a nonproduction environment to test the steps in this quickstart.

## Prerequisites

To add an enterprise application to your Microsoft Entra tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, or Application Administrator.

## Add an enterprise application

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To add an enterprise application to your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Select **New application**.
1. The **Browse Microsoft Entra Gallery** pane opens and displays tiles for cloud platforms, on-premises applications, and featured applications. Applications listed in the **Featured applications** section have icons indicating whether they support federated single sign-on (SSO) and provisioning. Search for and select the application. In this quickstart, **Microsoft Entra SAML Toolkit** is being used.

    :::image type="content" source="media/add-application-portal/browse-gallery.png" alt-text="Browse in the enterprise application gallery for the application that you want to add." lightbox="media/add-application-portal/browse-gallery.png":::

1. Enter a name that you want to use to recognize the instance of the application. For example, `Microsoft Entra SAML Toolkit 1`.
1. Select **Create**, you're taken to the application that you registered.
1. You should [assign owners to the application](/entra/identity/enterprise-apps/assign-app-owners#assign-an-owner) as a best practice at this point.

If you choose to install an application that uses OpenID Connect based SSO, instead of seeing a **Create** button, you see a button that redirects you to the application sign-in or sign-up page depending on whether you already have an account there. For more information, see [Add an OpenID Connect based single sign-on application](add-application-portal-setup-oidc-sso.md). After sign-in, the application is added to your tenant.

## Clean up resources

If you're planning to complete the next quickstart, keep the enterprise application that you created. Otherwise, you can consider deleting it to clean up your tenant. For more information, see [Delete an application](delete-application-portal.md).

## Microsoft Graph API

To add an application from the Microsoft Entra gallery programmatically, use the [applicationTemplate: instantiate](/graph/api/applicationtemplate-instantiate) API in Microsoft Graph.

## Next steps

Learn how to create a user account and assign it to the enterprise application that you added.
> [!div class="nextstepaction"]
> [Create and assign a user account](add-application-portal-assign-users.md)
