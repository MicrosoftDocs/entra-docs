---
title: Configure Fastly Edge Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Fastly Edge Cloud.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Fastly Edge Cloud so that I can control who has access to Fastly Edge Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Fastly Edge Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Fastly Edge Cloud with Microsoft Entra ID. When you integrate Fastly Edge Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Fastly Edge Cloud.
* Enable your users to be automatically signed-in to Fastly Edge Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Fastly Edge Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Fastly Edge Cloud supports **IDP** initiated SSO.

## Add Fastly Edge Cloud from the gallery

To configure the integration of Fastly Edge Cloud into Microsoft Entra ID, you need to add Fastly Edge Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Fastly Edge Cloud** in the search box.
1. Select **Fastly Edge Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-fastly-edge-cloud'></a>

## Configure and test Microsoft Entra SSO for Fastly Edge Cloud

Configure and test Microsoft Entra SSO with Fastly Edge Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Fastly Edge Cloud.

To configure and test Microsoft Entra SSO with Fastly Edge Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Fastly Edge Cloud SSO](#configure-fastly-edge-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Fastly Edge Cloud test user](#create-fastly-edge-cloud-test-user)** - to have a counterpart of B.Simon in Fastly Edge Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Fastly Edge Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Identifier** text box, type a URL using the following pattern:
    `https://api.fastly.com/saml/<CUSTOM_IDENTIFIER>`

	> [!NOTE]
	> This value isn't real. Update the value with the actual Identifier. Contact [Fastly Edge Cloud Client support team](mailto:support@fastly.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Fastly Edge Cloud** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Fastly Edge Cloud SSO

To configure single sign-on on **Fastly Edge Cloud** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Fastly Edge Cloud support team](mailto:support@fastly.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Fastly Edge Cloud test user

In this section, you create a user called B.Simon in Fastly Edge Cloud. Work with [Fastly Edge Cloud support team](mailto:support@fastly.com) to add the users in the Fastly Edge Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Fastly Edge Cloud for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Fastly Edge Cloud tile in the My Apps, you should be automatically signed in to the Fastly Edge Cloud for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Fastly Edge Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
