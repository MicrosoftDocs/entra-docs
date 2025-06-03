---
title: Configure workhub for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and workhub.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and workhub so that I can control who has access to workhub, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure workhub for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate workhub with Microsoft Entra ID. When you integrate workhub with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to workhub.
* Enable your users to be automatically signed-in to workhub with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* workhub single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* workhub supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add workhub from the gallery

To configure the integration of workhub into Microsoft Entra ID, you need to add workhub from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **workhub** in the search box.
1. Select **workhub** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-workhub'></a>

## Configure and test Microsoft Entra SSO for workhub

Configure and test Microsoft Entra SSO with workhub using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user at workhub.

To configure and test Microsoft Entra SSO with workhub, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure workhub SSO](#configure-workhub-sso)** - to configure the single sign-on settings on application side.
    1. **[Create workhub test user](#create-workhub-test-user)** - to have a counterpart of B.Simon in workhub linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **workhub** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows how to edit basic SAML Configuration.](common/edit-urls.png "Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type the URL:
    `https://ainz-okal-gown.firebaseapp.com/__/auth/handler`

    b. In the **Reply URL** textbox, type the URL:
    `https://ainz-okal-gown.firebaseapp.com/__/auth/handler`

    c. In the **Sign-on URL** text box, type the URL:
    `https://admin.workhub.site/sso`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up workhub** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure workhub SSO

To configure single sign-on on **workhub** side, you need to send the downloaded **Certificate (Base64)**, and appropriate copied URLs from the application configuration to [workhub support team](mailto:support_work@bitkey.jp). They set this setting to have the SAML SSO connection set properly on both sides.

### Create workhub test user

In this section, you create a user called Britta Simon at workhub. Work with [workhub support team](mailto:support_work@bitkey.jp) to add the users in the workhub platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to workhub Sign-on URL where you can initiate the sign-in flow. 

* Go to workhub Sign-on URL directly and initiate the sign-in flow from there.

* You can use Microsoft My Apps. When you select the workhub tile in the My Apps, this option redirects to workhub Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure workhub you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
