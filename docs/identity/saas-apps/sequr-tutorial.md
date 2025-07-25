---
title: Configure Genea Access Control for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Genea Access Control.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Genea Access Control so that I can control who has access to Genea Access Control, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Genea Access Control for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Genea Access Control with Microsoft Entra ID. When you integrate Genea Access Control with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Genea Access Control.
* Enable your users to be automatically signed-in to Genea Access Control with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Genea Access Controls single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Genea Access Control supports **SP and IDP** initiated SSO.
> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.


## Adding Genea Access Control from the gallery

To configure the integration of Genea Access Control into Microsoft Entra ID, you need to add Genea Access Control from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Genea Access Control** in the search box.
1. Select **Genea Access Control** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-genea-access-control'></a>

## Configure and test Microsoft Entra SSO for Genea Access Control

Configure and test Microsoft Entra SSO with Genea Access Control using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Genea Access Control.

To configure and test Microsoft Entra SSO with Genea Access Control, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Genea Access Control SSO](#configure-genea-access-control-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Genea Access Control test user](#create-genea-access-control-test-user)** - to have a counterpart of B.Simon in Genea Access Control that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Genea Access Control** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following step:

    In the **Identifier** text box, type the URL:
    `https://login.sequr.io`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    a. In the **Sign-on URL** text box, type the URL: `https://login.sequr.io`

	b. In the **Relay State** textbox, you get this value, which is explained later in the article.

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

7. On the **Set up Genea Access Control** section, copy one or more appropriate URLs as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Genea Access Control SSO

1. In a different web browser window, sign in to your Genea Access Control company site as an administrator.

1. Select the **Integrations** from the left navigation panel.

	![Screenshot shows Integration selected from the navigation panel.](./media/sequr-tutorial/configure-1.png)

1. Scroll down to the **Single Sign-On** section and select **Manage**.

	![Screenshot shows the Single Sign-on section with the Manage button selected.](./media/sequr-tutorial/configure-2.png)

1. In the **Manage Single Sign-On** section, perform the following steps:

	![Screenshot shows the Manage Single Sign-On section where you can enter the values described.](./media/sequr-tutorial/configure-3.png)

	a. In the **Identity Provider Single Sign-On URL** textbox, paste the **Login URL** value, which you copied previously.

	b. Drag and drop the **Certificate** file, which you have downloaded or manually enters the content of the certificate.

	c. After saving the configuration, the relay state value is generated. Copy the **relay state** value and paste it in the **Relay State** textbox of **Basic SAML Configuration** section.

	d. Select **Save**.

### Create Genea Access Control test user

In this section, you create a user called Britta Simon in Genea Access Control. Work with [Genea Access Control Client support team](mailto:support@sequr.io) to add the users in the Genea Access Control platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Genea Access Control Sign on URL where you can initiate the sign in flow.  

* Go to Genea Access Control Sign-on URL directly and initiate the sign in flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Genea Access Control for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the Genea Access Control tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the sign in flow and if configured in IDP mode, you should be automatically signed in to the Genea Access Control for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Multiple Microsoft Entra Instances in One Genea Portal

* Does Genea Support Multiple Microsoft Entra Instances?

	Yes, it's possible to connect with multiple Microsoft Entra instances to a single Genea portal where user groups are enabled. Here are mandatory considerations to keep in mind:

	1.	External ID Mapping: Ensure that the external ID is mapped to the object ID for user provisioning; else, the user may lose access. To update the mapping, sign in to Microsoft Entra and go to Enterprise Applications > Genea SCIM Application > Provisioning > Edit Provisioning > Mappings > Edit User Mapping, then change the externalId mapping from mailNickname to objectId.
	2.	Unique Group Names: Genea doesn’t support duplicate user group names. Ensure that each Microsoft Entra instance uses distinct group names to avoid any potential errors.
	3.	Moving to single Microsoft Entra Instances: If you plan to transition from multiple Microsoft Entra instances to a single one, it’s essential to have a clear migration plan. You can either manage this transition internally or collaborate with Genea to ensure a smooth migration without service disruptions.

## Related content

Once you configure Genea Access Control you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
