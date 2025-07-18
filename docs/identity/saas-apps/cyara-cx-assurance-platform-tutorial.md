---
title: Configure Cyara CX Assurance Platform for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cyara CX Assurance Platform.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cyara CX Assurance Platform so that I can control who has access to Cyara CX Assurance Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Cyara CX Assurance Platform for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cyara CX Assurance Platform with Microsoft Entra ID. When you integrate Cyara CX Assurance Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cyara CX Assurance Platform.
* Enable your users to be automatically signed-in to Cyara CX Assurance Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Cyara CX Assurance Platform single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Cyara CX Assurance Platform supports **IDP** initiated SSO.

## Add Cyara CX Assurance Platform from the gallery

To configure the integration of Cyara CX Assurance Platform into Microsoft Entra ID, you need to add Cyara CX Assurance Platform from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cyara CX Assurance Platform** in the search box.
1. Select **Cyara CX Assurance Platform** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cyara-cx-assurance-platform'></a>

## Configure and test Microsoft Entra SSO for Cyara CX Assurance Platform

Configure and test Microsoft Entra SSO with Cyara CX Assurance Platform using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cyara CX Assurance Platform.

To configure and test Microsoft Entra SSO with Cyara CX Assurance Platform, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cyara CX Assurance Platform SSO](#configure-cyara-cx-assurance-platform-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cyara CX Assurance Platform test user](#create-cyara-cx-assurance-platform-test-user)** - to have a counterpart of B.Simon in Cyara CX Assurance Platform that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cyara CX Assurance Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://www.cyaraportal.us/cyarawebidentity/identity/<provider>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://www.cyaraportal.us/cyarawebidentity/identity/<provider>/Acs`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Cyara CX Assurance Platform Client support team](mailto:support@cyara.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Screenshot shows to Edit SAML Signing Certificate.](common/edit-certificate.png "Certificate")

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Screenshot shows to Copy Thumbprint value.](common/copy-thumbprint.png "Thumbprint")

1. On the **Set up Cyara CX Assurance Platform** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cyara CX Assurance Platform SSO

To configure single sign-on on **Cyara CX Assurance Platform** side, you need to send the **Thumbprint Value** and appropriate copied URLs from the application configuration to [Cyara CX Assurance Platform support team](mailto:support@cyara.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cyara CX Assurance Platform test user

In this section, you create a user called Britta Simon in Cyara CX Assurance Platform. Work with [Cyara CX Assurance Platform support team](mailto:support@cyara.com) to add the users in the Cyara CX Assurance Platform platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the Cyara CX Assurance Platform for which you set up the SSO.

* You can use Microsoft My Apps. When you select the Cyara CX Assurance Platform tile in the My Apps, you should be automatically signed in to the Cyara CX Assurance Platform for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Cyara CX Assurance Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
