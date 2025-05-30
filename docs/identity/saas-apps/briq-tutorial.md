---
title: Configure Briq for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Briq.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Briq so that I can control who has access to Briq, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Briq for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Briq with Microsoft Entra ID. When you integrate Briq with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Briq.
* Enable your users to be automatically signed-in to Briq with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Briq single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Briq supports only **SP** initiated SSO.
* Briq supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Briq from the gallery

To configure the integration of Briq into Microsoft Entra ID, you need to add Briq from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Briq** in the search box.
1. Select **Briq** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Briq

Configure and test Microsoft Entra SSO with Briq using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Briq.

To configure and test Microsoft Entra SSO with Briq, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Briq SSO](#configure-briq-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Briq test user](#create-briq-test-user)** - to have a counterpart of B.Simon in Briq that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Briq** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `https://microservice-prod.br.iq/authentication/microsoft/metadata`

    b. In the **Reply URL** text box, type the URL:
    `https://microservice-prod.br.iq/authentication/microsoft/ssodata`

    b. In the **Sign on URL** text box, type the URL:
    `https://app.br.iq`

1. Briq application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Briq application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| ---- | ---------------- |
	| number | user.mobilephone |
	| country | user.country |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Briq** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Briq SSO

To configure single sign-on on **Briq** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Briq support team](https://briq.com/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Briq test user

In this section, a user called Britta Simon is created in Briq. Briq supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Briq, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Briq Sign-on URL where you can initiate the login flow.
 
* Go to Briq Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Briq tile in the My Apps, this option redirects to Briq Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Briq you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
