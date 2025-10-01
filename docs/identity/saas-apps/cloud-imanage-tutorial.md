---
title: Configure Cloud iManage for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cloud iManage.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 04/05/2024
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cloud iManage so that I can control who has access to Cloud iManage, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Cloud iManage for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cloud iManage with Microsoft Entra ID. When you integrate Cloud iManage with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cloud iManage.
* Enable your users to be automatically signed-in to Cloud iManage with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cloud iManage single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Cloud iManage supports both **SP and IDP** initiated SSO.

## Add Cloud iManage from the gallery

To configure the integration of Cloud iManage into Microsoft Entra ID, you need to add Cloud iManage from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cloud iManage** in the search box.
1. Select **Cloud iManage** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Cloud iManage

Configure and test Microsoft Entra SSO with Cloud iManage using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cloud iManage.

To configure and test Microsoft Entra SSO with Cloud iManage, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cloud iManage SSO](#configure-cloud-imanage-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cloud iManage test user](#create-cloud-imanage-test-user)** - to have a counterpart of B.Simon in Cloud iManage that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cloud iManage** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://cloudimanage.com/auth/api/v1/saml/login/<Customer_ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://cloudimanage.com/auth/api/v1/saml/login/<Customer_ID>`

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://cloudimanage.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Cloud iManage support team](mailto:cloudsupport@imanage.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Cloud iManage** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to Copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cloud iManage SSO

To configure single sign-on on **Cloud iManage** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from Microsoft Entra admin center to [Cloud iManage support team](mailto:cloudsupport@imanage.com). They set this setting to have the SAML SSO connection set properly on both sides. For more information, please refer this [document.](https://docs.imanage.com/cloud/cc-help/en-US/SAML_Single_Sign-On_(SSO).html)

### Create Cloud iManage test user

In this section, you create a user called B.Simon in Cloud iManage. Work with [Cloud iManage support team](mailto:cloudsupport@imanage.com) to add the users in the Cloud iManage platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Select **Test this application** in Microsoft Entra admin center. This option redirects to Cloud iManage Sign on URL where you can initiate the login flow.  
 
* Go to Cloud iManage Sign-on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Select **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the Cloud iManage for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you select the Cloud iManage tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Cloud iManage for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Cloud iManage you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).