---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Leapsome'
description: Learn how to configure single sign-on between Microsoft Entra ID and Leapsome.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Leapsome so that I can control who has access to Leapsome, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Leapsome

In this tutorial, you'll learn how to integrate Leapsome with Microsoft Entra ID. When you integrate Leapsome with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Leapsome.
* Enable your users to be automatically signed-in to Leapsome with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Leapsome single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Leapsome supports **SP and IDP** initiated SSO.
* Leapsome supports [Automated user provisioning](leapsome-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Leapsome from the gallery

To configure the integration of Leapsome into Microsoft Entra ID, you need to add Leapsome from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Leapsome** in the search box.
1. Select **Leapsome** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-leapsome'></a>

## Configure and test Microsoft Entra SSO for Leapsome

Configure and test Microsoft Entra SSO with Leapsome using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Leapsome.

To configure and test Microsoft Entra SSO with Leapsome, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Leapsome SSO](#configure-leapsome-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Leapsome test user](#create-leapsome-test-user)** - to have a counterpart of B.Simon in Leapsome that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Leapsome** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type the URL: `https://www.leapsome.com`

	b. In the **Reply URL** text box, type a URL using the following pattern: `https://www.leapsome.com/api/users/auth/saml/<CLIENTID>/assert`

1. Click **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://www.leapsome.com/api/users/auth/saml/<CLIENTID>/login`

	> [!NOTE]
	> The preceding Reply URL and Sign-on URL value is not real value. You will update these with the actual values, which is explained later in the tutorial.

1. Leapsome application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Leapsome application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name | Source Attribute | Namespace |
	| ---------------| --------------- | --------- |  
	| firstname | user.givenname | https://schemas.xmlsoap.org/ws/2005/05/identity/claims |
	| lastname | user.surname | https://schemas.xmlsoap.org/ws/2005/05/identity/claims |
	| title | user.jobtitle | https://schemas.xmlsoap.org/ws/2005/05/identity/claims |
	| picture | URL to the employee's picture | https://schemas.xmlsoap.org/ws/2005/05/identity/claims |
	| | |

	> [!Note]
	> The value of picture attribute is not real. Update this value with actual picture URL. To get this value contact [Leapsome Client support team](mailto:support@leapsome.com).

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Leapsome** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Leapsome.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Leapsome**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Leapsome SSO

1. In a different web browser window, sign in to Leapsome as a Security Administrator.

1. On the top right, Click on Settings logo and then click **Admin Settings**.

	![Leapsome set](./media/leapsome-tutorial/admin.png)

1. On the left menu bar click **Single Sign On (SSO)**, and on the **SAML-based single sign-on (SSO)** page perform the following steps:

	![Leapsome saml](./media/leapsome-tutorial/settings.png)

	a. Select **Enable SAML-based single sign-on**.

	b. Copy the **Login URL (point your users here to start login)** value and paste it into the **Sign-on URL** textbox in **Basic SAML Configuration** section.

	c. Copy the **Reply URL (receives response from your identity provider)** value and paste it into the **Reply URL** textbox in  **Basic SAML Configuration** section.

	d. In the **SSO Login URL (provided by identity provider)** textbox, paste the value of **Login URL**, which you copied.

	e. Copy the Certificate that you have downloaded from Azure portal without `--BEGIN CERTIFICATE and END CERTIFICATE--` comments and paste it in the **Certificate (provided by identity provider)** textbox.

	f. Click **UPDATE SSO SETTINGS**.

### Create Leapsome test user

In this section, you create a user called Britta Simon in Leapsome. Work with [Leapsome Client support team](mailto:support@leapsome.com) to add the users or the domain that must be added to an allow list for the Leapsome platform. If the domain is added by the team, users will get automatically provisioned to the Leapsome platform. Users must be created and activated before you use single sign-on.

Leapsome also supports automatic user provisioning, you can find more details [here](./leapsome-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Click on **Test this application**, this will redirect to Leapsome Sign on URL where you can initiate the login flow.  

* Go to Leapsome Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Click on **Test this application**, and you should be automatically signed in to the Leapsome for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you click the Leapsome tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Leapsome for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Leapsome you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
