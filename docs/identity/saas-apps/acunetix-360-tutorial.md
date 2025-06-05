---
title: Configure Acunetix 360 for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Acunetix 360.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Acunetix 360 so that I can control who has access to Acunetix 360, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Acunetix 360 for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Acunetix 360 with Microsoft Entra ID. When you integrate Acunetix 360 with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Acunetix 360.
* Enable your users to be automatically signed-in to Acunetix 360 with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Acunetix 360 single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Acunetix 360 supports **SP and IDP** initiated SSO.
* Acunetix 360 supports **Just In Time** user provisioning.
* Acunetix 360 supports [Automated user provisioning](acunetix-360-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Acunetix 360 from the gallery

To configure the integration of Acunetix 360 into Microsoft Entra ID, you need to add Acunetix 360 from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Acunetix 360** in the search box.
1. Select **Acunetix 360** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-acunetix-360'></a>

## Configure and test Microsoft Entra SSO for Acunetix 360

Configure and test Microsoft Entra SSO with Acunetix 360 using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Acunetix 360.

To configure and test Microsoft Entra SSO with Acunetix 360, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Acunetix 360 SSO](#configure-acunetix-360-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Acunetix 360 test user](#create-acunetix-360-test-user)** - to have a counterpart of B.Simon in Acunetix 360 that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Acunetix 360** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    In the **Reply URL** text box, type a URL using the following pattern:
    `https://online.acunetix360.com/account/assertionconsumerservice/?spId=<SPID>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://online.acunetix360.com/account/ssosignin`

	> [!NOTE]
	> The values aren't real. Update the Reply URL value with the actual Reply URL. Contact [Acunetix 360 Client support team](mailto:support@acunetix.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Acunetix 360 application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Acunetix 360 expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)

1. In addition to above, Acunetix 360 application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| ---------------| --------- |
	| FirstName | user.givenName |
	| LastName | user.surName |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Acunetix 360** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Acunetix 360 SSO

To configure single sign-on on **Acunetix 360** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Acunetix 360 support team](mailto:support@acunetix.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Acunetix 360 test user

In this section, a user called Britta Simon is created in Acunetix 360. Acunetix 360 supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Acunetix 360, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Acunetix 360 Sign on URL where you can initiate the login flow.  

* Go to Acunetix 360 Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Acunetix 360 for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Acunetix 360 tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Acunetix 360 for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Acunetix 360 you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).