---
title: Configure XM Discover for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and XM Discover.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and XM Discover so that I can control who has access to XM Discover, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure XM Discover for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate XM Discover with Microsoft Entra ID. When you integrate XM Discover with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to XM Discover.
* Enable your users to be automatically signed-in to XM Discover with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* XM Discover single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* XM Discover supports only **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add XM Discover from the gallery

To configure the integration of XM Discover into Microsoft Entra ID, you need to add XM Discover from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **XM Discover** in the search box.
1. Select **XM Discover** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for XM Discover

Configure and test Microsoft Entra SSO with XM Discover using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in XM Discover.

To configure and test Microsoft Entra SSO with XM Discover, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure XM Discover SSO](#configure-xm-discover-sso)** - to configure the single sign-on settings on application side.
    1. **[Create XM Discover test user](#create-xm-discover-test-user)** - to have a counterpart of B.Simon in XM Discover that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **XM Discover** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Microsoft Entra. The user needs to save the configuration by selecting the **Save** button.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png)

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure XM Discover SSO

To configure single sign-on on **XM Discover** side, you need to send the **App Federation Metadata Url** to [XM Discover support team](mailto:support@qualtrics.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create XM Discover test user

In this section, you create a user called B.Simon in XM Discover. Work with [XM Discover support team](mailto:support@qualtrics.com) to add the users in the XM Discover platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the XM Discover for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the XM Discover tile in the My Apps, you should be automatically signed in to the XM Discover for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure XM Discover you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
