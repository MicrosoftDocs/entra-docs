---
title: Configure ArborXR for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ArborXR.
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ArborXR so that I can control who has access to ArborXR, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ArborXR for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ArborXR with Microsoft Entra ID. When you integrate ArborXR with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ArborXR.
* Enable your users to be automatically signed-in to ArborXR with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ArborXR single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ArborXR supports **SP** initiated SSO.

## Add ArborXR from the gallery

To configure the integration of ArborXR into Microsoft Entra ID, you need to add ArborXR from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ArborXR** in the search box.
1. Select **ArborXR** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for ArborXR

Configure and test Microsoft Entra SSO with ArborXR using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ArborXR.

To configure and test Microsoft Entra SSO with ArborXR, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ArborXR SSO](#configure-arborxr-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ArborXR test user](#create-arborxr-test-user)** - to have a counterpart of B.Simon in ArborXR that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ArborXR** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://api.xrdm.app/auth/realms/<INSTANCE>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://api.xrdm.app/auth/realms/<INSTANCE>/broker/SAML2/endpoint`

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://api.xrdm.app/auth/realms/<INSTANCE>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [ArborXR support team](mailto:support@arborxr.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ArborXR SSO

1. Log in to ArborXR company site as an administrator.

1. Go to **Settings** > **Single Sign-On** > and select **SAML**.

1. In the **Hosted IdP Metadata URL** textbox, paste the **App Federation Metadata Url**, which you have copied from the Microsoft Entra admin center.

    ![Screenshot shows settings of the configuration.](./media/arborxr-tutorial/settings.png "Account")

1. Select **Apply Changes**.

### Create ArborXR test user

1. In a different web browser window, sign into ArborXR website as an administrator.

1. Navigate to **Settings** > **Users** and select **Add Users**.

    ![Screenshot shows how to create users in application.](./media/arborxr-tutorial/create.png "Users")

1. In the **Add Users** section, perform the following steps:

    ![Screenshot shows how to create new users in the page.](./media/arborxr-tutorial/details.png "Creating Users")

    1. Select **Role** from the drop-down.

    1. Enter a valid email address in the **Invite via email** textbox. 

    1. Select **Invite**.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to ArborXR Sign-on URL where you can initiate the login flow.
 
* Go to ArborXR Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the ArborXR tile in the My Apps, this option redirects to ArborXR Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure ArborXR you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).