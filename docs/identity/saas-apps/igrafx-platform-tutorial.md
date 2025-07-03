---
title: Configure iGrafx Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and iGrafx Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and iGrafx Platform so that I can control who has access to iGrafx Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure iGrafx Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate iGrafx Platform with Microsoft Entra ID. When you integrate iGrafx Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to iGrafx Platform.
* Enable your users to be automatically signed-in to iGrafx Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* iGrafx Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* iGrafx Platform supports **SP** initiated SSO.

* iGrafx Platform supports **Just In Time** user provisioning.

## Add iGrafx Platform from the gallery

To configure the integration of iGrafx Platform into Microsoft Entra ID, you need to add iGrafx Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **iGrafx Platform** in the search box.
1. Select **iGrafx Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-igrafx-platform'></a>

## Configure and test Microsoft Entra SSO for iGrafx Platform

Configure and test Microsoft Entra SSO with iGrafx Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in iGrafx Platform.

To configure and test Microsoft Entra SSO with iGrafx Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure iGrafx Platform SSO](#configure-igrafx-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create iGrafx Platform test user](#create-igrafx-platform-test-user)** - to have a counterpart of B.Simon in iGrafx Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **iGrafx Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using one of the following patterns:

    | **Identifier** |
    |--------|
    | `https://<SUBDOMAIN>.igrafxcloud.com/saml/metadata` |
    | `https://<SUBDOMAIN>.igrafxdemo.com/saml/metadata` |
    | `https://<SUBDOMAIN>.igrafxtraining.com/saml/metadata` |
    | `https://<SUBDOMAIN>.igrafx.com/saml/metadata` |

    b.  In the **Reply URL** text box, type a URL using one of the following patterns:

    | **Reply URL** |
    |---------|
    | `https://<SUBDOMAIN>.igrafxcloud.com/` |
    | `https://<SUBDOMAIN>.igrafxdemo.com/` |
    | `https://<SUBDOMAIN>.igrafxtraining.com/` |
    | `https://<SUBDOMAIN>.igrafx.com/` |

	c. In the **Sign on URL** text box, type a URL using one of the following patterns:

    | **Sign on URL** |
    |-------|
    | `https://<SUBDOMAIN>.igrafxcloud.com/` |
    | `https://<SUBDOMAIN>.igrafxdemo.com/` |
    | `https://<SUBDOMAIN>.igrafxtraining.com/` |
    | `https://<SUBDOMAIN>.igrafx.com/` |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [iGrafx Platform Client support team](mailto:support@igrafx.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure iGrafx Platform SSO

To configure single sign-on on **iGrafx Platform** side, you need to send the **App Federation Metadata Url** to [iGrafx Platform support team](mailto:support@igrafx.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create iGrafx Platform test user

In this section, a user called B.Simon is created in iGrafx Platform. iGrafx Platform supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in iGrafx Platform, a new one is created when you attempt to access iGrafx Platform.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to iGrafx Platform Sign-on URL where you can initiate the login flow. 

* Go to iGrafx Platform Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the iGrafx Platform tile in the My Apps, this option redirects to iGrafx Platform Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure iGrafx Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
