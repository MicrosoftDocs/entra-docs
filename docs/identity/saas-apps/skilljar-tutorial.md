---
title: Configure Skilljar for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Skilljar.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Skilljar so that I can control who has access to Skilljar, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Skilljar for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Skilljar with Microsoft Entra ID. When you integrate Skilljar with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Skilljar.
* Enable your users to be automatically signed-in to Skilljar with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Skilljar single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Skilljar supports **SP** initiated SSO.
* Skilljar supports **Just In Time** user provisioning.

## Add Skilljar from the gallery

To configure the integration of Skilljar into Microsoft Entra ID, you need to add Skilljar from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Skilljar** in the search box.
1. Select **Skilljar** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-skilljar'></a>

## Configure and test Microsoft Entra SSO for Skilljar

Configure and test Microsoft Entra SSO with Skilljar using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Skilljar.

To configure and test Microsoft Entra SSO with Skilljar, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Skilljar SSO](#configure-skilljar-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Skilljar test user](#create-skilljar-test-user)** - to have a counterpart of B.Simon in Skilljar that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Skilljar** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<companyname>.skilljar.com/`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<companyname>.skilljar.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Skilljar Client support team](https://support.skilljar.com/hc/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Skilljar** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Skilljar SSO

To configure single sign-on on **Skilljar** side, you need to send the downloaded **Federation Metadata XML**, and **Name Identifier Format Value - `urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress`** to [Skilljar support team](https://support.skilljar.com/hc/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Skilljar test user

In this section, a user called Britta Simon is created in Skilljar. Skilljar supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Skilljar, a new one is created after authentication.

> [!NOTE]
> If you need to create a user manually, you need to contact the [Skilljar support team](https://support.skilljar.com/hc/).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Skilljar Sign-on URL where you can initiate the login flow. 

* Go to Skilljar Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Skilljar tile in the My Apps, this option redirects to Skilljar Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Skilljar you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
