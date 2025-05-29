---
title: Configure Adoddle cSaas Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Adoddle cSaas Platform.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Adoddle cSaas Platform so that I can control who has access to Adoddle cSaas Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Adoddle cSaas Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Adoddle cSaas Platform with Microsoft Entra ID. When you integrate Adoddle cSaas Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Adoddle cSaas Platform.
* Enable your users to be automatically signed-in to Adoddle cSaas Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Adoddle cSaas Platform single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Adoddle cSaas Platform supports **IDP** initiated SSO.

* Adoddle cSaas Platform supports **Just In Time** user provisioning.

## Add Adoddle cSaas Platform from the gallery

To configure the integration of Adoddle cSaas Platform into Microsoft Entra ID, you need to add Adoddle cSaas Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Adoddle cSaas Platform** in the search box.
1. Select **Adoddle cSaas Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-adoddle-csaas-platform'></a>

## Configure and test Microsoft Entra SSO for Adoddle cSaas Platform

Configure and test Microsoft Entra SSO with Adoddle cSaas Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Adoddle cSaas Platform.

To configure and test Microsoft Entra SSO with Adoddle cSaas Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Adoddle cSaas Platform SSO](#configure-adoddle-csaas-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Adoddle cSaas Platform test user](#create-adoddle-csaas-platform-test-user)** - to have a counterpart of B.Simon in Adoddle cSaas Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Adoddle cSaas Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up Adoddle cSaas Platform** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Adoddle cSaas Platform SSO

To configure single sign-on on **Adoddle cSaas Platform** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Adoddle cSaas Platform support team](mailto:support@asite.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Adoddle cSaas Platform test user

In this section, a user called Britta Simon is created in Adoddle cSaas Platform. Adoddle cSaas Platform supports **just-in-time provisioning**, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Adoddle cSaas Platform, a new one is created when you attempt to access Adoddle cSaas Platform.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Adoddle cSaas Platform for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Adoddle cSaas Platform tile in the My Apps, you should be automatically signed in to the Adoddle cSaas Platform for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Adoddle cSaas Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
