---
title: Configure ShiftWizard SAML for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ShiftWizard SAML.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ShiftWizard SAML so that I can control who has access to ShiftWizard SAML, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ShiftWizard SAML for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ShiftWizard SAML with Microsoft Entra ID. When you integrate ShiftWizard SAML with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ShiftWizard SAML.
* Enable your users to be automatically signed-in to ShiftWizard SAML with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ShiftWizard SAML single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ShiftWizard SAML supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ShiftWizard SAML from the gallery

To configure the integration of ShiftWizard SAML into Microsoft Entra ID, you need to add ShiftWizard SAML from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ShiftWizard SAML** in the search box.
1. Select **ShiftWizard SAML** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-shiftwizard-saml'></a>

## Configure and test Microsoft Entra SSO for ShiftWizard SAML

Configure and test Microsoft Entra SSO with ShiftWizard SAML using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ShiftWizard SAML.

To configure and test Microsoft Entra SSO with ShiftWizard SAML, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ShiftWizard SAML SSO](#configure-shiftwizard-saml-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ShiftWizard SAML test user](#create-shiftwizard-saml-test-user)** - to have a counterpart of B.Simon in ShiftWizard SAML that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ShiftWizard SAML** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign on URL** textbox, type the URL:
    `https://azureadsso.myshiftwizard.com/SSOActiveDirectory`

1. ShiftWizard SAML application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, ShiftWizard SAML application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| -------- |--------- |
	| employeeID | user.employeeid |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (PEM)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificate-base64-download.png)    

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ShiftWizard SAML SSO

To configure single sign-on on **ShiftWizard SAML** side, you need to send the **Certificate (PEM)** to [ShiftWizard SAML support team](mailto:it@shiftwizard.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ShiftWizard SAML test user

In this section, you create a user called Britta Simon in ShiftWizard SAML. Work with [ShiftWizard SAML support team](mailto:it@shiftwizard.com) to add the users in the ShiftWizard SAML platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ShiftWizard SAML Sign-on URL where you can initiate the login flow. 

* Go to ShiftWizard SAML Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ShiftWizard SAML tile in the My Apps, this option redirects to ShiftWizard SAML Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ShiftWizard SAML you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
