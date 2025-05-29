---
title: Configure CyberSolutions MAILBASEΣ\CMSS for Single sign-on in Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CyberSolutions MAILBASEΣ\CMSS.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
---

# Configure CyberSolutions MAILBASEΣ\CMSS for Single sign-on in Microsoft Entra ID

In this article,  you learn how to integrate CyberSolutions MAILBASEΣ\CMSS with Microsoft Entra ID. When you integrate CyberSolutions MAILBASEΣ\CMSS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CyberSolutions MAILBASEΣ\CMSS.
* Enable your users to be automatically signed-in to CyberSolutions MAILBASEΣ\CMSS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CyberSolutions MAILBASEΣ\CMSS single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CyberSolutions MAILBASEΣ\CMSS supports **SP and IDP** initiated SSO

## Adding CyberSolutions MAILBASEΣ\CMSS from the gallery

To configure the integration of CyberSolutions MAILBASEΣ\CMSS into Microsoft Entra ID, you need to add CyberSolutions MAILBASEΣ\CMSS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CyberSolutions MAILBASEΣ\CMSS** in the search box.
1. Select **CyberSolutions MAILBASEΣ\CMSS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-cybersolutions-mailbasecmss'></a>

## Configure and test Microsoft Entra SSO for CyberSolutions MAILBASEΣ\CMSS

Configure and test Microsoft Entra SSO with CyberSolutions MAILBASEΣ\CMSS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CyberSolutions MAILBASEΣ\CMSS.

To configure and test Microsoft Entra SSO with CyberSolutions MAILBASEΣ\CMSS, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CyberSolutions MAILBASE SSO](#configure-cybersolutions-mailbase-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CyberSolutions MAILBASE test user](#create-cybersolutions-mailbase-test-user)** - to have a counterpart of B.Simon in CyberSolutions MAILBASEΣ\CMSS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CyberSolutions MAILBASEΣ\CMSS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/saml/module.php/saml/sp/metadata.php/mb_generic_sp`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/cgi-bin/mbase/mblogin/saml2-acs/mb_generic_sp`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/cgi-bin/mbase/mblogin?saml_domain=<domain>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [CyberSolutions MAILBASEΣ\CMSS Client support team](mailto:tech@cybersolutions.co.jp) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up CyberSolutions MAILBASEΣ\CMSS** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CyberSolutions MAILBASE SSO

To configure single sign-on on **CyberSolutions MAILBASEΣ\CMSS** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [CyberSolutions MAILBASEΣ\CMSS support team](mailto:tech@cybersolutions.co.jp). They set this setting to have the SAML SSO connection set properly on both sides.

### Create CyberSolutions MAILBASE test user

In this section, you create a user called Britta Simon in CyberSolutions MAILBASEΣ\CMSS. Work with [CyberSolutions MAILBASEΣ\CMSS support team](mailto:tech@cybersolutions.co.jp) to add the users in the CyberSolutions MAILBASEΣ\CMSS platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to CyberSolutions MAILBASEΣ\CMSS Sign on URL where you can initiate the login flow.  

* Go to CyberSolutions MAILBASEΣ\CMSS Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the CyberSolutions MAILBASEΣ\CMSS for which you set up the SSO 

You can also use Microsoft Access Panel to test the application in any mode. When you select the CyberSolutions MAILBASEΣ\CMSS tile in the Access Panel, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the CyberSolutions MAILBASEΣ\CMSS for which you set up the SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure CyberSolutions MAILBASEΣ\CMSS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
