---
title: Configure EAB Navigate Strategic Care for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and EAB Navigate Strategic Care.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and EAB Navigate Strategic Care so that I can control who has access to EAB Navigate Strategic Care, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure EAB Navigate Strategic Care for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate EAB Navigate Strategic Care with Microsoft Entra ID. When you integrate EAB Navigate Strategic Care with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to EAB Navigate Strategic Care.
* Enable your users to be automatically signed-in to EAB Navigate Strategic Care with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* EAB Navigate Strategic Care single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* EAB Navigate Strategic Care supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add EAB Navigate Strategic Care from the gallery

To configure the integration of EAB Navigate Strategic Care into Microsoft Entra ID, you need to add EAB Navigate Strategic Care from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **EAB Navigate Strategic Care** in the search box.
1. Select **EAB Navigate Strategic Care** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-eab-navigate-strategic-care'></a>

## Configure and test Microsoft Entra SSO for EAB Navigate Strategic Care

Configure and test Microsoft Entra SSO with EAB Navigate Strategic Care using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in EAB Navigate Strategic Care.

To configure and test Microsoft Entra SSO with EAB Navigate Strategic Care, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure EAB Navigate Strategic Care SSO](#configure-eab-navigate-strategic-care-sso)** - to configure the single sign-on settings on application side.
    1. **[Create EAB Navigate Strategic Care test user](#create-eab-navigate-strategic-care-test-user)** - to have a counterpart of B.Simon in EAB Navigate Strategic Care that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **EAB Navigate Strategic Care** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<CUSTOMERURL>.eab.com`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [EAB Navigate Strategic Care Client support team](mailto:tech@gradesfirst.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select the copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure EAB Navigate Strategic Care SSO

To configure single sign-on on **EAB Navigate Strategic Care** side, you need to send the **App Federation Metadata Url** to [EAB Navigate Strategic Care support team](mailto:tech@gradesfirst.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create EAB Navigate Strategic Care test user

In this section, you create a user called B.Simon in EAB Navigate Strategic Care. Work with [EAB Navigate Strategic Care support team](mailto:tech@gradesfirst.com) to add the users in the EAB Navigate Strategic Care platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to EAB Navigate Strategic Care Sign-on URL where you can initiate the login flow. 

* Go to EAB Navigate Strategic Care Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the EAB Navigate Strategic Care tile in the My Apps, this option redirects to EAB Navigate Strategic Care Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure EAB Navigate Strategic Care you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
