---
title: Configure IWT Procurement Suite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and IWT Procurement Suite.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IWT Procurement Suite so that I can control who has access to IWT Procurement Suite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure IWT Procurement Suite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate IWT Procurement Suite with Microsoft Entra ID. When you integrate IWT Procurement Suite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to IWT Procurement Suite.
* Enable your users to be automatically signed-in to IWT Procurement Suite with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* IWT Procurement Suite single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* IWT Procurement Suite supports **IDP** initiated SSO.

## Add IWT Procurement Suite from the gallery

To configure the integration of IWT Procurement Suite into Microsoft Entra ID, you need to add IWT Procurement Suite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **IWT Procurement Suite** in the search box.
1. Select **IWT Procurement Suite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-iwt-procurement-suite'></a>

## Configure and test Microsoft Entra SSO for IWT Procurement Suite

Configure and test Microsoft Entra SSO with IWT Procurement Suite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in IWT Procurement Suite.

To configure and test Microsoft Entra SSO with IWT Procurement Suite, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure IWT Procurement Suite SSO](#configure-iwt-procurement-suite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create IWT Procurement Suite test user](#create-iwt-procurement-suite-test-user)** - to have a counterpart of B.Simon in IWT Procurement Suite that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **IWT Procurement Suite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://[customersubdomain].ionwave.net/sso/[customerid]`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://[customersubdomain].ionwave.net/sso/[customerid]`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [IWT Procurement Suite Client support team](mailto:support@ionwave.net) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. IWT Procurement Suite application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **Emailaddress** is mapped with **user.mail**. IWT Procurement Suite application expects **Emailaddress** to be mapped with **user.userprincipalname**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/default-attributes.png)

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure IWT Procurement Suite SSO

To configure single sign-on on **IWT Procurement Suite** side, you need to send the **App Federation Metadata Url** to [IWT Procurement Suite support team](mailto:support@ionwave.net). They set this setting to have the SAML SSO connection set properly on both sides.

### Create IWT Procurement Suite test user

In this section, you create a user called Britta Simon in IWT Procurement Suite. Work with [IWT Procurement Suite support team](mailto:support@ionwave.net) to add the users in the IWT Procurement Suite platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the IWT Procurement Suite for which you set up the SSO.

* You can use Microsoft My Apps. When you select the IWT Procurement Suite tile in the My Apps, you should be automatically signed in to the IWT Procurement Suite for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure IWT Procurement Suite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
