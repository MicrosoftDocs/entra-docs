---
title: Configure Wingspan eTMF for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Wingspan eTMF.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Wingspan eTMF so that I can control who has access to Wingspan eTMF, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Wingspan eTMF for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Wingspan eTMF with Microsoft Entra ID. When you integrate Wingspan eTMF with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Wingspan eTMF.
* Enable your users to be automatically signed-in to Wingspan eTMF with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Wingspan eTMF single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Wingspan eTMF supports **SP** initiated SSO.

## Add Wingspan eTMF from the gallery

To configure the integration of Wingspan eTMF into Microsoft Entra ID, you need to add Wingspan eTMF from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Wingspan eTMF** in the search box.
1. Select **Wingspan eTMF** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-wingspan-etmf'></a>

## Configure and test Microsoft Entra SSO for Wingspan eTMF

Configure and test Microsoft Entra SSO with Wingspan eTMF using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Wingspan eTMF.

To configure and test Microsoft Entra SSO with Wingspan eTMF, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Wingspan eTMF SSO](#configure-wingspan-etmf-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Wingspan eTMF test user](#create-wingspan-etmf-test-user)** - to have a counterpart of B.Simon in Wingspan eTMF that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Wingspan eTMF** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot for Edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<customer name>.<instance name>.mywingspan.com/saml`

    b. In the **Identifier** box, type a URL using the following pattern:
    `http://saml.<instance name>.wingspan.com/shibboleth`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<customer name>.<instance name>.mywingspan.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign-On URL, Identifier and Reply URL. Contact Wingspan eTMF Client support team to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![Screenshot for The Certificate download link.](common/metadataxml.png)

6. On the **Set up Wingspan eTMF** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot for Copy configuration URLs.](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Wingspan eTMF SSO

To configure single sign-on on **Wingspan eTMF** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to Wingspan eTMF support team. They set this setting to have the SAML SSO connection set properly on both sides.

### Create Wingspan eTMF test user

In this section, you create a user called Britta Simon in Wingspan eTMF. Work with Wingspan eTMF support team to add the users in the Wingspan eTMF platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Wingspan eTMF Sign-on URL where you can initiate the login flow. 

* Go to Wingspan eTMF Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Wingspan eTMF tile in the My Apps, this option redirects to Wingspan eTMF Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Wingspan eTMF you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
