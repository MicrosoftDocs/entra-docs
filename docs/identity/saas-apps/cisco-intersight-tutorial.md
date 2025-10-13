---
title: Configure Cisco Intersight for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cisco Intersight.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cisco Intersight so that I can control who has access to Cisco Intersight, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Cisco Intersight for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cisco Intersight with Microsoft Entra ID. When you integrate Cisco Intersight with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cisco Intersight.
* Enable your users to be automatically signed-in to Cisco Intersight with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cisco Intersight single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Cisco Intersight supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Cisco Intersight from the gallery

To configure the integration of Cisco Intersight into Microsoft Entra ID, you need to add Cisco Intersight from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cisco Intersight** in the search box.
1. Select **Cisco Intersight** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

  For step-by-step guidance on adding enterprise applications, refer to [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-cisco-intersight'></a>

## Configure and test Microsoft Entra SSO for Cisco Intersight

Configure and test Microsoft Entra SSO with Cisco Intersight using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cisco Intersight.

To configure and test Microsoft Entra SSO with Cisco Intersight, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cisco Intersight SSO](#configure-cisco-intersight-sso)** - to configure the single sign-on settings on application side.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cisco Intersight** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type the URL:
    `https://intersight.com`

    b. In the **Identifier (Entity ID)** text box, type the URL:
    `www.intersight.com`

1. Your Cisco Intersight application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Cisco Intersight expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration..

	![image](common/default-attributes.png)

1. In addition to above, Cisco Intersight application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| -------------- | --------- |
	| First_Name | user.givenname |
	| Last_Name | user.surname |
	| memberOf | user.groups |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Cisco Intersight** section, copy one or more appropriate URLs based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cisco Intersight SSO

To configure single sign-on on **Cisco Intersight** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Cisco Intersight support team](mailto:intersight-feedback@cisco.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cisco Intersight test user

### Configuring and Testing Microsoft Entra SSO for Cisco Intersight

The SSO configuration for Cisco Intersight is now self-service and managed directly through the Cisco Intersight platform. To complete the setup, visit the Cisco Intersight Help Center and follow their up-to-date guidance: [Cisco Intersight Help Documentation](https://www.intersight.com/help/saas)

#### Steps Overview:
1. Sign in to Cisco Intersight.
    1. Navigate to the **Settings** section.
    1. Access the **SSO Configuration** page.
1. Follow the self-service setup instructions provided in the Cisco Intersight Help documentation to configure the necessary SAML attributes, metadata, and certificate details.
1. Test the integration using the built-in testing tools available in both Microsoft Entra ID and Cisco Intersight to ensure seamless SSO.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Cisco Intersight Sign-on URL where you can initiate the sign in flow. 

* Go to Cisco Intersight Sign on URL directly and initiate the sign in flow from there.

* You can use Microsoft My Apps. When you select the Cisco Intersight tile in the My Apps, this option redirects to Cisco Intersight Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Cisco Intersight you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
