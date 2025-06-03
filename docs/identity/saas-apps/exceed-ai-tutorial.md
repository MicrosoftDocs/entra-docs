---
title: Configure Exceed.ai for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Exceed.ai.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Exceed.ai so that I can control who has access to Exceed.ai, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Exceed.ai for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Exceed.ai with Microsoft Entra ID. When you integrate Exceed.ai with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Exceed.ai.
* Enable your users to be automatically signed-in to Exceed.ai with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Exceed.ai single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Exceed.ai supports **SP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Exceed.ai from the gallery

To configure the integration of Exceed.ai into Microsoft Entra ID, you need to add Exceed.ai from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Exceed.ai** in the search box.
1. Select **Exceed.ai** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-exceedai'></a>

## Configure and test Microsoft Entra SSO for Exceed.ai

Configure and test Microsoft Entra SSO with Exceed.ai using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Exceed.ai.

To configure and test Microsoft Entra SSO with Exceed.ai, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Exceed.ai SSO](#configure-exceedai-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Exceed.ai test user](#create-exceedai-test-user)** - to have a counterpart of B.Simon in Exceed.ai that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Exceed.ai** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    In the **Sign-on URL** text box, type the URL:
    `https://prod.exceed.ai/saml/sp/discovery`

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Exceed.ai SSO

To configure single sign-on on **Exceed.ai** side, you need to send the **App Federation Metadata Url** to [Exceed.ai support team](mailto:support@exceed.ai). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Exceed.ai test user

In this section, you create a user called Britta Simon in Exceed.ai. Work with [Exceed.ai support team](mailto:support@exceed.ai) to add the users in the Exceed.ai platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Exceed.ai Sign-on URL where you can initiate the login flow. 

* Go to Exceed.ai Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Exceed.ai tile in the My Apps, this option redirects to Exceed.ai Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Exceed.ai you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
