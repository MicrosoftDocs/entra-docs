---
title: Configure Bugsnag for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Bugsnag.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Bugsnag so that I can control who has access to Bugsnag, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Bugsnag for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Bugsnag with Microsoft Entra ID. When you integrate Bugsnag with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Bugsnag.
* Enable your users to be automatically signed-in to Bugsnag with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Bugsnag single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Bugsnag supports **SP and IDP** initiated SSO.
* Bugsnag supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Bugsnag from the gallery

To configure the integration of Bugsnag into Microsoft Entra ID, you need to add Bugsnag from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Bugsnag** in the search box.
1. Select **Bugsnag** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-bugsnag'></a>

## Configure and test Microsoft Entra SSO for Bugsnag

Configure and test Microsoft Entra SSO with Bugsnag using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Bugsnag.

To configure and test Microsoft Entra SSO with Bugsnag, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Bugsnag SSO](#configure-bugsnag-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Bugsnag test user](#create-bugsnag-test-user)** - to have a counterpart of B.Simon in Bugsnag that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Bugsnag** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following step:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.bugsnag.com/user/sign_in/saml/<org_slug>/acs`

    > [!NOTE]
    > The Reply URL value isn't real. Update this value with the actual Reply URL. Contact [Bugsnag Client support team](mailto:support@bugsnag.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://app.bugsnag.com/user/identity_provider`

6. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

    ![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Bugsnag SSO

1. Sign into the Bugsnag website as an administrator.

1. In BugSnag settings, select **Organization settings -> Single sign-on**.

    ![Screenshot of Authentication page.](./media/bugsnag-tutorial/authentication.png)

1. Perform the following steps in the **Enable single sign-on** page:

    ![Screenshot of SSO settings page.](./media/bugsnag-tutorial/enable-sso.png)

    a. In the **SAML/IdP Metadata** field, enter the **App Federation Metadata Url** value, which you copied from Azure portal.

    b. Copy the **SAML Endpoint URL** value and paste this value into the **Reply URL** text box in the **Basic SAML Configuration** section.

    c. Select **ENABLE SSO**.

> [!NOTE]
> For more information on the Bugsnag SSO configuration, please follow [this](https://docs.bugsnag.com/product/single-sign-on/other/#setup-saml) guide.

### Create Bugsnag test user

In this section, a user called Britta Simon is created in Bugsnag. Bugsnag supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Bugsnag, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Bugsnag Sign on URL where you can initiate the login flow.  

* Go to Bugsnag Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Bugsnag for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Bugsnag tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Bugsnag for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Bugsnag you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
