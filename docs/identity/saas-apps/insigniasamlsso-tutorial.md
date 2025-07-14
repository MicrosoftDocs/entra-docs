---
title: Configure Insignia SAML SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Insignia SAML SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Insignia SAML SSO so that I can control who has access to Insignia SAML SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Insignia SAML SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Insignia SAML SSO with Microsoft Entra ID. When you integrate Insignia SAML SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Insignia SAML SSO.
* Enable your users to be automatically signed-in to Insignia SAML SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.


## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Insignia SAML SSO single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Insignia SAML SSO supports **SP** initiated SSO.

## Add Insignia SAML SSO from the gallery

To configure the integration of Insignia SAML SSO into Microsoft Entra ID, you need to add Insignia SAML SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Insignia SAML SSO** in the search box.
1. Select **Insignia SAML SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-insignia-saml-sso'></a>

## Configure and test Microsoft Entra SSO for Insignia SAML SSO

Configure and test Microsoft Entra SSO with Insignia SAML SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Insignia SAML SSO.

To configure and test Microsoft Entra SSO with Insignia SAML SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    2. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure Insignia SAML SSO](#configure-insignia-saml-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Insignia SAML SSO test user](#create-insignia-saml-sso-test-user)** - to have a counterpart of B.Simon in Insignia SAML SSO that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Insignia SAML SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot showing the edit Basic SAML Configuration screen.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using one of the following patterns:
	
   | Sign on URL|
   |------------|
   | `https://<customername>.insigniails.com/ils` |
   | `https://<customername>.insigniails.com/` |
   | `https://<customername>.insigniailsusa.com/` |
   |
	
	b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<customername>.insigniailsusa.com/<uniqueid>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Insignia SAML SSO Client support team](https://www.insigniasoftware.com/Support) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Insignia SAML SSO** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Insignia SAML SSO

To configure single sign-on on **Insignia SAML SSO** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Insignia SAML SSO support team](https://www.insigniasoftware.com/Support). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Insignia SAML SSO test user

In this section, you create a user called Britta Simon in Insignia SAML SSO. Work with [Insignia SAML SSO support team](https://www.insigniasoftware.com/Support) to add the users in the Insignia SAML SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Insignia SAML SSO Sign-on URL where you can initiate the login flow. 

* Go to Insignia SAML SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Insignia SAML SSO tile in the My Apps, this option redirects to Insignia SAML SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Insignia SAML SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
