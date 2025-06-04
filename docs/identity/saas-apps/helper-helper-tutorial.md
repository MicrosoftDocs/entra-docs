---
title: Configure Helper Helper for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Helper Helper.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Helper Helper so that I can control who has access to Helper Helper, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Helper Helper for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Helper Helper with Microsoft Entra ID. When you integrate Helper Helper with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Helper Helper.
* Enable your users to be automatically signed-in to Helper Helper with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Helper Helper single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment. 
* Helper Helper supports **SP and IDP** initiated SSO and supports **Just In Time** user provisioning.

## Add Helper Helper from the gallery

To configure the integration of Helper Helper into Microsoft Entra ID, you need to add Helper Helper from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Helper Helper** in the search box.
1. Select **Helper Helper** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-helper-helper'></a>

## Configure and test Microsoft Entra SSO for Helper Helper

Configure and test Microsoft Entra SSO with Helper Helper using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Helper Helper.

To configure and test Microsoft Entra SSO with Helper Helper, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Helper Helper SSO](#configure-helper-helper-sso)** - to configure the single sign-on settings on application side.
   1. **[Create Helper Helper test user](#create-helper-helper-test-user)** - to have a counterpart of B.Simon in Helper Helper that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Helper Helper** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file** and wish to configure in **IDP** initiated mode perform the following steps:

    >[!NOTE]
    >Go to the URL `https://sso.helperhelper.com/saml/<customer_id>` to get the Service Provider metadata file. Contact [Helper Helper Client support team](mailto:info@helperhelper.com) for `<customer_id>`.

	a. Select **Upload metadata file**.

	b. Select **folder logo** to select the metadata file and select **Upload**.

	c. After the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in Basic SAML Configuration section.

	> [!Note]
	> If the **Identifier** and **Reply URL** values don't get auto populated, then fill in the values manually according to your requirement.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

	In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://sso.helperhelper.com/saml/<customer_id>/login`

	> [!NOTE]
    > The Sign-on URL value isn't real. Update this value with the actual Sign-on URL. Contact [Helper Helper Client support team](mailto:info@helperhelper.com) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.l.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your Notepad.

   ![The Certificate download link](common/copy-metadataurl.png)

1. On the **Set up Helper Helper** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you create a test user called B. Simon.

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

In this section, you enable B. Simon to use Azure single sign-on by granting access to Helper Helper.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Helper Helper**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B. Simon** from the Users list, then select the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then select the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure Helper Helper SSO

To configure single sign-on on **Helper Helper** side, you need to send the **App Federation Metadata Url** to [Helper Helper support team](mailto:info@helperhelper.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Helper Helper test user

In this section, a user called Britta Simon is created in Helper Helper. Helper Helper supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Helper Helper, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Helper Helper Sign on URL where you can initiate the login flow.  

* Go to Helper Helper Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Helper Helper for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Helper Helper tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Helper Helper for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Helper Helper you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
