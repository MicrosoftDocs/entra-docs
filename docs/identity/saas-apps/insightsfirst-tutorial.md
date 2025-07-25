---
title: Configure Insightsfirst for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Insightsfirst.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Insightsfirst so that I can control who has access to Insightsfirst, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Insightsfirst for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Insightsfirst with Microsoft Entra ID. When you integrate Insightsfirst with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Insightsfirst.
* Enable your users to be automatically signed-in to Insightsfirst with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Insightsfirst single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Insightsfirst supports **SP** initiated SSO.
* Insightsfirst supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Insightsfirst from the gallery

To configure the integration of Insightsfirst into Microsoft Entra ID, you need to add Insightsfirst from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Insightsfirst** in the search box.
1. Select **Insightsfirst** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)].

## Configure and test Microsoft Entra SSO for Insightsfirst

Configure and test Microsoft Entra SSO with Insightsfirst using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Insightsfirst.

To configure and test Microsoft Entra SSO with Insightsfirst, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Insightsfirst SSO](#configure-insightsfirst-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Insightsfirst test user](#create-insightsfirst-test-user)** - to have a counterpart of B.Simon in Insightsfirst that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Insightsfirst** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type one of the following URLs:

    | **Identifier** |
    |------------|
    | `https://insightsfirst-implementation.evalueserve.com` |
    | `https://insightsfirst.evalueserve.com/` |

    b. In the **Reply URL** textbox, type one of the following URLs:

    | **Reply URL** |
    |------------|
    | `https://insightsfirst-implementation.evalueserve.com/InsightFirstSSO/api/Assertion/ConsumerService` |
    | `https://insightsfirst.evalueserve.com/InsightFirstSSO/api/Assertion/ConsumerService` |

	c. In the **Sign on URL** textbox, type one of the following URLs:

	| **Sign on URL** |
    |------------|
    | `https://insightsfirst.evalueserve.com/Microsoft` |
    | `https://insightsfirst-implementation.evalueserve.com/Microsoft` |

1. Insightsfirst application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Insightsfirst application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| ---------------|  --------- |
	| Email | user.mail |

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Screenshot shows to Edit SAML Signing Certificate.](common/edit-certificate.png "Certificate")

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Screenshot shows to Copy Thumbprint value.](common/copy-thumbprint.png "Thumbprint")

1. On the **Set up Insightsfirst** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Insightsfirst SSO

To configure single sign-on on **Insightsfirst** side, you need to send the **Thumbprint Value** and appropriate copied URLs from Microsoft Entra admin center to [Insightsfirst support team](mailto:insightsfirst.support@evalueserve.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Insightsfirst test user

In this section, a user called Britta Simon is created in Insightsfirst. Insightsfirst supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Insightsfirst, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Insightsfirst Sign-on URL where you can initiate the login flow.
 
* Go to Insightsfirst Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the Insightsfirst tile in the My Apps, this option redirects to Insightsfirst Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Insightsfirst you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).