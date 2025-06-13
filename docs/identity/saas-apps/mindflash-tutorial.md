---
title: Configure Trakstar Learn for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Trakstar Learn (Mindflash).

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Trakstar Learn so that I can control who has access to Trakstar Learn, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Trakstar Learn for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Trakstar Learn (Mindflash) with Microsoft Entra ID. When you integrate Learn with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Learn.
* Enable your users to be automatically signed-in to Learn with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Trakstar Learn single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Learn supports **SP** initiated SSO.

## Add Learn from the gallery

To configure the integration of Learn into Microsoft Entra ID, you need to add Learn from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Trakstar Learn** in the search box.  Trakstar Learn was formerly Mindlfash.
1. Select **Trakstar Learn** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

<a name='configure-and-test-azure-ad-sso-for-learn'></a>

## Configure and test Microsoft Entra SSO for Learn

Configure and test Microsoft Entra SSO with Learn using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Learn.

To configure and test Microsoft Entra SSO with Learn, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Trakstar Learn SSO](#configure-trakstar-learn-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Trakstar Learn test user](#create-trakstar-learn-test-user)** - to have a counterpart of B.Simon in Trakstar Learn that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Trakstar Learn** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<companyname>.mindflash.com`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<companyname>.mindflash.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Trakstar Learn Client support team](mailto:learn@trakstar.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Trakstar Learn** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Trakstar Learn SSO

To configure single sign-on on **Trakstar Learn** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Trakstar Learn support team](mailto:learn@trakstar.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Trakstar Learn test user

In order to enable Microsoft Entra users to log into Learn, they must be provisioned into Learn. In the case of Learn, provisioning is a manual task.

### To provision a user account, perform the following steps:

1. Log in to your **Trakstar Learn** company site as an administrator.

1. Go to **Manage Users**.
   
    ![Screenshot shows the Manage Users of account.](./media/mindflash-tutorial/account.png "Manage Users")

1. Select the **Add Users**, and then select **New**.

1. In the **Add New Users** section, perform the following steps of a valid Microsoft Entra account you want to provision:
   
    ![Screenshot shows to Add New Users of the account.](./media/mindflash-tutorial/user.png "Add New Users")
   
    a. In the **First name** textbox, type **First name** of the user as **Britta**.

	b. In the **Last name** textbox, type **Last name** of the user as **Simon**.
	
	c. In the **Email** textbox, type **Email Address** of the user as **BrittaSimon\@contoso.com**.

    b. Select **Add**.

>[!NOTE]
>You can use any other Learn user account creation tools or APIs provided by Learn to provision Microsoft Entra user accounts. 
> 

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Learn Sign on URL where you can initiate the login flow. 

* Go to Learn Sign on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Trakstar Learn tile in the My Apps, this option redirects to Learn Sign on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Trakstar Learn you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
