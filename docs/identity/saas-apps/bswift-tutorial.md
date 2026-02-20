---
title: Configure bswift for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and bswift.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and bswift so that I can control who has access to bswift, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure bswift for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate bswift with Microsoft Entra ID. When you integrate bswift with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to bswift.
* Enable your users to be automatically signed-in to bswift with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* bswift single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* bswift supports **IDP** initiated SSO.

## Add bswift from the gallery

To configure the integration of bswift into Microsoft Entra ID, you need to add bswift from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **bswift** in the search box.
1. Select **bswift** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for bswift

Configure and test Microsoft Entra SSO with bswift using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in bswift.

To configure and test Microsoft Entra SSO with bswift, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure bswift SSO](#configure-bswift-sso)** - to configure the single sign-on settings on application side.
    1. **[Create bswift test user](#create-bswift-test-user)** - to have a counterpart of B.Simon in bswift that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **bswift** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type one of the following values:

    | Environment | URL |
    |--------------|----|
    | Production| `secure.bswift.com/edge` |
    | Staging | `secure.bswiftsandbox.com` |

    b. In the **Reply URL** text box, type one of the following URLs:

     | Environment | URL |
    |--------------|----|
    | Production| `https://secure.bswift.com/sso/ssologin.aspx` |
    | Staging | `https://secure.bswiftsandbox.com/sso/ssologin.aspx` |

1. bswift application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, bswift application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name   | Source Attribute|
	| --------------- | --------- |
	| workEmail | user.mail |
	| abbrevName  | <company_URL> |
	| clientSSOInboundID  | <custom_ID> |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-a-microsoft-entra-id-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure bswift SSO

To configure single sign-on on **bswift** side, you need to send the **App Federation Metadata Url** to [bswift support team](mailto:bswiftConnectionSupport@bswift.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create bswift test user

In this section, you create a user called B.Simon in bswift. Work with [bswift support team](mailto:bswiftConnectionSupport@bswift.com) to add the users in the bswift platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the bswift for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the bswift tile in the My Apps, you should be automatically signed in to the bswift for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure bswift you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
