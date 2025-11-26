---
title: Configure Box for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Box.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Box so that I can control who has access to Box, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Box for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Box with Microsoft Entra ID. When you integrate Box with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Box.
* Enable your users to be automatically signed-in to Box with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Box single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Box supports **SP** initiated SSO
* Box supports [**Automated** user provisioning and deprovisioning](./box-userprovisioning-tutorial.md) (recommended)
* Box supports **Just In Time** user provisioning

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Box from the gallery

To configure the integration of Box into Microsoft Entra ID, you need to add Box from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Box** in the search box.
1. Select **Box** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-box'></a>

## Configure and test Microsoft Entra SSO for Box

Configure and test Microsoft Entra SSO with Box using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Box.

To configure and test Microsoft Entra SSO with Box, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Box SSO](#configure-box-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Box test user](#create-box-test-user)** - to have a counterpart of B.Simon in Box that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Box** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.account.box.com`

    b. In the **Identifier (Entity ID)** text box, type a URL:
    `box.net`

    c. In the **Reply URL** text box, type the URL:
    `https://sso.services.box.net/sp/ACS.saml2`

	> [!NOTE]
	> The Sign-on URL value isn't real. Update the value with the actual Sign-On URL. Contact [Box Client support team](https://support.box.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Box application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Box expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)


1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Box SSO

1. In a different web browser window, sign in to your Box company site as an administrator and follow the procedure in [Set up SSO on your own](https://support.box.com).

> [!NOTE]
> If you're unable to configure the SSO settings for your Box account, you need to send the downloaded **Federation Metadata XML** to [Box support team](https://support.box.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Box test user

In this section, a user called Britta Simon is created in Box. Box supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Box, a new one is created after authentication.

> [!NOTE]
> If you need to create a user manually, contact [Box support team](https://support.box.com).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**. You're redirected to the Box Sign-on URL, where you can initiate the login flow.

* Go to Box Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Box tile in the My Apps, this option redirects to Box Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

### Push an Azure group to Box

You can push an Azure group to Box and sync that group. Azure pushes groups to Box via an API-level integration.

1. In **Users & Groups**, search for the group you want to assign to Box.
1. In **Provisioning**, ensure that **Synchronize Microsoft Entra groups to Box** is selected. This setting syncs the groups that you allocated in the preceding step. It might take some time for these groups to be pushed from Azure.

> [!NOTE]
> If you need to create a user manually, contact [Box support team](https://support.box.com).

## Related content

Once you configure Box you can enforce Session Control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session Control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
