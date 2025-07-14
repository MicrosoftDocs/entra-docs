---
title: Configure Skillport for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Skillport.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Skillport so that I can control who has access to Skillport, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Skillport for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Skillport with Microsoft Entra ID. When you integrate Skillport with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Skillport.
* Enable your users to be automatically signed-in to Skillport with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Skillport single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Skillport supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Skillport from the gallery

To configure the integration of Skillport into Microsoft Entra ID, you need to add Skillport from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Skillport** in the search box.
1. Select **Skillport** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-skillport'></a>

## Configure and test Microsoft Entra SSO for Skillport

Configure and test Microsoft Entra SSO with Skillport using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Skillport.

To configure and test Microsoft Entra SSO with Skillport, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Skillport SSO](#configure-skillport-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Skillport test user](#create-skillport-test-user)** - to have a counterpart of B.Simon in Skillport that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Skillport** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    1. In the **Sign-on URL** text box, type one of the following URLs:

        EU Datacenter: `https://adfs.skillport.eu`

        US Datacenter: `https://sso.skillport.com`

    1. In the **Identifier** box, type one of the following URLs:

        EU Datacenter: `http://adfs.skillport.eu/adfs/services/trust`

        US Datacenter: `https://sso.skillport.com`

    1. In the **Reply URL** text box, type one of the following URLs:

        EU Datacenter: `https://adfs.skillport.eu/adfs/ls/`

        US Datacenter: `https://sso.skillport.com/sp/ACS.saml2`

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Skillport** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Skillport SSO

To configure single sign-on on **Skillport** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Skillport support team](https://www.skillsoft.com/about/contact-us). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Skillport test user

In order to create Skillport test user, you need to contact [Skillport support team](https://www.skillsoft.com/about/contact-us) as they have multiple business scenarios according to the requirement of end user. They will configure it after discussion with the users.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Skillport Sign-on URL where you can initiate the login flow. 

* Go to Skillport Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Skillport tile in the My Apps, this option redirects to Skillport Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Skillport you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
