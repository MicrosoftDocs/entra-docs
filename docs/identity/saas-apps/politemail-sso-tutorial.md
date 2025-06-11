---
title: Configure PoliteMail - SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and PoliteMail - SSO.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 06/11/2024
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and PoliteMail - SSO so that I can control who has access to PoliteMail - SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure PoliteMail - SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate PoliteMail - SSO with Microsoft Entra ID. When you integrate PoliteMail - SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to PoliteMail - SSO.
* Enable your users to be automatically signed-in to PoliteMail - SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* PoliteMail - SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* PoliteMail - SSO supports **SP** initiated SSO.
* PoliteMail - SSO supports **Just In Time** user provisioning.

## Add PoliteMail - SSO from the gallery

To configure the integration of PoliteMail - SSO into Microsoft Entra ID, you need to add PoliteMail - SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **PoliteMail - SSO** in the search box.
1. Select **PoliteMail - SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for PoliteMail - SSO

Configure and test Microsoft Entra SSO with PoliteMail - SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in PoliteMail - SSO.

To configure and test Microsoft Entra SSO with PoliteMail - SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure PoliteMail - SSO](#configure-politemail---sso)** - to configure the single sign-on settings on application side.
    1. **[Create PoliteMail - SSO test user](#create-politemail---sso-test-user)** - to have a counterpart of B.Simon in PoliteMail - SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **PoliteMail - SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<YOUR_POLITEMAIL_HOSTNAME>`

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | **Reply URL** |
    |----------------|
    | `https://<YOUR_POLITEMAIL_HOSTNAME>/api/Saml2/Acs` |
    | `https://<YOUR_POLITEMAIL_HOSTNAME>/ssv3/Saml2/Acs` |

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<YOUR_POLITEMAIL_HOSTNAME>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on url. Contact [PoliteMail - SSO support team](mailto:serversupport@politemail.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. PoliteMail - SSO application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, PoliteMail - SSO application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |   Source Attribute|
	| ---- | --------- |
	| role | user.assignedroles |

    > [!NOTE]
    > Please select [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui) to know how to configure Role in Microsoft Entra ID.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Screenshot shows to edit SAML Signing Certificate.](common/edit-certificate.png "Certificate")

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Screenshot shows to copy Thumbprint value](common/copy-thumbprint.png "Thumbprint")

1. On the **Set up PoliteMail - SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure PoliteMail - SSO

To configure single sign-on on **PoliteMail - SSO** side, you need to send the **Thumbprint Value** and appropriate copied URLs from Microsoft Entra admin center to [PoliteMail - SSO support team](mailto:serversupport@politemail.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create PoliteMail - SSO test user

In this section, a user called B.Simon is created in PoliteMail - SSO. PoliteMail - SSO supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in PoliteMail - SSO, a new one is created when you attempt to access PoliteMail - SSO.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to PoliteMail - SSO Sign-on URL where you can initiate the login flow.
 
* Go to PoliteMail - SSO Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the PoliteMail - SSO tile in the My Apps, this option redirects to PoliteMail - SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure PoliteMail - SSO you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).