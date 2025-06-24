---
title: Configure Scuba Analytics for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Scuba Analytics.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Scuba Analytics so that I can control who has access to Scuba Analytics, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Scuba Analytics for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Scuba Analytics with Microsoft Entra ID. When you integrate Scuba Analytics with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Scuba Analytics.
* Enable your users to be automatically signed-in to Scuba Analytics with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Scuba Analytics single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Scuba Analytics supports **IDP** initiated SSO.

## Add Scuba Analytics from the gallery

To configure the integration of Scuba Analytics into Microsoft Entra ID, you need to add Scuba Analytics from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Scuba Analytics** in the search box.
1. Select **Scuba Analytics** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-scuba-analytics'></a>

## Configure and test Microsoft Entra SSO for Scuba Analytics

Configure and test Microsoft Entra SSO with Scuba Analytics using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Scuba Analytics.

To configure and test Microsoft Entra SSO with Scuba Analytics, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Scuba Analytics SSO](#configure-scuba-analytics-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Scuba Analytics test user](#create-scuba-analytics-test-user)** - to have a counterpart of B.Simon in Scuba Analytics that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Scuba Analytics** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section the application is pre-configured in **IDP** initiated mode and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Scuba Analytics** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Scuba Analytics SSO

To configure single sign-on on **Scuba Analytics** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Scuba Analytics support team](mailto:help@scuba.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Scuba Analytics test user

In this section, you create a user called Britta Simon in Scuba Analytics. Work with [Scuba Analytics support team](mailto:help@scuba.io) to add the users in the Scuba Analytics platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Scuba Analytics for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Scuba Analytics tile in the My Apps, you should be automatically signed in to the Scuba Analytics for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Scuba Analytics you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
