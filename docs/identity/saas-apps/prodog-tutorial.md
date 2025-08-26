---
title: Configure Prodog for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Prodog.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/01/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Prodog for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Prodog with Microsoft Entra ID. When you integrate Prodog with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Prodog.
* Enable your users to be automatically signed-in to Prodog with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Prodog single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Prodog supports **SP** initiated SSO.


## Add Prodog from the gallery

To configure the integration of Prodog into Microsoft Entra ID, you need to add Prodog from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Prodog** in the search box.
1. Select **Prodog** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Prodog

Configure and test Microsoft Entra SSO with Prodog using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Prodog.

To configure and test Microsoft Entra SSO with Prodog, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Prodog SSO](#configure-prodog-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Prodog test user](#create-prodog-test-user)** - to have a counterpart of B.Simon in Prodog that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Prodog** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type one of the following URLs:

    | Identifier |
    |------|
    | `https://t.leanwo.com` |
    | `https://u.leanwo.com`|

    b. In the **Reply URL** text box, type one of the following URLs:

    | Reply URL |
    |------|
    | `https://tt.leanwo.com/api/saml/sso/a` |
    | `https://u.leanwo.com/api/saml/sso/a`|
    

    c. In the **Sign on URL** text box, type ine fo the following URLs:

    | Sign on URL |
    |------|
    | `https://t.leanwo.com` |
    | `https://u.leanwo.com`|

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows The Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Prodog** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows how to copy configuration URLs.](common/copy-configuration-urls.png "Configuration")
    

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Prodog SSO

To configure single sign-on on **Prodog** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Prodog support team](mailto:15800458450@leanwo.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Prodog test user

In this section, you create a user called B.Simon in Prodog. Work with [Prodog support team](mailto:15800458450@leanwo.com) to add the users in the Prodog platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Prodog Sign-on URL where you can initiate the login flow.  
 
* Go to Prodog Sign-on URL directly and initiate the login flow from there.

## Related content

Once you configure Prodog you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).

