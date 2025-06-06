---
title: Configure Expiration Reminder for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Expiration Reminder.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Expiration Reminder so that I can control who has access to Expiration Reminder, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Expiration Reminder for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Expiration Reminder with Microsoft Entra ID. When you integrate Expiration Reminder with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Expiration Reminder.
* Enable your users to be automatically signed-in to Expiration Reminder with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Expiration Reminder single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Expiration Reminder supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Expiration Reminder from the gallery

To configure the integration of Expiration Reminder into Microsoft Entra ID, you need to add Expiration Reminder from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Expiration Reminder** in the search box.
1. Select **Expiration Reminder** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-expiration-reminder'></a>

## Configure and test Microsoft Entra SSO for Expiration Reminder

Configure and test Microsoft Entra SSO with Expiration Reminder using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Expiration Reminder.

To configure and test Microsoft Entra SSO with Expiration Reminder, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Expiration Reminder SSO](#configure-expiration-reminder-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Expiration Reminder test user](#create-expiration-reminder-test-user)** - to have a counterpart of B.Simon in Expiration Reminder that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Expiration Reminder** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type the URL:
    `https://app.expirationreminder.net/account/sso`

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Raw)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificateraw.png)

6. On the **Set up Expiration Reminder** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Expiration Reminder SSO

To configure single sign-on on **Expiration Reminder** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from the application configuration to [Expiration Reminder support team](mailto:support@expirationreminder.net).
They set this setting to have the SAML SSO connection set properly on both sides.

### Create Expiration Reminder test user

In this section, you create a user called Britta Simon in Expiration Reminder. Work with [Expiration Reminder support team](mailto:support@expirationreminder.net) to add the users in the Expiration Reminder platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Expiration Reminder Sign-on URL where you can initiate the login flow. 

* Go to Expiration Reminder Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Expiration Reminder tile in the My Apps, this option redirects to Expiration Reminder Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Expiration Reminder you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
