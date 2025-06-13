---
title: Configure EAB for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and EAB.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and EAB so that I can control who has access to EAB, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure EAB for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate EAB with Microsoft Entra ID. When you integrate EAB with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to EAB.
* Enable your users to be automatically signed-in to EAB with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* EAB single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* EAB supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding EAB from the gallery

To configure the integration of EAB into Microsoft Entra ID, you need to add EAB from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **EAB** in the search box.
1. Select **EAB** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-eab'></a>

## Configure and test Microsoft Entra SSO for EAB

Configure and test Microsoft Entra SSO with EAB using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in EAB.

To configure and test Microsoft Entra SSO with EAB, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure EAB SSO](#configure-eab-sso)** - to configure the single sign-on settings on application side.
    * **[Create EAB test user](#create-eab-test-user)** - to have a counterpart of B.Simon in EAB that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **EAB** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:
    
    a. In the **Identifier (Entity ID)** text box, enter exactly the following value:
    `https://bouncer.eab.com`
    
    b. In the **Reply URL (Assertion Consumer Service URL)** text box, enter both the following values as separate rows:

    | Reply URL |
    |-----------|
    | `https://bouncer.eab.com/sso/saml2/acs` |
    | `https://bouncer.eab.com/sso/saml2/acs/` |
    |
    
    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.navigate.eab.com/`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [EAB Client support team](mailto:EABTechSupport@eab.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure EAB SSO

To configure single sign-on on **EAB** side, you need to send the **App Federation Metadata Url** to [EAB support team](mailto:EABTechSupport@eab.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create EAB test user

In this section, you create a user called B.Simon in EAB. Work with [EAB support team](mailto:EABTechSupport@eab.com) to add the users in the EAB platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to EAB Sign-on URL where you can initiate the login flow. 

* Go to EAB Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the EAB tile in the My Apps, this option redirects to EAB Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure EAB you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
