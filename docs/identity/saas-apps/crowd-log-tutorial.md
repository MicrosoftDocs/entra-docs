---
title: Configure Crowd Log for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Crowd Log.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Crowd Log so that I can control who has access to Crowd Log, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Crowd Log for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Crowd Log with Microsoft Entra ID. When you integrate Crowd Log with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Crowd Log.
* Enable your users to be automatically signed-in to Crowd Log with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Crowd Log single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Crowd Log supports **SP and IDP** initiated SSO.

## Add Crowd Log from the gallery

To configure the integration of Crowd Log into Microsoft Entra ID, you need to add Crowd Log from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Crowd Log** in the search box.
1. Select **Crowd Log** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-crowd-log'></a>

## Configure and test Microsoft Entra SSO for Crowd Log

Configure and test Microsoft Entra SSO with Crowd Log using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Crowd Log.

To configure and test Microsoft Entra SSO with Crowd Log, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Crowd Log SSO](#configure-crowd-log-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Crowd Log test user](#create-crowd-log-test-user)** - to have a counterpart of B.Simon in Crowd Log that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Crowd Log** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://app.crowdlog.jp/metadata/<auth_code>/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.crowdlog.jp/saml/?auth_code=<auth_code>`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://app.crowdlog.jp/login.cgi?auth_code=<auth_code>`

	> [!NOTE]
	> These values aren't real. Check the actual Identifier, Reply URL and Sign-on URL on the "Company Settings > Security > SAML Auth" on Crowd Log. You can also refer to the patterns shown in the Basic SAML Configuration section. 

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Crowd Log SSO

To perform the Single Sign-On configuration on the Crowd Log side, please follow [this](https://support.crowdlog.jp/portal/ja/kb/articles/admin-settings-saml) link.

### Create Crowd Log test user

In this section, you create a user called Britta Simon in Crowd Log. For more information on how to create a user, please refer [this](https://support.crowdlog.jp/portal/ja/kb/articles/admin-memberadmin-member-create) link.  

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Crowd Log Sign on URL where you can initiate the login flow.  

* Go to Crowd Log Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Crowd Log for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Crowd Log tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Crowd Log for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Crowd Log you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
