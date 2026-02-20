---
title: Configure ScreenPal for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ScreenPal.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Screencast-O-Matic so that I can control who has access to Screencast-O-Matic, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ScreenPal for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ScreenPal with Microsoft Entra ID. When you integrate ScreenPal with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ScreenPal.
* Enable your users to be automatically signed-in to ScreenPal with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ScreenPal single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ScreenPal supports only **SP** initiated SSO.
* ScreenPal supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ScreenPal from the gallery

To configure the integration of ScreenPal into Microsoft Entra ID, you need to add ScreenPal from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ScreenPal** in the search box.
1. Select **ScreenPal** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ScreenPal'></a>

## Configure and test Microsoft Entra SSO for ScreenPal

Configure and test Microsoft Entra SSO with ScreenPal using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ScreenPal.

To configure and test Microsoft Entra SSO with ScreenPal, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ScreenPal SSO](#configure-screenpal-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ScreenPal test user](#create-screenpal-test-user)** - to have a counterpart of B.Simon in ScreenPal that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ScreenPal** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://screencast-o-matic.com/<InstanceName>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [ScreenPal support team](mailto:support@screencast-o-matic.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up ScreenPal** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ScreenPal SSO

1. In a different web browser window, sign in to your ScreenPal company site as an administrator

1. Select **Authentication** on left navigation and perform the following steps:

    [ ![Screenshot that shows the "Access Page" section.](./media/screencast-tutoriaL/settings.png) ](media/screencast-tutorial/settings.png#lightbox)

    1. Turn on the **SAML Authentication** toggle.

    1. In **Upload IDP Metadata File**, Select Choose File and upload the metadata which you have downloaded previously.

    1. Download the **Metadata XML file** from the **ScreenPal SAML Info**.

    1. Select **Save**.

1. Under **SAML User Access** move the toggle to the **On** position, which forces your users to login via SAML. Once enabled, you see additional settings for setting up communication between ScreenPal and the ADFS identity provider.

1. Download the metadata XML file under **ScreenPal SAML Info** and Under Upload IDP Metadata XML File, Select Choose File to upload the metadata which you have downloaded previously.

### Create ScreenPal test user

In this section, a user called Britta Simon is created in ScreenPal. ScreenPal supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in ScreenPal, a new one is created after authentication. If you need to create a user manually, contact [ScreenPal Client support team](mailto:support@screencast-o-matic.com).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ScreenPal Sign-on URL where you can initiate the login flow. 

* Go to ScreenPal Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ScreenPal tile in the My Apps, this option redirects to ScreenPal Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ScreenPal you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).