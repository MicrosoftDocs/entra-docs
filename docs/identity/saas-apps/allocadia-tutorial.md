---
title: Configure Allocadia for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Allocadia.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Allocadia so that I can control who has access to Allocadia, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Allocadia for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Allocadia with Microsoft Entra ID. When you integrate Allocadia with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Allocadia.
* Enable your users to be automatically signed-in to Allocadia with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:
[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Allocadia single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Allocadia supports **IDP** initiated SSO.
* Allocadia supports **Just In Time** user provisioning.

## Add Allocadia from the gallery

To configure the integration of Allocadia into Microsoft Entra ID, you need to add Allocadia from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Allocadia** in the search box.
1. Select **Allocadia** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-allocadia'></a>

## Configure and test Microsoft Entra SSO for Allocadia

Configure and test Microsoft Entra SSO with Allocadia using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Allocadia.

To configure and test Microsoft Entra SSO with Allocadia, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Allocadia SSO](#configure-allocadia-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Allocadia test user](#create-allocadia-test-user)** - to have a counterpart of B.Simon in Allocadia that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Allocadia** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type one of the following URLs:

	| **Identifier** |
	|------- |
	| For test environment - `https://na2standby.allocadia.com` |
	| For production environment - `https://na2.allocadia.com`

    b. In the **Reply URL** text box, type one of the following URLs:

	| **Reply URL** |
	|--------|
	| For test environment - `https://na2standby.allocadia.com/allocadia/saml/SSO` |
	| For production environment - `https://na2.allocadia.com/allocadia/saml/SSO` |

1. Allocadia application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Allocadia application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| -------------- | ----------- |
	| firstname | user.givenname |
	| lastname | user.surname |
	| email | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Allocadia** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Allocadia SSO

To configure single sign-on on **Allocadia** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Allocadia support team](mailto:support@allocadia.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Allocadia test user

In this section, a user called B.Simon is created in Allocadia. Allocadia supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Allocadia, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Allocadia for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Allocadia tile in the My Apps, you should be automatically signed in to the Allocadia for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Allocadia you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
