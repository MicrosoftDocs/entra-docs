---
title: Configure ForeSee CX Suite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ForeSee CX Suite.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ForeSee CX Suite so that I can control who has access to ForeSee CX Suite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure ForeSee CX Suite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ForeSee CX Suite with Microsoft Entra ID. When you integrate ForeSee CX Suite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ForeSee CX Suite.
* Enable your users to be automatically signed-in to ForeSee CX Suite with their Microsoft Entra accounts.
* Manage your accounts in one central location.


## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ForeSee CX Suite single sign-on enabled subscription

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* ForeSee CX Suite supports **SP** initiated SSO.

* ForeSee CX Suite supports **Just In Time** user provisioning.

## Add ForeSee CX Suite from the gallery

To configure the integration of ForeSee CX Suite into Microsoft Entra ID, you need to add ForeSee CX Suite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ForeSee CX Suite** in the search box.
1. Select **ForeSee CX Suite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-foresee-cx-suite'></a>

## Configure and test Microsoft Entra SSO for ForeSee CX Suite

Configure and test Microsoft Entra SSO with ForeSee CX Suite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ForeSee CX Suite.

To configure and test Microsoft Entra SSO with ForeSee CX Suite, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    2. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure ForeSee CX Suite SSO](#configure-foresee-cx-suite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ForeSee CX Suite test user](#create-foresee-cx-suite-test-user)** - to have a counterpart of B.Simon in ForeSee CX Suite that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ForeSee CX Suite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot showing the edit Basic SAML Configuration screen.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

	a. Select **Upload metadata file**.

    ![Upload metadata file](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![choose metadata file](common/browse-upload-metadata.png)

	c. After the metadata file is successfully uploaded, the **Identifier** value gets auto populated in Basic SAML Configuration section.

	d. In the **Sign-on URL** text box, type a URL:
    `https://cxsuite.foresee.com/`

	e. In the **Identifier** textbox, type a URL using the following pattern: https:\//www.okta.com/saml2/service-provider/\<UniqueID>

	> [!Note]
	> If the **Identifier** value don't get auto populated, then please fill in the value manually according to above pattern. The Identifier value isn't real. Update this value with the actual Identifier. Contact [ForeSee CX Suite Client support team](mailto:support@foresee.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up ForeSee CX Suite** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ForeSee CX Suite SSO

To configure single sign-on on **ForeSee CX Suite** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [ForeSee CX Suite support team](mailto:support@foresee.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ForeSee CX Suite test user

In this section, you create a user called Britta Simon in ForeSee CX Suite. Work with [ForeSee CX Suite support team](mailto:support@foresee.com) to add the users or the domain that must be added to an allowlist for the ForeSee CX Suite platform. If the domain is added by the team, users get automatically provisioned to the ForeSee CX Suite platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ForeSee CX Suite Sign-on URL where you can initiate the login flow. 

* Go to ForeSee CX Suite Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ForeSee CX Suite tile in the My Apps, this option redirects to ForeSee CX Suite Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ForeSee CX Suite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
