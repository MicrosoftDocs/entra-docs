---
title: Configure Achieve3000 for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Achieve3000.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Achieve3000 so that I can control who has access to Achieve3000, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Achieve3000 for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Achieve3000 with Microsoft Entra ID. When you integrate Achieve3000 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Achieve3000.
* Enable your users to be automatically signed-in to Achieve3000 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Achieve3000 single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Achieve3000 supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Achieve3000 from the gallery

To configure the integration of Achieve3000 into Microsoft Entra ID, you need to add Achieve3000 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Achieve3000** in the search box.
1. Select **Achieve3000** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-achieve3000'></a>

## Configure and test Microsoft Entra SSO for Achieve3000

Configure and test Microsoft Entra SSO with Achieve3000 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Achieve3000.

To configure and test Microsoft Entra SSO with Achieve3000, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Achieve3000 SSO](#configure-achieve3000-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Achieve3000 test user](#create-achieve3000-test-user)** - to have a counterpart of B.Simon in Achieve3000 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Achieve3000** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the value:
    `achieve3000-saml`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://saml.achieve3000.com/district/<District Identifier>`

	> [!NOTE]
	> The Sign-On URL value isn't  real. Update the value with the actual Sign-On URL. Contact [Achieve3000 Client support team](https://www.achieve3000.com/contact-us/) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. Achieve3000 application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes..

	![image](common/edit-attribute.png)

6. In addition to above, Achieve3000 application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement. 

	| Name |  Source Attribute|
	| ---------------| --------- |
	| studentID 	| user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Achieve3000** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Achieve3000 SSO

To configure single sign-on on **Achieve3000** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Achieve3000 support team](https://www.achieve3000.com/contact-us/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Achieve3000 test user

In this section, you create a user called B.Simon in Achieve3000. Work with [Achieve3000 support team](https://www.achieve3000.com/contact-us/) to add the users in the Achieve3000 platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Achieve3000 Sign-on URL where you can initiate the login flow. 

* Go to Achieve3000 Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Achieve3000 tile in the My Apps, this option redirects to Achieve3000 Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Achieve3000 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
