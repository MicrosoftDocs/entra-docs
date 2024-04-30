---
title: 'Tutorial: Microsoft Entra integration with BambooHR'
description: Learn how to configure single sign-on between Microsoft Entra ID and BambooHR.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BambooHR so that I can control who has access to BambooHR, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra integration with BambooHR

In this tutorial, you'll learn how to integrate BambooHR with Microsoft Entra ID. When you integrate BambooHR with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BambooHR.
* Enable your users to be automatically signed-in to BambooHR with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* BambooHR single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* BambooHR supports **SP** initiated SSO

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.


## Adding BambooHR from the gallery

To configure the integration of BambooHR into Microsoft Entra ID, you need to add BambooHR from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **BambooHR** in the search box.
1. Select **BambooHR** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-bamboohr'></a>

## Configure and test Microsoft Entra SSO for BambooHR

Configure and test Microsoft Entra SSO with BambooHR using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BambooHR.

To configure and test Microsoft Entra SSO with BambooHR, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with Britta Simon.
    * **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure BambooHR SSO](#configure-bamboohr-sso)** - to configure the Single Sign-On settings on application side.
    * **[Create BambooHR test user](#create-bamboohr-test-user)** - to have a counterpart of Britta Simon in BambooHR that is linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **BambooHR** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<company>.bamboohr.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:

    | Reply URL |
    |-----------|
    | `https://<company>.bamboohr.com/saml/consume.php` |
    | `https://<company>.bamboohr.co.uk/saml/consume.php` |

	> [!NOTE]
	> These values are not real. Update these values with actual sign-on URL and Reply URL. Contact [BambooHR Client support team](https://www.bamboohr.com/contact.php) to get the values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, click **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up BambooHR** section, copy the appropriate URL(s) as per your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to BambooHR.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **BambooHR**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure BambooHR SSO

1. In a new window, sign in to your BambooHR company site as an administrator.

2. On the home page, do the following:
   
    ![The BambooHR Single Sign-On page](./media/bamboo-hr-tutorial/ic796691.png "Single Sign-On")   

    a. Select **Apps**.
   
    b. In the **Apps** pane, select **Single Sign-On**.
   
    c. Select **SAML Single Sign-On**.

3. In the **SAML Single Sign-On** pane, do the following:
   
    ![The SAML Single Sign-On pane](./media/bamboo-hr-tutorial/IC796692.png "SAML Single Sign-On")
   
    a. Into the **SSO Login Url** box, paste the **Login URL** that you copied in step 6.
      
    b. In Notepad, open the base-64 encoded certificate that you downloaded, copy its content, and then paste it into the **X.509 Certificate** box.
   
    c. Select **Save**.

### Create BambooHR test user

To enable Microsoft Entra users to sign in to BambooHR, set them up manually in BambooHR by doing the following:

1. Sign in to your **BambooHR** site as an administrator.

2. In the toolbar at the top, select **Settings**.
   
    ![The Settings button](./media/bamboo-hr-tutorial/IC796694.png "Setting")

3. Select **Overview**.

4. In the left pane, select **Security** > **Users**.

5. Type the username, password, and email address of the valid Microsoft Entra account that you want to set up.

6. Select **Save**.
		
>[!NOTE]
>To set up Microsoft Entra user accounts, you can also use BambooHR user account-creation tools or APIs.

### Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Click on **Test this application**, this will redirect to BambooHR Sign-on URL where you can initiate the login flow. 

2. Go to BambooHR Sign-on URL directly and initiate the login flow from there.

3. You can use Microsoft Access Panel. When you click the BambooHR tile in the Access Panel, this will redirect to BambooHR Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Next steps

Once you configure BambooHR you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
