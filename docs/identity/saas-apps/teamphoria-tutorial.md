---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Teamphoria'
description: Learn how to configure single sign-on between Microsoft Entra ID and Teamphoria.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Teamphoria so that I can control who has access to Teamphoria, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Teamphoria

In this tutorial, you'll learn how to integrate Teamphoria with Microsoft Entra ID. When you integrate Teamphoria with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Teamphoria.
* Enable your users to be automatically signed-in to Teamphoria with their Microsoft Entra accounts.
* Manage your accounts in one central location.

To learn more about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Teamphoria single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Teamphoria supports **SP** initiated SSO

## Adding Teamphoria from the gallery

To configure the integration of Teamphoria into Microsoft Entra ID, you need to add Teamphoria from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Teamphoria** in the search box.
1. Select **Teamphoria** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-teamphoria'></a>

## Configure and test Microsoft Entra single sign-on for Teamphoria

Configure and test Microsoft Entra SSO with Teamphoria using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Teamphoria.

To configure and test Microsoft Entra SSO with Teamphoria, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Teamphoria SSO](#configure-teamphoria-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Teamphoria test user](#create-teamphoria-test-user)** - to have a counterpart of B.Simon in Teamphoria that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Teamphoria** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<sub-domain>.teamphoria.com/login`

	> [!NOTE]
	> The value is not real. Update the value with the actual Sign-On URL. Contact [Teamphoria Client support team](https://www.teamphoria.com/) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Teamphoria** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Teamphoria.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Teamphoria**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.

   ![The "Users and groups" link](common/users-groups-blade.png)

1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.

	![The Add User link](common/add-assign-user.png)

1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then click the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Teamphoria SSO




1. In a different web browser window, sign in to your Teamphoria company site as an administrator

4. Go to **ADMIN SETTINGS** option in the left toolbar and under the Configure Tab click on **SINGLE SIGN-ON** to open the SSO configuration window.

	![Screenshot shows ADMIN SETTINGS where you can select SINGLE SIGN-ON.](./media/teamphoria-tutorial/admin_sso_configure.png)

5. Click on **ADD NEW IDENTITY PROVIDER** option in the top right corner to open the form for adding the settings for SSO.

	![Screenshot shows where you can select ADD NEW IDENTITY PROVIDER.](./media/teamphoria-tutorial/add_new_identity_provider.png)

6. Enter the details in the fields as described below-

	![Screenshot shows the page where you can enter the values described.](./media/teamphoria-tutorial/Teamphoria_sso_save.png)

	a. **DISPLAY NAME**: Enter the display name of the plugin on the admin page.

	b. **BUTTON NAME**: The name of the tab that will display on the login page for logging in via SSO.

	c. **CERTIFICATE**: Open the Certificate downloaded earlier in notepad, copy the contents of the same and paste it here in the box.

	d. **ENTRY POINT**: Paste the **Login URL** copied earlier.

	e. Switch the option to **ON** and click on **SAVE**.

### Create Teamphoria test user

In order to enable Microsoft Entra users to sign in to Teamphoria, they must be provisioned into Teamphoria. In the case of Teamphoria, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Sign in to your Teamphoria company site as an administrator.

1. Click on **ADMIN** settings on the left toolbar and under the **MANAGE** tab Click on **USERS** to open the admin page for users.

    ![Add Employee](./media/teamphoria-tutorial/admin_manage_users.png)

1. Click on the **MANUAL INVITE** option.

	![Screenshot shows the MANUAL INVITE option.](./media/teamphoria-tutorial/admin_manage_add_users.png)

1. On this page, perform following action.

	![Screenshot shows the MANUAL USER INVITE page where you can enter name and email address.](./media/teamphoria-tutorial/manual_user_invite.png)

    a. In the **EMAIL ADDRESS** textbox, enter the **email address** of the user like B.Simon.

    b. In the **FIRST NAME** textbox, enter the first name of the user like **B**.

	c. In the **LAST NAME** textbox, enter the last name of the user like **Simon**.

    d. Click **INVITE 1 USER**. User needs to accept the invite to get created in the system.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you click the Teamphoria tile in the Access Panel, you should be automatically signed in to the Teamphoria for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional resources

- [List of Tutorials on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
