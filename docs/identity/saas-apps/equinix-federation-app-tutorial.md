---
title: Configure Equinix Federation App for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Equinix Federation App.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 06/19/2024
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Equinix Federation App so that I can control who has access to Equinix Federation App, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Equinix Federation App for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Equinix Federation App with Microsoft Entra ID. When you integrate Equinix Federation App with Microsoft Entra ID, you can do the following:

* Control in Microsoft Entra ID who has access to Equinix Federation App.
* Enable your users to be automatically signed-in to Equinix Federation App with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Equinix Federation App single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Equinix Federation App supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Equinix Federation App from the gallery

To configure the integration of Equinix Federation App into Microsoft Entra ID, you need to add Equinix Federation App from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Equinix Federation App** in the search box.
1. Select **Equinix Federation App** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-equinix-federation-app'></a>

## Configure and test Microsoft Entra SSO for Equinix Federation App

Configure and test Microsoft Entra SSO with Equinix Federation App using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Equinix Federation App.

To configure and test Microsoft Entra SSO with Equinix Federation App, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Equinix Federation App SSO](#configure-equinix-federation-app-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Equinix Federation App test user](#create-equinix-federation-app-test-user)** - to have a counterpart of B.Simon in Equinix Federation App that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Equinix Federation App** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

	In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<customerprefix>customerportal.equinix.com`

	> [!NOTE]
	> The Sign on URL value isn't real. Update the value with the actual Sign on URL. Contact [Equinix Federation App Client support team](mailto:FederationSupport@equinix.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Equinix Federation App** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Equinix Federation App SSO

To configure Single Sign-On on **Equinix Federation App** side, please follow the [link](https://docs.equinix.com/Content/home.htm).

### Create Equinix Federation App test user

In this section, you create a user called Britta Simon in Equinix Federation App. Work with [Equinix Federation App support team](mailto:FederationSupport@equinix.com) to add the users in the Equinix Federation App platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

Go to Equinix Federation App Sign-on URL directly, and initiate the login flow from there.

 > [!NOTE]
 > If you attempt to test your Azure application by using the **Test this application** link or by selecting the Equinix Federation App tile, it doesn't work, as that's IdP-initiated SSO, which Equinix doesn't support by default.  For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Equinix Federation App you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
