---
title: Configure Beatrust for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Beatrust.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Beatrust so that I can control who has access to Beatrust, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Beatrust for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Beatrust with Microsoft Entra ID. When you integrate Beatrust with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Beatrust.
* Enable your users to be automatically signed-in to Beatrust with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Beatrust single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Beatrust supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Beatrust from the gallery

To configure the integration of Beatrust into Microsoft Entra ID, you need to add Beatrust from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Beatrust** in the search box.
1. Select **Beatrust** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-beatrust'></a>

## Configure and test Microsoft Entra SSO for Beatrust

Configure and test Microsoft Entra SSO with Beatrust using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Beatrust.

To configure and test Microsoft Entra SSO with Beatrust, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Beatrust SSO](#configure-beatrust-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Beatrust test user](#create-beatrust-test-user)** - to have a counterpart of B.Simon in Beatrust that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Beatrust** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://beatrust.com`

    b. In the **Reply URL** text box, type the URL:
    `https://beatrust.com/__/auth/handler`

    c. In the **Sign-on URL** text box, type a URL using  of the following pattern:
    `https://beatrust.com/<org_key>

    > [!NOTE]
	> The Sign-on URL value isn't real. Update the value with the actual Sign-on URL. Contact [Beatrust Client support team](mailto:support@beatrust.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Beatrust** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

1. From the **SAML Certificates** section, copy the App Federation Metadata Url.

    ![Copy App Federation Metadata URL](common/app-federation-metadata-url.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Beatrust SSO

To configure single sign-on on **Beatrust** side, you need to send the downloaded **Certificate (Base64)**, appropriate copied URLs from the application configuration, and App Federation Metadata Url to [Beatrust support team](mailto:support@beatrust.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Beatrust test user

In this section, you create a user called Britta Simon in Beatrust. Work with [Beatrust support team](mailto:support@beatrust.com) to add the users in the Beatrust platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Beatrust Sign-on URL where you can initiate the login flow. 

* Go to Beatrust Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Beatrust tile in the My Apps, this option redirects to Beatrust Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Beatrust you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
