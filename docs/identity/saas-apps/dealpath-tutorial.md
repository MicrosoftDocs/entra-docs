---
title: 'Tutorial: Microsoft Entra SSO integration with Dealpath'
description: Learn how to configure single sign-on between Microsoft Entra ID and Dealpath.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Dealpath so that I can control who has access to Dealpath, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra SSO integration with Dealpath

In this tutorial, you'll learn how to integrate Dealpath with Microsoft Entra ID. When you integrate Dealpath with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Dealpath.
* Enable your users to be automatically signed-in to Dealpath with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Dealpath single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra single sign-on in a test environment.

* Dealpath supports **SP** initiated SSO.

## Add Dealpath from the gallery

To configure the integration of Dealpath into Microsoft Entra ID, you need to add Dealpath from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Dealpath** in the search box.
1. Select **Dealpath** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-dealpath'></a>

## Configure and test Microsoft Entra SSO for Dealpath

Configure and test Microsoft Entra SSO with Dealpath using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Dealpath.

To configure and test Microsoft Entra SSO with Dealpath, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Dealpath SSO](#configure-dealpath-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Dealpath test user](#create-dealpath-test-user)** - to have a counterpart of B.Simon in Dealpath that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Dealpath** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type the URL:
    `https://app.dealpath.com/account/login`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://api.dealpath.com/saml/metadata/<ID>`

	> [!NOTE]
	> The Identifier value is not real. Update the value with the actual Identifier. Contact [Dealpath Client support team](mailto:kenter@dealpath.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set-up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, click **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Dealpath** section, copy the appropriate URL(s) as per your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Dealpath.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Dealpath**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Dealpath SSO

1. In a different web browser window, sign in to Dealpath as an Administrator.

2. In the top right, click **Admin Tools** and navigate to **Integrations**, then in **SAML 2.0 Authentication** section click **Update Settings**:

	![Screenshot that shows the "Admin Tools - Integrations" page with the "S A M L 2.0 Authentication" section and "Update Settings" selected.](./media/dealpath-tutorial/admin.png)

3. In the **Set up SAML 2.0 authentication** page, perform the following steps:

	![Screenshot that shows Dealpath Configuration.](./media/dealpath-tutorial/configuration.png) 

	a. In the **SAML SSO URL** textbox, paste the value of **Login URL**.

	b. In the **Identity Provider Issuer** textbox, paste the value of **Microsoft Entra Identifier**, ..

	c. Copy the content of the downloaded **certificate(Base64)** file in notepad, and then paste it into the **Public Certificate** textbox.

	d. Click **Update settings**.

### Create Dealpath test user

In this section, you create a user called Britta Simon in Dealpath. Work with [Dealpath Client support team](mailto:kenter@dealpath.com) to add the users in the Dealpath platform. Users must be created and activated before you use single sign-on

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Dealpath Sign-on URL where you can initiate the login flow. 

* Go to Dealpath Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Dealpath tile in the My Apps, this will redirect to Dealpath Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Next steps

Once you configure Dealpath you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
