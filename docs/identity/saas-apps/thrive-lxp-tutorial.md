---
title: Configure Thrive LXP for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Thrive LXP.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Thrive LXP so that I can control who has access to Thrive LXP, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Thrive LXP for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Thrive LXP with Microsoft Entra ID. When you integrate Thrive LXP with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Thrive LXP.
* Enable your users to be automatically signed-in to Thrive LXP with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Thrive LXP single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Thrive LXP supports **SP** initiated SSO.
* Thrive LXP supports [Automated user provisioning](thrive-lxp-provisioning-tutorial.md).

## Adding Thrive LXP from the gallery

To configure the integration of Thrive LXP into Microsoft Entra ID, you need to add Thrive LXP from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Thrive LXP** in the search box.
1. Select **Thrive LXP** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-thrive-lxp'></a>

## Configure and test Microsoft Entra SSO for Thrive LXP

Configure and test Microsoft Entra SSO with Thrive LXP using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Thrive LXP.

To configure and test Microsoft Entra SSO with Thrive LXP, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Thrive LXP SSO](#configure-thrive-lxp-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Thrive LXP test user](#create-thrive-lxp-test-user)** - to have a counterpart of B.Simon in Thrive LXP that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Thrive LXP** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `urn:amazon:cognito:sp:<THRIVE_LXP_IDENTIFIER>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>-lxp.auth.eu-west-2.amazoncognito.com/saml2/idpresponse`

	c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.learn.link`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Thrive LXP Client support team](mailto:support@thrivelearning.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Thrive LXP** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Thrive LXP SSO

To configure single sign-on on **Thrive LXP** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Thrive LXP support team](mailto:support@thrivelearning.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Thrive LXP test user

In this section, you create a user called Britta Simon in Thrive LXP. Work with [Thrive LXP support team](mailto:support@thrivelearning.com) to add the users in the Thrive LXP platform. Users must be created and activated before you use single sign-on.

Thrive LXP also supports automatic user provisioning, you can find more details [here](./thrive-lxp-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Thrive LXP Sign-on URL where you can initiate the login flow. 

* Go to Thrive LXP Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Thrive LXP tile in the My Apps, this option redirects to Thrive LXP Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Thrive LXP you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
