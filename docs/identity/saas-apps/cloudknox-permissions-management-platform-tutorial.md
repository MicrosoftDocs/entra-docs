---
title: Configure CloudKnox Permissions Management Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CloudKnox Permissions Management Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and CloudKnox Permissions Management Platform so that I can control who has access to CloudKnox Permissions Management Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure CloudKnox Permissions Management Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate CloudKnox Permissions Management Platform with Microsoft Entra ID. When you integrate CloudKnox Permissions Management Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CloudKnox Permissions Management Platform.
* Enable your users to be automatically signed-in to CloudKnox Permissions Management Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CloudKnox Permissions Management Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CloudKnox Permissions Management Platform supports **IDP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding CloudKnox Permissions Management Platform from the gallery

To configure the integration of CloudKnox Permissions Management Platform into Microsoft Entra ID, you need to add CloudKnox Permissions Management Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CloudKnox Permissions Management Platform** in the search box.
1. Select **CloudKnox Permissions Management Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-cloudknox-permissions-management-platform'></a>

## Configure and test Microsoft Entra SSO for CloudKnox Permissions Management Platform

Configure and test Microsoft Entra SSO with CloudKnox Permissions Management Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CloudKnox Permissions Management Platform.

To configure and test Microsoft Entra SSO with CloudKnox Permissions Management Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CloudKnox Permissions Management Platform SSO](#configure-cloudknox-permissions-management-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CloudKnox Permissions Management Platform test user](#create-cloudknox-permissions-management-platform-test-user)** - to have a counterpart of B.Simon in CloudKnox Permissions Management Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CloudKnox Permissions Management Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, enter the values for the following fields:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.cloudknox.io/saml/<ID>`

	> [!NOTE]
	> The Reply URL value isn't real. Update the value with the actual Reply URL. Contact [CloudKnox Permissions Management Platform Client support team](mailto:support@cloudknox.io) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. CloudKnox Permissions Management Platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, CloudKnox Permissions Management Platform application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source attribute|
	| --------------- | --------- |
	| First_Name | user.givenname |
	| Groups | user.groups |
	| Last_Name | user.surname |
	| Email_Address | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up CloudKnox Permissions Management Platform** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CloudKnox Permissions Management Platform SSO

To configure single sign-on on **CloudKnox Permissions Management Platform** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [CloudKnox Permissions Management Platform support team](mailto:support@cloudknox.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create CloudKnox Permissions Management Platform test user

In this section, you create a user called Britta Simon in CloudKnox Permissions Management Platform. Work with [CloudKnox Permissions Management Platform support team](mailto:support@cloudknox.io) to add the users in the CloudKnox Permissions Management Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the CloudKnox Permissions Management Platform for which you set up the SSO

* You can use Microsoft My Apps. When you select the CloudKnox Permissions Management Platform tile in the My Apps, you should be automatically signed in to the CloudKnox Permissions Management Platform for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure CloudKnox Permissions Management Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
