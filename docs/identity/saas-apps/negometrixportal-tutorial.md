---
title: Configure NegometrixPortal Single Sign On (SSO) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and NegometrixPortal Single Sign On (SSO).

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and NegometrixPortal Single Sign On (SSO) so that I can control who has access to NegometrixPortal Single Sign On (SSO), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure NegometrixPortal Single Sign On (SSO) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate NegometrixPortal Single Sign On (SSO) with Microsoft Entra ID. When you integrate NegometrixPortal Single Sign On (SSO) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to NegometrixPortal Single Sign On (SSO).
* Enable your users to be automatically signed-in to NegometrixPortal Single Sign On (SSO) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* NegometrixPortal Single Sign On (SSO) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* NegometrixPortal Single Sign On (SSO) supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add NegometrixPortal Single Sign On (SSO) from the gallery

To configure the integration of NegometrixPortal Single Sign On (SSO) into Microsoft Entra ID, you need to add NegometrixPortal Single Sign On (SSO) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **NegometrixPortal Single Sign On (SSO)** in the search box.
1. Select **NegometrixPortal Single Sign On (SSO)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-negometrixportal-single-sign-on-sso'></a>

## Configure and test Microsoft Entra SSO for NegometrixPortal Single Sign On (SSO)

Configure and test Microsoft Entra SSO with NegometrixPortal Single Sign On (SSO) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in NegometrixPortal Single Sign On (SSO).

To configure and test Microsoft Entra SSO with NegometrixPortal Single Sign On (SSO), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure NegometrixPortal Single Sign On (SSO) SSO](#configure-negometrixportal-single-sign-on-sso-sso)** - to configure the single sign-on settings on application side.
    1. **[Create NegometrixPortal Single Sign On (SSO) test user](#create-negometrixportal-single-sign-on-sso-test-user)** - to have a counterpart of B.Simon in NegometrixPortal Single Sign On (SSO) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **NegometrixPortal Single Sign On (SSO)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://portal.negometrix.com/sso/<CUSTOMURL>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [NegometrixPortal Single Sign On (SSO) Client support team](mailto:sander.hoek@negometrix.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. NegometrixPortal Single Sign On (SSO) application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, NegometrixPortal Single Sign On (SSO) application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute|
	| ---------------|  --------- |
	| upn | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure NegometrixPortal Single Sign On (SSO) SSO

To configure single sign-on on **NegometrixPortal Single Sign On (SSO)** side, you need to send the **App Federation Metadata Url** to [NegometrixPortal Single Sign On (SSO) support team](mailto:sander.hoek@negometrix.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create NegometrixPortal Single Sign On (SSO) test user

In this section, you create a user called B.Simon in NegometrixPortal Single Sign On (SSO). Work with [NegometrixPortal Single Sign On (SSO) support team](mailto:sander.hoek@negometrix.com) to add the users in the NegometrixPortal Single Sign On (SSO) platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to NegometrixPortal Single Sign On (SSO) Sign-on URL where you can initiate the login flow. 

* Go to NegometrixPortal Single Sign On (SSO) Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the NegometrixPortal Single Sign On (SSO) tile in the My Apps, this option redirects to NegometrixPortal Single Sign On (SSO) Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure NegometrixPortal Single Sign On (SSO) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
