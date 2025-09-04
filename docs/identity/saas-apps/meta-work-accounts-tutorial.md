---
title: Configure Meta Work Accounts for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Meta Work Accounts.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Meta Work Accounts so that I can control who has access to Meta Work Accounts, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Meta Work Accounts for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Meta Work Accounts with Microsoft Entra ID. When you integrate Meta Work Accounts with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Meta Work Accounts.
* Enable your users to be automatically signed-in to Meta Work Accounts with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Meta Work Accounts single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Meta Work Accounts supports **SP and IDP** initiated SSO.

## Add Meta Work Accounts from the gallery

To configure the integration of Meta Work Accounts into Microsoft Entra ID, you need to add Meta Work Accounts from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Meta Work Accounts** in the search box.
1. Select **Meta Work Accounts** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-meta-work-accounts'></a>

## Configure and test Microsoft Entra SSO for Meta Work Accounts

Configure and test Microsoft Entra SSO with Meta Work Accounts using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Meta Work Accounts.

To configure and test Microsoft Entra SSO with Meta Work Accounts, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Meta Work Accounts SSO](#configure-meta-work-accounts-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Meta Work Accounts test user](#create-meta-work-accounts-test-user)** - to have a counterpart of B.Simon in Meta Work Accounts that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Meta Work Accounts** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://work.facebook.com/company/<ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    ` https://work.facebook.com/work/saml.php?__cid=<ID>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://work.facebook.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Engage the [Work Accounts team](https://www.workplace.com/help/work) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Meta Work Accounts** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Meta Work Accounts SSO

1. Log in to your Meta Work Accounts company site as an administrator.

1. Go to **Security** > **Single Sign-On**.

1. Enable **Single-sign on(SSO)** checkbox and select **+Add new SSO Provider**.

<!-- ![Screenshot shows the SSO Account.](./media/meta-work-accounts-tutorial/security.png "SSO Account") -->

1. On the **Single Sign-On (SSO) Setup** page, perform the following steps:

<!--     ![Screenshot shows the SSO Configuration.](./media/meta-work-accounts-tutorial/certificate.png "Configuration") -->

1. Enter a valid **Name of the SSO Provider**.

1. In the **SAML URL** textbox, paste the **Login URL** value which you copied previously.

1. In the **SAML Issuer URL** textbox, paste the **Microsoft Entra Identifier** value which you copied previously.

1. **Enable SAML logout redirection** checkbox and in the **SAML Logout URL** textbox, paste the **Logout URL** value which you copied previously.

1. Open the downloaded **Certificate (Base64)** into Notepad and paste the content into the **SAML Certificate** textbox.

1. Copy **Audience URL** value, paste this value into the **Identifier** textbox in the **Basic SAML Configuration** section.

1. Copy **ACS (Assertion Consumer Service) URL** value, paste this value into the **Reply URL** text box in the **Basic SAML Configuration** section.

1. In the **Test SSO Setup** section, enter a valid email in the textbox and select **Test SSO**.

1. Select **Save Changes**.

### Create Meta Work Accounts test user

In this section, you create a user called Britta Simon in Meta Work Accounts. Work with the [Work Accounts team](https://www.workplace.com/help/work) to add the users in the Meta Work Accounts platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Meta Work Accounts Sign on URL where you can initiate the login flow.  

* Go to Meta Work Accounts Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Meta Work Accounts for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Meta Work Accounts tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Meta Work Accounts for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Meta Work Accounts you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
