---
title: Configure Superluminal for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Superluminal.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Superluminal so that I can control who has access to Superluminal, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Superluminal for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Superluminal with Microsoft Entra ID. When you integrate Superluminal with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Superluminal.
* Enable your users to be automatically signed-in to Superluminal with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Superluminal single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Superluminal supports only **SP** initiated SSO.
* Superluminal supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Superluminal from the gallery

To configure the integration of Superluminal into Microsoft Entra ID, you need to add Superluminal from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Superluminal** in the search box.
1. Select **Superluminal** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Superluminal

Configure and test Microsoft Entra SSO with Superluminal using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Superluminal.

To configure and test Microsoft Entra SSO with Superluminal, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Superluminal SSO](#configure-superluminal-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Superluminal test user](#create-superluminal-test-user)** - to have a counterpart of B.Simon in Superluminal that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Superluminal** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `https://superluminal.eu`

    b. In the **Reply URL** textbox, type the URL:
    `https://portal.superluminal.eu/Identity/Account/SSO/SamlACS`

    c. In the **Sign on URL** text box, type one of the following URLs:

    |**Sign on URL**|
    |---------------|
    |`https://portal.superluminal.eu/Identity/Account/Login`|
    |`https://portal.superluminal.eu/Identity/Account/LoginSSO`|

1. Superluminal application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Superluminal application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name  |  Source Attribute|
	| --------------- | --------- |
	| user.email | user.mail |
	| user.firstName | user.givenname |
	| user.lastName | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Superluminal SSO

Please refer [this](https://portal.superluminal.eu/Documentation#sso) article for setting the SAML SSO connection properly on both sides or contact [Superluminal support team](mailto:info@superluminal.eu) for any queriers.

### Create Superluminal test user

In this section, a user called Britta Simon is created in Superluminal. Superluminal supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Superluminal, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Superluminal Sign on URL where you can initiate the login flow.
 
* Go to Superluminal Sign on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Superluminal tile in the My Apps, this option redirects to Superluminal Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Superluminal you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
