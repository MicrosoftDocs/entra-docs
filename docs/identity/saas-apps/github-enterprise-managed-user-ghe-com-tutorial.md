---
title: Configure GitHub Enterprise Managed User - GHE.com for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and GitHub Enterprise Managed User - GHE.com.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 06/28/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and GitHub Enterprise Managed User so that I can control who has access to GitHub Enterprise Managed User, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure GitHub Enterprise Managed User - GHE.com for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate GitHub Enterprise Managed User with Microsoft Entra ID. When you integrate GitHub Enterprise Managed User with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to GitHub Enterprise Managed User.
* Enable your users to be automatically signed-in to GitHub Enterprise Managed User with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* GitHub Enterprise Managed User single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* GitHub Enterprise Managed User supports both **SP and IDP** initiated SSO.

## Adding GitHub Enterprise Managed User from the gallery

To configure the integration of GitHub Enterprise Managed User into Microsoft Entra ID, you need to add GitHub Enterprise Managed User from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. Type **GitHub Enterprise Managed User** in the search box.
1. Select **GitHub Enterprise Managed User** from results panel and then select the **Create** button. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for GitHub Enterprise Managed User

Configure and test Microsoft Entra SSO with GitHub Enterprise Managed User using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in GitHub Enterprise Managed User.

To configure and test Microsoft Entra SSO with GitHub Enterprise Managed User, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure GitHub Enterprise Managed User SSO](#configure-github-enterprise-managed-user-sso)** - to configure the single sign-on settings on application side.
    1. **[Create GitHub Enterprise Managed User test user](#create-github-enterprise-managed-user-test-user)** - to have a counterpart of B.Simon in GitHub Enterprise Managed User that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **GitHub Enterprise Managed User** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<ENTERPRISE>.ghe.com/enterprises/<ENTERPRISE>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<ENTERPRISE>.ghe.com/enterprises/<ENTERPRISE>/saml/consume`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<ENTERPRISE>.ghe.com/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [GitHub Enterprise Managed User support team](https://support.github.com/early-access/data-residency) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up GitHub Enterprise Managed User** section, copy the appropriate URLs based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure GitHub Enterprise Managed User SSO

To configure single sign-on on **GitHub Enterprise Managed User** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [GitHub Enterprise Managed User support team](https://support.github.com/early-access/data-residency). They set this setting to have the SAML SSO connection set properly on both sides.

### Create GitHub Enterprise Managed User test user

In this section, you create a user called B.Simon in GitHub Enterprise Managed User. Work with [GitHub Enterprise Managed User support team](https://support.github.com/early-access/data-residency) to add the users in the GitHub Enterprise Managed User platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to GitHub Enterprise Managed User Sign-on URL where you can initiate the login flow.  
 
* Go to GitHub Enterprise Managed User Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the GitHub Enterprise Managed User for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the GitHub Enterprise Managed User tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the GitHub Enterprise Managed User for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure GitHub Enterprise Managed User you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
