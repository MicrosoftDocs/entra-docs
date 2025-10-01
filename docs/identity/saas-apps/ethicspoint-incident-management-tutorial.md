---
title: Configure EthicsPoint Incident Management (EPIM) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and EthicsPoint Incident Management (EPIM).

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and EthicsPoint Incident Management (EPIM) so that I can control who has access to EthicsPoint Incident Management (EPIM), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure EthicsPoint Incident Management (EPIM) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate EthicsPoint Incident Management (EPIM) with Microsoft Entra ID. When you integrate EthicsPoint Incident Management (EPIM) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to EthicsPoint Incident Management (EPIM).
* Enable your users to be automatically signed-in to EthicsPoint Incident Management (EPIM) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* EthicsPoint Incident Management (EPIM) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* EthicsPoint Incident Management (EPIM) supports **SP** initiated SSO.

## Add EthicsPoint Incident Management (EPIM) from the gallery

To configure the integration of EthicsPoint Incident Management (EPIM) into Microsoft Entra ID, you need to add EthicsPoint Incident Management (EPIM) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **EthicsPoint Incident Management (EPIM)** in the search box.
1. Select **EthicsPoint Incident Management (EPIM)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-ethicspoint-incident-management-epim'></a>

## Configure and test Microsoft Entra SSO for EthicsPoint Incident Management (EPIM)

Configure and test Microsoft Entra SSO with EthicsPoint Incident Management (EPIM) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in EthicsPoint Incident Management (EPIM).

To configure and test Microsoft Entra SSO with EthicsPoint Incident Management (EPIM), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure EthicsPoint Incident Management (EPIM) SSO](#configure-ethicspoint-incident-management-epim-sso)** - to configure the single sign-on settings on application side.
    1. **[Create EthicsPoint Incident Management (EPIM) test user](#create-ethicspoint-incident-management-epim-test-user)** - to have a counterpart of B.Simon in EthicsPoint Incident Management (EPIM) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **EthicsPoint Incident Management (EPIM)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** box, type a URL using the following pattern:
    `https://<COMPANY_NAME>.navexglobal.com/adfs/services/trust`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SERVER_NAME>.navexglobal.com/adfs/ls/`

     c. In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | Sign-on URL|
    |---|
    |`https://<COMPANY_NAME>.navexglobal.com`|
    |`https://<COMPANY_NAME>.ethicspointvp.com`|
    |
  
	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier,Reply URL and Sign-On URL. Contact [EthicsPoint Incident Management (EPIM) Client support team](https://www.navex.com/en-us/products/navex-ethics-compliance/ethicspoint-hotline-incident-management/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up EthicsPoint Incident Management (EPIM)** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure EthicsPoint Incident Management (EPIM) SSO

To configure single sign-on on **EthicsPoint Incident Management (EPIM)** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [EthicsPoint Incident Management (EPIM) support team](https://www.navex.com/en-us/products/navex-ethics-compliance/ethicspoint-hotline-incident-management/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create EthicsPoint Incident Management (EPIM) test user

In this section, you create a user called Britta Simon in EthicsPoint Incident Management (EPIM). Work with [EthicsPoint Incident Management (EPIM) support team](https://www.navex.com/en-us/products/navex-ethics-compliance/ethicspoint-hotline-incident-management/) to add the users in the EthicsPoint Incident Management (EPIM) platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to EthicsPoint Incident Management (EPIM) Sign-on URL where you can initiate the login flow. 

* Go to EthicsPoint Incident Management (EPIM) Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the EthicsPoint Incident Management (EPIM) tile in the My Apps, this option redirects to EthicsPoint Incident Management (EPIM) Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure EthicsPoint Incident Management (EPIM) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
