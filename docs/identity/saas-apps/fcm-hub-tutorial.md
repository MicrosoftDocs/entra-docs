---
title: Configure FCM HUB for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FCM HUB.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FCM HUB so that I can control who has access to FCM HUB, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FCM HUB for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FCM HUB with Microsoft Entra ID. When you integrate FCM HUB with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FCM HUB.
* Enable your users to be automatically signed-in to FCM HUB with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FCM HUB single sign-on (SSO) enabled subscription.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FCM HUB supports **SP and IDP** initiated SSO.

## Add FCM HUB from the gallery

To configure the integration of FCM HUB into Microsoft Entra ID, you need to add FCM HUB from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FCM HUB** in the search box.
1. Select **FCM HUB** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-fcm-hub'></a>

## Configure and test Microsoft Entra SSO for FCM HUB

Configure and test Microsoft Entra SSO with FCM HUB using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FCM HUB.

To configure and test Microsoft Entra SSO with FCM HUB, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FCM HUB SSO](#configure-fcm-hub-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FCM HUB test user](#create-fcm-hub-test-user)** - to have a counterpart of B.Simon in FCM HUB that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FCM HUB** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://hub.fcm.travel/SsoSp/SpInit?clientid=<CUSTOMID>`

    > [!NOTE]
	> The value isn't real. Update the value with the actual Sign-on URL. Contact account manager who is assigned to you or contact [FCM HUB Client support team](mailto:fcmssoadmin@us.fcm.travel) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Select **Save**.

1. On the **Manage Claim** page, in the **User Attributes & Claims** section, add these custom attributes:
   - **Name**: PortalID
   - **Source**: Attribute
   - **Source Attribute**: PortalID, value provided by FCM

1. In the **SAML Signing Certificate** section, use the edit option to select or enter the following settings, and then select **Save**:
   - **Signing Option**: Sign SAML response and Assertion
   - **Signing Algorithm**: SHA-256

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up FCM HUB** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FCM HUB SSO

To configure single sign-on on **FCM HUB** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to your account manager who is assigned to you for the support or contact [FCM HUB Client support team](mailto:fcmssoadmin@us.fcm.travel). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FCM HUB test user

In this section, you create a user called B.Simon in FCM HUB. Work with your account manager or contact [FCM HUB Client support team](mailto:fcmssoadmin@us.fcm.travel) to add the users in the FCM HUB platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to FCM HUB Sign on URL where you can initiate the login flow.  

* Go to FCM HUB Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the FCM HUB for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the FCM HUB tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the FCM HUB for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure FCM HUB you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
