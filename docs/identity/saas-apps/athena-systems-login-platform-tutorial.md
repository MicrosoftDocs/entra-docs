---
title: Configure Athena Systems Login Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Athena Systems Login Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Athena Systems Login Platform so that I can control who has access to Athena Systems Login Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Athena Systems Login Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Athena Systems Login Platform with Microsoft Entra ID. When you integrate Athena Systems Login Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Athena Systems Login Platform.
* Enable your users to be automatically signed-in to Athena Systems Login Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Athena Systems Login Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Athena Systems Login Platform supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Athena Systems Login Platform from the gallery

To configure the integration of Athena Systems Login Platform into Microsoft Entra ID, you need to add Athena Systems Login Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Athena Systems Login Platform** in the search box.
1. Select **Athena Systems Login Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-athena-systems-login-platform'></a>

## Configure and test Microsoft Entra SSO for Athena Systems Login Platform

Configure and test Microsoft Entra SSO with Athena Systems Login Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Athena Systems Login Platform.

To configure and test Microsoft Entra SSO with Athena Systems Login Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Athena Systems Login Platform SSO](#configure-athena-systems-login-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Athena Systems Login Platform test user](#create-athena-systems-login-platform-test-user)** - to have a counterpart of B.Simon in Athena Systems Login Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Athena Systems Login Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **SP** initiated mode then perform the following steps:

    a. In the **Identifier** text box, type the value:
    `athenasystems`

    b. In the **Reply URL** text box, type the URL:
    `https://login.athenasystems.com/saml/module.php/saml/sp/saml2-acs.php/default-sp`

    In the **Sign-on URL** text box, type the URL:
    `https://login.athenasystems.com/`

1. Athena Systems Login Platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Athena Systems Login Platform application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	|  Name  | Source Attribute |
	| ------ | ---------------- |
	| Client | user.companyname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Athena Systems Login Platform** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Athena Systems Login Platform SSO

To configure single sign-on on **Athena Systems Login Platform** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Athena Systems Login Platform support team](mailto:support@athenasystems.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Athena Systems Login Platform test user

In this section, you create a user called Britta Simon in Athena Systems Login Platform. Work with [Athena Systems Login Platform support team](mailto:support@athenasystems.com) to add the users in the Athena Systems Login Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Athena Systems Login Platform Sign on URL where you can initiate the login flow.  

* Go to Athena Systems Login Platform Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Athena Systems Login Platform for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Athena Systems Login Platform tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Athena Systems Login Platform for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Athena Systems Login Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
