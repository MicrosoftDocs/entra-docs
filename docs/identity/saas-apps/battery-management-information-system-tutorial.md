---
title: Configure BMIS - Battery Management Information System for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and BMIS - Battery Management Information System.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BMIS - Battery Management Information System so that I can control who has access to BMIS - Battery Management Information System, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure BMIS - Battery Management Information System for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate BMIS - Battery Management Information System with Microsoft Entra ID. When you integrate BMIS - Battery Management Information System with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BMIS - Battery Management Information System.
* Enable your users to be automatically signed-in to BMIS - Battery Management Information System with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* BMIS - Battery Management Information System single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* BMIS - Battery Management Information System supports **IDP** initiated SSO.

## Add BMIS - Battery Management Information System from the gallery

To configure the integration of BMIS - Battery Management Information System into Microsoft Entra ID, you need to add BMIS - Battery Management Information System from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **BMIS - Battery Management Information System** in the search box.
1. Select **BMIS - Battery Management Information System** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-bmis---battery-management-information-system'></a>

## Configure and test Microsoft Entra SSO for BMIS - Battery Management Information System

Configure and test Microsoft Entra SSO with BMIS - Battery Management Information System using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BMIS - Battery Management Information System.

To configure and test Microsoft Entra SSO with BMIS - Battery Management Information System, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure BMIS - Battery Management Information System SSO](#configure-bmis---battery-management-information-system-sso)** - to configure the single sign-on settings on application side.
    1. **[Create BMIS - Battery Management Information System test user](#create-bmis---battery-management-information-system-test-user)** - to have a counterpart of B.Simon in BMIS - Battery Management Information System that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **BMIS - Battery Management Information System** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the application is pre-configured and the necessary URLs are already pre-populated with Azure. The user needs to save the configuration by selecting the **Save** button.

1. BMIS - Battery Management Information System application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the Battery Management Information System application image.](common/default-attributes.png "Image")

1. In addition to above, BMIS - Battery Management Information System application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirement.

	| Name |  Source Attribute |
	|-------| --------- |
    | email | user.mail |
    | first_name | user.givenname |
    | last_name | user.surname |
    | user_name | user.mail |

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up BMIS - Battery Management Information System** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URLs.](common/copy-configuration-urls.png "Attributes")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure BMIS - Battery Management Information System SSO

To configure single sign-on on **BMIS - Battery Management Information System** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [BMIS - Battery Management Information System support team](mailto:bmissupport@midtronics.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create BMIS - Battery Management Information System test user

In this section, you create a user called Britta Simon in BMIS - Battery Management Information System. Work with [BMIS - Battery Management Information System support team](mailto:bmissupport@midtronics.com) to add the users in the BMIS - Battery Management Information System platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the BMIS - Battery Management Information System for which you set up the SSO.

* You can use Microsoft My Apps. When you select the BMIS - Battery Management Information System tile in the My Apps, you should be automatically signed in to the BMIS - Battery Management Information System for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure BMIS - Battery Management Information System you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
