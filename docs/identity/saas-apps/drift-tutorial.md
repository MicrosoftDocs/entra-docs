---
title: Configure Drift for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Drift.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Drift so that I can control who has access to Drift, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Drift for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Drift with Microsoft Entra ID. When you integrate Drift with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Drift.
* Enable your users to be automatically signed-in to Drift with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Drift single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Drift supports **SP and IDP** initiated SSO.
* Drift supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Drift from the gallery

To configure the integration of Drift into Microsoft Entra ID, you need to add Drift from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Drift** in the search box.
1. Select **Drift** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-drift'></a>

## Configure and test Microsoft Entra SSO for Drift

Configure and test Microsoft Entra SSO with Drift using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Drift.

To configure and test Microsoft Entra SSO with Drift, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Drift SSO](#configure-drift-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Drift test user](#create-drift-test-user)** - to have a counterpart of B.Simon in Drift that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Drift** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

	a. Select **Set additional URLs**.
 
	b. In the **Relay State** text box, type the URL:
    `https://app.drift.com` 

1. Perform the following step if you wish to configure the application in SP initiated mode, select Set additional URLs :

	a. In the **Sign-on URL** text box, type the URL:
    `https://start.drift.com`

6. Your Drift application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

7. In addition to above, Drift application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirement. 

	| Name | Source Attribute|
	| ---------------| --------------- |    
	| Name | user.displayname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Drift** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Drift SSO




1. In a different web browser window, sign in to your Drift company site as an administrator

4. From the left side of menu bar, select **Settings icon** > **App Settings** > **Authentication** and perform the following steps:

	![The Admin link](./media/drift-tutorial/admin.png)

	a. Upload the **Federation Metadata XML** that you have downloaded, into the **Upload Identity Provider metadata file** text box.

	b. After uploading the metadata file, the remaining values get auto populated on the page automatically.

	c. Select **Enable SAML**.

### Create Drift test user

In this section, a user called Britta Simon is created in Drift. Drift supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Drift, a new one is created after authentication.

>[!Note]
>If you need to create a user manually, contact [Drift support team](mailto:integrations@drift.com).

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Drift Sign on URL where you can initiate the login flow.  

* Go to Drift Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Drift for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Drift tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Drift for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Drift you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
