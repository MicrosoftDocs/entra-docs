---
title: Configure X-point Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and X-point Cloud.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and X-point Cloud so that I can control who has access to X-point Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure X-point Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate X-point Cloud with Microsoft Entra ID. When you integrate X-point Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to X-point Cloud.
* Enable your users to be automatically signed-in to X-point Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* X-point Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* X-point Cloud supports **SP** initiated SSO.

## Add X-point Cloud from the gallery

To configure the integration of X-point Cloud into Microsoft Entra ID, you need to add X-point Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **X-point Cloud** in the search box.
1. Select **X-point Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-x-point-cloud'></a>

## Configure and test Microsoft Entra SSO for X-point Cloud

Configure and test Microsoft Entra SSO with X-point Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in X-point Cloud.

To configure and test Microsoft Entra SSO with X-point Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure X-point Cloud SSO](#configure-x-point-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create X-point Cloud test user](#create-x-point-cloud-test-user)** - to have a counterpart of B.Simon in X-point Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **X-point Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.atledcloud.jp`

    b. In the **Reply URL (Assertion Consumer Service URL)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.atledcloud.jp/xpoint/saml/acs`

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.atledcloud.jp/xpoint`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Please match the `<SUBDOMAIN>` part of `https://<SUBDOMAIN>.atledcloud.jp` with the URL of the X-point you're using. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

1. On the **Set up X-point Cloud** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure X-point Cloud SSO

To configure single sign-on on the X-point Cloud side, you can use the downloaded **Certificate (Raw)** and the **Login URL** copied into the **SAML service settings** in the X-point Cloud domain management menu. Set to Certificate of public key used by IdP to sign and SSO endpoint URL for IdP.

### Create X-point Cloud test user

In this section, you can use the **email addresses** of users registered with Microsoft Entra ID in X-point Cloud.
Create a user who has removed @ and beyond.
For example "username@companydomain.extension", add "username" to X-point Cloud, Before you can use single sign-on, you must create and enable users.


## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to X-point Cloud Sign-on URL where you can initiate the login flow. 

* Go to X-point Cloud Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the X-point Cloud tile in the My Apps, this option redirects to X-point Cloud Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure X-point Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
