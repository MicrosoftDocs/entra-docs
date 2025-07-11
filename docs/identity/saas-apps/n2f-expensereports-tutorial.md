---
title: Configure N2F - Expense reports for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and N2F - Expense reports.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and N2F - Expense reports so that I can control who has access to N2F - Expense reports, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure N2F - Expense reports for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate N2F - Expense reports with Microsoft Entra ID. When you integrate N2F - Expense reports with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to N2F - Expense reports.
* Enable your users to be automatically signed-in to N2F - Expense reports with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* N2F - Expense reports single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* N2F - Expense reports supports **SP** and **IDP** initiated SSO.

## Add N2F - Expense reports from the gallery

To configure the integration of N2F - Expense reports into Microsoft Entra ID, you need to add N2F - Expense reports from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **N2F - Expense reports** in the search box.
1. Select **N2F - Expense reports** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-n2f---expense-reports'></a>

## Configure and test Microsoft Entra SSO for N2F - Expense reports

Configure and test Microsoft Entra SSO with N2F - Expense reports using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in N2F - Expense reports.

To configure and test Microsoft Entra SSO with N2F - Expense reports, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure N2F - Expense reports SSO](#configure-n2f---expense-reports-sso)** - to configure the single sign-on settings on application side.
    1. **[Create N2F - Expense reports test user](#create-n2f---expense-reports-test-user)** - to have a counterpart of B.Simon in N2F - Expense reports that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **N2F - Expense reports** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, the user doesn't have to perform any steps as the app is already pre-integrated with Azure.

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://www.n2f.com/app/`

6. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

7. On the **Set up myPolicies** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure N2F - Expense reports SSO

1. In a different web browser window, sign in to your N2F - Expense reports company site as an administrator.

2. Select **Settings** and then select **Advance Settings** from the dropdown.

	![Screenshot shows Advanced Settings selected.](./media/n2f-expensereports-tutorial/profile.png)

3. Select **Account settings** tab.

	![Screenshot shows Account settings selected.](./media/n2f-expensereports-tutorial/account.png)

4. Select **Authentication** and then select **+ Add an authentication method** tab.

	![Screenshot shows Account Setting Authentication where you can add an authentication method.](./media/n2f-expensereports-tutorial/general.png)

5. Select **SAML Microsoft Office 365** as Authentication method.

	![Screenshot shows Authentication method with SAML Microsoft Office 365 selected.](./media/n2f-expensereports-tutorial/method.png)

6. On the **Authentication method** section, perform the following steps:

	![Screenshot shows Authentication method where you can enter the values described.](./media/n2f-expensereports-tutorial/metadata.png)

	a. In the **Entity ID** textbox, paste the **Microsoft Entra Identifier** value, which you copied previously.

	b. In the **Metadata URL** textbox, paste the **App Federation Metadata Url** value, which you copied previously.

	c. Select **Save**.

### Create N2F - Expense reports test user

To enable Microsoft Entra users to log in to N2F - Expense reports, they must be provisioned into N2F - Expense reports. In the case of N2F - Expense reports, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Log in to your N2F - Expense reports company site as an administrator.

2. Select **Settings** and then select **Advance Settings** from the dropdown.

    ![Screenshot shows Advanced Settings selected.](./media/n2f-expensereports-tutorial/profile.png)

3. Select **Users** tab from left navigation panel.

	![Screenshot shows Users selected.](./media/n2f-expensereports-tutorial/user.png)

4. Select **+ New user** tab.

    ![Screenshot shows the New user option.](./media/n2f-expensereports-tutorial/create-user.png)

5. On the **User** section, perform the following steps:

	![Screenshot shows the section where you can enter the values described.](./media/n2f-expensereports-tutorial/values.png)

	a. In the **Email address** textbox, enter the email address of user like **brittasimon\@contoso.com**.

	b. In the **First name** textbox, enter the first name of user like **Britta**.

	c. In the **Name** textbox, enter the name of user like **BrittaSimon**.

	d. Choose **Role, Direct manager (N+1)**, and **Division** as per your organization requirement.

	e. Select **Validate and send invitation**.

	> [!NOTE]
	> If you're facing any problems while adding the user, please contact [N2F - Expense reports support team](mailto:support@n2f.com)

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to N2F - Expense reports Sign on URL where you can initiate the login flow.  

* Go to N2F - Expense reports Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the N2F - Expense reports for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the N2F - Expense reports tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the N2F - Expense reports for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure N2F - Expense reports you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
