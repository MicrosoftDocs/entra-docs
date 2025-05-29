---
title: Configure Assent SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Assent SSO.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Assent SSO so that I can control who has access to Assent SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Assent SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Assent SSO with Microsoft Entra ID. When you integrate Assent SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Assent SSO.
* Enable your users to be automatically signed-in to Assent SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Assent SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Assent SSO supports only **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Assent SSO from the gallery

To configure the integration of Assent SSO into Microsoft Entra ID, you need to add Assent SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Assent SSO** in the search box.
1. Select **Assent SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Assent SSO

Configure and test Microsoft Entra SSO with Assent SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Assent SSO.

To configure and test Microsoft Entra SSO with Assent SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Assent SSO](#configure-assent-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Assent SSO test user](#create-assent-sso-test-user)** - to have a counterpart of B.Simon in Assent SSO that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Assent SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `http://sts.assentcompliance.com/adfs/services/trust`

    b. In the **Reply URL** text box, type the URL:
    `https://sts.assentcompliance.com/adfs/ls/`

	c. In the **Sign-on URL** text box, type the URL:
    `https://sts.assentcompliance.com/adfs/ls/`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Assent SSO

To configure single sign-on on **Assent SSO** side, you need to send the **App Federation Metadata Url** to [Assent SSO support team](mailto:customersupport@assent.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Assent SSO test user

In this section, you create a user called B.Simon in Assent SSO. Work with [Assent SSO support team](mailto:customersupport@assent.com) to add the users in the Assent SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Assent SSO Sign-on URL where you can initiate the login flow.
 
* Go to Assent SSO Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Assent SSO tile in the My Apps, this option redirects to Assent SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Assent SSO you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
