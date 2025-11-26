---
title: Configure Chargebee for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Chargebee.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Chargebee so that I can control who has access to Chargebee, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Chargebee for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Chargebee with Microsoft Entra ID. When you integrate Chargebee with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Chargebee.
* Enable your users to be automatically signed-in to Chargebee with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Chargebee single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Chargebee supports **SP and IDP** initiated SSO.

## Add Chargebee from the gallery

To configure the integration of Chargebee into Microsoft Entra ID, you need to add Chargebee from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Chargebee** in the search box.
1. Select **Chargebee** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-chargebee'></a>

## Configure and test Microsoft Entra SSO for Chargebee

Configure and test Microsoft Entra SSO with Chargebee using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Chargebee.

To configure and test Microsoft Entra SSO with Chargebee, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure Chargebee SSO](#configure-chargebee-sso)** - to configure the Single Sign-On settings on application side.
    1. **[Create Chargebee test user](#create-chargebee-test-user)** - to have a counterpart of B.Simon in Chargebee that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Chargebee** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<domainname>.chargebee.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.chargebee.com/saml/<domainname>/acs`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<domainname>.chargebee.com`

	> [!NOTE]
	> `<domainname>` is the name of the domain that the user creates after claiming the account. In case of any other information, contact [Chargebee Client support team](mailto:support@chargebee.com). You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Chargebee** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Chargebee SSO

1. Open a new web browser window and sign into your Chargebee company site as an administrator.

4. From the left side of menu, select **Settings** > **Security** > **Manage**.

	![Screenshot shows the Chargebee company site with Settings, Security, and Manage selected.](./media/chargebee-tutorial/security.png)

5. On the **Single Sign-On** pop-up, perform the following steps:

	![Screenshot shows the Single Sign-On dialog box with SAML selected and the option to confirm.](./media/chargebee-tutorial/settings.png)

	a. Select **SAML**.

	b. In the **Login URL** text box, Paste the **Login URL** value, which you copied previously.

	c. Open the Base64 encoded certificate in notepad, copy its content and paste it into the **SAML Certificate** text box.

	d. Select **Confirm**.

### Create Chargebee test user

To enable Microsoft Entra users, sign in to Chargebee, they must be provisioned into Chargebee. In Chargebee, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. In a different web browser window, sign in to Chargebee as a Security Administrator.

2. From the left side of menu,, select **Customers** and then navigate to **Create a New Customer**.

	![Screenshot shows Chargebee site with Customers and Create a New Customer selected.](./media/chargebee-tutorial/menu.png)

3. On the **New Customer** page, fill the respective fields shown below and select **Create Customer** for user creation.

	![Screenshot shows the New Customer page where you can enter customer information.](./media/chargebee-tutorial/customers.png)

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Chargebee Sign on URL where you can initiate the login flow.  

* Go to Chargebee Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Chargebee for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Chargebee tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Chargebee for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Chargebee you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
