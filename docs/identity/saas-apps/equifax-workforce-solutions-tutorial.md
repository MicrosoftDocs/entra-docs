---
title: Configure Equifax Workforce Solutions for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Equifax Workforce Solutions.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Equifax Workforce Solutions so that I can control who has access to Equifax Workforce Solutions, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Equifax Workforce Solutions for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Equifax Workforce Solutions with Microsoft Entra ID. When you integrate Equifax Workforce Solutions with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Equifax Workforce Solutions.
* Enable your users to be automatically signed-in to Equifax Workforce Solutions with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Equifax Workforce Solutions single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Equifax Workforce Solutions supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Equifax Workforce Solutions from the gallery

To configure the integration of Equifax Workforce Solutions into Microsoft Entra ID, you need to add Equifax Workforce Solutions from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Equifax Workforce Solutions** in the search box.
1. Select **Equifax Workforce Solutions** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-equifax-workforce-solutions'></a>

## Configure and test Microsoft Entra SSO for Equifax Workforce Solutions

Configure and test Microsoft Entra SSO with Equifax Workforce Solutions using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Equifax Workforce Solutions.

To configure and test Microsoft Entra SSO with Equifax Workforce Solutions, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Equifax Workforce Solutions SSO](#configure-equifax-workforce-solutions-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Equifax Workforce Solutions test user](#create-equifax-workforce-solutions-test-user)** - to have a counterpart of B.Simon in Equifax Workforce Solutions that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Equifax Workforce Solutions** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **SP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `http://federation.talx.com/adfs/services/trust`

    b.  In the **Reply URL** text box, type the URL:
    `https://federation.talx.com/adfs/ls/`

	c. In the **Sign-on URL** text box, type the URL:
    `https://federation.talx.com/adfs/ls/`

	d. In the **Relay State** text box, type the value:
    `rpid=https%3A%2F%2Ffederationx.talx.com%2FClaimsAwareHelper%2F`

1. Select **Save**.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Equifax Workforce Solutions** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Equifax Workforce Solutions SSO

To configure single sign-on on **Equifax Workforce Solutions** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Equifax Workforce Solutions support team](mailto:ws.pd.samlsupport@equifax.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Equifax Workforce Solutions test user

In this section, you create a user called Britta Simon in Equifax Workforce Solutions. Work with [Equifax Workforce Solutions support team](mailto:ws.pd.samlsupport@equifax.com) to add the users in the Equifax Workforce Solutions platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Equifax Workforce Solutions Sign on URL where you can initiate the login flow.  

* Go to Equifax Workforce Solutions Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Equifax Workforce Solutions for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Equifax Workforce Solutions tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Equifax Workforce Solutions for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Equifax Workforce Solutions you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
