---
title: Configure Freshservice for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Freshservice.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/03/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Freshservice so that I can control who has access to Freshservice, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Freshservice for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Freshservice with Microsoft Entra ID. When you integrate Freshservice with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Freshservice.
* Enable your users to be automatically signed-in to Freshservice with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Freshservice single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Freshservice supports **SP** initiated SSO.
* Freshservice supports [Automated user provisioning](freshservice-provisioning-tutorial.md).

## Add Freshservice from the gallery

To configure the integration of Freshservice into Microsoft Entra ID, you need to add Freshservice from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Freshservice** in the search box.
1. Select **Freshservice** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-freshservice'></a>

## Configure and test Microsoft Entra SSO for Freshservice

Configure and test Microsoft Entra SSO with Freshservice using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Freshservice.

To configure and test Microsoft Entra SSO with Freshservice, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Freshservice SSO](#configure-freshservice-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Freshservice test user](#create-freshservice-test-user)** - to have a counterpart of B.Simon in Freshservice that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Freshservice** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<company-name>.freshservice.com`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<company-name>.freshservice.com`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<company-name>.freshservice.com/login/saml`
	
	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL, Identifier and Reply URL. Contact [Freshservice Client support team](https://support.freshservice.com/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Freshservice** section on the **Azure portal**, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Freshservice SSO

1. In a different web browser window, sign in to your Freshservice company site as an administrator

1. In the menu on the left, select **Admin** and select **Helpdesk Security** in the **General Settings**.

1. In the **Security**, select **Go to  Freshservice 360 Security**.

1. In the **Security** section, perform the following steps:

	![Single Sign On](./media/freshservice-tutorial/configure-3.png "Single Sign On")
  
	a. For **Single Sign On**, select **On**.

	b. In the **Login Method**, select **SAML SSO**.

    c. In the **Entity ID provided by the IdP** textbox, paste **Entity ID** value, which you copied previously.

	d. In the **SAML SSO URL** textbox, paste **Login URL** value, which you copied previously.

	e. In the **Signing Options**, select **Only Signed Assertions** from the dropdown.

    f. In the **Logout URL** textbox, paste **Logout URL** value, which you copied previously.

    g. In the **Security Certificate** textbox, paste **Certificate (Base64)** value, which you have obtained earlier.
  
	h. Select **Save**.


## Create Freshservice test user

To enable Microsoft Entra users to sign in to FreshService, they must be provisioned into FreshService. In the case of FreshService, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Sign in to your **FreshService** company site as an administrator.

2. In the menu on the left, select **Admin**.

3. In the **User Management** section, select **Requesters**.

    ![Requesters](./media/freshservice-tutorial/create-user-1.png "Requesters")

4. Select **New Requester**.

    ![New Requesters](./media/freshservice-tutorial/create-user-2.png "New Requesters")

5. In the **New Requester** section, enter the required fields and select **Save**.
    ![New Requester](./media/freshservice-tutorial/create-user-3.png "New Requester")  

    > [!NOTE]
    > The Microsoft Entra account holder gets an email including a link to confirm the account before it becomes active
    >  

    > [!NOTE]
    > You can use any other FreshService user account creation tools or APIs provided by FreshService to provision Microsoft Entra user accounts.
   
> [!NOTE]
>Freshservice also supports automatic user provisioning, you can find more details [here](./freshservice-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to  Freshservice Sign-on URL where you can initiate the login flow. 

* Go to  Freshservice Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the  Freshservice tile in the My Apps, you should be automatically signed in to the  Freshservice for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

 Once you configure Freshservice you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
