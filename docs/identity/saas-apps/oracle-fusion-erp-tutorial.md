---
title: 'Tutorial: Microsoft Entra SSO integration with Oracle Fusion ERP'
description: Learn how to configure single sign-on between Microsoft Entra ID and Oracle Fusion ERP.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Oracle Fusion ERP so that I can control who has access to Oracle Fusion ERP, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Oracle Fusion ERP

In this tutorial, you learn how to integrate Oracle Fusion ERP with Microsoft Entra ID. When you integrate Oracle Fusion ERP with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Oracle Fusion ERP.
* Enable your users to be automatically signed-in to Oracle Fusion ERP with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Oracle Fusion ERP single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Oracle Fusion ERP supports **SP and IDP** initiated SSO.
* Oracle Fusion ERP supports [**Automated** user provisioning and deprovisioning](oracle-fusion-erp-provisioning-tutorial.md) (recommended).

## Add Oracle Fusion ERP from the gallery

To configure the integration of Oracle Fusion ERP into Microsoft Entra ID, you need to add Oracle Fusion ERP from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Oracle Fusion ERP** in the search box.
1. Select **Oracle Fusion ERP** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-oracle-fusion-erp'></a>

## Configure and test Microsoft Entra SSO for Oracle Fusion ERP

Configure and test Microsoft Entra SSO with Oracle Fusion ERP using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Oracle Fusion ERP.

To configure and test Microsoft Entra SSO with Oracle Fusion ERP, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Oracle Fusion ERP SSO](#configure-oracle-fusion-erp-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Oracle Fusion ERP test user](#create-oracle-fusion-erp-test-user)** - to have a counterpart of B.Simon in Oracle Fusion ERP that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Oracle Fusion ERP** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following step:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.login.em2.oraclecloud.com:443/oam/fed`

    b. In the **Reply URL** text box, type a URL using the following pattern: 
    `https://<SUBDOMAIN>.login.em2.oraclecloud.com:443/oam/fed`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode. This is optional:

    In the **Sign-on URL** text box, type a URL using the following pattern: 
    `https://<SUBDOMAIN>.fa.em2.oraclecloud.com/fscmUI/faces/AtkHomePageWelcome`

	> [!NOTE]
	> These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Oracle Fusion ERP Client support team](https://www.oracle.com/applications/erp/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Oracle Fusion ERP** section, copy one or more appropriate URLs based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you create a test user called B.Simon.

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

In this section, you enable B.Simon to use single sign-on by granting access to Oracle Fusion ERP.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Oracle Fusion ERP**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Added Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Added Assignment** dialog, select the **Assign** button.

## Configure Oracle Fusion ERP SSO

To configure single sign-on on **Oracle Fusion ERP** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Oracle Fusion ERP support team](https://www.oracle.com/applications/erp/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Oracle Fusion ERP test user

In this section, you create a user called Britta Simon in Oracle Fusion ERP. Work with [Oracle Fusion ERP support team](https://www.oracle.com/applications/erp/) to add the users in the Oracle Fusion ERP platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select on **Test this application**, this will redirect to Oracle Fusion ERP Sign-on URL where you can initiate the sign in flow.  

* Go to Oracle Fusion ERP Sign-on URL directly and initiate the sign in flow from there.

#### IDP initiated:

* Select on **Test this application**, and you should be automatically signed in to the Oracle Fusion ERP for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Oracle Fusion ERP tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the sign in flow and if configured in IDP mode, you should be automatically signed in to the Oracle Fusion ERP for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Oracle Fusion ERP you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
