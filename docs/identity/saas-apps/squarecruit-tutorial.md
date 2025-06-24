---
title: Configure SquaREcruit for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SquaREcruit.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SquaREcruit so that I can control who has access to SquaREcruit, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SquaREcruit for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SquaREcruit with Microsoft Entra ID. When you integrate SquaREcruit with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SquaREcruit.
* Enable your users to be automatically signed-in to SquaREcruit with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SquaREcruit single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SquaREcruit supports only **SP** initiated SSO.
* SquaREcruit supports **Just In Time** user provisioning.

## Add SquaREcruit from the gallery

To configure the integration of SquaREcruit into Microsoft Entra ID, you need to add SquaREcruit from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SquaREcruit** in the search box.
1. Select **SquaREcruit** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for SquaREcruit

Configure and test Microsoft Entra SSO with SquaREcruit using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SquaREcruit.

To configure and test Microsoft Entra SSO with SquaREcruit, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SquaREcruit SSO](#configure-squarecruit-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SquaREcruit test user](#create-squarecruit-test-user)** - to have a counterpart of B.Simon in SquaREcruit that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SquaREcruit** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a value using the following pattern:
    `urn:amazon:cognito:sp:<SquaREcruit_ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.sso.squarecruit.com/saml2/idpresponse`

    c. In the **Sign on URL** text box, type the URL:
    `https://dls.squarecruit.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [SquaREcruit support team](mailto:support@intellectselect.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. SquaREcruit application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, SquaREcruit application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| ---- | --------------- |
	| family_name | user.surname |
	| email | user.mail |
	| username | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SquaREcruit SSO

To configure single sign-on on **SquaREcruit** side, you need to send the **App Federation Metadata Url** to [SquaREcruit support team](mailto:support@intellectselect.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SquaREcruit test user

In this section, a user called Britta Simon is created in SquaREcruit. SquaREcruit supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in SquaREcruit, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to SquaREcruit Sign-on URL where you can initiate the login flow.
 
* Go to SquaREcruit Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the SquaREcruit tile in the My Apps, this option redirects to SquaREcruit Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure SquaREcruit you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).