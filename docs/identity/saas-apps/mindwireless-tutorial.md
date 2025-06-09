---
title: Configure mindWireless for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and mindWireless.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and mindWireless so that I can control who has access to mindWireless, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure mindWireless for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate mindWireless with Microsoft Entra ID. When you integrate mindWireless with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to mindWireless.
* Enable your users to be automatically signed-in to mindWireless with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* mindWireless single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* mindWireless supports **IDP** initiated SSO.

## Add mindWireless from the gallery

To configure the integration of mindWireless into Microsoft Entra ID, you need to add mindWireless from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **mindWireless** in the search box.
1. Select **mindWireless** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-mindwireless'></a>

## Configure and test Microsoft Entra SSO for mindWireless

Configure and test Microsoft Entra SSO with mindWireless using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in mindWireless.

To configure and test Microsoft Entra SSO with mindWireless, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure mindWireless SSO](#configure-mindwireless-sso)** - to configure the single sign-on settings on application side.
    1. **[Create mindWireless test user](#create-mindwireless-test-user)** - to have a counterpart of B.Simon in mindWireless that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **mindWireless** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.mwsmart.com/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.mwsmart.com/SAML/AssertionConsumerService.aspx`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [mindWireless Client support team](mailto:sdulloor@mindwireless.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. mindWireless application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, mindWireless application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

    | Name | Namespace  |  Source Attribute|
	| -------------- | --------------- | ----------------|
	| Employee ID | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims`| user.employeeid |

    > [!NOTE]
    > The claim name always be **Employee ID** and the value of which we have mapped to **user.employeeid**, which contains the EmployeeID of the user. Here the user mapping from Microsoft Entra ID to mindWireless is done on the EmployeeID but you can map it to a different value also based on your application settings. You can work with the [mindWireless support team](mailto:sdulloor@mindwireless.com) first to use the correct identifier of a user and map that value with the **Employee ID** claim.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up mindWireless** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure mindWireless SSO

To configure single sign-on on **mindWireless** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [mindWireless support team](mailto:sdulloor@mindwireless.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create mindWireless test user

In this section, you create a user called B.Simon in mindWireless. Work with [mindWireless support team](mailto:sdulloor@mindwireless.com) to add the users in the mindWireless platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the mindWireless for which you set up the SSO.

* You can use Microsoft My Apps. When you select the mindWireless tile in the My Apps, you should be automatically signed in to the mindWireless for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure mindWireless you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
