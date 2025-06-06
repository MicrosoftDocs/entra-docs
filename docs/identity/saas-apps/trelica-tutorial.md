---
title: Configure Trelica for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Trelica.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Trelica so that I can control who has access to Trelica, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Trelica for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Trelica with Microsoft Entra ID. When you integrate Trelica with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Trelica.
* Enable your users to be automatically signed in to Trelica with their Microsoft Entra accounts.
* Manage your accounts in one central location: the Azure portal.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Trelica subscription with single sign-on (SSO) enabled.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Trelica supports IDP-initiated SSO.
* Trelica supports just-in-time user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Trelica from the gallery

To configure the integration of Trelica into Microsoft Entra ID, you need to add Trelica from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, enter **Trelica** in the search box.
1. Select **Trelica** from the search results, and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-trelica'></a>

## Configure and test Microsoft Entra SSO for Trelica

Configure and test Microsoft Entra SSO with Trelica by using a test user called **B.Simon**. For SSO to work, you must establish a linked relationship between a Microsoft Entra user and the related user in Trelica.

To configure and test Microsoft Entra SSO with Trelica, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Trelica SSO](#configure-trelica-sso)** to configure the single sign-on settings on the application side.
    1. **[Create a Trelica test user](#create-a-trelica-test-user)** to have a counterpart of B.Simon in Trelica. This counterpart is linked to the Microsoft Entra representation of the user.
1. **[Test SSO](#test-sso)** to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Azure portal:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Trelica** application integration page, go to the **Manage** section. Select **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![The Set up Single Sign-On with SAML page, with the pencil icon for Basic SAML Configuration highlighted](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    1. In the **Identifier** box, type the URL:
    `https://app.trelica.com`.

    1. In the **Reply URL** box, type a URL using the following pattern:
    `https://app.trelica.com/Id/Saml2/<CUSTOM_IDENTIFIER>/Acs`.

	> [!NOTE]
	> The Reply URL value isn't real. Update this value with the actual Reply URL (also known as the ACS).
    > You can find this by logging in to Trelica and going to the [SAML identity providers configuration page](https://app.trelica.com/Admin/Profile/SAML) (Admin > Account > SAML). Select the copy button next to the **Assertion Consumer Service (ACS) URL** to put this onto the clipboard, ready for pasting into the **Reply URL** text box in Microsoft Entra ID.
    > Read the [Trelica help documentation](https://docs.trelica.com/admin/saml/azure-ad) or contact the [Trelica Client support team](mailto:support@trelica.com) if you have questions.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select the copy button to copy **App Federation Metadata Url** and save it on your computer.

    ![The SAML Signing Certificate section, with the copy button highlighted next to App Federation Metadata URL](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Trelica SSO

To configure single sign-on on the **Trelica** side, go to the [SAML identity providers configuration page](https://app.trelica.com/Admin/Profile/SAML) (Admin > Account > SAML). Select the **New** button. Enter **Microsoft Entra ID** as the Name and choose **Metadata from url** for the Metadata type. Paste the **App Federation Metadata Url** you took from Microsoft Entra ID into the **Metadata url** field in Trelica.

Read the [Trelica help documentation](https://docs.trelica.com/admin/saml/azure-ad) or contact the [Trelica Client support team](mailto:support@trelica.com) if you have questions.

### Create a Trelica test user

Trelica supports just-in-time user provisioning, which is enabled by default. There's no action for you to take in this section. If a user doesn't already exist in Trelica, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Trelica for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Trelica tile in the My Apps, you should be automatically signed in to the Trelica for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Trelica you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
