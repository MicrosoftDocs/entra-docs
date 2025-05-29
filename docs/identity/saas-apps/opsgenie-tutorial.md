---
title: Configure OpsGenie for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and OpsGenie.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and OpsGenie so that I can control who has access to OpsGenie, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure OpsGenie for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate OpsGenie with Microsoft Entra ID. When you integrate OpsGenie with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to OpsGenie.
* Enable your users to be automatically signed-in to OpsGenie with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* OpsGenie single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* OpsGenie supports **IDP** initiated SSO

## Adding OpsGenie from the gallery

To configure the integration of OpsGenie into Microsoft Entra ID, you need to add OpsGenie from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **OpsGenie** in the search box.
1. Select **OpsGenie** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-opsgenie'></a>

## Configure and test Microsoft Entra SSO for OpsGenie

Configure and test Microsoft Entra SSO with OpsGenie using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in OpsGenie.

To configure and test Microsoft Entra SSO with OpsGenie, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure OpsGenie SSO](#configure-opsgenie-sso)** - to configure the single sign-on settings on application side.
    1. **[Create OpsGenie test user](#create-opsgenie-test-user)** - to have a counterpart of B.Simon in OpsGenie that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **OpsGenie** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://app.opsginie.com/auth/saml/<UNIQUEID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.opsginie.com/auth/saml?id=<UNIQUEID>`

    > [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL, which is explained later in this article.

1. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

1. On the **Set up OpsGenie** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure OpsGenie SSO




1. In a different web browser window, sign in to your OpsGenie company site as an administrator

2. Select **Settings**, and then select the **Single Sign On** tab.
   
    ![OpsGenie Single Sign-On](./media/opsgenie-tutorial/tutorial-opsgenie-06.png)

3. To enable SSO, select **Enabled**.
   
    ![Screenshot that shows the "Enabled" checkbox selected.](./media/opsgenie-tutorial/tutorial-opsgenie-07.png) 

4. In the **Provider** section, select the **Microsoft Entra ID** tab.

5. On the Microsoft Entra dialog page, perform the following steps:
   
    ![Screenshot that shows the "Single sign-on" section with the "Enable single sign-on" toggle, "S A M L 2.0 Endpoint", and "Metadata U R L".](./media/opsgenie-tutorial/tutorial-opsgenie-09.png)
	
    a. Copy the **App ID URI** value and paste it into **Identifier (Entity ID)** textbox in the **Basic SAML Configuration** section.

    a. Copy the **Reply URL** value and paste it into **Reply URL** textbox in the **Basic SAML Configuration** section.

	a. In the **SAML 2.0 Endpoint** textbox, paste **Login URL**value which you copied previously.
	
	b. In the **Metadata Url:** textbox, paste **App Federation Metadata Url** value which you copied previously.
    
    c. To enable SSO, turn on the **Enable single sign-on** toggle.

    d. Select **Apply SSO settings**.

### Create OpsGenie test user

The objective of this section is to create a user called B.Simon in OpsGenie. 

1. In a web browser window, sign into your OpsGenie tenant as an administrator.

2. Navigate to Users list by selecting **Users** in left panel.
   
    ![OpsGenie Settings](./media/opsgenie-tutorial/tutorial-opsgenie-10.png) 

3. Select **Add User**.

4. On the **Add User** dialog, perform the following steps:
   
    ![Screenshot that shows the "Add User" dialog with the "Email" and "Full name" text boxes highlighted, and the "Save" button selected.](./media/opsgenie-tutorial/tutorial-opsgenie-11.png)
   
    a. In the **Email** textbox, type the email address of B.Simon addressed in Microsoft Entra ID.
   
    b. In the **Full Name** textbox, type **B.Simon**.
   
    c. Select **Save**. 

> [!NOTE]
> B.Simon gets an email with instructions for setting up their profile.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the OpsGenie for which you set up the SSO

* You can use Microsoft My Apps. When you select the OpsGenie tile in the My Apps, you should be automatically signed in to the OpsGenie for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

* Once you configure OpsGenie you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
