---
title: 'Tutorial: Microsoft Entra integration with PagerDuty'
description: Learn how to configure single sign-on between Microsoft Entra ID and PagerDuty.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and PagerDuty so that I can control who has access to PagerDuty, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with PagerDuty

In this tutorial, you'll learn how to integrate PagerDuty with Microsoft Entra ID. When you integrate PagerDuty with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to PagerDuty.
* Enable your users to be automatically signed-in to PagerDuty with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* PagerDuty single sign-on (SSO) enabled subscription.

> [!NOTE]
> If you are using MFA or Passwordless authentication with Microsoft Entra ID then switch off the AuthnContext value in the SAML Request. Otherwise Microsoft Entra ID will throw the error on mismatch of the AuthnContext and will not send the token back to the application.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* PagerDuty supports **SP** initiated SSO

## Add PagerDuty from the gallery

To configure the integration of PagerDuty into Microsoft Entra ID, you need to add PagerDuty from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **PagerDuty** in the search box.
1. Select **PagerDuty** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-single-sign-on-for-pagerduty'></a>

## Configure and test Microsoft Entra single sign-on for PagerDuty

Configure and test Microsoft Entra SSO with PagerDuty using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in PagerDuty.

To configure and test Microsoft Entra SSO with PagerDuty, complete the following building blocks:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure PagerDuty SSO](#configure-pagerduty-sso)** - to configure the single sign-on settings on application side.
    1. **[Create PagerDuty test user](#create-pagerduty-test-user)** - to have a counterpart of B.Simon in PagerDuty that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **PagerDuty** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<tenant-name>.pagerduty.com`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<tenant-name>.pagerduty.com`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<tenant-name>.pagerduty.com`

	> [!NOTE]
	> These values are not real. Update these values with the actual Sign on URL, Identifier and Reply URL. Contact [PagerDuty Client support team](https://www.pagerduty.com/support/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up PagerDuty** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to PagerDuty.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **PagerDuty**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then click the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure PagerDuty SSO

1. In a different web browser window, sign into your Pagerduty company site as an administrator.

2. In the menu on the top, click **Account Settings**.

    ![Account Settings](./media/pagerduty-tutorial/ic778535.png "Account Settings")

3. Click **Single Sign-on**.

    ![Single sign-on](./media/pagerduty-tutorial/ic778536.png "Single sign-on")

4. On the **Enable Single Sign-on (SSO)** page, perform the following steps:

    ![Enable single sign-on](./media/pagerduty-tutorial/ic778537.png "Enable single sign-on")

    a. Open your base-64 encoded certificate downloaded from Azure portal in notepad, copy the content of it into your clipboard, and then paste it to the **X.509 Certificate** textbox
  
    b. In the **Login URL** textbox, paste **Login URL**..
  
    c. In the **Logout URL** textbox, paste **Logout URL**..

    d. Select **Allow username/password login**.

	e. Select **Require EXACT authentication context comparison** checkbox.

    f. Click **Save Changes**.

### Create PagerDuty test user

To enable Microsoft Entra users to sign into PagerDuty, they must be provisioned into PagerDuty. In the case of PagerDuty, provisioning is a manual task.

> [!NOTE]
> You can use any other Pagerduty user account creation tools or APIs provided by Pagerduty to provision Microsoft Entra user accounts.

**To provision a user account, perform the following steps:**

1. Sign into your **Pagerduty** tenant.

2. In the menu on the top, click **Users**.

3. Click **Add Users**.
   
    ![Add Users](./media/pagerduty-tutorial/ic778539.png "Add Users")

4.  On the **Invite your team** dialog, perform the following steps:
   
    ![Invite your team](./media/pagerduty-tutorial/ic778540.png "Invite your team")

    a. Type the **First and Last Name** of user like **B.Simon**. 
   
    b. Enter **Email** address of user like **b.simon\@contoso.com**.
   
    c. Click **Add**, and then click **Send Invites**.
   
    > [!NOTE]
    > All added users will receive an invite to create a PagerDuty account.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to PagerDuty Sign-on URL where you can initiate the login flow. 

* Go to PagerDuty Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the PagerDuty tile in the My Apps, this will redirect to PagerDuty Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure PagerDuty you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
