---
title: Configure Zola for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Zola.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Zola so that I can control who has access to Zola, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Zola for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Zola with Microsoft Entra ID. When you integrate Zola with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Zola.
* Enable your users to be automatically signed-in to Zola with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Zola single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Zola supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Zola from the gallery

To configure the integration of Zola into Microsoft Entra ID, you need to add Zola from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Zola** in the search box.
1. Select **Zola** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-zola'></a>

## Configure and test Microsoft Entra SSO for Zola

Configure and test Microsoft Entra SSO with Zola using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user at Zola.

To configure and test Microsoft Entra SSO with Zola, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Zola SSO](#configure-zola-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Zola test user](#create-zola-test-user)** - to have a counterpart of B.Simon in Zola that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Zola** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Reply URL** textbox, type the URL: 
    `https://zola-prod.auth.eu-west-3.amazoncognito.com/saml2/idpresponse`

    b. In the **Sign-on URL** textbox, type the URL provided by Zola:
    `https://app.zola.fr/?company=<MYCOMPANYID>`

    c. In the **Relay State** textbox, type the URL:
    `https://app.zola.fr/dashboard`

    > [!NOTE]
	> The Sign-on URL value isn't real. Update the value with the actual Sign on URL. Contact [Zola support team](mailto:tech@zola.fr) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Zola** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows how to copy the appropriate configuration URL.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Zola SSO

To configure single sign-on on **Zola** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Zola support team](mailto:tech@zola.fr). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Zola test user

In this section, you create a user called Britta Simon at Zola. Work with [Zola support team](mailto:tech@zola.fr) to add the users in the Zola platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Zola Sign on URL where you can initiate the login flow. 

* Go to Zola Sign on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Zola tile in the My Apps, this option redirects to Zola Sign on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Zola you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
