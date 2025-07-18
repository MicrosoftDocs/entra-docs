---
title: Configure S4 - Digitsec for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and S4 - Digitsec.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and S4 - Digitsec so that I can control who has access to S4 - Digitsec, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure S4 - Digitsec for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate S4 - Digitsec with Microsoft Entra ID. When you integrate S4 - Digitsec with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to S4 - Digitsec.
* Enable your users to be automatically signed-in to S4 - Digitsec with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* S4 - Digitsec single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* S4 - Digitsec supports **SP and IDP** initiated SSO.
* S4 - Digitsec supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add S4 - Digitsec from the gallery

To configure the integration of S4 - Digitsec into Microsoft Entra ID, you need to add S4 - Digitsec from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **S4 - Digitsec** in the search box.
1. Select **S4 - Digitsec** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-s4---digitsec'></a>

## Configure and test Microsoft Entra SSO for S4 - Digitsec

Configure and test Microsoft Entra SSO with S4 - Digitsec using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in S4 - Digitsec.

To configure and test Microsoft Entra SSO with S4 - Digitsec, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure S4 - Digitsec SSO](#configure-s4---digitsec-sso)** - to configure the single sign-on settings on application side.
    1. **[Create S4 - Digitsec test user](#create-s4---digitsec-test-user)** - to have a counterpart of B.Simon in S4 - Digitsec that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **S4 - Digitsec** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:
    
    In the **Sign-on URL** text box, type the URL:
    `https://s4.digitsec.com`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up S4 - Digitsec** section, copy the appropriate URL(s) based on your requirement.

    ![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Attributes")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure S4 - Digitsec SSO

To configure single sign-on on S4 - Digitsec side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [S4 - Digitsec support team](mailto:Support@digitsec.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create S4 - Digitsec test user

In this section, a user called B.Simon is created in S4 - Digitsec. S4 - Digitsec supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in S4 - Digitsec, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to S4 - Digitsec Sign on URL where you can initiate the login flow.  

* Go to S4 - Digitsec Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the S4 - Digitsec for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the S4 - Digitsec tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the S4 - Digitsec for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure S4 - Digitsec you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
