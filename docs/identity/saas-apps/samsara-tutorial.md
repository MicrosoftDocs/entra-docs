---
title: Configure Samsara for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Samsara.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Samsara so that I can control who has access to Samsara, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Samsara for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Samsara with Microsoft Entra ID. When you integrate Samsara with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Samsara.
* Enable your users to be automatically signed-in to Samsara with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Samsara single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Samsara supports **SP** and **IDP** initiated SSO.
* Samsara supports **Just In Time** user provisioning.

## Add Samsara from the gallery

To configure the integration of Samsara into Microsoft Entra ID, you need to add Samsara from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Samsara** in the search box.
1. Select **Samsara** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-samsara'></a>

## Configure and test Microsoft Entra SSO for Samsara

Configure and test Microsoft Entra SSO with Samsara using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Samsara.

To configure and test Microsoft Entra SSO with Samsara, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Samsara SSO](#configure-samsara-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Samsara test user](#create-samsara-test-user)** - to have a counterpart of B.Simon in Samsara that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Samsara** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set-up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign-on URL** text box, type a URL using one of the following patterns:
    `https://cloud.samsara.com/signin/<ORGID>` for US cloud customers
    `https://cloud.eu.samsara.com/signin/<ORGID>` for EU cloud customers

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `urn:auth0:samsara-dev:samlp-orgid-<ORGID>`

	c. In the **Reply URL** text box, type a URL using the following pattern:
	`https://samsara-dev.auth0.com/login/callback?connection=samlp-orgid-<ORGID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign-on URL, Reply URL, and Identifier. Contact the [Samsara Client support team](mailto:support@samsara.com) to get these values, or in Samsara, go to **Settings** > **Single-Sign-On** > **New SAML Connection** to obtain the \<ORGID\>. You also can refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set-up Samsara** section, copy the **login URL**

	![Copy configuration URLs](common/copy-configuration-urls.png)
	
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Samsara SSO

To configure single sign-on on **Samsara** side, you need to send the downloaded **Certificate (Base64)** and **Login URL** from Azure portal to [Samsara support team](mailto:support@samsara.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Samsara test user

In this section, a user called B.Simon is created in Samsara. Samsara supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Samsara, a new one is created after authentication with a default role of Standard Admin (No Dash Cam Access) for Organization. The user's access can then be increased or decreased as needed in Samsara.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Samsara Sign on URL where you can initiate the login flow.  

* Go to Samsara Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Samsara for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Samsara tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Samsara for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Samsara you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
