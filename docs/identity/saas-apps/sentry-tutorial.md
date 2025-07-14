---
title: Configure Sentry for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Sentry.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Sentry so that I can control who has access to Sentry, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Sentry for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Sentry with Microsoft Entra ID. When you integrate Sentry with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Sentry.
* Enable your users to be automatically signed-in to Sentry with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Sentry single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Sentry supports **SP and IDP** initiated SSO
* Sentry supports **Just In Time** user provisioning

## Adding Sentry from the gallery

To configure the integration of Sentry into Microsoft Entra ID, you need to add Sentry from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Sentry** in the search box.
1. Select **Sentry** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-sentry'></a>

## Configure and test Microsoft Entra SSO for Sentry

Configure and test Microsoft Entra SSO with Sentry using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Sentry.

To configure and test Microsoft Entra SSO with Sentry, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    * **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    * **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Sentry SSO](#configure-sentry-sso)** - to configure the single sign-on settings on application side.
    * **[Create Sentry test user](#create-sentry-test-user)** - to have a counterpart of B.Simon in Sentry that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Sentry** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://sentry.io/saml/metadata/<ORGANIZATION_SLUG>/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://sentry.io/saml/acs/<ORGANIZATION_SLUG>/`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://sentry.io/organizations/<ORGANIZATION_SLUG>/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual values Identifier, Reply URL, and Sign-on URL. For more information about finding these values, see the [Sentry documentation](https://docs.sentry.io/product/accounts/sso/azure-sso/#installation). You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select the copy icon to copy the **App Metadata URL** value, and then save it on your computer.

   ![The Certificate download link](common/copy-metadataurl.png)
	
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Sentry SSO

To configure single sign-on on the **Sentry** side, go to **Org Settings** > **Auth** (or go to `https://sentry.io/settings/<YOUR_ORG_SLUG>/auth/`) and select **Configure** for Active Directory. Paste the App Federation Metadata URL from your Azure SAML configuration.

### Create Sentry test user

In this section, a user called B.Simon is created in Sentry. Sentry supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Sentry, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

1. Select **Test this application**. You're redirected to the Sentry sign-on URL, where you can initiate the sign-in flow.  

1. Go to Sentry sign-on URL directly and initiate the sign-in flow from there.

#### IDP initiated:

* In the Azure portal, select **Test this application**. You should be automatically signed in to the Sentry application for which you set up the SSO. 

#### Either mode:

You can use the My Apps portal to test the application in any mode. When you select the Sentry tile in the My Apps portal, if configured in SP mode, you're redirected to the application sign-on page to initiate the sign-in flow. If configured in IDP mode, you should be automatically signed in to the Sentry application for which you set up the SSO. For more information about the My Apps portal, see [Sign in and start apps from the My Apps portal](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Sentry you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
