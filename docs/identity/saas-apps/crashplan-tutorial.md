---
title: Configure CrashPlan for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CrashPlan.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 05/17/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure CrashPlan for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate CrashPlan with Microsoft Entra ID. When you integrate CrashPlan with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CrashPlan.
* Enable your users to be automatically signed-in to CrashPlan with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CrashPlan single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CrashPlan supports only **SP** initiated SSO.

## Add CrashPlan from the gallery

To configure the integration of CrashPlan into Microsoft Entra ID, you need to add CrashPlan from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CrashPlan** in the search box.
1. Select **CrashPlan** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for CrashPlan

Configure and test Microsoft Entra SSO with CrashPlan using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CrashPlan.

To configure and test Microsoft Entra SSO with CrashPlan, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CrashPlan SSO](#configure-crashplan-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CrashPlan test user](#create-crashplan-test-user)** - to have a counterpart of B.Simon in CrashPlan that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CrashPlan** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://console.<ENVIRONMENT>.crashplan.com/<ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://console.<ENVIRONMENT>.crashplan.com/api/SsoAuthLoginResponse`

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://console.<ENVIRONMENT>.crashplan.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [CrashPlan support team](mailto:gethelp@crashplan.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. CrashPlan application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, CrashPlan application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| ---- | --------------- |
	| givenName | user.givenname |
	| sn | user.surname |
	| mail | user.mail |
	| uid  | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the certificate download link.](common/copy-metadataurl.png "Certificate")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CrashPlan SSO

To configure single sign-on on **CrashPlan** side, you need to send the **App Federation Metadata Url** to [CrashPlan support team](mailto:gethelp@crashplan.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create CrashPlan test user

In this section, you create a user called B.Simon in CrashPlan. Work with [CrashPlan support team](mailto:gethelp@crashplan.com) to add the users in the CrashPlan platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to CrashPlan Sign-on URL where you can initiate the login flow.
 
* Go to CrashPlan Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the CrashPlan tile in the My Apps, this option redirects to CrashPlan Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure CrashPlan you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).