---
title: Configure Nodetrax Project for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Nodetrax Project.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Nodetrax Project so that I can control who has access to Nodetrax Project, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Nodetrax Project for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Nodetrax Project with Microsoft Entra ID. When you integrate Nodetrax Project with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Nodetrax Project.
* Enable your users to be automatically signed-in to Nodetrax Project with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Nodetrax Project single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Nodetrax Project supports **SP and IDP** initiated SSO.

## Add Nodetrax Project from the gallery

To configure the integration of Nodetrax Project into Microsoft Entra ID, you need to add Nodetrax Project from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Nodetrax Project** in the search box.
1. Select **Nodetrax Project** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-nodetrax-project'></a>

## Configure and test Microsoft Entra SSO for Nodetrax Project

Configure and test Microsoft Entra SSO with Nodetrax Project using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Nodetrax Project.

To configure and test Microsoft Entra SSO with Nodetrax Project, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Nodetrax Project SSO](#configure-nodetrax-project-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Nodetrax Project test user](#create-nodetrax-project-test-user)** - to have a counterpart of B.Simon in Nodetrax Project that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Nodetrax Project** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, the user doesn't have to perform any step as the app is already pre-integrated with Azure.

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://project.nodetrax.com`

1. Nodetrax Project application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of Nodetrax Project application.](common/default-attributes.png "Attributes")

1. In addition to above, Nodetrax Project application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| ---------| --------- |
	| id | user.objectid |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Nodetrax Project** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy Configuration appropriate U R L.](common/copy-configuration-urls.png "Configuration")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Nodetrax Project SSO

To configure single sign-on on **Nodetrax Project** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Nodetrax Project support team](mailto:support@nodetrax.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Nodetrax Project test user

In this section, you create a user called Britta Simon in Nodetrax Project. Work with [Nodetrax Project support team](mailto:support@nodetrax.com) to add the users in the Nodetrax Project platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Nodetrax Project Sign on URL where you can initiate the login flow.  

* Go to Nodetrax Project Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Nodetrax Project for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Nodetrax Project tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Nodetrax Project for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Nodetrax Project you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
