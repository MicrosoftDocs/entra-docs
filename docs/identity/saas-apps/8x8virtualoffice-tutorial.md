---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with 8x8'
description: Learn how to configure single sign-on between Microsoft Entra ID and 8x8.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 05/22/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and 8x8 so that I can control who has access to 8x8, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with 8x8

In this tutorial, you'll learn how to integrate 8x8 with Microsoft Entra ID. When you integrate 8x8 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to 8x8.
* Enable your users to be automatically signed-in to 8x8 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* An 8x8 subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* 8x8 supports both **SP and IDP** initiated SSO.
* 8x8 supports [**Automated** user provisioning and deprovisioning](8x8-provisioning-tutorial.md) (recommended).

> [!NOTE]
> The Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add 8x8 from the gallery

To configure the integration of 8x8 into Microsoft Entra ID, you need to add 8x8 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **8x8** in the search box.
1. Select **8x8** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for 8x8

Configure and test Microsoft Entra SSO with 8x8 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in 8x8.

To configure and test Microsoft Entra SSO with 8x8, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-microsoft-entra-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure 8x8 SSO in 8x8 Admin Console](#configure-8x8-sso-in-8x8-admin-console)** - to configure the single sign-on settings on application side.
    1. **[Create 8x8 test user](#create-8x8-test-user)** - to have a counterpart of B.Simon in 8x8 that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **8x8** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL: `https://sso.8x8.com/saml2`

    b. In the **Reply URL** text box, type the URL: `https://sso.8x8.com/saml2`

1. Perform the following step, if you wish to configure the application in SP initiated mode:
    
    In the **Sign on URL** text box, type the URL:
    `https://sso.8x8.com`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer. You will use the certificate later in the tutorial in the **Configure 8x8 SSO** section.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up 8x8** section, copy the URL(s) and you will use these URL values later in the tutorial.

	![Copy configuration URLs](./media/8x8virtualoffice-tutorial/copy-configuration-urls.png)

### Create a Microsoft Entra test user

In this section, you'll create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to 8x8.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **8x8**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

### Configure 8x8 SSO in 8x8 Admin Console

1. In a different web browser window, sign in to the 8x8 [Admin Console](https://admin.8x8.com/) as an administrator.

1. From the home page click **Identity Management**.

    ![Screenshot that highlights the Identity Management tile.](./media/8x8virtualoffice-tutorial/configure1.png)

1. Check **Single Sign On (SSO)** then select **Microsoft Entra ID**.

    ![Screenshot that highlights the Single Sign on (SSO) and Microsoft Entra options.](./media/8x8virtualoffice-tutorial/configure2.png)

1. Copy the three URLs and signing certificate from the **Set up Single Sign-On with SAML** page in Microsoft Entra ID into the **Microsoft Entra SAML Settings** section in 8x8 Admin Console.

    ![8x8 Admin Console](./media/8x8virtualoffice-tutorial/configure3.png)

    a. Copy **Login URL** from Microsoft Entra admin center and paste in the **IDP Login URL** field.

    b. Copy **Microsoft Entra Identifier** from Microsoft Entra admin center and paste in the **IDP Issuer URL/URN** field.

    c. Copy **Logout URL** from Microsoft Entra admin center and paste in the **IDP Logout URL** (optional) field.

    d. Download the **Certificate (Base64)** from Microsoft Entra admin center and upload into the **Certificate**.

    e. Click **Save**.

### Create 8x8 test user

Create a user called Britta Simon in 8x8 Admin Console. Users must be created in 8x8 Admin Console before you can use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with either an SP initiated flow which starts at the 8x8 login page, or an IDP initiated flow which starts at the Microsoft My Apps. 

#### SP initiated:

* Go to the 8x8 [Sign-on URL](https://sso.8x8.com) directly and initiate the login flow from there.

#### IDP initiated:

* Click on **Test this application**, and you should be automatically signed in to the 8x8 for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you click the 8x8 tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the 8x8 for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure 8x8 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).