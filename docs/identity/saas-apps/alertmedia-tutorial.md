---
title: Configure AlertMedia for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and AlertMedia.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and AlertMedia so that I can control who has access to AlertMedia, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure AlertMedia for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate AlertMedia with Microsoft Entra ID. When you integrate AlertMedia with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to AlertMedia.
* Enable your users to be automatically signed-in to AlertMedia with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* AlertMedia single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* AlertMedia supports **IDP** initiated SSO.
* AlertMedia supports **Just In Time** user provisioning.
* AlertMedia supports [Automated user provisioning](alertmedia-provisioning-tutorial.md).

## Add AlertMedia from the gallery

To configure the integration of AlertMedia into Microsoft Entra ID, you need to add AlertMedia from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **AlertMedia** in the search box.
1. Select **AlertMedia** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-alertmedia'></a>

## Configure and test Microsoft Entra SSO for AlertMedia

Configure and test Microsoft Entra SSO with AlertMedia using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in AlertMedia.

To configure and test Microsoft Entra SSO with AlertMedia, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure AlertMedia SSO](#configure-alertmedia-sso)** - to configure the single sign-on settings on application side.
    1. **[Create AlertMedia test user](#create-alertmedia-test-user)** - to have a counterpart of B.Simon in AlertMedia that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **AlertMedia** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.alertmedia.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.alertmedia.com/api/sso/saml/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [AlertMedia Client support team](mailto:support@alertmedia.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. AlertMedia application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, AlertMedia application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

| Name | Source Attribute|
| ---- | --------------- |
| email | user.userprincipalname |
| firstname | user.givenname |
| lastname | user.surname |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure AlertMedia SSO

1. In a new web browser window, sign in to your AlertMedia company site as an administrator.
1. Navigate to **Company** and select **Single Sign-On**.

    ![The Account button](./media/alertmedia-tutorial/account.png)

1. In the **Authentication Method**, select **Remote SAML Metadata**.
1. Toggle ON the **Sign Request**.
1. Toggle ON the **Allow Passive Requests**.
1. In the **MetaData URL** textbox,  paste the **App Federation Metadata Url** value, which you have copied fro the Azure portal.
1. Select **Requested Authentication Context Comparison** as **exact**.
1. In **IDP Login URL** textbox,  paste the **Login URL** value, which you copied previously.
1. Select **Save**.

### Create AlertMedia test user

In this section, a user called Britta Simon is created in AlertMedia. AlertMedia supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in AlertMedia, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the AlertMedia for which you set up the SSO.

* You can use Microsoft My Apps. When you select the AlertMedia tile in the My Apps, you should be automatically signed in to the AlertMedia for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure AlertMedia you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
