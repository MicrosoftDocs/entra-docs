---
title: Configure Datasite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Datasite.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Datasite so that I can control who has access to Datasite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Datasite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Datasite with Microsoft Entra ID. When you integrate Datasite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Datasite.
* Enable your users to be automatically signed-in to Datasite with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Datasite single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Datasite supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Datasite from the gallery

To configure the integration of Datasite into Microsoft Entra ID, you need to add Datasite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Datasite** in the search box.
1. Select **Datasite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-datasite'></a>

## Configure and test Microsoft Entra SSO for Datasite

Configure and test Microsoft Entra SSO with Datasite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Datasite.

To configure and test Microsoft Entra SSO with Datasite, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Datasite SSO](#configure-datasite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Datasite test user](#create-datasite-test-user)** - to have a counterpart of B.Simon in Datasite that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Datasite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:
    
    a. In the **Reply URL** text box, type the URL:
    `https://auth.datasite.com/sp/ACS.saml2`
    
    b. In the **Sign-on URL** text box, type the URL:
    `https://auth.datasite.com/sp/ACS.saml2`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Datasite** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Datasite SSO

To configure single sign-on on **Datasite** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Datasite support team](mailto:service@datasite.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Datasite test user

In this section, you create a user called B.Simon in Datasite. Work with [Datasite support team](mailto:service@datasite.com) to add the users in the Datasite platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Datasite Sign-on URL where you can initiate the login flow. 

* Go to Datasite Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Datasite tile in the My Apps, this option redirects to Datasite Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Datasite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
