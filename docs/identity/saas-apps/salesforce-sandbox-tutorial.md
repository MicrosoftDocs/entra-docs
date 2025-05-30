---
title: Configure Salesforce Sandbox for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Salesforce Sandbox.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Salesforce Sandbox so that I can control who has access to Salesforce Sandbox, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Salesforce Sandbox for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Salesforce Sandbox with Microsoft Entra ID. When you integrate Salesforce Sandbox with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Salesforce Sandbox.
* Enable your users to be automatically signed-in to Salesforce Sandbox with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Salesforce Sandbox single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Salesforce Sandbox supports **SP and IDP** initiated SSO
* Salesforce Sandbox supports **Just In Time** user provisioning
* Salesforce Sandbox supports [**Automated** user provisioning](salesforce-sandbox-provisioning-tutorial.md)

## Adding Salesforce Sandbox from the gallery

To configure the integration of Salesforce Sandbox into Microsoft Entra ID, you need to add Salesforce Sandbox from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Salesforce Sandbox** in the search box.
1. Select **Salesforce Sandbox** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-salesforce-sandbox'></a>

## Configure and test Microsoft Entra SSO for Salesforce Sandbox

Configure and test Microsoft Entra SSO with Salesforce Sandbox using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Salesforce Sandbox.

To configure and test Microsoft Entra SSO with Salesforce Sandbox, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Salesforce Sandbox SSO](#configure-salesforce-sandbox-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Salesforce Sandbox test user](#create-salesforce-sandbox-test-user)** - to have a counterpart of B.Simon in Salesforce Sandbox that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Salesforce Sandbox** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file** and wish to configure in **IDP** initiated mode perform the following steps:

	a. Select **Upload metadata file**.

    ![Upload metadata file](common/upload-metadata.png)

	b. Select **folder logo** to select the metadata file and select **Upload**.

	![choose metadata file](common/browse-upload-metadata.png)

	> [!NOTE]
    > You get the service provider metadata file from the Salesforce Sandbox admin portal which is explained later in the article.

	c. After the metadata file is successfully uploaded, the **Reply URL** value gets auto populated in **Reply URL** textbox.

	![image](common/both-replyurl.png)

	> [!Note]
	> If the **Reply URL** value don't get auto populated, then fill in the value manually according to your requirement.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Salesforce Sandbox** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Salesforce Sandbox SSO

1. Open a new tab in your browser and sign in to your Salesforce Sandbox administrator account.

2. Select the **Setup** under **settings icon** on the top right corner of the page.

    ![Screenshot that shows the "Settings" icon in the top-right selected, and "Setup" selected from the drop-down.](./media/salesforce-sandbox-tutorial/configure1.png)

3. Scroll down to the **SETTINGS** in the left navigation pane, select **Identity** to expand the related section. Then select **Single Sign-On Settings**.

    ![Screenshot that shows the "Settings" menu in the left pane, with "Single Sign-On Settings" selected from the "Identity" menu.](./media/salesforce-sandbox-tutorial/sf-admin-sso.png)

4. On the **Single Sign-On Settings** page, select the **Edit** button.

    ![Screenshot that shows the "Single Sign-On Settings" page with the "Edit" button selected.](./media/salesforce-sandbox-tutorial/configure3.png)

5. Select **SAML Enabled**, and then select **Save**.

	![Screenshot that shows the "Single Sign-On Settings" page with the "S A M L Enabled" checkbox selected and the "Save" button selected.](./media/salesforce-sandbox-tutorial/sf-enable-saml.png)

6. To configure your SAML single sign-on settings, select **New from Metadata File**.

	![Screenshot that shows the "Single Sign-On Settings" page with the "New from Metadata File" button selected.](./media/salesforce-sandbox-tutorial/sf-admin-sso-new.png)

7. Select **Choose File** to upload the metadata XML file which you have downloaded and select **Create**.

    ![Screenshot that shows the "Single Sign-On Settings" page with the "Choose File" and "Create" buttons selected.](./media/salesforce-sandbox-tutorial/xmlchoose.png)

8. On the **SAML Single Sign-On Settings** page, fields populate automatically and select save.

    ![Screenshot that shows the "Single Sign-On Settings" page with fields populated and the "Save" button selected.](./media/salesforce-sandbox-tutorial/salesforcexml.png)

9. On the **Single Sign-On Settings** page, select the **Download Metadata** button to download the service provider metadata file. Use this file in the **Basic SAML Configuration** section in the Azure portal for configuring the necessary URLs as explained above.

    ![Screenshot that shows the "Single Sign-On Settings" page with the "Download Metadata" button selected.](./media/salesforce-sandbox-tutorial/configure4.png)

10. If you wish to configure the application in **SP** initiated mode, following are the prerequisites for that:

    a. You should have a verified domain.

    b. You need to configure and enable your domain on Salesforce Sandbox, steps for this are explained later in this article.

    c. In the Azure portal, on the **Basic SAML Configuration** section, select **Set additional URLs** and perform the following step:
  
    ![Salesforce Sandbox Domain and URLs single sign-on information](common/both-signonurl.png)

    In the **Sign-on URL** textbox, type the value using the following pattern: `https://<instancename>--Sandbox.<entityid>.my.salesforce.com`

    > [!NOTE]
    > This value should be copied from the Salesforce Sandbox portal once you have enabled the domain.

11. On the **SAML Signing Certificate** section, select **Federation Metadata XML** and then save the xml file on your computer.

	![The Certificate download link](common/metadataxml.png)

12. Open a new tab in your browser and sign in to your Salesforce Sandbox administrator account.

13. Select the **Setup** under **settings icon** on the top right corner of the page.

    ![Screenshot that shows the "Settings" icon in the top-right selected, and "Setup" selected from the drop-down menu.](./media/salesforce-sandbox-tutorial/configure1.png)

14. Scroll down to the **SETTINGS** in the left navigation pane, select **Identity** to expand the related section. Then select **Single Sign-On Settings**.

    ![Screenshot that shows the "Settings" menu in the left navigation pane, with "Single Sign-On Settings" selected from the "Identity" menu.](./media/salesforce-sandbox-tutorial/sf-admin-sso.png)

15. On the **Single Sign-On Settings** page, select the **Edit** button.

    ![Screenshot that shows the "Single Sign-On Settings" page with "Edit" button selected.](./media/salesforce-sandbox-tutorial/configure3.png)

16. Select **SAML Enabled**, and then select **Save**.

	![Screenshot that shows the "Single Sign-On Settings" page with the "S A M L Enabled" box checked and the "Save" button selected.](./media/salesforce-sandbox-tutorial/sf-enable-saml.png)

17. To configure your SAML single sign-on settings, select **New from Metadata File**.

	![Screenshot that shows the "Single Sign-On Settings" page and "New from Metadata File" button selected.](./media/salesforce-sandbox-tutorial/sf-admin-sso-new.png)

18. Select **Choose File** to upload the metadata XML file and select **Create**.

    ![Screenshot that shows the "Single Sign-On Settings" page with the "Choose File" button and "Create" button selected.](./media/salesforce-sandbox-tutorial/xmlchoose.png)

19. On the **SAML Single Sign-On Settings** page, fields populate automatically, type the name of the configuration (for example: *SPSSOWAAD_Test*), in the **Name** textbox and select save.

    ![Screenshot that shows the "Single Sign-On Settings" page with fields populated, an example name in the "Name" textbox, and the "Save" button selected.](./media/salesforce-sandbox-tutorial/sf-saml-config.png)

20. To enable your domain on Salesforce Sandbox, perform the following steps:

    > [!NOTE]
    > Before enabling the domain you need to create the same on Salesforce Sandbox. For more information, see [Defining Your Domain Name](https://help.salesforce.com/HTViewHelpDoc?id=domain_name_define.htm&language=en_US). Once the domain is created, please make sure that it's configured correctly.

21. On the left navigation pane in Salesforce Sandbox, select **Company Settings** to expand the related section, and then select **My Domain**.

    ![Screenshot that shows the "Company Settings" and "My Domain" selected from the left navigation pane.](./media/salesforce-sandbox-tutorial/sf-my-domain.png)

22. In the **Authentication Configuration** section, select **Edit**.

    ![Screenshot that shows the "Authentication Configuration" section, with the "Edit" button selected.](./media/salesforce-sandbox-tutorial/sf-edit-auth-config.png)

23. In the **Authentication Configuration** section, as **Authentication Service**, select the name of the SAML Single Sign-On Setting which you have set during SSO configuration in Salesforce Sandbox and select **Save**.

    ![Configure Single Sign-On](./media/salesforce-sandbox-tutorial/configure2.png)

### Create Salesforce Sandbox test user

In this section, a user called Britta Simon is created in Salesforce Sandbox. Salesforce Sandbox supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Salesforce Sandbox, a new one is created when you attempt to access Salesforce Sandbox. Salesforce Sandbox also supports automatic user provisioning, you can find more details [here](salesforce-sandbox-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Salesforce Sandbox Sign on URL where you can initiate the login flow.  

* Go to Salesforce Sandbox Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Salesforce Sandbox for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the Salesforce Sandbox tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Salesforce Sandbox for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure the Salesforce Sandbox you can enforce session controls, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session controls extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
