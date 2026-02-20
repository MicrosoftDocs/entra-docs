---
title: Configure Wootric for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Wootric.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Wootric so that I can control who has access to Wootric, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Wootric for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Wootric with Microsoft Entra ID. When you integrate Wootric with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Wootric.
* Enable your users to be automatically signed-in to Wootric with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Wootric single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Wootric supports **IDP** initiated SSO.
* Wootric supports **Just In Time** user provisioning.

## Adding Wootric from the gallery

To configure the integration of Wootric into Microsoft Entra ID, you need to add Wootric from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Wootric** in the search box.
1. Select **Wootric** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-wootric'></a>

## Configure and test Microsoft Entra SSO for Wootric

Configure and test Microsoft Entra SSO with Wootric using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Wootric.

To configure and test Microsoft Entra SSO with Wootric, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Wootric SSO](#configure-wootric-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Wootric test user](#create-wootric-test-user)** - to have a counterpart of B.Simon in Wootric that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Wootric** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.


1. Wootric application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, Wootric application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute |
	| -------------- | --------- |
	| id | user.objectid |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Wootric** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Wootric SSO




1. In a different web browser window, sign in to your Wootric company site as an administrator

1. Select **Settings Icon** from the top menu.

	![Screenshot shows the Settings Icon selected from the Wootric site.](./media/wootric-tutorial/configure-1.PNG)

1. In the **INTEGRATIONS**, select **Authentication** from the Left side menu and select **Enable Single Sign On with Microsoft Entra ID**.

1. Perform the following steps in the following page:

	![Screenshot shows the Settings page where you can enter the values described.](./media/wootric-tutorial/configure-3.PNG)

	a. In the **Identity Provider Single Sign-On URL** textbox, paste the **Login URL** value which you copied previously.

	b. In the **Identity Provider Issuer** textbox, paste the **Entity ID** value which you copied previously.

	c. Open the downloaded **Certificate (Base64)** into Notepad and paste the content into the **X.509 Certificate** textbox.

	d. Select **Automatically grant access to new users** checkbox.
	
	e. Select **Save**.

### Create Wootric test user

In this section, a user called B.Simon is created in Wootric. Wootric supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Wootric, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Wootric for which you set up the SSO

* You can use Microsoft My Apps. When you select the Wootric tile in the My Apps, you should be automatically signed in to the Wootric for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Wootric you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
