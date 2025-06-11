---
title: Configure Getabstract for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Getabstract.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Getabstract so that I can control who has access to Getabstract, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Getabstract for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Getabstract with Microsoft Entra ID. When you integrate Getabstract with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Getabstract.
* Enable your users to be automatically signed-in to Getabstract with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Getabstract single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Getabstract supports **SP and IDP** initiated SSO.

* Getabstract supports **Just In Time** user provisioning.

* Getabstract supports [Automated user provisioning](getabstract-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Getabstract from the gallery

To configure the integration of Getabstract into Microsoft Entra ID, you need to add Getabstract from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Getabstract** in the search box.
1. Select **Getabstract** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-getabstract'></a>

## Configure and test Microsoft Entra SSO for Getabstract

Configure and test Microsoft Entra SSO with Getabstract using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Getabstract.

To configure and test Microsoft Entra SSO with Getabstract, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
	1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
	1. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure Getabstract SSO](#configure-getabstract-sso)** - to configure the Single Sign-On settings on application side.
	1. **[Create Getabstract test user](#create-getabstract-test-user)** - to have a counterpart of Britta Simon in Getabstract that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Getabstract** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type the URL:

    For Stage/pre_production: `https://int.getabstract.com`

	For Production: `https://www.getabstract.com`

	b. In the **Reply URL** textbox, type the URL:
	
	For Stage/pre_production: `https://int.getabstract.com/ACS.do`
	
	For Production: `https://www.getabstract.com/ACS.do`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:
    
    In the **Sign-on URL** textbox, type a URL using the following pattern:

    For Stage/pre_production: `https://int.getabstract.com/portal/<org_username>`
	
	For Production: `https://www.getabstract.com/portal/<org_username>`

	> [!NOTE] 
	> This value isn't real. Update this value with the actual Sign-On URL. Contact [Getabstract Client support team](https://www.getabstract.com/en/contact) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set-up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Getabstract** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Getabstract SSO

To configure single sign-on on **Getabstract** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Getabstract support team](https://www.getabstract.com/en/contact). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Getabstract test user

In this section, a user called Britta Simon is created in Getabstract. Getabstract supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Getabstract, a new one is created after authentication.

>[!Note]
>Getabstract also supports automatic user provisioning, you can find more details [here](./getabstract-provisioning-tutorial.md) on how to configure automatic user provisioning.

### Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

#### SP initiated:

* Select **Test this application**, this option redirects to Getabstract Sign on URL where you can initiate the login flow.

* Go to Getabstract Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Getabstract for which you set up the SSO

You can also use Microsoft My Apps to test the application in any mode. When you select the Getabstract tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Getabstract for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).


## Related content

Once you configure Getabstract you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
