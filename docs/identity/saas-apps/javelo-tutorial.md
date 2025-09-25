---
title: Configure Javelo for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Javelo.
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Javelo so that I can control who has access to Javelo, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Javelo for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Javelo with Microsoft Entra ID. When you integrate Javelo with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Javelo.
* Enable your users to be automatically signed-in to Javelo with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Javelo single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Javelo supports **SP** initiated SSO.
* Javelo supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Javelo from the gallery

To configure the integration of Javelo into Microsoft Entra ID, you need to add Javelo from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Javelo** in the search box.
1. Select **Javelo** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-javelo'></a>

## Configure and test Microsoft Entra SSO for Javelo

Configure and test Microsoft Entra SSO with Javelo using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Javelo.

To configure and test Microsoft Entra SSO with Javelo, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Javelo SSO](#configure-javelo-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Javelo test user](#create-javelo-test-user)** - to have a counterpart of B.Simon in Javelo that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Javelo** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, Upload the **Service Provider metadata file** which you can download from the `https://api.javelo.io/omniauth/<CustomerSPIdentifier>_saml/metadata` and perform the following steps:

	a. Select **Upload metadata file**.

    ![Screenshot shows Basic SAML Configuration with the Upload metadata file link.](common/upload-metadata.png "Folder")

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![Screenshot shows a dialog box where you can select and upload a file.](common/browse-upload-metadata.png "Logo")

	c. Once the metadata file is successfully uploaded, the necessary URLs get auto populated automatically.

	d. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<CustomerSubdomain>.javelo.io/auth/login`

    > [!NOTE]
	> This value isn't real. Update this value with the actual Sign-on URL. Contact [Javelo Client support team](mailto:Support@javelo.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Javelo SSO

1. Log in to your Javelo company site as an administrator.

1. Go to **Admin** view and navigate to **SSO** tab > **Microsoft Entra ID** and select **Configure**.

1. In the **Enable SSO with Microsoft Entra ID** page, perform the following steps:

    ![Screenshot that shows the Configuration Settings.](./media/javelo-tutorial/settings.png "Configuration")

    a. Enter a valid name in the **Provider** textbox.

    b.  In the **Entity ID** textbox, paste the **Microsoft Entra Identifier** value which you copied previously.

    c. In the **Metadata URL** textbox, paste the **App Federation Metadata Url** which you copied previously.

    d. Select **Test URL**.

    e. Enter a valid domain in the **Email Domains** textbox.

    f. Select **Enable SSO with Microsoft Entra ID**.

### Create Javelo test user

In this section, a user called B.Simon is created in Javelo. Javelo supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Javelo, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Javelo Sign-on URL where you can initiate the login flow. 

* Go to Javelo Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Javelo tile in the My Apps, this option redirects to Javelo Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Javelo you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
