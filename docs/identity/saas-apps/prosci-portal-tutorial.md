---
title: Configure Prosci Portal for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Prosci Portal.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Prosci Portal so that I can control who has access to Prosci Portal, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Prosci Portal for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Prosci Portal with Microsoft Entra ID. When you integrate Prosci Portal with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Prosci Portal.
* Enable your users to be automatically signed-in to Prosci Portal with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Prosci Portal single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Prosci Portal supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Prosci Portal from the gallery

To configure the integration of Prosci Portal into Microsoft Entra ID, you need to add Prosci Portal from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Prosci Portal** in the search box.
1. Select **Prosci Portal** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Prosci Portal

Configure and test Microsoft Entra SSO with Prosci Portal using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Prosci Portal.

To configure and test Microsoft Entra SSO with Prosci Portal, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Prosci Portal SSO](#configure-prosci-portal-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Prosci Portal test user](#create-prosci-portal-test-user)** - to have a counterpart of B.Simon in Prosci Portal that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Prosci Portal** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type one of the following values:

    | **Environment**| **URL** |
    |------------|---------|
    | Production |`urn:auth0:prosci-prod:microsoft`|
    | Staging |`urn:auth0:prosci-staging:microsoft`|

    b. In the **Reply URL** textbox, type one of the following URLs:

    | **Environment**| **URL** |
    |------------|---------|
    | Production | `https://id.prosci.com/login/callback?connection=microsoft` |
    | Staging | `https://id-staging.prosci.com/login/callback?connection=microsoft` |

	c. In the **Sign on URL** textbox, type one of the following URLs:
    
    | **Environment**| **URL** |
    |------------|---------|
    | Production | `https://id.prosci.com` |
    | Staging | `https://id-staging.prosci.com` |

    d. In the **Relay State** textbox, type one of the following URLs:

    | **Environment**| **URL** |
    |------------|---------|
    | Production | `https://portal.prosci.com` |
    | Staging | `https://portal-staging.prosci.com` |

    e. In the **Logout Url** textbox, type one of the following URLs:

    | **Environment**| **URL** |
    |------------|---------|
    | Production | `https://id.prosci.com/logout` |
    | Staging | `https://id-staging.prosci.com/logout` |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Prosci Portal** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to Copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Prosci Portal SSO

To configure single sign-on on **Prosci Portal** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [Prosci Portal support team](mailto:support@prosci.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Prosci Portal test user

In this section, you create a user called B.Simon in Prosci Portal. Work with [Prosci Portal support team](mailto:support@prosci.com) to add the users in the Prosci Portal platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Prosci Portal Sign-on URL where you can initiate the login flow.
 
* Go to Prosci Portal Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Prosci Portal tile in the My Apps, this option redirects to Prosci Portal Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Prosci Portal you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
