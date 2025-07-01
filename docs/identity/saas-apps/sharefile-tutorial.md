---
title: Configure Citrix ShareFile for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Citrix ShareFile.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Citrix ShareFile so that I can control who has access to Citrix ShareFile, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Citrix ShareFile for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Citrix ShareFile with Microsoft Entra ID. When you integrate Citrix ShareFile with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Citrix ShareFile.
* Enable your users to be automatically signed-in to Citrix ShareFile with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Citrix ShareFile single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Citrix ShareFile supports **SP** initiated SSO.

## Add Citrix ShareFile from the gallery

To configure the integration of Citrix ShareFile into Microsoft Entra ID, you need to add Citrix ShareFile from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Citrix ShareFile** in the search box.
1. Select **Citrix ShareFile** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-citrix-sharefile'></a>

## Configure and test Microsoft Entra SSO for Citrix ShareFile

In this section, you configure and test Microsoft Entra single sign-on with Citrix ShareFile based on a test user called **Britta Simon**.
For single sign-on to work, a link relationship between a Microsoft Entra user and the related user in Citrix ShareFile needs to be established.

To configure and test Microsoft Entra single sign-on with Citrix ShareFile, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
	
	1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
	1. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure Citrix ShareFile SSO](#configure-citrix-sharefile-sso)** - to configure the Single Sign-On settings on application side.
	1. **[Create Citrix ShareFile test user](#create-citrix-sharefile-test-user)** - to have a counterpart of Britta Simon in Citrix ShareFile that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Citrix ShareFile** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic SAML Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps: 

    a. In the **Identifier (Entity ID)** textbox, type a URL using one of the following patterns:

	| **Identifier** |
	|--------|
    | `https://<tenant-name>.sharefile.com` |
	| `https://<tenant-name>.sharefile.com/saml/info` |
	| `https://<tenant-name>.sharefile1.com/saml/info` |
	| `https://<tenant-name>.sharefile1.eu/saml/info` |
	| `https://<tenant-name>.sharefile.eu/saml/info` |

	b. In the **Reply URL** textbox, type a URL using one of the following patterns:
	
	| **Reply URL** |
	|-------|
	| `https://<tenant-name>.sharefile.com/saml/acs` |
	| `https://<tenant-name>.sharefile.eu/saml/<URL path>` |
	| `https://<tenant-name>.sharefile.com/saml/<URL path>` |

	c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<tenant-name>.sharefile.com/saml/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier,Reply URL and Sign on URL. Contact [Citrix ShareFile Client support team](https://support.sharefile.com/s/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link](common/certificatebase64.png "Certificate")

1. On the **Set up Citrix ShareFile** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Citrix ShareFile SSO

1. In a different web browser window, sign in to your Citrix ShareFile company site as an administrator

1. In the **Dashboard**, select **Settings** and select **Admin Settings**.

	![Screenshot shows the Administration page.](./media/sharefile-tutorial/settings.png "Administration")

1. In the Admin Settings, go to the **Security** > **Login & Security Policy**.
   
    ![Screenshot shows the Account Administration page.](./media/sharefile-tutorial/settings-security.png "Account Administration")

1. On the **Single Sign-On/ SAML 2.0 Configuration** dialog page under **Basic Settings**, perform the following steps:
   
    ![Screenshot shows the Single sign-on page.](./media/sharefile-tutorial/saml-configuration.png "Single sign-on")
   
	a. Select **YES** in the **Enable SAML**.

	b. Copy the **ShareFile Issuer/ Entity ID** value and paste it into the **Identifier URL** box in the **Basic SAML Configuration** dialog box.
	
	c. In **Your IDP Issuer/ Entity ID** textbox, paste the value of **Microsoft Entra Identifier**.

	d. Open the downloaded **Certificate (Base64)** into Notepad and paste the content into the **X.509 Certificate** textbox by selecting **Change** button.
	
	e. In **Login URL** textbox, paste the value of **Login URL**.
	
	f. In **Logout URL** textbox, paste the value of **Logout URL**.

	g. In the **Optional Settings**, choose **SP-Initiated Auth Context** as **User Name and Password** and **Exact**.

5. Select **Save**.

## Create Citrix ShareFile test user

1. Log in to your **Citrix ShareFile** tenant.

2. Select **People** > **Manage Users Home** > **Create New Users** > **Create Employee**.
   
	![Screenshot shows to Create Employee.](./media/sharefile-tutorial/create-user.png "Create Employee")

3. On the **Basic Information** section, perform below steps:
   
	![Screenshot shows the Basic Information.](./media/sharefile-tutorial/user-form.png "Basic Information")
   
	a. In the **First Name** textbox, type **first name** of user as **Britta**.
   
	b.  In the **Last Name** textbox, type **last name** of user as **Simon**.
   
	c. In the **Email Address** textbox, type the email address of Britta Simon as **brittasimon\@contoso.com**.

4. Select **Add User**.
  
	>[!NOTE]
	>The Microsoft Entra account holder will receive an email and follow a link to confirm their account before it becomes active.You can use any other Citrix ShareFile user account creation tools or APIs provided by Citrix ShareFile to provision Microsoft Entra user accounts.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, this option redirects to Citrix ShareFile Sign-on URL where you can initiate the login flow.

* Go to Citrix ShareFile Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Citrix ShareFile tile in the My Apps, this option redirects to Citrix ShareFile Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Citrix ShareFile you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
