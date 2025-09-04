---
title: Configure Mosaic Project Operations for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Mosaic Project Operations.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Mosaic Project Operations so that I can control who has access to Mosaic Project Operations, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Mosaic Project Operations for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Mosaic Project Operations with Microsoft Entra ID. When you integrate Mosaic Project Operations with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Mosaic Project Operations.
* Enable your users to be automatically signed-in to Mosaic Project Operations with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Mosaic Project Operations single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Mosaic Project Operations supports **SP** initiated SSO.

## Adding Mosaic Project Operations from the gallery

To configure the integration of Mosaic Project Operations into Microsoft Entra ID, you need to add Mosaic Project Operations from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Mosaic Project Operations** in the search box.
1. Select **Mosaic Project Operations** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Mosaic Project Operations

Configure and test Microsoft Entra SSO with Mosaic Project Operations using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Mosaic Project Operations.

To configure and test Microsoft Entra SSO with Mosaic Project Operations, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Mosaic Project Operations SSO](#configure-mosaic-project-operations-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Mosaic Project Operations test user](#create-mosaic-project-operations-test-user)** - to have a counterpart of B.Simon in Mosaic Project Operations that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Mosaic Project Operations** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using one of the following patterns:

    | **Identifier** |
    |---------|
    | `https://auth.us-east-1.party.mosaicapp.com/<UUID>` |
    | `https://auth.us-east-1.<ENVIRONMENT>.mosaicapp.com/<UUID>` |

    b. In the **Reply URL** textbox, type a URL using one of the following patterns:

    | **Reply URL** |
    |---------|
    | `https://auth.us-east-1.party.mosaicapp.com/auth/saml/callback/<UUID>` |
    | `https://auth.us-east-1.<ENVIRONMENT>.mosaicapp.com/auth/saml/callback/<UUID>` |

    c. In the **Sign on URL** textbox, type the URL:
    `https://login.mosaicapp.com/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Mosaic Project Operations support team](mailto:support@mosaicapp.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Mosaic Project Operations** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Mosaic Project Operations SSO

To configure single sign-on on **Mosaic Project Operations** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Mosaic Project Operations support team](mailto:support@mosaicapp.com). They set this setting to have the SAML SSO connection set properly on both sides. For more information, please refer [this](https://readme.mosaicapp.com/docs/microsoft-azure-saml) link.

### Create Mosaic Project Operations test user

In this section, you create a user called B.Simon in Mosaic Project Operations. Work with [Mosaic Project Operations support team](mailto:support@mosaicapp.com) to add the users in the Mosaic Project Operations platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application** in Microsoft Entra admin center. this option redirects to Mosaic Project Operations Sign-on URL where you can initiate the login flow.

* Go to Mosaic Project Operations Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Mosaic Project Operations tile in the My Apps, this option redirects to Mosaic Project Operations Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Mosaic Project Operations you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
