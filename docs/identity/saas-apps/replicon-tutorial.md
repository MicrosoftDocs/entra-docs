---
title: Configure Replicon for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Replicon.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Replicon so that I can control who has access to Replicon, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Replicon for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Replicon with Microsoft Entra ID. When you integrate Replicon with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Replicon.
* Enable your users to be automatically signed-in to Replicon with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Replicon single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment. 

* Replicon supports **SP** initiated SSO.

## Add Replicon from the gallery

To configure the integration of Replicon into Microsoft Entra ID, you need to add Replicon from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Replicon** in the search box.
1. Select **Replicon** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-replicon'></a>

## Configure and test Microsoft Entra SSO for Replicon

Configure and test Microsoft Entra SSO with Replicon using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Replicon.

To configure and test Microsoft Entra SSO with Replicon, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Replicon SSO](#configure-replicon-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Replicon test user](#create-replicon-test-user)** - to have a counterpart of B.Simon in Replicon that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Replicon** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following steps:

    a. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://global.replicon.com/!/saml2/<client name>/sp-sso/post`

    b. In the **Identifier** box, type a URL using the following pattern:
    `https://global.replicon.com/!/saml2/<client name>`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://global.replicon.com/!/saml2/<client name>/sso/post`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign-On URL, Identifier and Reply URL. Contact [Replicon Client support team](https://www.replicon.com/customerzone/contact-support) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Select the pencil icon for **SAML Signing Certificate** to edit the settings.

    ![Signing Algorithm](common/signing-algorithm.png)

    1. Select **Sign SAML assertion** as the **Signing Option**.

    1. Select **SHA-256** as the **Signing Algorithm**.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/metadataxml.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Replicon SSO

1. In a different web browser window, sign into your Replicon company site as an administrator.

2. To configure SAML 2.0, perform the following steps:

    ![Enable SAML authentication](./media/replicon-tutorial/authentication.png "Enable SAML authentication")

	a. To display the **EnableSAML Authentication2** dialog, append the following to your URL, after your company key: `/services/SecurityService1.svc/help/test/EnableSAMLAuthentication2`

	1. The following shows the schema of the complete URL:
   `https://na2.replicon.com/<YourCompanyKey>/services/SecurityService1.svc/help/test/EnableSAMLAuthentication2`

   b. Select the **+** to expand the **v20Configuration** section.

   c. Select the **+** to expand the **metaDataConfiguration** section.

   d. Select **SHA256** for xmlSignatureAlgorithm

   e. Select **Choose File**, to select your identity provider metadata XML file, and select **Submit**.

### Create Replicon test user

The objective of this section is to create a user called B.Simon in Replicon.

**If you need to create user manually, perform following steps:**

1. In a web browser window, sign into your Replicon company site as an administrator.

2. Go to **Administration** > **Users**.

    ![Users](./media/replicon-tutorial/administration.png "Users")

3. Select **+Add User**.

    ![Add User](./media/replicon-tutorial/user.png "Add User")

4. In the **User Profile** section, perform the following steps:

    ![User profile](./media/replicon-tutorial/profile.png "User profile")

	a. In the **Login Name** textbox, type the Microsoft Entra ID email address of the Microsoft Entra user you want to provision like `B.Simon@contoso.com`.

    > [!NOTE]
    > Login Name needs to match the user's email address in Microsoft Entra ID

	b. As **Authentication Type**, select **SSO**.

    c. Set Authentication ID to the same value as Login Name (The Microsoft Entra ID email address of the user)

	d. In the **Department** textbox, type the user’s department.

	e. As **Employee Type**, select **Administrator**.

	f. Select **Save User Profile**.

> [!NOTE]
> You can use any other Replicon user account creation tools or APIs provided by Replicon to provision Microsoft Entra user accounts.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Replicon Sign-on URL where you can initiate the login flow. 

* Go to Replicon Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Replicon tile in the My Apps, this option redirects to Replicon Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Replicon you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
