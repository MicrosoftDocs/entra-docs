---
title: Configure Yuhu Property Management Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Yuhu Property Management Platform.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Yuhu Property Management Platform so that I can control who has access to Yuhu Property Management Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Yuhu Property Management Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Yuhu Property Management Platform with Microsoft Entra ID. When you integrate Yuhu Property Management Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Yuhu Property Management Platform.
* Enable your users to be automatically signed-in to Yuhu Property Management Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Yuhu Property Management Platform single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Yuhu Property Management Platform supports **SP** initiated SSO.

## Add Yuhu Property Management Platform from the gallery

To configure the integration of Yuhu Property Management Platform into Microsoft Entra ID, you need to add Yuhu Property Management Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Yuhu Property Management Platform** in the search box.
1. Select **Yuhu Property Management Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-yuhu-property-management-platform'></a>

## Configure and test Microsoft Entra SSO for Yuhu Property Management Platform

Configure and test Microsoft Entra SSO with Yuhu Property Management Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Yuhu Property Management Platform.

To configure and test Microsoft Entra SSO with Yuhu Property Management Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Yuhu Property Management Platform SSO](#configure-yuhu-property-management-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Yuhu Property Management Platform test user](#create-yuhu-property-management-platform-test-user)** - to have a counterpart of B.Simon in Yuhu Property Management Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Yuhu Property Management Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a value using the following pattern:
    `yuhu-<ID>`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.yuhu.io/companies`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Yuhu Property Management Platform Client support team](mailto:hello@yuhu.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Yuhu Property Management Platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Attributes")

1. In addition to above, Yuhu Property Management Platform application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ---------------| --------------- |
	| firstName | user.givenname |
	| lastName | user.surname |
	| email | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificateraw.png "Certificate")

1. On the **Set up Yuhu Property Management Platform** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Yuhu Property Management Platform SSO

To configure single sign-on on **Yuhu Property Management Platform** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [Yuhu Property Management Platform support team](mailto:hello@yuhu.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Yuhu Property Management Platform test user

In this section, you create a user called B.Simon in Yuhu Property Management Platform. Work with [Yuhu Property Management Platform support team](mailto:hello@yuhu.io) to add the users in the Yuhu Property Management Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Yuhu Property Management Platform Sign-on URL where you can initiate the login flow. 

* Go to Yuhu Property Management Platform Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Yuhu Property Management Platform tile in the My Apps, this option redirects to Yuhu Property Management Platform Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Yuhu Property Management Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
