---
title: 'Add an OpenID Connect-based single sign-on application'
description: Learn how to add OpenID Connect-based single sign-on application in Microsoft Entra ID.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article

ms.date: 05/22/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps

#customer intent: As an administrator, I want to add an application that supports OpenID Connect-based single sign-on (SSO) to my Microsoft Entra tenant, so that I can provide a seamless authentication experience for my users.
---

# Add an OpenID Connect-based single sign-on application

Add an application that supports [OpenID Connect (OIDC)](~/identity-platform/v2-protocols.md) based single sign-on (SSO) to your Microsoft Entra tenant.

We recommend you use a nonproduction environment to test the steps in this page.

[!INCLUDE [portal updates](~/includes/portal-update.md)]

## Prerequisites

To configure OIDC-based SSO, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.

## Add the application

When you add an enterprise application that uses the OIDC standard for SSO, you select a setup button. When you select the button, you complete the sign-up process for the application.

To configure OIDC-based SSO for an application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. In the **All applications** pane, select **New application**.
1. The **Browse Microsoft Entra Gallery** pane opens and displays tiles for cloud platforms, on-premises applications, and featured applications. Applications listed in the **Featured applications** section have icons indicating whether they support federated SSO and provisioning. Search for and select the application. In this example, **SmartSheet** is being used.
1. Select **Sign-up**. Sign in with the user account credentials from Microsoft Entra ID. If you already have a subscription to the application, then user details and tenant information is validated. If the application isn't able to verify the user, then it redirects you to sign up for the application service.

    :::image type="content" source="media/add-application-portal-setup-oidc-sso/oidc-sso-configuration.png" alt-text="Complete the consent screen for an application." lightbox="media/add-application-portal-setup-oidc-sso/oidc-sso-configuration.png":::

1. Select **Consent on behalf of your organization** and then select **Accept**. The application is added to your tenant and the application home page appears. To learn more about user and admin consent, see [Understand user and admin consent](~/identity-platform/howto-convert-app-to-be-multi-tenant.md#understand-user-and-admin-consent-and-make-appropriate-code-changes).

## Next steps

Learn more about planning a single sign-on deployment.
> [!div class="nextstepaction"]
> [Plan single sign-on deployment](plan-sso-deployment.md)
