---
title: Configure Supermood for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Supermood.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Supermood so that I can control who has access to Supermood, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Supermood for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Supermood with Microsoft Entra ID. When you integrate Supermood with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Supermood.
* Enable your users to be automatically signed-in to Supermood with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Supermood single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Supermood supports **SP and IDP** initiated SSO
* Supermood supports **Just In Time** user provisioning

## Adding Supermood from the gallery

To configure the integration of Supermood into Microsoft Entra ID, you need to add Supermood from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Supermood** in the search box.
1. Select **Supermood** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-supermood'></a>

## Configure and test Microsoft Entra single sign-on for Supermood

Configure and test Microsoft Entra SSO with Supermood using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Supermood.

To configure and test Microsoft Entra SSO with Supermood, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Supermood SSO](#configure-supermood-sso)** - to configure the single sign-on settings on application side.
    * **[Create Supermood test user](#create-supermood-test-user)** - to have a counterpart of B.Simon in Supermood that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Supermood** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

	a. Check **Set additional URLs**.
	
	b. In the **Relay State** textbox, type a URL: `https://supermood.co/auth/sso/saml20`

1. Select **Set additional URLs** and perform the following steps if you wish to configure the application in **SP** initiated mode:

	In the **Sign-on URL** text box, type the URL:
    `https://supermood.co/app/#!/loginv2`

1. Select **Save**.

1. Supermood application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Supermood application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ---------------| ------|
	| firstName | user.givenname |
	| lastName | user.surname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Supermood SSO

1. Go to your Supermood.co admin panel as Security Administrator.

1. Select **My account** (bottom left) and **Single Sign On (SSO)**.

1. On **Your SAML 2.0 configurations**, Select **Add an SAML 2.0 configuration for an email domain**.

	![The Certificate add](./media/supermood-tutorial/tutorial_supermood_add.png)

1. On **Add an SAML 2.0 configuration for an email domain**. section, perform the following steps:

	![The Certificate saml](./media/supermood-tutorial/tutorial_supermood_saml.png)

	a. In the **email domain for this Identity provider** textbox, type your domain.

	b. In the **Use a metadata URL** textbox, paste the **App Federation Metadata Url**..

	c. Select **Add**.

### Create Supermood test user

In this section, a user called Britta Simon is created in Supermood. Supermood supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Supermood, a new one is created after authentication. If you need to create a user manually, contact [Supermood support team](mailto:hello@supermood.fr).

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Supermood tile in the Access Panel, you should be automatically signed in to the Supermood for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
