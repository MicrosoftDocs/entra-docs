---
title: Configure Continuity Control for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Continuity Control.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Control so that I can control who has access to Control, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Continuity Control for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Continuity Control (Control) with Microsoft Entra ID. When you integrate Control with Microsoft Entra ID, you can:

* Manage in Microsoft Entra ID who has access to Control.
* Enable your users to be automatically signed-in to Control with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Control single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Control supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Control from the gallery

To configure the integration of Control into Microsoft Entra ID, you need to add Control from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Control** in the search box.
1. Select **Control** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-control'></a>

## Configure and test Microsoft Entra SSO for Control

Configure and test Microsoft Entra SSO with Control using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Control.

To configure and test Microsoft Entra SSO with Control, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Control SSO](#configure-control-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Control test user](#create-control-test-user)** - to have a counterpart of B.Simon in Control that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Control** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following step:

	In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.continuity.net/auth/saml`

	> [!Note]
	> The value isn't real. Update the value with the correct subdomain. Your SSO subdomain can be configured at [Control Authentication Strategies](https://control.continuity.net/settings/account_profile#tab/security). You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Edit SAML Signing Certificate](common/edit-certificate.png)

1. In the **SAML Signing Certificate** section, copy the **Thumbprint** and save it on your computer.

    ![Copy Thumbprint value](common/copy-thumbprint.png)

1. On the **Set up Control** section, copy the Login URL and save it on your computer.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Control SSO

To configure single sign-on on the **Control** side, you need to update the single sign-on authentication settings at [Control Authentication Strategies](https://control.continuity.net/settings/account_profile#tab/security). Update **SAML SSO URL** with the **Login URL** and **Certificate Fingerprint** with the **Thumbprint value**.

### Create Control test user

In this section, you create a user called Britta Simon in Control. Work with [Control support team](mailto:help@continuity.net) to add the users in the Control platform. Use Britta Simon's Microsoft Entra ID **User name** to populate her **Identity Provider User ID** in Control. Users must be created, and their **Identity Provider User ID** set, in Control before they can use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Control Sign-on URL where you can initiate the login flow. 

* Go to Control Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Control tile in the My Apps, this option redirects to Control Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Control you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
