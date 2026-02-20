---
title: Configure Moveworks for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Moveworks.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.workload: identity
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Moveworks so that I can control who has access to Moveworks, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Moveworks for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Moveworks with Microsoft Entra ID. When you integrate Moveworks with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Moveworks.
* Enable your users to be automatically signed-in to Moveworks with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Moveworks single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Moveworks supports both **SP and IDP** initiated SSO.
* Moveworks supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Moveworks from the gallery

To configure the integration of Moveworks into Microsoft Entra ID, you need to add Moveworks from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Moveworks** in the search box.
1. Select **Moveworks** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Moveworks

Configure and test Microsoft Entra SSO with Moveworks using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Moveworks.

To configure and test Microsoft Entra SSO with Moveworks, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Moveworks SSO](#configure-moveworks-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Moveworks test user](#create-moveworks-test-user)** - to have a counterpart of B.Simon in Moveworks that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Moveworks** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://moveworks.com`

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    |**Reply URL**|
    |-------------|
    | `https://<CustomerName>.moveworks.com/login/sso/saml` |
    | `https://<CustomerName>.am-ca-central.moveworks.com/login/sso/saml` |
    | `https://<CustomerName>.am-eu-central.moveworks.com/login/sso/saml` |
    | `https://<CustomerName>.am-ap-southeast.moveworks.com/login/sso/saml` |
    | `https://<CustomerName>.moveworksgov.com/login/sso/saml` |

    c. In the **Relay State**, type a value using the following pattern:
    `<CustomerName>`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using one of the following patterns:

    |**Sign-on URL**|
    |---------------|
    | `https://<CustomerName>.moveworks.com` |
    | `https://<CustomerName>.am-ca-central.moveworks.com` |
    | `https://<CustomerName>.am-eu-central.moveworks.com` |
    | `https://<CustomerName>.am-ap-southeast.moveworks.com` |
    | `https://<CustomerName>.moveworksgov.com` |
    
	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL, Relay State and Sign on URL. Contact [Moveworks support team](mailto:support@moveworks.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Moveworks** section, copy the appropriate URL based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Moveworks SSO

To configure single sign-on on **Moveworks** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Moveworks support team](mailto:support@moveworks.com). They set this setting to have the SAML SSO connection set properly on both sides. For more information, please refer [this](https://help.moveworks.com/docs/microsoft-manual-sso-configuration-guide-saml) link.

### Create Moveworks test user

In this section, a user called Britta Simon is created in Moveworks. Moveworks supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Moveworks, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Moveworks Sign on URL where you can initiate the login flow.  
 
* Go to Moveworks Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the Moveworks for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the Moveworks tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Moveworks for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Moveworks you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
