---
title: Configure Cequence Application Security Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cequence Application Security Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cequence Application Security Platform so that I can control who has access to Cequence Application Security Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Cequence Application Security Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cequence Application Security Platform with Microsoft Entra ID. When you integrate Cequence Application Security Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cequence Application Security Platform.
* Enable your users to be automatically signed-in to Cequence Application Security Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cequence Application Security Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Cequence Application Security Platform supports **SP** initiated SSO

* Cequence Application Security Platform supports **Just In Time** user provisioning


## Adding Cequence Application Security Platform from the gallery

To configure the integration of Cequence Application Security Platform into Microsoft Entra ID, you need to add Cequence Application Security Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cequence Application Security Platform** in the search box.
1. Select **Cequence Application Security Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-cequence-application-security-platform'></a>

## Configure and test Microsoft Entra SSO for Cequence Application Security Platform

Configure and test Microsoft Entra SSO with Cequence Application Security Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cequence Application Security Platform.

To configure and test Microsoft Entra SSO with Cequence Application Security Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cequence Application Security Platform SSO](#configure-cequence-application-security-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cequence Application Security Platform test user](#create-cequence-application-security-platform-test-user)** - to have a counterpart of B.Simon in Cequence Application Security Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cequence Application Security Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<CUSTOMERNAME>.s.cequence.cloud`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<CUSTOMERNAME>.s.cequence.cloud:443/saml/metadata`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Cequence Application Security Platform Client support team](mailto:support@cequence.ai) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Cequence Application Security Platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Cequence Application Security Platform application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| --------------- | --------- |
	| Group | user.groups |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cequence Application Security Platform SSO

To configure single sign-on on **Cequence Application Security Platform** side, you need to send the **App Federation Metadata Url** to [Cequence Application Security Platform support team](mailto:support@cequence.ai). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cequence Application Security Platform test user

In this section, a user called Britta Simon is created in Cequence Application Security Platform. Cequence Application Security Platform supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Cequence Application Security Platform, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Select **Test this application**, this option redirects to Cequence Application Security Platform Sign-on URL where you can initiate the login flow. 

2. Go to Cequence Application Security Platform Sign-on URL directly and initiate the login flow from there.

3. You can use Microsoft Access Panel. When you select the Cequence Application Security Platform tile in the Access Panel, this option redirects to Cequence Application Security Platform Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Cequence Application Security Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
