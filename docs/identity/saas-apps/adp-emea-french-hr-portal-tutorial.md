---
title: Configure ADP EMEA French HR Portal mon.adp.com for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ADP EMEA French HR Portal mon.adp.com.
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ADP EMEA French HR Portal mon.adp.com so that I can control who has access to ADP EMEA French HR Portal mon.adp.com, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ADP EMEA French HR Portal mon.adp.com for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ADP EMEA French HR Portal mon.adp.com with Microsoft Entra ID. When you integrate ADP EMEA French HR Portal mon.adp.com with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ADP EMEA French HR Portal mon.adp.com.
* Enable your users to be automatically signed-in to ADP EMEA French HR Portal mon.adp.com with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ADP EMEA French HR Portal mon.adp.com single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ADP EMEA French HR Portal mon.adp.com supports **IDP** initiated SSO.

## Add ADP EMEA French HR Portal mon.adp.com from the gallery

To configure the integration of ADP EMEA French HR Portal mon.adp.com into Microsoft Entra ID, you need to add ADP EMEA French HR Portal mon.adp.com from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ADP EMEA French HR Portal mon.adp.com** in the search box.
1. Select **ADP EMEA French HR Portal mon.adp.com** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-adp-emea-french-hr-portal-monadpcom'></a>

## Configure and test Microsoft Entra SSO for ADP EMEA French HR Portal mon.adp.com

Configure and test Microsoft Entra SSO with ADP EMEA French HR Portal mon.adp.com using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ADP EMEA French HR Portal mon.adp.com.

To configure and test Microsoft Entra SSO with ADP EMEA French HR Portal mon.adp.com, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ADP EMEA French HR Portal mon.adp.com SSO](#configure-adp-emea-french-hr-portal-monadpcom-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ADP EMEA French HR Portal mon.adp.com test user](#create-adp-emea-french-hr-portal-monadpcom-test-user)** - to have a counterpart of B.Simon in ADP EMEA French HR Portal mon.adp.com that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ADP EMEA French HR Portal mon.adp.com** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. ADP EMEA French HR Portal mon.adp.com application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, ADP EMEA French HR Portal mon.adp.com application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| -------- | --------- |
	| CompanyID | <given_by_adp> |
    | ApplicationID | uxfr|

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (PEM)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificate-base64-download.png)    
    
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ADP EMEA French HR Portal mon.adp.com SSO

To configure single sign-on on **ADP EMEA French HR Portal mon.adp.com** side, you need to send the downloaded **Certificate (PEM)** and appropriate copied URLs from the application configuration to [ADP EMEA French HR Portal mon.adp.com support team](mailto:asp.projects@europe.adp.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ADP EMEA French HR Portal mon.adp.com test user

In this section, you create a user called Britta Simon in ADP EMEA French HR Portal mon.adp.com. Work with [ADP EMEA French HR Portal mon.adp.com support team](mailto:asp.projects@europe.adp.com) to add the users in the ADP EMEA French HR Portal mon.adp.com platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the ADP EMEA French HR Portal mon.adp.com for which you set up the SSO.

* You can use Microsoft My Apps. When you select the ADP EMEA French HR Portal mon.adp.com tile in the My Apps, you should be automatically signed in to the ADP EMEA French HR Portal mon.adp.com for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ADP EMEA French HR Portal mon.adp.com you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
