---
title: 'Tutorial: Microsoft Entra SSO integration with Tulip'
description: Learn how to configure single sign-on between Microsoft Entra ID and Tulip.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Tulip so that I can control who has access to Tulip, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra SSO integration with Tulip

In this tutorial, you'll learn how to integrate Tulip with Microsoft Entra ID. When you integrate Tulip with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Tulip.
* Enable your users to be automatically signed-in to Tulip with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Tulip single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Tulip supports **IDP** initiated SSO.

## Add Tulip from the gallery

To configure the integration of Tulip into Microsoft Entra ID, you need to add Tulip from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Tulip** in the search box.
1. Select **Tulip** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-tulip'></a>

## Configure and test Microsoft Entra SSO for Tulip

To configure and test Microsoft Entra SSO with Tulip, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.

1. **[Configure Tulip SSO](#configure-tulip-sso)** - to configure the single sign-on settings on application side.
    1. To configure SSO on a Tulip instance with existing users, reach out to support@tulip.co.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Tulip** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you have **Service Provider metadata file**, perform the following steps:

	a.Download Tulip's Metadata File which is accessible under the settings page on your Tulip instance - 
	
	b. Click **Upload metadata file**. 
	
	![image1](common/upload-metadata.png)

	b. Click on **folder logo** to select the metadata file and click **Upload**.

	![image2](common/browse-upload-metadata.png)

	c. Once the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in Basic SAML Configuration section:

	![image3](common/idp-intiated.png)

	> [!Note]
	> If the **Identifier** and **Reply URL** values are not getting auto populated, then fill in the values manually according to your requirement.

1. Tulip application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. If the ```nameID``` needs to be an email, change the format to be ```Persistent```.

	![image](common/default-attributes.png)

1. In addition to the above, Tulip application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |Source Attribute|
	| -------------- | --------- |
	| displayName | user.displayname |
	| emailAddress |user.mail |
	| badgeID |	user.employeeid |
	| groups |user.groups |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

## Configure Tulip SSO

1. Log in to your Tulip instance as an Account Owner.

1. Go to the **Settings** -> **SAML** and perform the following steps in the below page.

	![Screenshot for tulip configuration.](./media/tulip-tutorial/configuration.png)

	a. **Enable SAML Logins**. 

	b. Click on **metadata xml file** to download the **Service Provider metadata file** and use this file to upload in the **Basic SAML Configuration** section in Azure portal.

	c. Upload the Federation Metadata XML file from Azure to Tulip. This will populate the SSO Login, SSO Logout URL and the Certificates.

	d. Verify that the Name, Email and Badge attributes are not null, that is, enter any unique strings in all three inputs and do a test authentication using the ```Authenticate``` button on the right.
	
	e. Upon successful authentication, copy/paste the entire claim URL into the appropriate mapping for the name, email and badgeID attributes.
	
	* Paste the **Name Attribute** value as `http://schemas.microsoft.com/identity/claims/displayname` or the appropriate claim URL.

	* Paste the **Email Attribute** value as `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` or the appropriate claim URL.

	* Paste the **Badge Attribute** value as `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/badgeID` or the appropriate claim URL.

	* Paste the **Role Attribute** value as `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/groups` or the appropriate claim URL.

	f. Click **Save SAML Configuration**.

## Next steps

Once you configure Tulip you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).

Please reach out to `support@tulip.co` for any further questions including migrating existing users in Tulip to use SAML!
