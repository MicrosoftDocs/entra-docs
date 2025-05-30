---
title: Configure MailGates for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and MailGates.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and MailGates so that I can control who has access to MailGates, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure MailGates for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate MailGates with Microsoft Entra ID. When you integrate MailGates with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to MailGates.
* Enable your users to be automatically signed-in to MailGates with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* MailGates single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* MailGates supports **SP** initiated SSO.

## Add MailGates from the gallery

To configure the integration of MailGates into Microsoft Entra ID, you need to add MailGates from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **MailGates** in the search box.
1. Select **MailGates** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-mailgates'></a>

## Configure and test Microsoft Entra SSO for MailGates

Configure and test Microsoft Entra SSO with MailGates using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in MailGates.

To configure and test Microsoft Entra SSO with MailGates, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure MailGates SSO](#configure-mailgates-sso)** - to configure the single sign-on settings on application side.
    1. **[Create MailGates test user](#create-mailgates-test-user)** - to have a counterpart of B.Simon in MailGates that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **MailGates** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot for Edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/mg-cgi/mg_login?saml_domain=<DOMAIN>`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/saml/module.php/saml/sp/metadata.php/mg_generic_sp`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cybercloud.jp/mg-cgi/mg_login/saml2-acs/mg_generic_sp`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL.Contact [MailGates Client support team](mailto:tech@cybersolutions.co.jp) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot for The Certificate download link.](common/metadataxml.png)

1. On the **Set up MailGates** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot for Copy configuration URLs.](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure MailGates SSO

To configure single sign-on on **MailGates** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [MailGates support team](mailto:tech@cybersolutions.co.jp). They set this setting to have the SAML SSO connection set properly on both sides.

### Create MailGates test user

In this section, you create a user called Britta Simon in MailGates. Work with [MailGates support team](mailto:tech@cybersolutions.co.jp) to add the users in the MailGates platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to MailGates Sign-on URL where you can initiate the login flow. 

* Go to MailGates Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the MailGates tile in the My Apps, this option redirects to MailGates Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure MailGates you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
