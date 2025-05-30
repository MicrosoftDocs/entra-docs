---
title: Configure Appian for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Appian.
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Appian so that I can control who has access to Appian, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Appian for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Appian with Microsoft Entra ID. When you integrate Appian with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Appian.
* Enable your users to be automatically signed-in to Appian with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Appian single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Appian supports **SP and IDP** initiated SSO.
* Appian supports **Just In Time** user provisioning.

## Adding Appian from the gallery

To configure the integration of Appian into Microsoft Entra ID, you need to add Appian from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Appian** in the search box.
1. Select **Appian** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-appian'></a>

## Configure and test Microsoft Entra SSO for Appian

Configure and test Microsoft Entra SSO with Appian using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Appian.

To configure and test Microsoft Entra SSO with Appian, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Appian SSO](#configure-appian-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Appian test user](#create-appian-test-user)** - to have a counterpart of B.Simon in Appian that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Appian** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.appiancloud.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.appiancloud.com/suite/saml/AssertionConsumer`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.appiancloud.com/suite`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Appian Client support team](mailto:support@appian.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Appian** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

1. Appian application expects to enable token encryption in order to make SSO work. To activate token encryption, Browse to **Entra ID** > **Enterprise apps** > select your application > **Token encryption**. For more information see the article [Configure Microsoft Entra SAML token encryption](~/identity/enterprise-apps/howto-saml-token-encryption.md).

    ![Screenshot shows the activation of Token Encryption.](./media/appian-tutorial/token.png "Token Encryption")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Appian SSO

1. In a different web browser window, sign into Appian website as an administrator.

1. Go to the **Admin Console** and  select **Enable SAML**.

1. Select **Add SAML Identity Provider**.

1.  Enter a **Description** for the IdP.

1.  Enter a **Service Provider Name**, this should be a unique name for both the service and identity providers.

1.  Upload the IdP metadata into **Identity Provider Metadata**. 

1.  Choose the appropriate **Signature Hashing Algorithm** that matches the IdP.

1.  Select **Test This Configuration** in the top-right side of the dialog to verify that the configuration is valid or not.

1. Select **Done** after successfully signing in to close the configuration dialog.

1. If you want the new IdP's sign-in page to be the default, set the **Default Sign-In Page**
accordingly.

1.  Select **Verify My Access** once the dialog is closed to ensure that you can still sign in to Appian. This time, you have to sign in with the current user.

1.  Once you have successfully verified that you can still sign in, select **Save Changes**.

### Create Appian test user

In this section, a user called Britta Simon is created in Appian. Appian supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Appian, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Appian Sign on URL where you can initiate the login flow.  

* Go to Appian Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Appian for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Appian tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Appian for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Appian you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
