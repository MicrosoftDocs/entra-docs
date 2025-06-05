---
title: Configure Kontiki for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Kontiki.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Kontiki so that I can control who has access to Kontiki, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Kontiki for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Kontiki with Microsoft Entra ID. When you integrate Kontiki with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Kontiki.
* Enable your users to be automatically signed-in to Kontiki with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Kontiki subscription with single sign-on enabled.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment and integrate Kontiki with Microsoft Entra ID.

Kontiki supports the following features:

* **SP-initiated single sign-on**.
* **Just-in-time user provisioning**.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Kontiki in the Azure portal

To configure the integration of Kontiki into Microsoft Entra ID, you need to add Kontiki from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Kontiki** in the search box.
1. Select **Kontiki** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-kontiki'></a>

## Configure and test Microsoft Entra SSO for Kontiki

Configure and test Microsoft Entra SSO with Kontiki using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Kontiki.

To configure and test Microsoft Entra SSO with Kontiki, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Kontiki SSO](#configure-kontiki-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Kontiki test user](#create-kontiki-test-user)** - to have a counterpart of B.Simon in Kontiki that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Kontiki** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. In the **Basic SAML Configuration** section, perform the following step:

	In the **Sign on URL** text box, type a URL using the following pattern: 
	`https://<companyname>.mc.eval.kontiki.com`

   	> [!NOTE]
	> Contact the [Kontiki Client support team](https://kollective.com/support/) to get the correct value to use. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **Set up Single Sign-On with SAML** pane, in the **SAML Signing Certificate** section, select **Download** next to **Federation Metadata XML**. Select a download option based on your requirements. Save the certificate on your computer.

	![The Federation Metadata XML certificate download option](common/metadataxml.png)

1. In the **Set up Kontiki** section, copy the following URLs based on your requirements:

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Kontiki SSO

To configure single sign-on on the Kontiki side, send the downloaded Federation Metadata XML file and the relevant URLs that you copied to the [Kontiki support team](https://kollective.com/support/). The Kontiki support team uses the information you send them to ensure that the SAML single sign-on connection is set properly on both sides.

### Create Kontiki test user

There's no action item for you to configure user provisioning in Kontiki. When an assigned user tries to sign in to Kontiki by using the My Apps portal, Kontiki checks whether the user exists. If no user account is found, Kontiki automatically creates the user account.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Kontiki Sign-on URL where you can initiate the login flow. 

* Go to Kontiki Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Kontiki tile in the My Apps, this option redirects to Kontiki Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Kontiki you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
