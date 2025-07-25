---
title: Configure Mobile Xpense for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Mobile Xpense.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Mobile Xpense so that I can control who has access to Mobile Xpense, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Mobile Xpense for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Mobile Xpense with Microsoft Entra ID. When you integrate Mobile Xpense with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Mobile Xpense.
* Enable your users to be automatically signed-in to Mobile Xpense with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Mobile Xpense single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Mobile Xpense supports **SP** and **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Mobile Xpense from the gallery

To configure the integration of Mobile Xpense into Microsoft Entra ID, you need to add Mobile Xpense from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Mobile Xpense** in the search box.
1. Select **Mobile Xpense** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-mobile-xpense'></a>

## Configure and test Microsoft Entra SSO for Mobile Xpense

Configure and test Microsoft Entra SSO with Mobile Xpense using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Mobile Xpense.

To configure and test Microsoft Entra SSO with Mobile Xpense, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Mobile Xpense SSO](#configure-mobile-xpense-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Mobile Xpense test user](#create-mobile-xpense-test-user)** - to have a counterpart of B.Simon in Mobile Xpense that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Mobile Xpense** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://mobilexpense.com/ServiceProvider`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<subdomain>.mobilexpense.com/NET/SSO/SAML20/SAML/AssertionConsumerService.aspx`

1. Select **Set additional URLs** and perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<sub-domain>.mobilexpense.com/<customername>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Reply URL and Sign-on URL. Contact [Mobile Xpense Client support team](https://www.mobilexpense.com/contact) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Mobile Xpense** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Mobile Xpense SSO

To configure single sign-on on **Mobile Xpense** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Mobile Xpense support team](https://www.mobilexpense.com/contact). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Mobile Xpense test user

In this section, you create a user called Britta Simon in Mobile Xpense. Work with [Mobile Xpense support team](https://www.mobilexpense.com/contact) to add the users in the Mobile Xpense platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Mobile Xpense Sign-On URL where you can initiate the login flow.  

* Go to Mobile Xpense Sign-On URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Mobile Xpense for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Mobile Xpense tile in the My Apps, if configured in SP mode you would be redirected to the application Sign-On page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Mobile Xpense for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Mobile Xpense you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
