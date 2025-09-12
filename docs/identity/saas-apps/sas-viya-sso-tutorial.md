---
title: Configure SAS Viya SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SAS Viya SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SAS Viya SSO so that I can control who has access to SAS Viya SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SAS Viya SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SAS Viya SSO with Microsoft Entra ID. When you integrate SAS Viya SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SAS Viya SSO.
* Enable your users to be automatically signed-in to SAS Viya SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SAS Viya SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SAS Viya SSO supports both **SP and IDP** initiated SSO.
* SAS Viya SSO supports [Automated user provisioning](sas-viya-sso-provisioning-tutorial.md).

## Add SAS Viya SSO from the gallery

To configure the integration of SAS Viya SSO into Microsoft Entra ID, you need to add SAS Viya SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SAS Viya SSO** in the search box.
1. Select **SAS Viya SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for SAS Viya SSO

Configure and test Microsoft Entra SSO with SAS Viya SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SAS Viya SSO.

To configure and test Microsoft Entra SSO with SAS Viya SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SAS Viya SSO](#configure-sas-viya-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SAS Viya SSO test user](#create-sas-viya-sso-test-user)** - to have a counterpart of B.Simon in SAS Viya SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SAS Viya SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a value:
    `cloudfoundry-saml-login`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SAS_DOMAIN>.com/SASLogon/saml/SSO/alias/cloudfoundry-saml-login`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://miroda.unx.sas.com/SASLogon/home`

	> [!NOTE]
	> The Reply URL isn't real. Update the value with the actual Reply URL. Contact [SAS Viya SSO support team](mailto:support@sas.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SAS Viya SSO

To configure SAS Viya SSO to support single sign-on with Microsoft Entra ID, please refer [this](https://go.documentation.sas.com/doc/en/sasadmincdc/default/calauthmdl/n1iyx40th7exrqn1ej8t12gfhm88.htm#n1mj93glryngkgn1e2mam2uy2dt8) link in SAS Viya Platform Administration.

### Create SAS Viya SSO test user

In this section, you create a user called B.Simon in SAS Viya SSO. Work with [SAS Viya SSO support team](mailto:support@sas.com) to add the users in the SAS Viya SSO platform. Users must be created and activated before you use single sign-on.

SAS Viya SSO also supports automatic user provisioning, you can find more details [here](./sas-viya-sso-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to SAS Viya SSO Sign-on URL where you can initiate the login flow.  
 
* Go to SAS Viya SSO Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the SAS Viya SSO for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the SAS Viya SSO tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the SAS Viya SSO for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SAS Viya SSO you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
