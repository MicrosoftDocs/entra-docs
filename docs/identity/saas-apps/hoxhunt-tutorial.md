---
title: Configure Hoxhunt for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Hoxhunt.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Hoxhunt so that I can control who has access to Hoxhunt, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Hoxhunt for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Hoxhunt with Microsoft Entra ID. When you integrate Hoxhunt with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Hoxhunt.
* Enable your users to be automatically signed-in to Hoxhunt with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Hoxhunt single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Hoxhunt supports **SP** initiated SSO.
* Hoxhunt supports [Automated user provisioning](hoxhunt-provisioning-tutorial.md).

## Add Hoxhunt from the gallery

To configure the integration of Hoxhunt into Microsoft Entra ID, you need to add Hoxhunt from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Hoxhunt** in the search box.
1. Select **Hoxhunt** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-hoxhunt'></a>

## Configure and test Microsoft Entra SSO for Hoxhunt

Configure and test Microsoft Entra SSO with Hoxhunt using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Hoxhunt.

To configure and test Microsoft Entra SSO with Hoxhunt, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Hoxhunt SSO](#configure-hoxhunt-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Hoxhunt test user](#create-hoxhunt-test-user)** - to have a counterpart of B.Simon in Hoxhunt that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Hoxhunt** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://app.hoxhunt.com/saml/consume/<ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.hoxhunt.com/saml/consume/<ID>`

	c. In the **Sign on URL** text box, type the URL:
    `https://game.hoxhunt.com/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Hoxhunt Client support team](mailto:support@hoxhunt.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Hoxhunt** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

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

In this section, you enable B.Simon to use single sign-on by granting access to Hoxhunt.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Hoxhunt**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure Hoxhunt SSO

To configure single sign-on on **Hoxhunt** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Hoxhunt support team](mailto:support@hoxhunt.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Hoxhunt test user

In this section, you create a user called Britta Simon in Hoxhunt. Work with [Hoxhunt support team](mailto:support@hoxhunt.com) to add the users in the Hoxhunt platform. Users must be created and activated before you use single sign-on.

Hoxhunt also supports automatic user provisioning, you can find more details [here](./hoxhunt-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Hoxhunt Sign-on URL where you can initiate the login flow. 

* Go to Hoxhunt Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Hoxhunt tile in the My Apps, this option redirects to Hoxhunt Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Hoxhunt you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
