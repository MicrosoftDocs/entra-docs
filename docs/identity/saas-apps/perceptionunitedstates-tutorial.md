---
title: 'Tutorial: Microsoft Entra SSO integration with UltiPro Perception'
description: Learn how to configure single sign-on between Microsoft Entra ID and UltiPro Perception.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and UltiPro perception so that I can control who has access to UltiPro perception, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra SSO integration with UltiPro Perception

In this tutorial, you'll learn how to integrate UltiPro Perception with Microsoft Entra ID. When you integrate UltiPro Perception with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to UltiPro Perception.
* Enable your users to be automatically signed-in to UltiPro Perception with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* UltiPro Perception single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra single sign-on in a test environment.

* UltiPro Perception supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add UltiPro Perception from the gallery

To configure the integration of UltiPro Perception into Microsoft Entra ID, you need to add UltiPro Perception from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **UltiPro Perception** in the search box.
1. Select **UltiPro Perception** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-ultipro-perception'></a>

## Configure and test Microsoft Entra SSO for UltiPro Perception

Configure and test Microsoft Entra SSO with UltiPro Perception using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in UltiPro Perception.

To configure and test Microsoft Entra SSO with UltiPro Perception, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure UltiPro Perception SSO](#configure-ultipro-perception-sso)** - to configure the single sign-on settings on application side.
    1. **[Create UltiPro Perception test user](#create-ultipro-perception-test-user)** - to have a counterpart of B.Simon in UltiPro Perception that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **UltiPro Perception** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following steps:

    a. In the **Reply URL** text box, type a URL using the following pattern:
    `https://perception.kanjoya.com/sso?idp=<entity_id>`

	b. The **UltiPro Perception** application requires the **Microsoft Entra Identifier** value as <entity_id>, which you will get from the **Set up UltiPro Perception** section, to be URI-encoded. To get the URI-encoded value, use the following link: **http://www.url-encode-decode.com/**.

	c. After getting the URI-encoded value combine it with the **Reply URL** as mentioned below-

	`https://perception.kanjoya.com/sso?idp=<URI encooded entity_id>`
	
	d. Paste the above value in the **Reply URL** textbox.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, click **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up UltiPro Perception** section, copy the appropriate URL(s) as per your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to UltiPro Perception.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **UltiPro Perception**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure UltiPro Perception SSO

1. In another browser window, sign on to your UltiPro Perception company site as an administrator.

2. In the main toolbar, click **Account Settings**.

    ![Screenshot that shows "Account Settings" selected from the main toolbar.](./media/perceptionunitedstates-tutorial/user.png)

3. On the **Account Settings** page, perform the following steps:

	![UltiPro Perception user](./media/perceptionunitedstates-tutorial/account.png)

	a. In the **Company Name** textbox, type the name of the **Company**.
	
	b. In the **Account Name** textbox, type the name of the **Account**.

	c. In **Default Reply-To Email** text box, type the valid **Email**.

	d. Select **SSO Identity Provider** as **SAML 2.0**.

4. On the **SSO Configuration** page, perform the following steps:

    ![UltiPro Perception SSO Configuration.](./media/perceptionunitedstates-tutorial/configuration.png)

	a. Select **SAML NameID Type** as **EMAIL**.

	b. In the **SSO Configuration Name** textbox, type the name of your **Configuration**.
	
	c. In **Identity Provider Name** textbox, paste the value of **Microsoft Entra Identifier**. 

	d. In **SAML Domain textbox**, enter the domain like @contoso.com.

	e. Click on **Upload Again** to upload the **Metadata XML** file.

	f. Click **Update**.

### Create UltiPro Perception test user

In this section, you create a user called Britta Simon in UltiPro Perception. Work with [UltiPro Perception support team](https://www.ultimatesoftware.com/Contact/ContactUs) to add the users in the UltiPro Perception platform.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Click on **Test this application**, and you should be automatically signed in to the UltiPro Perception for which you set up the SSO.

* You can use Microsoft My Apps. When you click the UltiPro Perception tile in the My Apps, you should be automatically signed in to the UltiPro Perception for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Next steps

Once you configure UltiPro Perception you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
