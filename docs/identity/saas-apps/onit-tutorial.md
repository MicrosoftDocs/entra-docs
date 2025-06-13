---
title: Configure Onit for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Onit.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Onit so that I can control who has access to Onit, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Onit for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Onit with Microsoft Entra ID. When you integrate Onit with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Onit.
* Enable your users to be automatically signed-in to Onit with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Onit single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Onit supports **SP** initiated SSO.

## Add Onit from the gallery

To configure the integration of Onit into Microsoft Entra ID, you need to add Onit from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Onit** in the search box.
1. Select **Onit** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-onit'></a>

## Configure and test Microsoft Entra SSO for Onit

Configure and test Microsoft Entra SSO with Onit using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Onit.

To configure and test Microsoft Entra SSO with Onit, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Onit SSO](#configure-onit-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Onit test user](#create-onit-test-user)** - to have a counterpart of B.Simon in Onit that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Onit** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.onit.com`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.onit.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Onit Client support team](https://www.onit.com/support-portal) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Edit SAML Signing Certificate](common/edit-certificate.png)

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Copy Thumbprint value](common/copy-thumbprint.png)

1. On the **Set up Onit** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Onit SSO

1. In a different web browser window, log into your Onit company site as an administrator.

2. In the menu on the top, select **Administration**.
   
    ![Screenshot that shows the menu at the top of the "M S S S O Test" page with the "Administration" action selected.](./media/onit-tutorial/admin.png "Administration")

3. Select **Edit Corporation**.
   
    ![Edit Corporation](./media/onit-tutorial/corporation.png "Edit Corporation")
   
4. Select the **Security** tab.
    
    ![Edit Company Information](./media/onit-tutorial/security.png "Edit Company Information")

5. On the **Security** tab, perform the following steps:

	![Single Sign-On](./media/onit-tutorial/configuration.png "Single Sign-On")

	a. As **Authentication Strategy**, select **Single Sign On and Password**.
	
	b. In **Idp Target URL** textbox, paste the value of **Login URL**.

	c. In **Idp logout URL** textbox, paste the value of  **Logout URL**.

	d. In **Idp Cert Fingerprint (SHA1)** textbox, paste the  **Thumbprint** value of certificate.

### Create Onit test user

In order to enable Microsoft Entra users to log into Onit, they must be provisioned into Onit. In the case of Onit, provisioning is a manual task.

**To configure user provisioning, perform the following steps:**

1. Sign on to your **Onit** company site as an administrator.

2. Select **Add User**.

    ![Administration](./media/onit-tutorial/user.png "Administration")

3. On the **Add User** dialog page, perform the following steps:

    ![Add User](./media/onit-tutorial/create-user.png "Add User")

    a. Type the **Name** and the **Email Address** of a valid Microsoft Entra account you want to provision into the related textboxes.

    b. Select **Create**.

    > [!NOTE]
    > The Microsoft Entra account holder receives an email and follows a link to confirm their account before it becomes active.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Onit Sign-on URL where you can initiate the login flow. 

* Go to Onit Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Onit tile in the My Apps, this option redirects to Onit Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Onit you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
