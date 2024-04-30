---
title: 'Tutorial: Microsoft Entra SSO integration with Saba TalentSpace'
description: Learn how to configure single sign-on between Microsoft Entra ID and Saba TalentSpace.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Saba TalentSpace so that I can control who has access to Saba TalentSpace, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Saba TalentSpace

In this tutorial, you'll learn how to integrate Saba TalentSpace with Microsoft Entra ID. When you integrate Saba TalentSpace with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Saba TalentSpace.
* Enable your users to be automatically signed-in to Saba TalentSpace with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Saba TalentSpace single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Saba TalentSpace supports **SP** initiated SSO

## Add Saba TalentSpace from the gallery

To configure the integration of Saba TalentSpace into Microsoft Entra ID, you need to add Saba TalentSpace from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Saba TalentSpace** in the search box.
1. Select **Saba TalentSpace** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-saba-talentspace'></a>

## Configure and test Microsoft Entra SSO for Saba TalentSpace

Configure and test Microsoft Entra SSO with Saba TalentSpace using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Saba TalentSpace.

To configure and test Microsoft Entra SSO with Saba TalentSpace, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    * **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Saba TalentSpace SSO](#configure-saba-talentspace-sso)** - to configure the single sign-on settings on application side.
    * **[Create Saba TalentSpace test user](#create-saba-talentspace-test-user)** - to have a counterpart of B.Simon in Saba TalentSpace that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Saba TalentSpace** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Sign on URL** text box, type the URL using the following pattern:
    `https://global.hgncloud.com/<COMPANY_NAME>/saml/login`

	b. In the **Identifier (Entity ID)** text box, type the URL using the following pattern:
    `https://global.hgncloud.com/<COMPANY_NAME>/saml/metadata`

    c. In the **Reply URL (Assertion Consumer Service URL)** text box, type the URL using the following pattern:
    `https://global.hgncloud.com/<COMPANY_NAME>/saml/SSO`

	> [!NOTE]
	> These values are not real. Update these values with the actual Sign on URL and Identifier. Contact [Saba TalentSpace Client support team](https://support.saba.com/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, click **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Saba TalentSpace** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Saba TalentSpace.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Saba TalentSpace**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Saba TalentSpace SSO

1. In a different browser window, sign-on to your **Saba TalentSpace** application as an administrator.

2. Click the **Options** tab.
  
    ![Screenshot that shows the "saba TalentSpace" home page with the "Options" tab selected.](./media/halogen-software-tutorial/tutorial-halogen-12.png)

3. In the left navigation pane, click **SAML Configuration**.
  
    ![Screenshot that shows the "User Interface" left navigation pane with "S A M L Configuration" selected.](./media/halogen-software-tutorial/tutorial-halogen-13.png)

4. On the **SAML Configuration** page, perform the following steps:

    ![Screenshot that shows the "S A M L Configuration" page with the "Settings" options highlighted.](./media/halogen-software-tutorial/tutorial-halogen-14.png)

    a. As **Unique Identifier**, select **NameID**.

    b. As **Unique Identifier Maps To**, select **Username**, **Email Address**, or **Employee ID**. This is the field that needs to match with the Azure primary attribute.
  
    c. To upload your downloaded metadata file, click **Browse** to select the file, and then **Upload File**.

    d. To test the configuration, click **Run Test**.

    > [!NOTE]
    > You need to wait for the message "*The SAML test is complete. Please close this window*". Then, close the opened browser window. The **Enable SAML** checkbox is only enabled if the test has been completed.

    e. Select **Enable SAML**.

    f. Click **Save Changes**.

### Create Saba TalentSpace test user

The objective of this section is to create a user called Britta Simon in Saba TalentSpace.

**To create a user called Britta Simon in Saba TalentSpace, perform the following steps:**

1. Sign on to your **Saba TalentSpace** application as an administrator.

2. Click the **User Center** tab, and then click **Create User**.

    ![Screenshot that shows the "User Center" tab and "Create User" selected.](./media/halogen-software-tutorial/tutorial-halogen-300.png)  

3. On the **New User** dialog page, perform the following steps:

    ![What is Microsoft Entra Connect](./media/halogen-software-tutorial/tutorial-halogen-301.png)

    a. In the **First Name** textbox, type first name of the user like **B**.

    b. In the **Last Name** textbox, type last name of the user like **Simon**.

    c. In the **Username** textbox, type **B.Simon**, the user name as.

    d. In the **Password** textbox, type a password for B.Simon.

    e. Click **Save**.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Saba TalentSpace Sign-on URL where you can initiate the login flow. 

* Go to Saba TalentSpace Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Saba TalentSpace tile in the My Apps, you should be automatically signed in to the Saba TalentSpace for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

 Once you configure Saba TalentSpace you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
