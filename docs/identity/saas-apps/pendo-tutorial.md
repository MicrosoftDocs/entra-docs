---
title: Configure Pendo for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Pendo.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Pendo so that I can control who has access to Pendo, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Pendo for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Pendo with Microsoft Entra ID. When you integrate Pendo with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Pendo.
* Enable your users to be automatically signed-in to Pendo with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Pendo single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Pendo supports both **SP** and **IDP** initiated SSO.

## Add Pendo from the gallery

To configure the integration of Pendo into Microsoft Entra ID, you need to add Pendo from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Pendo** in the search box.
1. Select **Pendo** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-pendo'></a>

## Configure and test Microsoft Entra SSO for Pendo

Configure and test Microsoft Entra SSO with Pendo using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Pendo.

To configure and test Microsoft Entra SSO with Pendo, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Pendo SSO](#configure-pendo-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Pendo test user](#create-pendo-test-user)** - to have a counterpart of B.Simon in Pendo that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Pendo** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set-up single sign-on with SAML** page, perform the following steps:

    a. In the **Identifier** text box, enter `PingConnect`. (If this identifier is already used by another application, contact the [Pendo support team](https://support.pendo.io/hc/articles/360034163971-Get-help-with-Pendo-from-Technical-Support).)
    

    b. In the **Relay State** text box, type a URL using the following pattern:
    `https://pingone.com/1.0/<CUSTOM_GUID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Relay State. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Pendo application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **name** is mapped with **user.userprincipalname**. Pendo application expects **name** to be mapped with **user.mail**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

	![image](common/edit-attribute.png)

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **App Federation Metadata Url** (preferred) OR plain XML under **Federation Metadata XML** and select **Download** to download the metadata and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Pendo** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Pendo SSO

To configure single sign-on on **Pendo** side, you need to send the **App Federation Metadata Url** (preferred) or downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Pendo support team](https://support.pendo.io/hc/articles/360034163971-Get-help-with-Pendo-from-Technical-Support). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Pendo test user

In this section, you create a user called Britta Simon in Pendo. Work with [Pendo support team](https://support.pendo.io/hc/articles/360034163971-Get-help-with-Pendo-from-Technical-Support) to add the users in the Pendo platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Pendo Sign on URL where you can initiate the login flow.  

* Go to Pendo Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Pendo for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Pendo tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Pendo for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Pendo you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
