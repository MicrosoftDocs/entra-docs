---
title: Configure Acronis Cyber Protect Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Acronis Cyber Protect Cloud.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

---

# Configure Acronis Cyber Protect Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Acronis Cyber Protect Cloud with Microsoft Entra ID. When you integrate Acronis Cyber Protect Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Acronis Cyber Protect Cloud.
* Enable your users to be automatically signed-in to Acronis Cyber Protect Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Acronis Cyber Protect Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Acronis Cyber Protect Cloud supports only **IDP** initiated SSO.

## Add Acronis Cyber Protect Cloud from the gallery

To configure the integration of Acronis Cyber Protect Cloud into Microsoft Entra ID, you need to add Acronis Cyber Protect Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Acronis Cyber Protect Cloud** in the search box.
1. Select **Acronis Cyber Protect Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Acronis Cyber Protect Cloud

Configure and test Microsoft Entra SSO with Acronis Cyber Protect Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Acronis Cyber Protect Cloud.

To configure and test Microsoft Entra SSO with Acronis Cyber Protect Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Acronis Cyber Protect Cloud SSO](#configure-acronis-cyber-protect-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Acronis Cyber Protect Cloud test user](#create-acronis-cyber-protect-cloud-test-user)** - to have a counterpart of B.Simon in Acronis Cyber Protect Cloud that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Acronis Cyber Protect Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:cyber:protect:saml:<YOUR_ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<YOUR_DOMAIN>/api/2/saml/callback`

    c. In the **Logout URL** text box, type a URL using the following pattern:
    `https://<YOUR_DOMAIN>/api/2/saml/logout`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Logout URL. Contact [Acronis Cyber Protect Cloud support team](mailto:mspsupport@acronis.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Acronis Cyber Protect Cloud** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Acronis Cyber Protect Cloud SSO

To configure single sign-on on **Acronis Cyber Protect Cloud** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [Acronis Cyber Protect Cloud support team](mailto:mspsupport@acronis.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Acronis Cyber Protect Cloud test user

In this section, you create a user called B.Simon in Acronis Cyber Protect Cloud. Work with [Acronis Cyber Protect Cloud support team](mailto:mspsupport@acronis.com) to add the users in the Acronis Cyber Protect Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the Acronis Cyber Protect Cloud for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the Acronis Cyber Protect Cloud tile in the My Apps, you should be automatically signed in to the Acronis Cyber Protect Cloud for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Acronis Cyber Protect Cloud you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).