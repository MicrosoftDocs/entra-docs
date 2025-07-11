---
title: Configure Tangoe Command Premium Mobile for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Tangoe Command Premium Mobile.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Tangoe Command Premium Mobile so that I can control who has access to Tangoe Command Premium Mobile, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Tangoe Command Premium Mobile for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Tangoe Command Premium Mobile with Microsoft Entra ID. When you integrate Tangoe Command Premium Mobile with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Tangoe Command Premium Mobile.
* Enable your users to be automatically signed-in to Tangoe Command Premium Mobile with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Tangoe Command Premium Mobile single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Tangoe Command Premium Mobile supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Tangoe Command Premium Mobile from the gallery

To configure the integration of Tangoe Command Premium Mobile into Microsoft Entra ID, you need to add Tangoe Command Premium Mobile from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Tangoe Command Premium Mobile** in the search box.
1. Select **Tangoe Command Premium Mobile** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-tangoe-command-premium-mobile'></a>

## Configure and test Microsoft Entra SSO for Tangoe Command Premium Mobile

Configure and test Microsoft Entra SSO with Tangoe Command Premium Mobile using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Tangoe Command Premium Mobile.

To configure and test Microsoft Entra SSO with Tangoe Command Premium Mobile, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Tangoe Command Premium Mobile SSO](#configure-tangoe-command-premium-mobile-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Tangoe Command Premium Mobile test user](#create-tangoe-command-premium-mobile-test-user)** - to have a counterpart of B.Simon in Tangoe Command Premium Mobile that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Tangoe Command Premium Mobile** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://sso.tangoe.com/sp/startSSO.ping?PartnerIdpId=<TENANT_ISSUER>&TARGET=<TARGET_PAGE_URL>`

    b. In the **Reply URL** text box, type the URL:
    `https://sso.tangoe.com/sp/ACS.saml2`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL. Contact [Tangoe Command Premium Mobile Client support team](https://www.tangoe.com/contact-us/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Tangoe Command Premium Mobile** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Tangoe Command Premium Mobile SSO

To configure single sign-on on **Tangoe Command Premium Mobile** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Tangoe Command Premium Mobile support team](https://www.tangoe.com/contact-us/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Tangoe Command Premium Mobile test user

In this section, you create a user called Britta Simon in Tangoe Command Premium Mobile. Work with [Tangoe Command Premium Mobile support team](https://www.tangoe.com/contact-us/) to add the users in the Tangoe Command Premium Mobile platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Tangoe Command Premium Mobile Sign-on URL where you can initiate the login flow. 

* Go to Tangoe Command Premium Mobile Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Tangoe Command Premium Mobile tile in the My Apps, this option redirects to Tangoe Command Premium Mobile Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Tangoe Command Premium Mobile you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
