---
title: Configure Sakon Device Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Sakon Device Platform.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 06/04/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Sakon Device Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Sakon Device Platform with Microsoft Entra ID. When you integrate Sakon Device Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Sakon Device Platform.
* Enable your users to be automatically signed-in to Sakon Device Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Sakon Device Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Sakon Device Platform supports only **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Sakon Device Platform from the gallery

To configure the integration of Sakon Device Platform into Microsoft Entra ID, you need to add Sakon Device Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Sakon Device Platform** in the search box.
1. Select **Sakon Device Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Sakon Device Platform

Configure and test Microsoft Entra SSO with Sakon Device Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Sakon Device Platform.

To configure and test Microsoft Entra SSO with Sakon Device Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Sakon Device Platform SSO](#configure-sakon-device-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Sakon Device Platform test user](#create-sakon-device-platform-test-user)** - to have a counterpart of B.Simon in Sakon Device Platform that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Sakon Device Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://mobilemanager.net/5/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CUSTOMER_NAME>.gsgcloud.net/core5/AssertionConsumerService.aspx`

	> [!NOTE]
	> The Reply URL isn't real. Update this value with the actual Reply URL. Contact [Sakon Device Platform support team](mailto:imsteam@sakon.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. Your Sakon Device Platform application requires SAML assertions in a specific format. Typically, the attribute mappings use the **emailaddress** attribute in your SAML token configuration. The screenshot below shows an example of this setup. If your organization prefers to use **employeeid** instead, you need to add a custom attribute mapping. Here's how to do it:

    1.	Go to your Azure SAML configuration & Add a new claim.
    2.	Add a new claim and select **user.employeeid** from the list of attributes or choose the appropriate attribute based on your organization’s configuration.
    3.	Set the outgoing claim type to **employeeid**.

	![Screenshot shows the image of custom attribute mappings.](common/default-attributes.png "Image")

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Sakon Device Platform SSO

To configure single sign-on on **Sakon Device Platform** side, you need to send the **App Federation Metadata Url** to [Sakon Device Platform support team](mailto:imsteam@sakon.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Sakon Device Platform test user

In this section, you create a user called B.Simon in Sakon Device Platform. Work with [Sakon Device Platform support team](mailto:imsteam@sakon.com) to add the users in the Sakon Device Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the Sakon Device Platform for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the Sakon Device Platform tile in the My Apps, you should be automatically signed in to the Sakon Device Platform for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](
https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510
).

## Related content

Once you configure Sakon Device Platform you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).