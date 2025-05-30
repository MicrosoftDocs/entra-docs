---
title: Configure Datava Enterprise Service Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Datava Enterprise Service Platform.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Datava Enterprise Service Platform so that I can control who has access to Datava Enterprise Service Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Datava Enterprise Service Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Datava Enterprise Service Platform with Microsoft Entra ID. When you integrate Datava Enterprise Service Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Datava Enterprise Service Platform.
* Enable your users to be automatically signed-in to Datava Enterprise Service Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Datava Enterprise Service Platform single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Datava Enterprise Service Platform supports **SP** initiated SSO.
* Datava Enterprise Service Platform supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Datava Enterprise Service Platform from the gallery

To configure the integration of Datava Enterprise Service Platform into Microsoft Entra ID, you need to add Datava Enterprise Service Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Datava Enterprise Service Platform** in the search box.
1. Select **Datava Enterprise Service Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-datava-enterprise-service-platform'></a>

## Configure and test Microsoft Entra SSO for Datava Enterprise Service Platform

Configure and test Microsoft Entra SSO with Datava Enterprise Service Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Datava Enterprise Service Platform.

To configure and test Microsoft Entra SSO with Datava Enterprise Service Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Datava Enterprise Service Platform SSO](#configure-datava-enterprise-service-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Datava Enterprise Service Platform test user](#create-datava-enterprise-service-platform-test-user)** - to have a counterpart of B.Simon in Datava Enterprise Service Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Datava Enterprise Service Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, enter this value:
    `https://samlsp.datava.com`

    b. In the **Reply URL** textbox, type the URL:
    `https://go.datava.com/saml/module.php/saml/sp/saml2-acs.php/<TENANT_NAME>-sp`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://go.datava.com/<TENANT_NAME>`

	> [!NOTE]
	> Contact [Datava Enterprise Service Platform Client support team](mailto:support@datava.com) to get the TENANT_NAME value.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Datava Enterprise Service Platform SSO

To configure single sign-on on **Datava Enterprise Service Platform** side, you need to send the **App Federation Metadata Url** to [Datava Enterprise Service Platform support team](mailto:support@datava.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Datava Enterprise Service Platform test user

In this section, a user called Britta Simon is created in Datava Enterprise Service Platform. Datava Enterprise Service Platform supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Datava Enterprise Service Platform, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, this option redirects to Datava Enterprise Service Platform Sign-on URL where you can initiate the login flow.

* Go to Datava Enterprise Service Platform Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Datava Enterprise Service Platform tile in the My Apps, this option redirects to Datava Enterprise Service Platform Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Datava Enterprise Service Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
