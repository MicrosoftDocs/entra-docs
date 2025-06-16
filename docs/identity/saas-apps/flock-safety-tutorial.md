---
title: Configure Flock Safety for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Flock Safety.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Flock Safety so that I can control who has access to Flock Safety, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Flock Safety for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Flock Safety with Microsoft Entra ID. When you integrate Flock Safety with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Flock Safety.
* Enable your users to be automatically signed-in to Flock Safety with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Flock Safety single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Flock Safety supports **SP** initiated SSO.
* Flock Safety supports **Just In Time** user provisioning.

## Adding Flock Safety from the gallery

To configure the integration of Flock Safety into Microsoft Entra ID, you need to add Flock Safety from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Flock Safety** in the search box.
1. Select **Flock Safety** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Flock Safety

Configure and test Microsoft Entra SSO with Flock Safety using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Flock Safety.

To configure and test Microsoft Entra SSO with Flock Safety, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Flock Safety SSO](#configure-flock-safety-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Flock Safety test user](#create-flock-safety-test-user)** - to have a counterpart of B.Simon in Flock Safety that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Flock Safety** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a value using the following pattern:
    `urn:auth0:prod-flock:<ID>`

    b. In the **Reply URL** textbox, type a URL using the following pattern:
    `https://login.flocksafety.com/login/callback?connection=<ID>`

    c. In the **Sign on URL** textbox, type a URL using the following pattern:
    `https://users.flocksafety.com/sso-login/<CustomName>`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Flock Safety support team](mailto:support@flocksafety.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Flock Safety** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Flock Safety SSO

To configure single sign-on on **Flock Safety** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Flock Safety support team](mailto:support@flocksafety.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Flock Safety test user

In this section, a user called Britta Simon is created in Flock Safety. Flock Safety supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Flock Safety, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Flock Safety Sign-on URL where you can initiate the login flow.
 
* Go to Flock Safety Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Flock Safety tile in the My Apps, this option redirects to Flock Safety Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Flock Safety you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
