---
title: Configure Mapiq for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Mapiq.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Mapiq so that I can control who has access to Mapiq, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Mapiq for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Mapiq with Microsoft Entra ID. When you integrate Mapiq with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Mapiq.
* Enable your users to be automatically signed-in to Mapiq with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Mapiq single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Mapiq supports **SP** initiated SSO.
* Mapiq supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Mapiq from the gallery

To configure the integration of Mapiq into Microsoft Entra ID, you need to add Mapiq from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Mapiq** in the search box.
1. Select **Mapiq** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-mapiq'></a>

## Configure and test Microsoft Entra SSO for Mapiq

Configure and test Microsoft Entra SSO with Mapiq using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Mapiq.

To configure and test Microsoft Entra SSO with Mapiq, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Mapiq SSO](#configure-mapiq-sso)** - to configure the single sign-on settings on application side.
   1. **[Create Mapiq test user](#create-mapiq-test-user)** - to have a counterpart of B.Simon in Mapiq that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Mapiq** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

   a. In the **Reply URL** text box, type the URL:
   `https://mapiqprod.b2clogin.com/mapiqprod.onmicrosoft.com/B2C_1A_TrustFrameworkBase/samlp/sso/assertionconsumer`

   b. In the **Sign-on URL** text box, type the URL:
   `https://app.mapiq.com`

1. Mapiq application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

    ![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Mapiq application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

   | Name | Source Attribute|
   | ------------ | --------- |
   | displayname | user.displayname |
   | department | user.department |
   | businessunit | user.companyname |
   | office | user.officelocation |
   | jobTitle | user.jobtitle |
   | country | user.country  |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Mapiq SSO

To configure single sign-on on **Mapiq** side, you need to send the **App Federation Metadata Url** to [Mapiq support team](mailto:support@mapiq.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Mapiq test user

In this section, a user called B.Simon is created in Mapiq. Mapiq supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Mapiq, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Mapiq Sign-on URL where you can initiate the login flow. 

* Go to Mapiq Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Mapiq tile in the My Apps, this option redirects to Mapiq Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Mapiq you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
