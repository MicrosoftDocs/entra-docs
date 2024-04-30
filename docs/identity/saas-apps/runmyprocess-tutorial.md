---
title: 'Tutorial: Microsoft Entra SSO integration with RunMyProcess'
description: Learn how to configure single sign-on between Microsoft Entra ID and RunMyProcess.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RunMyProcess so that I can control who has access to RunMyProcess, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with RunMyProcess

In this tutorial, you'll learn how to integrate RunMyProcess with Microsoft Entra ID. When you integrate RunMyProcess with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RunMyProcess.
* Enable your users to be automatically signed-in to RunMyProcess with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* RunMyProcess single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* RunMyProcess supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add RunMyProcess from the gallery

To configure the integration of RunMyProcess into Microsoft Entra ID, you need to add RunMyProcess from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **RunMyProcess** in the search box.
1. Select **RunMyProcess** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-runmyprocess'></a>

## Configure and test Microsoft Entra SSO for RunMyProcess

Configure and test Microsoft Entra SSO with RunMyProcess using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in RunMyProcess.

To configure and test Microsoft Entra SSO with RunMyProcess, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RunMyProcess SSO](#configure-runmyprocess-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RunMyProcess test user](#create-runmyprocess-test-user)** - to have a counterpart of B.Simon in RunMyProcess that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **RunMyProcess** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://live.runmyprocess.com/live/<tenant id>`

	> [!NOTE]
	> The value is not real. Update the value with the actual Sign-On URL. Contact [RunMyProcess Client support team](mailto:support@runmyprocess.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up RunMyProcess** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to RunMyProcess.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **RunMyProcess**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then click the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure RunMyProcess SSO

1. In a different web browser window, sign-on to your RunMyProcess tenant as an administrator.

1. In left navigation panel, click **Account** and select **Configuration**.

    ![Screenshot shows Configuration selected from Account.](./media/runmyprocess-tutorial/account.png)

1. Go to **Authentication method** section and perform below steps:

    ![Screenshot shows the Authentication method tab where you can enter the values described.](./media/runmyprocess-tutorial/certificate.png)

    a. As **Method**, select **SSO with Samlv2**.

    b. In the **SSO redirect** textbox, paste the value of **Login URL**.

    c. In the **Logout redirect** textbox, paste the value of **Logout URL**.

    d. In the **Name ID Format** textbox, type the value of **Name Identifier Format** as **urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress**.

    e. Open the downloaded certificate file from Azure portal in notepad, copy the content of certificate file and then paste it into the **Certificate** textbox.

    f. Click **Save** icon.

### Create RunMyProcess test user

In order to enable Microsoft Entra users to sign in to RunMyProcess, they must be provisioned into RunMyProcess. In the case of RunMyProcess, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Sign in to your RunMyProcess company site as an administrator.

1. Click **Account** and select **Users** in left navigation panel, then click **New User**.

    ![New User](./media/runmyprocess-tutorial/user.png "New User")

1. In the **User Settings** section, perform the following steps:

    ![Profile](./media/runmyprocess-tutorial/new-user.png "Profile")
  
    a. Type the **Name** and **E-mail** of a valid Microsoft Entra account you want to provision into the related textboxes.

    b. Select an **IDE language**, **Language**, and **Profile**.

    c. Select **Send account creation e-mail to me**.

    d. Click **Save**.

    > [!NOTE]
    > You can use any other RunMyProcess user account creation tools or APIs provided by RunMyProcess to provision Microsoft Entra user accounts.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to RunMyProcess Sign-on URL where you can initiate the login flow. 

* Go to RunMyProcess Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the RunMyProcess tile in the My Apps, this will redirect to RunMyProcess Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Next steps

Once you configure RunMyProcess you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
