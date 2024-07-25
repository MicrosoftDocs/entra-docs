---
title: Microsoft Entra SSO integration with Othership Workplace Scheduler
description: Learn how to configure single sign-on between Microsoft Entra ID and Othership Workplace Scheduler.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Othership Workplace Scheduler so that I can control who has access to Othership Workplace Scheduler, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Othership Workplace Scheduler

In this tutorial, you'll learn how to integrate Othership Workplace Scheduler with Microsoft Entra ID. When you integrate Othership Workplace Scheduler with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Othership Workplace Scheduler.
* Enable your users to be automatically signed-in to Othership Workplace Scheduler with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with Othership Workplace Scheduler, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Othership Workplace Scheduler single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Othership Workplace Scheduler supports only **IDP** initiated SSO.
* Othership Workplace Scheduler supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Othership Workplace Scheduler from the gallery

To configure the integration of Othership Workplace Scheduler into Microsoft Entra ID, you need to add Othership Workplace Scheduler from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Othership Workplace Scheduler** in the search box.
1. Select **Othership Workplace Scheduler** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for Othership Workplace Scheduler

Configure and test Microsoft Entra SSO with Othership Workplace Scheduler using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Othership Workplace Scheduler.

To configure and test Microsoft Entra SSO with Othership Workplace Scheduler, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
   1. **[Create a Microsoft Entra test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
   1. **[Assign the Microsoft Entra test user](#assign-the-microsoft-entra-id-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Othership Workplace Scheduler SSO](#configure-othership-workplace-scheduler-sso)** - to configure the single sign-on settings on application side.
   1. **[Create Othership Workplace Scheduler test user](#create-othership-workplace-scheduler-test-user)** - to have a counterpart of B.Simon in Othership Workplace Scheduler that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Othership Workplace Scheduler** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the application is preconfigured and the necessary URLs are already prepopulated with Microsoft Entra. The user needs to save the configuration by clicking the **Save** button.

1. Othership Workplace Scheduler application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Othership Workplace Scheduler application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute |
	| ---- | ---------------- |
	| first_name | user.givenname |
	| last_name | user.surname |
	| email | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Othership Workplace Scheduler** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-a-microsoft-entra-id-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

<a name='assign-the-microsoft-entra-id-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to Othership Workplace Scheduler.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Othership Workplace Scheduler**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Othership Workplace Scheduler SSO

1. Log in to Othership Workplace Scheduler company site as an administrator.

1. Go to **Settings** > **Organisation Settings** > **Organisation Integrations** and click **+ Add** SAML 2.0.

   ![Screenshot shows the path to Configure.](./media/othership-workplace-scheduler-tutorial/settings.png "Settings")

1. In the **Add SAML Configuration** page, perform the following steps:

   ![Screenshot shows the Configuration.](./media/othership-workplace-scheduler-tutorial/configure.png "Configuration")

   1. Select **Microsoft Entra ID** as a **Provider** from the drop-down.

   1. In the **SAML SSO (Sign On URL)** text box, paste the **Login URL** value, which you have copied from the Microsoft Entra admin center.

   1. In the **Identity Provider Issuer** textbox, paste the **Microsoft Entra Identifier** value, which you have copied from the Microsoft Entra admin center.

   1. Click Import IDP Metadata to import the **Federation Metadata XML** file you previously downloaded, after which the Certificate will appear in the **Public Certificate** textbox.

   1. Click **Save Configuration**.

### Create Othership Workplace Scheduler test user

In this section, a user called Britta Simon is created in Othership Workplace Scheduler. Othership Workplace Scheduler supports just-in-time user provisioning, which is enabled by default. There is no action item for you in this section. If a user doesn't already exist in Othership Workplace Scheduler, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Click on Test this application in Microsoft Entra admin center and you should be automatically signed in to the Othership Workplace Scheduler for which you set up the SSO.
 
* You can use Microsoft My Apps. When you click the Othership Workplace Scheduler tile in the My Apps, you should be automatically signed in to the Othership Workplace Scheduler for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Othership Workplace Scheduler you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
