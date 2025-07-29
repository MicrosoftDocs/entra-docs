---
title: Add an enterprise application
description: Learn how to add enterprise applications to your Microsoft Entra external tenant using the admin center. Discover gallery apps, configuration steps, and deployment tips.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 07/17/2025
ms.custom: it-pro

#Customer intent: As an IT admin, I want to add an enterprise application to my Microsoft Entra tenant, so that I can provide my organization with access to pre-integrated applications from the gallery.
---
# Add an enterprise application to your external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Enterprise applications are software-as-a-service (SaaS) apps that are pre-integrated with Microsoft Entra ID. These apps support access management and single sign-on (SSO).
You can find these apps in the Microsoft Entra application gallery, which includes a wide range of pre-integrated SaaS applications.
This article uses the application named **Microsoft Entra SAML Toolkit** as an example, but the concepts apply for most [enterprise applications in the gallery](/entra/identity/saas-apps/tutorial-list).

## Prerequisites

To add an enterprise application to your external tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator).

## Add an enterprise application

To add an enterprise application to your Microsoft Entra external tenant, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select **New application** > **Create your own application**.
1. Start typing the name of the application you want to add. If the application is already in the gallery, it appears in the list. In this article we use **Microsoft Entra SAML Toolkit** as an example.

    :::image type="content" source="media/how-to-add-enterprise-application/add-enterprise-app.png" alt-text="Screenshot showing how to add an enterprise application in the external tenant.":::

1. Select the application from the list, and then select **Create**.
1. Select **Create**, you're taken to the application that you registered.
1. You should [assign owners to the application](/entra/identity/enterprise-apps/assign-app-owners?pivots=portal#assign-an-owner) as a best practice at this point.

## Clean up resources

You can keep the application in your tenant for future use, or you can [delete it](/entra/identity/enterprise-apps/delete-application-portal?pivots=portal) if you no longer need it. If you delete the application, all associated user assignments and configurations are also deleted.

## Related content

- [Register a SAML app in your external tenant](how-to-register-saml-app.md)