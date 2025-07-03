---
title: Configure WAN-Sign for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and WAN-Sign.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and WAN-Sign so that I can control who has access to WAN-Sign, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure WAN-Sign for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate WAN-Sign with Microsoft Entra ID. When you integrate WAN-Sign with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to WAN-Sign.
* Enable your users to be automatically signed-in to WAN-Sign with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* WAN-Sign single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* WAN-Sign supports both **SP** and **IDP** initiated SSO.

## Add WAN-Sign from the gallery

To configure the integration of WAN-Sign into Microsoft Entra ID, you need to add WAN-Sign from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **WAN-Sign** in the search box.
1. Select **WAN-Sign** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-wan-sign'></a>

## Configure and test Microsoft Entra SSO for WAN-Sign

Configure and test Microsoft Entra SSO with WAN-Sign using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in WAN-Sign.

To configure and test Microsoft Entra SSO with WAN-Sign, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure WAN-Sign SSO](#configure-wan-sign-sso)** - to configure the single sign-on settings on application side.
    1. **[Create WAN-Sign test user](#create-wan-sign-test-user)** - to have a counterpart of B.Simon in WAN-Sign that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **WAN-Sign** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://service10.wanbishi.ne.jp/saml/metadata/azuread/<CustomerID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://service10.wanbishi.ne.jp/saml/azuread/<CustomerID>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in SP initiated mode:

    In the **Sign on URL** textbox, type a URL using the following pattern:
    `https://service10.wanbishi.ne.jp/saml/login/azuread/<CustomerID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [WAN-Sign Client support team](mailto:wansign-help@wanbishi.ne.jp) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up WAN-Sign** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure WAN-Sign SSO

To configure single sign-on on **WAN-Sign** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [WAN-Sign support team](mailto:wansign-help@wanbishi.ne.jp). They set this setting to have the SAML SSO connection set properly on both sides.

### Create WAN-Sign test user

In this section, you create a user called Britta Simon in WAN-Sign. Work with [WAN-Sign support team](mailto:wansign-help@wanbishi.ne.jp) to add the users in the WAN-Sign platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to WAN-Sign Sign on URL where you can initiate the login flow.  

* Go to WAN-Sign Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the WAN-Sign for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the WAN-Sign tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the WAN-Sign for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure WAN-Sign you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
