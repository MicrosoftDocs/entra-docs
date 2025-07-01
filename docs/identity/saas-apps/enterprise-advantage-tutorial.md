---
title: Configure Enterprise Advantage for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Enterprise Advantage.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 03/28/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Enterprise Advantage for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Enterprise Advantage with Microsoft Entra ID. When you integrate Enterprise Advantage with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Enterprise Advantage.
* Enable your users to be automatically signed-in to Enterprise Advantage with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Enterprise Advantage single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Enterprise Advantage supports both **SP and IDP** initiated SSO.
* Enterprise Advantage supports **Just In Time** user provisioning.

## Add Enterprise Advantage from the gallery

To configure the integration of Enterprise Advantage into Microsoft Entra ID, you need to add Enterprise Advantage from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Enterprise Advantage** in the search box.
1. Select **Enterprise Advantage** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Enterprise Advantage

Configure and test Microsoft Entra SSO with Enterprise Advantage using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Enterprise Advantage.

To configure and test Microsoft Entra SSO with Enterprise Advantage, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Enterprise Advantage SSO](#configure-enterprise-advantage-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Enterprise Advantage test user](#create-enterprise-advantage-test-user)** - to have a counterpart of B.Simon in Enterprise Advantage that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Enterprise Advantage** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type one of the following URLs:

    | Environment | URL |
    |-------------|----|
    | Production| `https://sso.screeningxchange.com/` |
    | Staging | `https://ssotest.screeningxchange.com/` |

    b. In the **Reply URL** text box, type one of the following URLs:

    | Environment | URL |
    |-------------|----|
    | Production| `https://sso.screeningxchange.com/sp/SAML2/POST` |
    | Staging | `https://ssotest.screeningxchange.com/sp/SAML2/POST` |
    
1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | Environment | URL |
    |-------------|----|
    | Production| `https://sso.screeningxchange.com/<CustomerLink>` |
    | Staging | `https://ssotest.screeningxchange.com/<CustomerLink>` |
    
	> [!NOTE]
	> The Sign-on URL value isn't real. Update the value with the Sign on URL. Contact [Enterprise Advantage support team](mailto:globaladvantagesupport@fadv.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. Enterprise Advantage application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Enterprise Advantage application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| ---- | --------------- |
	| email| user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Enterprise Advantage** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Enterprise Advantage SSO

To configure single sign-on on **Enterprise Advantage** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [Enterprise Advantage support team](mailto:globaladvantagesupport@fadv.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Enterprise Advantage test user

In this section, a user called Britta Simon is created in Enterprise Advantage. Enterprise Advantage supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Enterprise Advantage, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Enterprise Advantage Sign on URL where you can initiate the login flow.  
 
* Go to Enterprise Advantage Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the Enterprise Advantage for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the Enterprise Advantage tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Enterprise Advantage for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Enterprise Advantage you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).