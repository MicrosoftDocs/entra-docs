---
title: Configure Collaborative Innovation for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Collaborative Innovation.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Collaborative Innovation so that I can control who has access to Collaborative Innovation, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Collaborative Innovation for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Collaborative Innovation with Microsoft Entra ID. When you integrate Collaborative Innovation with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Collaborative Innovation.
* Enable your users to be automatically signed-in to Collaborative Innovation with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Collaborative Innovation single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Collaborative Innovation supports **SP** initiated SSO


* Collaborative Innovation supports **Just In Time** user provisioning

## Adding Collaborative Innovation from the gallery

To configure the integration of Collaborative Innovation into Microsoft Entra ID, you need to add Collaborative Innovation from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Collaborative Innovation** in the search box.
1. Select **Collaborative Innovation** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-single-sign-on-for-collaborative-innovation'></a>

## Configure and test Microsoft Entra single sign-on for Collaborative Innovation

Configure and test Microsoft Entra SSO with Collaborative Innovation using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Collaborative Innovation.

To configure and test Microsoft Entra SSO with Collaborative Innovation, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Collaborative Innovation SSO](#configure-collaborative-innovation-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Collaborative Innovation test user](#create-collaborative-innovation-test-user)** - to have a counterpart of B.Simon in Collaborative Innovation that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Collaborative Innovation** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<instancename>.foundry.<companyname>.com/`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<instancename>.foundry.<companyname>.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Collaborative Innovation Client support team](https://www.unilever.com/contact/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Collaborative Innovation application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

1. In addition to above, Collaborative Innovation application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement.

	| Name | Source Attribute|
	| ---------------| --------------- |
	| givenname | user.givenname |
	| surname | user.surname |
	| emailaddress | user.userprincipalname |
	| name | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Collaborative Innovation** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Collaborative Innovation SSO

To configure single sign-on on **Collaborative Innovation** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Collaborative Innovation support team](https://www.unilever.com/contact/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Collaborative Innovation test user

In this section, a user called B.Simon is created in Collaborative Innovation. Collaborative Innovation supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Collaborative Innovation, a new one is created when you attempt to access Collaborative Innovation.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Collaborative Innovation tile in the Access Panel, you should be automatically signed in to the Collaborative Innovation for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
