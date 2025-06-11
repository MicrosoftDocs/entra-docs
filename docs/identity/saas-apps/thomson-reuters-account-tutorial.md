---
title: Configure Thomson Reuters Account for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Thomson Reuters Account.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 09/03/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Thomson Reuters Account for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Thomson Reuters Account with Microsoft Entra ID. When you integrate Thomson Reuters Account with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Thomson Reuters Account.
* Enable your users to be automatically signed-in to Thomson Reuters Account with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Thomson Reuters Account single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Thomson Reuters Account supports **SP** initiated SSO.

## Add Thomson Reuters Account from the gallery

To configure the integration of Thomson Reuters Account into Microsoft Entra ID, you need to add Thomson Reuters Account from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Thomson Reuters Account** in the search box.
1. Select **Thomson Reuters Account** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Thomson Reuters Account

Configure and test Microsoft Entra SSO with Thomson Reuters Account using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Thomson Reuters Account.

To configure and test Microsoft Entra SSO with Thomson Reuters Account, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Thomson Reuters Account SSO](#configure-thomson-reuters-account-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Thomson Reuters Account test user](#create-thomson-reuters-account-test-user)** - to have a counterpart of B.Simon in Thomson Reuters Account that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Thomson Reuters Account** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. For the **Identifier (Entity ID)** value, configure as follows:
    
    i. In the **Identifier (Entity ID)** select `trtasso.thomson.com`. And if that Identifier (Entity ID) doesn't exist, add that and proceed to step 5.b.

    ii. If the **Identifier (Entity ID)** `trtasso.thomson.com` already exists, select `trtasso.thomson.com_CIAM`. Now edit **Attribute and Claims**, select **Advanced settings** and select edit near **Advanced SAML claims options**. To the pane that appears from the right, enable **Append application ID to issuer**. Now proceed to step 5.b.

    b. In the **Reply URL** text box, type the URL:
    `https://trtasso.thomson.com/sp/ACS.saml2`

1. On the **Set up single sign-on with SAML** page, in the SAML Signing Certificate section, select copy button to copy **App Federation Metadata Url** and while reaching out to the Thomson Reuters Team, share this along with the **Identifier (Entity ID)** that was configured (`trtasso.thomson.com` or `trtasso.thomson.com_CIAM`).

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Thomson Reuters Account SSO

To configure single sign-on on **Thomson Reuters Account** side, you need to send the **App Federation Metadata Url** to [Thomson Reuters Account support team](mailto:customer.sso@thomsonreuters.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Thomson Reuters Account test user

In this section, you create a user called B.Simon in Thomson Reuters Account. Work with [Thomson Reuters Account support team](mailto:customer.sso@thomsonreuters.com) to add the users in the Thomson Reuters Account platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to Thomson Reuters Account Sign-on URL where you can initiate the login flow.
 
* You can use Microsoft My Apps. When you select the Thomson Reuters Account tile in the My Apps, this option redirects to Thomson Reuters Account Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Thomson Reuters Account you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).