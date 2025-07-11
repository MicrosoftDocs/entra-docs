---
title: Configure RocketReach SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and RocketReach SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RocketReach SSO so that I can control who has access to RocketReach SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure RocketReach SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate RocketReach SSO with Microsoft Entra ID. When you integrate RocketReach SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RocketReach SSO.
* Enable your users to be automatically signed-in to RocketReach SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* RocketReach SSO single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* RocketReach SSO supports **SP** and **IDP** initiated SSO.
* RocketReach SSO supports **Just In Time** user provisioning.

## Add RocketReach SSO from the gallery

To configure the integration of RocketReach SSO into Microsoft Entra ID, you need to add RocketReach SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RocketReach SSO** in the search box.
1. Select **RocketReach SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-rocketreach-sso'></a>

## Configure and test Microsoft Entra SSO for RocketReach SSO

Configure and test Microsoft Entra SSO with RocketReach SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user at RocketReach SSO.

To configure and test Microsoft Entra SSO with RocketReach SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RocketReach SSO](#configure-rocketreach-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RocketReach SSO test user](#create-rocketreach-sso-test-user)** - to have a counterpart of B.Simon in RocketReach SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **RocketReach SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://rocketreach.co/login/sso`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up RocketReach SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure RocketReach SSO

To configure single sign-on on **RocketReach SSO** side, you must follow the below steps:

1. Login to RocketReach.co as a Team Owner or Team Administrator.
2. Proceed to the **Account Settings** > **Security** section and select the **Setup SSO** button.
3. Choose **Azure** in the sidebar menu.
4. Copy the URLs from the Microsoft Entra platform into the **Login URL** and **Azure AD Identifier** fields.
5. Past the contents of the **Certificate (Base64)** file from Microsoft Entra into the **Key x509 Certificate field.
6. Test the SAML connection and save your changes.

### Create RocketReach SSO test user

In this section, a user called B.Simon is created in RocketReach SSO. RocketReach SSO supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user already exists with this email address, they must be assigned to the correct team in RocketReach. If a user doesn't already exist in RocketReach, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to RocketReach SSO Sign-on URL where you can initiate the login flow.  

* Go to RocketReach SSO Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the RocketReach SSO for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the RocketReach SSO tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the RocketReach SSO for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure RocketReach SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
