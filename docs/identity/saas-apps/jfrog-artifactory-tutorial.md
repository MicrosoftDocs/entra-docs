---
title: Configure JFrog Artifactory for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and JFrog Artifactory.
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


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and JFrog Artifactory so that I can control who has access to JFrog Artifactory, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure JFrog Artifactory for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate JFrog Artifactory with Microsoft Entra ID. When you integrate JFrog Artifactory with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to JFrog Artifactory.
* Enable your users to be automatically signed-in to JFrog Artifactory with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* JFrog Artifactory single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* JFrog Artifactory supports both **SP and IDP** initiated SSO.
* JFrog Artifactory supports **Just In Time** user provisioning.

## Add JFrog Artifactory from the gallery

To configure the integration of JFrog Artifactory into Microsoft Entra ID, you need to add JFrog Artifactory from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **JFrog Artifactory** in the search box.
1. Select **JFrog Artifactory** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for JFrog Artifactory

Configure and test Microsoft Entra SSO with JFrog Artifactory using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in JFrog Artifactory.

To configure and test Microsoft Entra SSO with JFrog Artifactory, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure JFrog Artifactory SSO](#configure-jfrog-artifactory-sso)** - to configure the single sign-on settings on application side.
    1. **[Create JFrog Artifactory test user](#create-jfrog-artifactory-test-user)** - to have a counterpart of B.Simon in JFrog Artifactory that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **JFrog Artifactory** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value using the following pattern:
    `<SERVERNAME>.jfrog.io`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SERVERNAME>.jfrog.io/<SERVERNAME>/webapp/saml/loginResponse`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SERVERNAME>.jfrog.io/<SERVERNAME>/webapp/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [JFrog Artifactory support team](https://support.jfrog.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. JFrog Artifactory application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")
 
1. In addition to above, JFrog Artifactory application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute |
	| ---- | ---------------- |
	| email | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificateraw.png "Certificate")

1. On the **Set up JFrog Artifactory** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure JFrog Artifactory SSO

To configure single sign-on on **JFrog Artifactory** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from Microsoft Entra admin center to [JFrog Artifactory support team](https://support.jfrog.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create JFrog Artifactory test user

In this section, a user called Britta Simon is created in JFrog Artifactory. JFrog Artifactory supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in JFrog Artifactory, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to JFrog Artifactory Sign on URL where you can initiate the login flow.  
 
* Go to JFrog Artifactory Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the JFrog Artifactory for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the JFrog Artifactory tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the JFrog Artifactory for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure JFrog Artifactory you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).