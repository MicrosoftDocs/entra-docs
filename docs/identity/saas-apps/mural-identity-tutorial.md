---
title: 'Tutorial: Microsoft Entra SSO integration with Mural Identity'
description: Learn how to configure single sign-on between Microsoft Entra ID and Mural Identity.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/10/2023
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Mural Identity so that I can control who has access to Mural Identity, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Mural Identity

In this tutorial, you'll learn how to integrate Mural Identity with Microsoft Entra ID. When you integrate Mural Identity with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Mural Identity.
* Enable your users to be automatically signed-in to Mural Identity with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Mural Identity single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Mural Identity supports **SP and IDP** initiated SSO.
* Mural Identity supports **Just In Time** user provisioning.
* Mural Identity supports [Automated user provisioning](mural-identity-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Mural Identity from the gallery

To configure the integration of Mural Identity into Microsoft Entra ID, you need to add Mural Identity from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Mural Identity** in the search box.
1. Select **Mural Identity** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-mural-identity'></a>

## Configure and test Microsoft Entra SSO for Mural Identity

Configure and test Microsoft Entra SSO with Mural Identity using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Mural Identity.

To configure and test Microsoft Entra SSO with Mural Identity, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Mural Identity SSO](#configure-mural-identity-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Mural Identity test user](#create-mural-identity-test-user)** - to have a counterpart of B.Simon in Mural Identity that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Mural Identity** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user does not have to perform any step as the app is already pre-integrated with Azure.

1. Mural Identity application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Mural Identity application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| -------- | --------- |
	| email | user.userprincipalname |
    | FirstName | user.givenname |
    | LastName | user.surname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (PEM)** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/certificate-base64-download.png)

1. On the **Set up Mural Identity** section, copy the appropriate URL(s) based on your requirement.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Mural Identity.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Mural Identity**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Mural Identity SSO

1. Log in to the Mural Identity website as an administrator.

1. Click your **name** in the bottom left corner of the dashboard and select **Company dashboard** from the list of options.

1. Click **SSO** in the left sidebar and perform the below steps.

    ![Screenshot of showing the configuration for MURAL.](./media/mural-identity-tutorial/settings.png)

a. Download the **MURAL's metadata**.

b. In the **Sign in URL** textbox, paste the **Login URL** value, which you copied previously.

c. In the **Sign in certificate**, upload the **Certificate (PEM)**, which you have downloaded. 

d. Select **HTTP-POST** as the Request binding type and select **SHA256** as the Sign-in algorithm type.

e. In the **Claim mapping** section, fill the following fields. 

* Email address: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`

* First name: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`

* Last name: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`

f. Click **Test single sign-on** to test the configuration and **Save** it.

> [!NOTE]
> For more information on how to configure the SSO at MURAL, please follow [this](https://support.mural.co/s/article/configure-sso-with-mural-and-azure-ad) support page.

### Create Mural Identity test user

In this section, a user called Britta Simon is created in Mural Identity. Mural Identity supports just-in-time user provisioning, which is enabled by default. There is no action item for you in this section. If a user doesn't already exist in Mural Identity, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Click on **Test this application**, this will redirect to Mural Identity Sign on URL where you can initiate the login flow.  

* Go to Mural Identity Sign on URL directly and initiate the login flow from there.

#### IDP initiated:

* Click on **Test this application**, and you should be automatically signed in to the Mural Identity for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you click the Mural Identity tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Mural Identity for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Change log

* 03/21/2022 - Application Name updated.

## Next steps

Once you configure Mural Identity you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
