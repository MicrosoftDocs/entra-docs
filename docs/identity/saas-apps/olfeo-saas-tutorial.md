---
title: Configure Olfeo SAAS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Olfeo SAAS.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Olfeo SAAS so that I can control who has access to Olfeo SAAS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Olfeo SAAS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Olfeo SAAS with Microsoft Entra ID. When you integrate Olfeo SAAS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Olfeo SAAS.
* Enable your users to be automatically signed-in to Olfeo SAAS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Olfeo SAAS single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Olfeo SAAS supports **SP** initiated SSO.

* Olfeo SAAS supports [Automated user provisioning](olfeo-saas-provisioning-tutorial.md).

## Adding Olfeo SAAS from the gallery

To configure the integration of Olfeo SAAS into Microsoft Entra ID, you need to add Olfeo SAAS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Olfeo SAAS** in the search box.
1. Select **Olfeo SAAS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-olfeo-saas'></a>

## Configure and test Microsoft Entra SSO for Olfeo SAAS

Configure and test Microsoft Entra SSO with Olfeo SAAS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Olfeo SAAS.

To configure and test Microsoft Entra SSO with Olfeo SAAS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Olfeo SAAS SSO](#configure-olfeo-saas-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Olfeo SAAS test user](#create-olfeo-saas-test-user)** - to have a counterpart of B.Simon in Olfeo SAAS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Olfeo SAAS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.olfeo.com/api/sso/saml/<ID>/login`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.olfeo.com/api/sso/saml/<ID>/login`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.olfeo.com/api/sso/saml/<ID>/acs`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL, Identifier and Reply URL. Contact [Olfeo SAAS Client support team](mailto:equipe-rd@olfeo.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Olfeo SAAS SSO

To configure single sign-on on **Olfeo SAAS** side, you need to send the **App Federation Metadata Url** to [Olfeo SAAS support team](mailto:equipe-rd@olfeo.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Olfeo SAAS test user

In this section, you create a user called Britta Simon in Olfeo SAAS. Work with [Olfeo SAAS support team](mailto:equipe-rd@olfeo.com) to add the users in the Olfeo SAAS platform. Users must be created and activated before you use single sign-on.

Olfeo SAAS also supports automatic user provisioning, you can find more details [here](./olfeo-saas-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Olfeo SAAS Sign-on URL where you can initiate the login flow. 

* Go to Olfeo SAAS Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Olfeo SAAS tile in the My Apps, this option redirects to Olfeo SAAS Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Olfeo SAAS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
