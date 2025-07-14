---
title: Configure TechSafe Entra ID SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and TechSafe Entra ID SSO.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 06/18/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure TechSafe Entra ID SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate TechSafe Entra ID SSO with Microsoft Entra ID. When you integrate TechSafe Entra ID SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to TechSafe Entra ID SSO.
* Enable your users to be automatically signed-in to TechSafe Entra ID SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* TechSafe Entra ID SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* TechSafe Entra ID SSO supports only **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add TechSafe Entra ID SSO from the gallery

To configure the integration of TechSafe Entra ID SSO into Microsoft Entra ID, you need to add TechSafe Entra ID SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **TechSafe Entra ID SSO** in the search box.
1. Select **TechSafe Entra ID SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for TechSafe Entra ID SSO

Configure and test Microsoft Entra SSO with TechSafe Entra ID SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in TechSafe Entra ID SSO.

To configure and test Microsoft Entra SSO with TechSafe Entra ID SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure TechSafe Entra ID SSO](#configure-techsafe-entra-id-sso)** - to configure the single sign-on settings on application side.
    1. **[Create TechSafe Entra ID SSO test user](#create-techsafe-entra-id-sso-test-user)** - to have a counterpart of B.Simon in TechSafe Entra ID SSO that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **TechSafe Entra ID SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `https://portal.techsafe.nz/saml2/sso`

    b. In the **Reply URL** text box, type the URL:
    ` https://portal.techsafe.nz/saml/module.php/saml/sp/saml2-acs.php/techsafe-sp `

    c. In the **Sign on URL** text box, type the URL:
    `https://portal.techsafe.nz`

    d. In the **Logout Url** text box, type the URL:
    `https://portal.techsafe.nz/logout.php`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up TechSafe Entra ID SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure TechSafe Entra ID SSO

To configure single sign-on on **TechSafe Entra ID SSO** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [TechSafe Entra ID SSO support team](mailto:support@capellaconsulting.co.nz). They set this setting to have the SAML SSO connection set properly on both sides.

### Create TechSafe Entra ID SSO test user

In this section, you create a user called B.Simon in TechSafe Entra ID SSO. Work with [TechSafe Entra ID SSO support team](mailto:support@capellaconsulting.co.nz) to add the users in the TechSafe Entra ID SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to TechSafe Entra ID SSO Sign-on URL where you can initiate the login flow.
 
* Go to TechSafe Entra ID SSO Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the TechSafe Entra ID SSO tile in the My Apps, this option redirects to TechSafe Entra ID SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure TechSafe Entra ID SSO you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).