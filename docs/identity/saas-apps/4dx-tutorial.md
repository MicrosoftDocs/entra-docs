---
title: Configure 4DX for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and 4DX.
author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and 4DX so that I can control who has access to 4DX, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure 4DX for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate 4DX with Microsoft Entra ID. When you integrate 4DX with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to 4DX.
* Enable your users to be automatically signed-in to 4DX with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* 4DX single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* 4DX supports **IDP** initiated SSO.

## Add 4DX from the gallery

To configure the integration of 4DX into Microsoft Entra ID, you need to add 4DX from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **4DX** in the search box.
1. Select **4DX** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-4dx'></a>

## Configure and test Microsoft Entra SSO for 4DX

Configure and test Microsoft Entra SSO with 4DX using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in 4DX.

To configure and test Microsoft Entra SSO with 4DX, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure 4DX SSO](#configure-4dx-sso)** - to configure the single sign-on settings on application side.
    1. **[Create 4DX test user](#create-4dx-test-user)** - to have a counterpart of B.Simon in 4DX that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **4DX** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. 4DX application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

    ![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, 4DX application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

    | Name | Source Attribute|
    | ------------ | --------- |
    | companykey | `<unique ID>` |

    > [!Note]
    > For this `<unique ID>` of a customer assertion, please reach out to [4DX support team](mailto:support@bahrcode.com).

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up 4DX** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows how to copy a configuration appropriate URL.](common/copy-configuration-urls.png "Attributes")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure 4DX SSO

To configure single sign-on on **4DX** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [4DX support team](mailto:support@bahrcode.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create 4DX test user

In this section, you create a user called Britta Simon in 4DX. Work with [4DX support team](mailto:support@bahrcode.com) to add the users in the 4DX platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* select **Test this application**, and you should be automatically signed in to the 4DX for which you set up the SSO.

* You can use Microsoft My Apps. When you select the 4DX tile in the My Apps, you should be automatically signed in to the 4DX for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure 4DX you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
