---
title: Configure Hosted MyCirqa SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Hosted MyCirqa SSO.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Hosted MyCirqa so that I can control who has access to Hosted MyCirqa, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Hosted MyCirqa SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Hosted MyCirqa SSO with Microsoft Entra ID. When you integrate Hosted MyCirqa SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Hosted MyCirqa SSO.
* Enable your users to be automatically signed-in to Hosted MyCirqa SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Hosted MyCirqa SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Hosted MyCirqa SSO supports **SP** initiated SSO.

## Add Hosted MyCirqa SSO from the gallery

To configure the integration of Hosted MyCirqa SSO into Microsoft Entra ID, you need to add Hosted MyCirqa SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Hosted MyCirqa SSO** in the search box.
1. Select **Hosted MyCirqa SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-hosted-mycirqa-sso'></a>

## Configure and test Microsoft Entra SSO for Hosted MyCirqa SSO

Configure and test Microsoft Entra SSO with Hosted MyCirqa SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Hosted MyCirqa SSO.

To configure and test Microsoft Entra SSO with Hosted MyCirqa SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Hosted MyCirqa SSO](#configure-hosted-mycirqa-sso)** - to configure the single sign-on settings on application side.
    * **[Create Hosted MyCirqa SSO test user](#create-hosted-mycirqa-sso-test-user)** - to have a counterpart of B.Simon in Hosted MyCirqa SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Hosted MyCirqa SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.cirqahosting.com/CirqaIdentity/external?`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://isoxford.com/<CUSTOMID>/cirqaidentity/saml2`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Hosted MyCirqa SSO Client support team](not sure) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you enable B.Simon to use single sign-on by granting access to Hosted MyCirqa SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Hosted MyCirqa SSO**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure Hosted MyCirqa SSO

To configure single sign-on on **Hosted MyCirqa SSO** side, you need to send the **App Federation Metadata Url** to [Hosted MyCirqa SSO support team](mailto:support@isoxford.com). They set this setting to have the SAML SSO connection set properly on both sides.

## Create Hosted MyCirqa SSO test user

In this section, you create a user called Britta Simon in Hosted MyCirqa SSO. Work with [Hosted MyCirqa SSO support team](mailto:support@isoxford.com) to add the users in the Hosted MyCirqa SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Hosted MyCirqa SSO Sign-on URL where you can initiate the login flow. 

* Go to Hosted MyCirqa SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Hosted MyCirqa SSO tile in the My Apps, this option redirects to Hosted MyCirqa SSO Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Hosted MyCirqa SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
