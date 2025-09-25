---
title: Configure FourKites SAML2.0 SSO for Tracking for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FourKites SAML2.0 SSO for Tracking.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FourKites SAML2.0 SSO for Tracking so that I can control who has access to FourKites SAML2.0 SSO for Tracking, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FourKites SAML2.0 SSO for Tracking for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FourKites SAML2.0 SSO for Tracking with Microsoft Entra ID. When you integrate FourKites SAML2.0 SSO for Tracking with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FourKites SAML2.0 SSO for Tracking.
* Enable your users to be automatically signed-in to FourKites SAML2.0 SSO for Tracking with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* FourKites SAML2.0 SSO for Tracking single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FourKites SAML2.0 SSO for Tracking supports **SP** and **IDP** initiated SSO.
* FourKites SAML2.0 SSO for Tracking supports **Just In Time** user provisioning.

## Add FourKites SAML2.0 SSO for Tracking from the gallery

To configure the integration of FourKites SAML2.0 SSO for Tracking into Microsoft Entra ID, you need to add FourKites SAML2.0 SSO for Tracking from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FourKites SAML2.0 SSO for Tracking** in the search box.
1. Select **FourKites SAML2.0 SSO for Tracking** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-fourkites-saml20-sso-for-tracking'></a>

## Configure and test Microsoft Entra SSO for FourKites SAML2.0 SSO for Tracking

Configure and test Microsoft Entra SSO with FourKites SAML2.0 SSO for Tracking using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FourKites SAML2.0 SSO for Tracking.

To configure and test Microsoft Entra SSO with FourKites SAML2.0 SSO for Tracking, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
   1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FourKites SAML2.0 SSO for Tracking SSO](#configure-fourkites-saml20-sso-for-tracking-sso)** - to configure the single sign-on settings on application side.
   1. **[Create FourKites SAML2.0 SSO for Tracking test user](#create-fourkites-saml20-sso-for-tracking-test-user)** - to have a counterpart of B.Simon in FourKites SAML2.0 SSO for Tracking that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FourKites SAML2.0 SSO for Tracking** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

   In the **Sign-on URL** text box, type one of the following URLs:
    
   | **Sign-on URL**|
   |-------|
   | `https://upsgff.fourkites.com` |
   | `https://upsgff-staging.fourkites.com` |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FourKites SAML2.0 SSO for Tracking SSO

To configure single sign-on on **FourKites SAML2.0 SSO for Tracking** side, you need to send the **App Federation Metadata Url** to [FourKites SAML2.0 SSO for Tracking support team](mailto:support@fourkites.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FourKites SAML2.0 SSO for Tracking test user

In this section, a user called B.Simon is created in FourKites SAML2.0 SSO for Tracking. FourKites SAML2.0 SSO for Tracking supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in FourKites SAML2.0 SSO for Tracking, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

### SP initiated:

* Select **Test this application**, this option redirects to FourKites SAML2.0 SSO for Tracking Sign-on URL where you can initiate the login flow.  

* Go to FourKites SAML2.0 SSO for Tracking Sign-on URL directly and initiate the login flow from there.

### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the FourKites SAML2.0 SSO for Tracking for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the FourKites SAML2.0 SSO for Tracking tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the FourKites SAML2.0 SSO for Tracking for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure FourKites SAML2.0 SSO for Tracking you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
