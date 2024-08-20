---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Nulab Pass (Backlog, Cacoo, and Typetalk)'
description: Learn how to configure single sign-on between Microsoft Entra ID and Nulab Pass (Backlog, Cacoo, and Typetalk).

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 07/01/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Nulab Pass (Backlog, Cacoo, and Typetalk) so that I can control who has access to Nulab Pass (Backlog, Cacoo, and Typetalk), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Nulab Pass (Backlog, Cacoo, and Typetalk)

In this tutorial, you'll learn how to integrate Nulab Pass (Backlog, Cacoo, and Typetalk) with Microsoft Entra ID. By integrating, you can:

* Control in Microsoft Entra ID who has access to Nulab Pass in Microsoft Entra ID.
* Enable users to be automatically signed in to Nulab Pass with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need:

* A Microsoft Entra subscription or [free account](https://azure.microsoft.com/free/).
* Nulab Pass SSO-enabled subscription.

## Scenario description

In this tutorial, you’ll configure and test Microsoft Entra SSO in a test environment. Nulab Pass supports both **SP and IDP**-initiated SSO.

## Add Nulab Pass from the gallery

To configure the integration of Nulab Pass into Microsoft Entra ID, add Nulab Pass from the gallery to your list of managed SaaS apps.

1. Go to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Nulab Pass** in the search box.
1. Select **Nulab Pass** from results panel and add the app.
1. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-nulab-pass-backlogcacootypetalk'></a>

## Configure and test Microsoft Entra SSO for Nulab Pass

Configure and test Microsoft Entra SSO with Nulab Pass using a test user called B.Simon. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Nulab Pass.

To configure and test Microsoft Entra SSO with Nulab Pass:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** to test Microsoft Entra SSO with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** to enable B.Simon to use Microsoft Entra SSO.
1. **[Configure Nulab Pass SSO](#configure-nulab-pass-sso)** to configure the SSO settings on the application side.
    1. **[Create Nulab Pass test user](#create-nulab-pass-test-user)** to have a counterpart of B.Simon in Nulab Pass that’s linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

To enable Microsoft Entra SSO:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Go to **Identity** > **Applications** > **Enterprise applications** > **Nulab Pass (Backlog,Cacoo,Typetalk)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. In the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
   `https://apps.nulab.com/signin/spaces/<Space_Key>/saml`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://apps.nulab.com/signin/spaces/<Space_Key>/saml/callback`

1. Perform the following step to configure the application in **SP** initiated mode:

    In the **Sign on URL** text box, type the URL:
   `https://apps.nulab.com/signin`

	> [!NOTE]
	> These values are not real and should be updated with the actual Identifier, Reply URL, and Sign on URL found in your Nulab Pass organization settings. In your organization settings:
	>  1. Select **Single Sign-On** from the menu on the left.
 	>  2. Press the **Manage** button to display the **Manage SAML authentication** dialog.
	>  3. Copy **SP Entity ID** and **SP Endpoint URL (ACS)** values and paste in the Entra side configuration.
 	>  4. For more information, please refer [how to set up SAML authentication](https://support.nulab.com/hc/en-us/articles/6478805477401) documentation.	

1. Your Nulab Pass application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname**, but Nulab Pass expects this to be mapped with the user's email. Use the **user.mail** attribute from the list or the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)

1. On the **Set up single sign-on with SAML** page in the **SAML Signing Certificate** section, you will find the **Certificate (Base64)**. Select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. In the **Set up Nulab Pass** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Go to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties
   1. Ener `B.Simon` in the **Display name** field.  
   1. Enter the username@companydomain.extension in the **User principal name** field. (E.g., `B.Simon@contoso.com`).
   1. Select the **Show password** check box and write down the value displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use SSO by granting access to Nulab Pass.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Go to **Identity** > **Applications** > **Enterprise applications** > **Nulab Pass**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group** and then **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the users list and then the **Select** button at the bottom of the screen.
   1. If you’re expecting users to be assigned a role, select it from the **Select a role** dropdown. If no role has been set up for this app, **Default Access** role is selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Nulab Pass SSO

You must configure **[Domain authentication](https://support.nulab.com/hc/en-us/articles/6558108028825)** before configure SSO.

To configure SSO in **Nulab Pass**, set the **Certificate (Base64)** and URLs from the application configuration to ensure that the SSO connection is set on both sides. To do this:

1. Go to your Nulab Pass organization settings.
2. Select **Single Sign-On** from the menu on the left.
3. Press the **Manage** button to display the **Manage SAML authentication** dialog.
4. Enter the following:
   * IdP Entity ID
   * IdP Endpoint URL
   * X.509 Certificate (Base64)

Please refer [how to set up SAML authentication](https://support.nulab.com/hc/en-us/articles/6478805477401) documentation for more details.

### Create Nulab Pass test user

Next, you’ll create a user called `Britta Simon` in Nulab Pass by [adding a Managed Account](https://support.nulab.com/hc/en-us/articles/6480291067801). Users must be created and activated before you use SSO.

## Test SSO 

Now, you’ll test your Microsoft Entra SSO configuration using one of the following options: 

#### SP initiated:

* Click on **Test this application** to be redirected to Nulab Pass to sign in.  

* Or, go to the Nulab Pass sign in page directly and initiate the flow from there.

#### IDP initiated:

* Click on **Test this application** to be automatically signed in to SSO-enabled Nulab Pass. 

You can also use Microsoft My Apps to test the application in any mode. When you click the Nulab Pass tile in My Apps, you’ll be redirected to the application sign on page for initiating the login flow if it was configured in SP mode. If configured in IDP mode, you’ll be automatically signed in to SSO-enabled Nulab Pass. [Learn more about My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

With Nulab Pass configured, you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).