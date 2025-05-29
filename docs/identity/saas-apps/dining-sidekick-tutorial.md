---
title: Configure Dining Sidekick for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Dining Sidekick.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Dining Sidekick so that I can control who has access to Dining Sidekick, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Dining Sidekick for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Dining Sidekick with Microsoft Entra ID. When you integrate Dining Sidekick with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Dining Sidekick.
* Enable your users to be automatically signed-in to Dining Sidekick with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Dining Sidekick single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Dining Sidekick supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Dining Sidekick from the gallery

To configure the integration of Dining Sidekick into Microsoft Entra ID, you need to add Dining Sidekick from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Dining Sidekick** in the search box.
1. Select **Dining Sidekick** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-dining-sidekick'></a>

## Configure and test Microsoft Entra SSO for Dining Sidekick

Configure and test Microsoft Entra SSO with Dining Sidekick using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Dining Sidekick.

To configure and test Microsoft Entra SSO with Dining Sidekick, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Dining Sidekick SSO](#configure-dining-sidekick-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Dining Sidekick test user](#create-dining-sidekick-test-user)** - to have a counterpart of B.Simon in Dining Sidekick that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Dining Sidekick** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `https://api.diningsidekick.com`

	b. In the **Reply URL** text box, type the URL:
	`https://api.diningsidekick.com/api_user/samlsuccess`

	c. In the **Sign on URL** text box, type the URL:
    `https://api.diningsidekick.com/api_user/samllogin`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Dining Sidekick** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Dining Sidekick SSO

To configure single sign-on on **Dining Sidekick** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Dining Sidekick support team](mailto:support@gethangry.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Dining Sidekick test user

In this section, you create a user called Britta Simon in Dining Sidekick. Work with [Dining Sidekick support team](mailto:support@gethangry.com) to add the users in the Dining Sidekick platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Dining Sidekick Sign-on URL where you can initiate the login flow. 

* Open Dining Sidekick mobile app, choose **Sidekick University** and then initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Dining Sidekick tile in the My Apps, this option redirects to Dining Sidekick Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Dining Sidekick you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
