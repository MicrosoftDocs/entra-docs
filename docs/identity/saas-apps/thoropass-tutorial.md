---
title: Configure Thoropass for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Thoropass.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/12/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Thoropass for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Thoropass with Microsoft Entra ID. When you integrate Thoropass with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Thoropass.
* Enable your users to be automatically signed-in to Thoropass with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Thoropass single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Thoropass supports **SP and IDP** initiated SSO.
* Thoropass supports **Just In Time** user provisioning.

## Add Thoropass from the gallery

To configure the integration of Thoropass into Microsoft Entra ID, you need to add Thoropass from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Thoropass** in the search box.
1. Select **Thoropass** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Thoropass

Configure and test Microsoft Entra SSO with Thoropass using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Thoropass.

To configure and test Microsoft Entra SSO with Thoropass, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Thoropass SSO](#configure-thoropass-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Thoropass test user](#create-thoropass-test-user)** - to have a counterpart of B.Simon in Thoropass that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Thoropass** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the application is preconfigured and the necessary URLs are already prepopulated with Microsoft Entra. The user needs to save the configuration by selecting the **Save** button.

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://login.thoropass.com`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Thoropass SSO

To configure single sign-on on **Thoropass** side, you need to send the **App Federation Metadata Url** to [Thoropass support team](mailto:support@thoropass.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Thoropass test user

In this section, a user called Britta Simon is created in Thoropass. Thoropass supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Thoropass, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the My Apps.


#### SP initiated:

* Select **Test this application** in Microsoft Entra admin center. this option redirects to Thoropass Sign on URL where you can initiate the login flow.  
* Go to Thoropass Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to Thoropass for which you set up the SSO.

You can also use Microsoft My Apps to test the application in any mode. When you select the Thoropass tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to Thoropass for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](
https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Thoropass you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).