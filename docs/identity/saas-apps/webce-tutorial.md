---
title: Configure WebCE for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and WebCE.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and WebCE so that I can control who has access to WebCE, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure WebCE for Single sign-on with Microsoft Entra ID

In this article, you learn how to integrate WebCE with Microsoft Entra ID. WebCE offers self-study online continuing education and pre-license training courses for a variety of professional licenses and designations. When you integrate WebCE with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to WebCE.
* Enable your users to be automatically signed-in to WebCE with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for WebCE in a test environment. WebCE supports only **SP** initiated single sign-on and **Just In Time** user provisioning.

## Prerequisites

To integrate Microsoft Entra ID with WebCE, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* WebCE single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the WebCE application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-webce-from-the-azure-ad-gallery'></a>

### Add WebCE from the Microsoft Entra gallery

Add WebCE from the Microsoft Entra application gallery to configure single sign-on with WebCE. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **WebCE** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using the following pattern:
    `https://www.webce.com`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://www.webce.com/<RootPortalFolder>/login/saml20`

    c. In the **Sign on URL** textbox, type a URL using the following pattern:
    `https://www.webce.com/<RootPortalFolder>/login`

    > [!Note]
    > These values aren't the real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [WebCE Client support team](mailto:corporatesales@webce.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Screenshot shows how to edit SAML Signing Certificate.](common/edit-certificate.png "Certificate")

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Screenshot shows how to copy Thumbprint value.](common/copy-thumbprint.png "Thumbprint")

## Configure WebCE SSO

To configure single sign-on on **WebCE** side, you need to send **Thumbprint Value** and appropriate copied URLs from the application configuration to [WebCE support team](mailto:corporatesales@webce.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create WebCE test user

In this section, a user called B.Simon is created in WebCE. WebCE supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in WebCE, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to WebCE Sign-on URL where you can initiate the login flow. 

* Go to WebCE Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the WebCE tile in the My Apps, this option redirects to WebCE Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Related content

Once you configure WebCE you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
