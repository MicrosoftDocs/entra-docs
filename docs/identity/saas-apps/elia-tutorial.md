---
title: Configure elia for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and elia.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and elia so that I can control who has access to elia, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure elia for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate elia with Microsoft Entra ID. When you integrate elia with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to elia.
* Enable your users to be automatically signed-in to elia with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* elia single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* elia supports **SP** initiated SSO.

## Add elia from the gallery

To configure the integration of elia into Microsoft Entra ID, you need to add elia from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **elia** in the search box.
1. Select **elia** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for elia

Configure and test Microsoft Entra SSO with elia using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in elia.

To configure and test Microsoft Entra SSO with elia, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure elia SSO](#configure-elia-sso)** - to configure the single sign-on settings on application side.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **elia** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   [![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")](common/edit-urls.png#lightbox)

1. On the **Basic SAML Configuration** section, perform the following steps:

   a. In the **Identifier (Entity ID)** text box, type a value using the following pattern:
    `urn:auth0:dev-p0tbk3x9:<CONNECTION-NAME>`

   b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://dev-p0tbk3x9.us.auth0.com/login/callback?connection=<CONNECTION-NAME>&organization=<ORGANIZATION-ID>`

   c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://elia.one/?organization=<ORGANIZATION-ID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [elia support team](mailto:support@gphy.ca) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. elia application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

   > [!NOTE]
   > Please select and update the **name** claim with **user.displayname** instead of user.userprincipalname as a Source attribute from the drop down manually to work SSO connection properly on both sides as per application side requirement and select **Save** as shown below.
   ![Screenshot shows the image of name claims configuration.](media/elia-tutorial/claims.png "Attribute")

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (PEM)** and select **PEM certificate download** to download the certificate and save it on your computer.

	[![Screenshot of a certificate showing the Certificate download link.](common/certificate-base64-download.png)](common/certificate-base64-download.png#lightbox)

1. On the **Set up elia** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](media/elia-tutorial/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure elia SSO

To configure single sign-on on **elia** side, you need to send the downloaded **Certificate (PEM)** and Login URL from Microsoft Entra admin center to [elia support team](mailto:support@gphy.ca). They set this setting to have the SAML SSO connection set properly on both sides.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to elia Sign-on URL where you can initiate the login flow.
 
* Go to elia Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the elia tile in the My Apps, this option redirects to elia Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure elia you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
