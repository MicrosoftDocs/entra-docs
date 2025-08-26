---
title: Configure WalkMe SAML2.0 for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and WalkMe SAML2.0.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and WalkMe SAML2.0 so that I can control who has access to WalkMe SAML2.0, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure WalkMe SAML2.0 for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate WalkMe SAML2.0 with Microsoft Entra ID. When you integrate WalkMe SAML2.0 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to WalkMe SAML2.0.
* Enable your users to be automatically signed-in to WalkMe SAML2.0 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* WalkMe SAML2.0 single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* WalkMe SAML2.0 supports **IDP** initiated SSO.

* WalkMe SAML2.0 supports **Just In Time** user provisioning.

## Add WalkMe SAML2.0 from the gallery

To configure the integration of WalkMe SAML2.0 into Microsoft Entra ID, you need to add WalkMe SAML2.0 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **WalkMe SAML2.0** in the search box.
1. Select **WalkMe SAML2.0** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-walkme-saml20'></a>

## Configure and test Microsoft Entra SSO for WalkMe SAML2.0

Configure and test Microsoft Entra SSO with WalkMe SAML2.0 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in WalkMe SAML2.0.

To configure and test Microsoft Entra SSO with WalkMe SAML2.0, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure WalkMe SAML2.0 SSO](#configure-walkme-saml20-sso)** - to configure the single sign-on settings on application side.
    1. **[Create WalkMe SAML2.0 test user](#create-walkme-saml20-test-user)** - to have a counterpart of B.Simon in WalkMe SAML2.0 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **WalkMe SAML2.0** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.walkme.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.walkme.com/ic/idp/p/saml/callback`

    c. In the **Relay State** textbox, type the value:
    `{ "loginType": "azureSAMLApp"}`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [WalkMe SAML2.0 Client support team](mailto:support@walkme.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up WalkMe SAML2.0** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure WalkMe SAML2.0 SSO

To configure single sign-on on **WalkMe SAML2.0** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [WalkMe SAML2.0 support team](mailto:support@walkme.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create WalkMe SAML2.0 test user

In this section, a user called Britta Simon is created in WalkMe SAML2.0. WalkMe SAML2.0 supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in WalkMe SAML2.0, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the WalkMe SAML2.0 for which you set up the SSO.

* You can use Microsoft My Apps. When you select the WalkMe SAML2.0 tile in the My Apps, you should be automatically signed in to the WalkMe SAML2.0 for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure WalkMe SAML2.0 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
