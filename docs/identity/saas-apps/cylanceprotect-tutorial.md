---
title: Configure CylancePROTECT for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CylancePROTECT.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and CylancePROTECT so that I can control who has access to CylancePROTECT, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure CylancePROTECT for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate CylancePROTECT with Microsoft Entra ID. When you integrate CylancePROTECT with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CylancePROTECT.
* Enable your users to be automatically signed-in to CylancePROTECT with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CylancePROTECT single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CylancePROTECT supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add CylancePROTECT from the gallery

To configure the integration of CylancePROTECT into Microsoft Entra ID, you need to add CylancePROTECT from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CylancePROTECT** in the search box.
1. Select **CylancePROTECT** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cylanceprotect'></a>

## Configure and test Microsoft Entra SSO for CylancePROTECT

Configure and test Microsoft Entra SSO with CylancePROTECT using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CylancePROTECT.

To configure and test Microsoft Entra SSO with CylancePROTECT, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CylancePROTECT SSO](#configure-cylanceprotect-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CylancePROTECT test user](#create-cylanceprotect-test-user)** - to have a counterpart of B.Simon in CylancePROTECT that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CylancePROTECT** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, enter the values for the following fields:

    a. In the **Identifier** textbox, type one of the following URLs:
	
	| Region | URL Value |
	|----------|---------|
	| Asia-Pacific Northeast (APNE1)| `https://login-apne1.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| Asia-Pacific Southeast (AU) | `https://login-au.cylance.com/EnterpriseLogin/ConsumeSaml` |
	| Europe Central (EUC1)|`https://login-euc1.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| North America|`https://login.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| South America (SAE1)|`https://login-sae1.cylance.com/EnterpriseLogin/ConsumeSaml`|

	b. In the **Reply URL** textbox, type one of the following URLs:
	
	| Region | URL Value |
	|----------|---------|
	| Asia-Pacific Northeast (APNE1)|`https://login-apne1.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| Asia-Pacific Southeast (AU)|`https://login-au.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| Europe Central (EUC1)|`https://login-euc1.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| North America|`https://login.cylance.com/EnterpriseLogin/ConsumeSaml`|
	| South America (SAE1)|`https://login-sae1.cylance.com/EnterpriseLogin/ConsumeSaml`|

1. CylancePROTECT application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. CylancePROTECT application expects **nameidentifier** to be mapped with **user.mail** and remove all other remaining claims, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up CylancePROTECT** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

> [!NOTE]
> Open the downloaded Base64 encoded certificate in a text editor and copy ONLY the text between **START** and **END** tags to paste in Cylance Admin portal.

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CylancePROTECT SSO

To configure single sign-on on **CylancePROTECT** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [CylancePROTECT support team](https://www.cylance.com/en-us/resources/support/support-overview.html). They set this setting to have the SAML SSO connection set properly on both sides. For more information, use Cylance documentation: [https://support.cylance.com/s/](https://support.cylance.com/s/).

### Create CylancePROTECT test user

In this section, you create a user called Britta Simon in CylancePROTECT. Work with console administrator to add the users in the CylancePROTECT platform. The Microsoft Entra account holder will receive an email and follow a link to confirm their account before it becomes active.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the CylancePROTECT for which you set up the SSO.

* You can use Microsoft My Apps. When you select the CylancePROTECT tile in the My Apps, you should be automatically signed in to the CylancePROTECT for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure CylancePROTECT you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
