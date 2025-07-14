---
title: Configure Innoverse for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Innoverse.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Innovation Hub so that I can control who has access to Innovation Hub, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Innoverse for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Innoverse with Microsoft Entra ID. When you integrate Innoverse with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Innoverse.
* Enable your users to be automatically signed-in to Innoverse with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Innoverse single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.



* Innoverse supports **SP and IDP** initiated SSO
* Innoverse supports **Just In Time** user provisioning


## Adding Innoverse from the gallery

To configure the integration of Innoverse into Microsoft Entra ID, you need to add Innoverse from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Innoverse** in the search box.
1. Select **Innoverse** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-single-sign-on-for-innoverse'></a>

## Configure and test Microsoft Entra single sign-on for Innoverse

Configure and test Microsoft Entra SSO with Innoverse using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Innoverse.

To configure and test Microsoft Entra SSO with Innoverse, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Innoverse SSO](#configure-innoverse-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Innoverse test user](#create-innoverse-test-user)** - to have a counterpart of B.Simon in Innoverse that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Innoverse** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<domainname>.innover.se`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<domainname>.innover.se/auth/saml2/login`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<domainname>.innover.se/auth/saml2/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Innoverse Client support team](mailto:support@readify.net) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Innoverse application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

1. In addition to above, Innoverse application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement.

	| Name | Namespace | Source Attribute| 
	| ---------------| --------- | ----------------|
	| displayname | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims` | `user.userprincipalname` |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Innoverse SSO

To configure single sign-on on **Innoverse** side, you need to send the **App Federation Metadata Url** to [Innoverse support team](mailto:support@readify.net). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Innoverse test user

In this section, a user called Britta Simon is created in Innoverse. Innoverse supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Innoverse, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the Innoverse tile in the Access Panel, you should be automatically signed in to the Innoverse for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
