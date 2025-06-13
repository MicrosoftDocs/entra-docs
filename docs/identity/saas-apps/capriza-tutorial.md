---
title: Configure Capriza Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Capriza Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Capriza Platform so that I can control who has access to Capriza Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Capriza Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Capriza Platform with Microsoft Entra ID. When you integrate Capriza Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Capriza Platform.
* Enable your users to be automatically signed-in to Capriza Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Capriza Platform single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Capriza Platform supports **SP** initiated SSO.
* Capriza Platform supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Capriza Platform from the gallery

To configure the integration of Capriza Platform into Microsoft Entra ID, you need to add Capriza Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Capriza Platform** in the search box.
1. Select **Capriza Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-capriza-platform'></a>

## Configure and test Microsoft Entra SSO for Capriza Platform

Configure and test Microsoft Entra SSO with Capriza Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Capriza Platform.

To configure and test Microsoft Entra SSO with Capriza Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Capriza Platform SSO](#configure-capriza-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Capriza Platform test user](#create-capriza-platform-test-user)** - to have a counterpart of B.Simon in Capriza Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Capriza Platform** application integration page, find the **Manage** section and select **single sign-on**.
2. On the **Select a single sign-on method** page, select **SAML**.
3. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following step:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<companyname>.capriza.com/<tenantid>`

	> [!NOTE]
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [Capriza Platform Client support team](mailto:support@capriza.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

6. On the **Set up Capriza Platform** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy appropriate configuration U R L.](common/copy-configuration-urls.png "Configuration")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Capriza Platform SSO

To configure single sign-on on **Capriza Platform** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Capriza Platform support team](mailto:support@capriza.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Capriza Platform test user

The objective of this section is to create a user called Britta Simon in Capriza. Capriza supports just-in-time provisioning, which is by default enabled. **Please make sure that your domain name is configured with Capriza for user provisioning. After that only the just-in-time user provisioning will work.**

There's no action item for you in this section. A new user is created during an attempt to access Capriza if it doesn't exist yet.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Capriza Platform Sign-on URL where you can initiate the login flow. 

* Go to Capriza Platform Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Capriza Platform tile in the My Apps, this option redirects to Capriza Platform Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Capriza Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
