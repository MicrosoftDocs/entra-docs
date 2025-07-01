---
title: Configure SynchroNet CLICK for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SynchroNet CLICK.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SynchroNet CLICK so that I can control who has access to SynchroNet CLICK, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SynchroNet CLICK for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SynchroNet CLICK with Microsoft Entra ID. When you integrate SynchroNet CLICK with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SynchroNet CLICK.
* Enable your users to be automatically signed-in to SynchroNet CLICK with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SynchroNet CLICK single sign-on (SSO) enabled subscription.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* SynchroNet CLICK supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add SynchroNet CLICK from the gallery

To configure the integration of SynchroNet CLICK into Microsoft Entra ID, you need to add SynchroNet CLICK from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SynchroNet CLICK** in the search box.
1. Select **SynchroNet CLICK** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-synchronet-select'></a>

## Configure and test Microsoft Entra SSO for SynchroNet CLICK

Configure and test Microsoft Entra SSO with SynchroNet CLICK using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SynchroNet CLICK.

To configure and test Microsoft Entra SSO with SynchroNet CLICK, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SynchroNet CLICK SSO](#configure-synchronet-click-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SynchroNet CLICK test user](#create-synchronet-click-test-user)** - to have a counterpart of B.Simon in SynchroNet CLICK that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SynchroNet CLICK** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

	In the **Sign on URL** text box, type the URL:
    `https://select.synchronet.com`

1. SynchroNet CLICK application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **emailaddress** is mapped with **user.mail**. SynchroNet CLICK application expects **emailaddress** to be mapped with **user.userprincipalname**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SynchroNet CLICK SSO

To configure single sign-on on **SynchroNet CLICK** side, you need to send the **App Federation Metadata Url** to [SynchroNet CLICK support team](mailto:tickets@synchronet.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SynchroNet CLICK test user

In this section, you create a user called Britta Simon in SynchroNet CLICK. Work with [SynchroNet CLICK support team](mailto:tickets@synchronet.com) to add the users in the SynchroNet CLICK platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to SynchroNet CLICK Sign-on URL where you can initiate the login flow. 

* Go to SynchroNet CLICK Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the SynchroNet CLICK tile in the My Apps, this option redirects to SynchroNet CLICK Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure SynchroNet CLICK you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
