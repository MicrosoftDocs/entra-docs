---
title: Configure Acronis Cyber Protect Cloud for Single Sign-On with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Acronis Cyber Protect Cloud.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

---

# Configure Acronis Cyber Protect Cloud for Single Sign-On with Microsoft Entra ID

In this article,  you learn how to integrate Acronis Cyber Protect Cloud with Microsoft Entra ID. When you integrate Acronis Cyber Protect Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Acronis Cyber Protect Cloud.
* Enable your users to be automatically signed on to Acronis Cyber Protect Cloud with their Microsoft Entra accounts.
* Control SP-initiated and IDP-initiated SAML Single Logout (SLO) processes.
* Manage your accounts in one central location.
* By-pass Acronis 2FA challenge.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* An Acronis Cyber Protect Cloud subscription. You can [subscribe for a free 30-day trial](https://www.acronis.com/products/cloud/trial/).
* An Acronis Cyber Protect Cloud **partner tenant**.
* An Acronis Cyber Protect Cloud user account with the company administrator role.

## Scenario description

In this article, you configure and test Microsoft Entra SSO in a test environment.

* Acronis Cyber Protect Cloud supports both **SP-initiated** and **IDP-initiated** SSO.

## Configure and test the Acronis integration with Microsoft Entra ID

### Activate the Acronis integration with Microsoft Entra ID

You must first activate the Acronis integration with Microsoft Entra ID for your Acronis partner tenant.

1. Open a browser tab.
1. Sign in to Acronis Management Portal as a partner administrator.
1. Select **INTEGRATIONS** from the main menu.
1. Locate the **Microsoft Entra ID** catalog card.
1. Hover over the **Microsoft Entra ID** catalog card and click **Configure**.
1. Enter your Microsoft Entra ID domain.
1. Click **Next**. Do not close this browser tab.

### Add Acronis Cyber Protect Cloud from the gallery

To configure the integration of Acronis Cyber Protect Cloud into Microsoft Entra ID, you need to add Acronis Cyber Protect Cloud from the gallery to your list of managed SaaS apps.

1. Open a new browser tab.
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Acronis Cyber Protect Cloud** in the search box.
1. Select **Acronis Cyber Protect Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

1. Open the application.
1. Select **Single sign-on** from the menu, and select the **SAML** single sign-on method.
1. Click **Edit** in the **Basic SAML Configuration** section.
1. Switch back to the Acronis Cyber Protect Cloud browser tab and click the copy icon in the **Identifier (Entity ID)** field to copy the value.
1. Switch to the Microsoft Entra admin center browser tab and paste the copied value into the **Identifier (Entity ID)** field.
1. Switch back to the Acronis Cyber Protect Cloud browser tab again and click the copy icon in the **Reply URL (Assertion Consumer Service URL)** field to copy the value.
1. Switch to the Microsoft Entra admin center browser tab and paste the copied value into the **Reply URL (Assertion Consumer Service URL)** field.
1. Click Save.
1. In the Microsoft Entra admin center browser tab, scroll down to the SAML Certificates and click **Download** to download the **Federation Metadata XML** file.
1. Switch to the Acronis Cyber Protect Cloud browser tab. In **App Federation Metadata**, click **Browse files...** to upload the Federation Metadata XML file you downloaded in the previous step.
1. Click **Activate**.
 
## Configure and test Microsoft Entra SSO for Acronis Cyber Protect Cloud

Configure and test Microsoft Entra SSO with Acronis Cyber Protect Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Acronis Cyber Protect Cloud.

To configure and test Microsoft Entra SSO with Acronis Cyber Protect Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Create and enable Acronis Cyber Protect Cloud test user](#create-and-enable-the-acronis-cyber-protect-cloud-test-user)** - to have a counterpart of B.Simon in Acronis Cyber Protect Cloud that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

### Configure Microsoft Entra SSO

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

### Create and enable the Acronis Cyber Protect Cloud test user

1. In Acronis Management Portal, create a user called B.Simon to map with the user you created in Microsoft Entra ID. Acronis sends an activation email to the new user.
1. Open the email and activate the user.

### Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the Acronis Cyber Protect Cloud for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the Acronis Cyber Protect Cloud tile in the My Apps, you should be automatically signed in to the Acronis Cyber Protect Cloud for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content
For more information about the Acronis integration with Microsoft Entra ID, see [the Acronis integration guide](https://www.acronis.com/support/documentation/EntraID/index.html#overview.html).

Once you configure Acronis Cyber Protect Cloud you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
