---
title: Configure Virtual Risk Manager - USA for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Virtual Risk Manager - USA.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Virtual Risk Manager - USA so that I can control who has access to Virtual Risk Manager - USA, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Virtual Risk Manager - USA for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Virtual Risk Manager - USA with Microsoft Entra ID. When you integrate Virtual Risk Manager - USA with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Virtual Risk Manager - USA.
* Enable your users to be automatically signed-in to Virtual Risk Manager - USA with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Virtual Risk Manager - USA single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Virtual Risk Manager - USA supports **IDP** initiated SSO.

* Virtual Risk Manager - USA supports **Just In Time** user provisioning.

## Add Virtual Risk Manager - USA from the gallery

To configure the integration of Virtual Risk Manager - USA into Microsoft Entra ID, you need to add Virtual Risk Manager - USA from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Virtual Risk Manager - USA** in the search box.
1. Select **Virtual Risk Manager - USA** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-virtual-risk-manager---usa'></a>

## Configure and test Microsoft Entra SSO for Virtual Risk Manager - USA

Configure and test Microsoft Entra SSO with Virtual Risk Manager - USA using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Virtual Risk Manager - USA.

To configure and test Microsoft Entra SSO with Virtual Risk Manager - USA, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Virtual Risk Manager - USA SSO](#configure-virtual-risk-manager---usa-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Virtual Risk Manager - USA test user](#create-virtual-risk-manager---usa-test-user)** - to have a counterpart of B.Simon in Virtual Risk Manager - USA that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Virtual Risk Manager - USA** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Virtual Risk Manager - USA SSO

To configure single sign-on on **Virtual Risk Manager - USA** side, you need to send the **App Federation Metadata Url** to [Virtual Risk Manager - USA support team](mailto:globalsupport@edriving.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Virtual Risk Manager - USA test user

In this section, a user called Britta Simon is created in Virtual Risk Manager - USA. Virtual Risk Manager - USA supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Virtual Risk Manager - USA, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Virtual Risk Manager - USA for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Virtual Risk Manager - USA tile in the My Apps, you should be automatically signed in to the Virtual Risk Manager - USA for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Virtual Risk Manager - USA you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
