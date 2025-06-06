---
title: Configure In Case of Crisis - Mobile for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and In Case of Crisis - Mobile.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 04/15/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and In Case of Crisis - Mobile so that I can control who has access to In Case of Crisis - Mobile, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure In Case of Crisis - Mobile for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate In Case of Crisis - Mobile with Microsoft Entra ID. When you integrate In Case of Crisis - Mobile with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to In Case of Crisis - Mobile.
* Enable your users to be automatically signed-in to In Case of Crisis - Mobile with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* In Case of Crisis - Mobile single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* In Case of Crisis - Mobile supports only **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add In Case of Crisis - Mobile from the gallery

To configure the integration of In Case of Crisis - Mobile into Microsoft Entra ID, you need to add In Case of Crisis - Mobile from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **In Case of Crisis - Mobile** in the search box.
1. Select **In Case of Crisis - Mobile** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-in-case-of-crisis---mobile'></a>

## Configure and test Microsoft Entra SSO for In Case of Crisis - Mobile

Configure and test Microsoft Entra SSO with In Case of Crisis - Mobile using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in In Case of Crisis - Mobile.

To configure and test Microsoft Entra SSO with In Case of Crisis - Mobile, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure In Case of Crisis - Mobile SSO](#configure-in-case-of-crisis---mobile-sso)** - to configure the single sign-on settings on application side.
    1. **[Create In Case of Crisis - Mobile test user](#create-in-case-of-crisis---mobile-test-user)** - to have a counterpart of B.Simon in In Case of Crisis - Mobile that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **In Case of Crisis - Mobile** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot for Edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

6. On the **Set up In Case of Crisis - Mobile.** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Attributes")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure In Case of Crisis - Mobile SSO

To configure single sign-on on **In Case of Crisis - Mobile** side, you need to send the downloaded **Certificate (Raw)** and copied **User access URL** from Azure portal to [In Case of Crisis - Mobile support team](https://www.rockdovesolutions.com/in-case-of-crisis-microsoft-teams-integration). They set this setting to have the SAML SSO connection set properly on both sides.

### Create In Case of Crisis - Mobile test user

In this section, you create a user called Britta Simon in In Case of Crisis - Mobile. Work with [In Case of Crisis - Mobile support team](https://www.rockdovesolutions.com/in-case-of-crisis-microsoft-teams-integration) to add the users in the In Case of Crisis - Mobile platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the In Case of Crisis - Mobile for which you set up the SSO.

* You can use Microsoft My Apps. When you select the In Case of Crisis - Mobile tile in the My Apps, you should be automatically signed in to the In Case of Crisis - Mobile for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure In Case of Crisis - Mobile you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).