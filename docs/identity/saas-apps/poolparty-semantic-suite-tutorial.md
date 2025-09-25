---
title: Configure PoolParty Semantic Suite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and PoolParty Semantic Suite.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and PoolParty Semantic Suite so that I can control who has access to PoolParty Semantic Suite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure PoolParty Semantic Suite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate PoolParty Semantic Suite with Microsoft Entra ID. When you integrate PoolParty Semantic Suite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to PoolParty Semantic Suite.
* Enable your users to be automatically signed-in to PoolParty Semantic Suite with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* PoolParty Semantic Suite single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* PoolParty Semantic Suite supports **SP** initiated SSO

## Adding PoolParty Semantic Suite from the gallery

To configure the integration of PoolParty Semantic Suite into Microsoft Entra ID, you need to add PoolParty Semantic Suite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **PoolParty Semantic Suite** in the search box.
1. Select **PoolParty Semantic Suite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-poolparty-semantic-suite'></a>

## Configure and test Microsoft Entra SSO for PoolParty Semantic Suite

Configure and test Microsoft Entra SSO with PoolParty Semantic Suite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in PoolParty Semantic Suite.

To configure and test Microsoft Entra SSO with PoolParty Semantic Suite, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure PoolParty Semantic Suite SSO](#configure-poolparty-semantic-suite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create PoolParty Semantic Suite test user](#create-poolparty-semantic-suite-test-user)** - to have a counterpart of B.Simon in PoolParty Semantic Suite that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **PoolParty Semantic Suite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.poolparty.biz/PoolParty/`

    b. In the **Identifier** box, type a URL using the following pattern:
    `https://<CustomerName>.poolparty.biz/<ID>`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CustomerName>.poolparty.biz/<ID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign-On URL, Identifier and Reply URL. Contact [PoolParty Semantic Suite Client support team](mailto:support@poolparty.biz) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up PoolParty Semantic Suite** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure PoolParty Semantic Suite SSO

To configure single sign-on on **PoolParty Semantic Suite** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [PoolParty Semantic Suite support team](mailto:support@poolparty.biz). They set this setting to have the SAML SSO connection set properly on both sides.

### Create PoolParty Semantic Suite test user

In this section, you create a user called Britta Simon in PoolParty Semantic Suite. Work with [PoolParty Semantic Suite support team](mailto:support@poolparty.biz) to add the users in the PoolParty Semantic Suite platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to PoolParty Semantic Suite Sign-on URL where you can initiate the login flow. 

* Go to PoolParty Semantic Suite Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the PoolParty Semantic Suite tile in the My Apps, this option redirects to PoolParty Semantic Suite Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure PoolParty Semantic Suite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
