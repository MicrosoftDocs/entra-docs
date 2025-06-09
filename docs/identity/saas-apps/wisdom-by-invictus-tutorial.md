---
title: Configure Wisdom by Invictus for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Wisdom by Invictus.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Wisdom by Invictus so that I can control who has access to Wisdom by Invictus, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Wisdom by Invictus for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Wisdom by Invictus with Microsoft Entra ID. When you integrate Wisdom by Invictus with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Wisdom by Invictus.
* Enable your users to be automatically signed-in to Wisdom by Invictus with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Wisdom by Invictus single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Wisdom by Invictus supports **SP and IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Wisdom by Invictus from the gallery

To configure the integration of Wisdom by Invictus into Microsoft Entra ID, you need to add Wisdom by Invictus from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Wisdom by Invictus** in the search box.
1. Select **Wisdom by Invictus** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-wisdom-by-invictus'></a>

## Configure and test Microsoft Entra SSO for Wisdom by Invictus

Configure and test Microsoft Entra SSO with Wisdom by Invictus using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Wisdom by Invictus.

To configure and test Microsoft Entra SSO with Wisdom by Invictus, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Wisdom by Invictus SSO](#configure-wisdom-by-invictus-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Wisdom by Invictus test user](#create-wisdom-by-invictus-test-user)** - to have a counterpart of B.Simon in Wisdom by Invictus that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Wisdom by Invictus** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://invictuselearning-pool7.com/?option=saml_user_login&idp=Microsoft`

1. Select **Save**.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Wisdom by Invictus SSO

To configure single sign-on on **Wisdom by Invictus** side, you need to send the **App Federation Metadata Url** to [Wisdom by Invictus support team](mailto:support@invictus.in). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Wisdom by Invictus test user

In this section, you create a user called Britta Simon in Wisdom by Invictus. Work with [Wisdom by Invictus support team](mailto:support@invictus.in) to add the users in the Wisdom by Invictus platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Wisdom by Invictus Sign-On URL where you can initiate the login flow.  

* Go to Wisdom by Invictus Sign-On URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Wisdom by Invictus for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Wisdom by Invictus tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Wisdom by Invictus for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Wisdom by Invictus you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
