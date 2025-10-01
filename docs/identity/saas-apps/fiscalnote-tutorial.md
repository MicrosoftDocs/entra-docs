---
title: Configure FiscalNote for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FiscalNote.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FiscalNote so that I can control who has access to FiscalNote, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FiscalNote for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FiscalNote with Microsoft Entra ID. When you integrate FiscalNote with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FiscalNote.
* Enable your users to be automatically signed-in to FiscalNote with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FiscalNote single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FiscalNote supports **SP** initiated SSO

* FiscalNote supports **Just In Time** user provisioning

## Adding FiscalNote from the gallery

To configure the integration of FiscalNote into Microsoft Entra ID, you need to add FiscalNote from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FiscalNote** in the search box.
1. Select **FiscalNote** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-single-sign-on-for-fiscalnote'></a>

## Configure and test Microsoft Entra single sign-on for FiscalNote

Configure and test Microsoft Entra SSO with FiscalNote using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FiscalNote.

To configure and test Microsoft Entra SSO with FiscalNote, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FiscalNote SSO](#configure-fiscalnote-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FiscalNote test user](#create-fiscalnote-test-user)** - to have a counterpart of B.Simon in FiscalNote that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FiscalNote** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<InstanceName>.fiscalnote.com/login?client=<ClientID>&redirect_uri=https://app.fiscalnote.com/saml-login.html&audience=https://api.fiscalnote.com/&connection=<CONNECTION_NAME>&response_type=id_token%20token`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `urn:auth0:fiscalnote:<CONNECTIONNAME>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [FiscalNote Client support team](mailto:support@fiscalnote.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. FiscalNote application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

6. In addition to above, FiscalNote application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement.


	| Name | Source Attribute|
	| ---------------| ----------------|
	| familyName| user.surname|
	| email| user.mail|

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up FiscalNote** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FiscalNote SSO

To configure single sign-on on **FiscalNote** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [FiscalNote support team](mailto:support@fiscalnote.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FiscalNote test user

In this section, a user called B.Simon is created in FiscalNote. FiscalNote supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in FiscalNote, a new one is created after authentication.

>[!Note]
>If you need to create a user manually, contact [FiscalNote support team](mailto:support@fiscalnote.com).

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you select the FiscalNote tile in the Access Panel, you should be automatically signed in to the FiscalNote for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of articles on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
