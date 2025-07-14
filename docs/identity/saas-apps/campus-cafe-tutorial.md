---
title: Configure Campus Café for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Campus Café.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Campus CafÃ© so that I can control who has access to Campus CafÃ©, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Campus Café for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Campus Café with Microsoft Entra ID. When you integrate Campus Café with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Campus Café.
* Enable your users to be automatically signed-in to Campus Café with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Campus Café single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Campus Café supports **SP** initiated SSO.

## Add Campus Café from the gallery

To configure the integration of Campus Café into Microsoft Entra ID, you need to add Campus Café from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Campus Café** in the search box.
1. Select **Campus Café** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-campus-caf'></a>

## Configure and test Microsoft Entra SSO for Campus Café

Configure and test Microsoft Entra SSO with Campus Café using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Campus Café.

To configure and test Microsoft Entra SSO with Campus Café, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Campus Café SSO](#configure-campus-cafe-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Campus Café test user](#create-campus-cafe-test-user)** - to have a counterpart of B.Simon in Campus Café that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Campus Café** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

	a. Select **Upload metadata file**.

    ![Upload metadata file](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![choose metadata file](common/browse-upload-metadata.png)

	c. After the metadata file is successfully uploaded, the **Identifier** value gets auto populated in **Basic SAML Configuration** section.

	In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://{SSO}-web.scansoftware.com/cafeweb/loginsso`

	> [!Note]
	> If the **Identifier** value doesn't get auto populated, then please fill in the value manually according to your requirement. The Sign-on URL value isn't real. Update this value with the actual Sign-on URL. Contact [Campus Café Client support team](mailto:support@campuscafesoftware.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Campus Café** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Campus Cafe SSO

To configure single sign-on on **Campus Café** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Campus Café support team](mailto:support@campuscafesoftware.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Campus Cafe test user

In this section, you create a user called B.Simon in Campus Café. Work with [Campus Café support team](mailto:support@campuscafesoftware.com) to add the users in the Campus Café platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Campus Cafe Sign-on URL where you can initiate the login flow. 

* Go to Campus Cafe Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Campus Cafe tile in the My Apps, this option redirects to Campus Cafe Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Campus Cafe you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
