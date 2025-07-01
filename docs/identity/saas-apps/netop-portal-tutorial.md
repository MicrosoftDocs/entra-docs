---
title: Configure Netop Portal for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Netop Portal.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Netop Portal so that I can control who has access to Netop Portal, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Netop Portal for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Netop Portal with Microsoft Entra ID. When you integrate Netop Portal with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Netop Portal.
* Enable your users to be automatically signed-in to Netop Portal with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Netop Portal single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Netop Portal supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Netop Portal from the gallery

To configure the integration of Netop Portal into Microsoft Entra ID, you need to add Netop Portal from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Netop Portal** in the search box.
1. Select **Netop Portal** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-netop-portal'></a>

## Configure and test Microsoft Entra SSO for Netop Portal

Configure and test Microsoft Entra SSO with Netop Portal using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Netop Portal.

To configure and test Microsoft Entra SSO with Netop Portal, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Netop Portal SSO](#configure-netop-portal-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Netop Portal test user](#create-netop-portal-test-user)** - to have a counterpart of B.Simon in Netop Portal that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Netop Portal** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set-up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. Netop Portal application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

1. In addition to above, Netop Portal application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirement.

	| Name |  Source Attribute|
	| ---------------| --------- |
	| NRC-ACCOUNT-ID | "adfs-demo" |
	| NRC-EMAIL | user.userprincipalname |
	| NRC-GIVEN-NAME | user.givenname |
	| NRC-SURNAME | user.surname |
	| NRC-USERNAME | user.userprincipalname |
	| nameidentifier | user.userprincipalname |
	| | |

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Netop Portal** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Netop Portal SSO

To configure single sign-on on **Netop Portal** side, you need to the downloaded **Federation Metadata XML** and the Login URL from Azure portal. Follow the instructions in Step 3 of the documentation [here](https://support.netop.com/hc/en-us/articles/35623530508435-ADFS-and-Azure-AD-Integration) to configure NetOp Portal for Microsoft Entra authentication.

### Create Netop Portal test user

In this section, you create a user called Britta Simon in Netop Portal. Work with [Netop Portal support team](mailto:casemanager@netop.com) to add the users in the Netop Portal platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Netop Portal for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Netop Portal tile in the My Apps, you should be automatically signed in to the Netop Portal for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Netop Portal you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
