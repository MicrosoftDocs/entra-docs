---
title: Configure A Cloud Guru for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and A Cloud Guru.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and A Cloud Guru so that I can control who has access to A Cloud Guru, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure A Cloud Guru for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate A Cloud Guru with Microsoft Entra ID. When you integrate A Cloud Guru with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to A Cloud Guru.
* Enable your users to be automatically signed-in to A Cloud Guru with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A Cloud Guru single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* A Cloud Guru supports **SP and IDP** initiated SSO.
* A Cloud Guru supports **Just In Time** user provisioning.

## Adding A Cloud Guru from the gallery

To configure the integration of A Cloud Guru into Microsoft Entra ID, you need to add A Cloud Guru from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **A Cloud Guru** in the search box.
1. Select **A Cloud Guru** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-a-cloud-guru'></a>

## Configure and test Microsoft Entra SSO for A Cloud Guru

Configure and test Microsoft Entra SSO with A Cloud Guru using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in A Cloud Guru.

To configure and test Microsoft Entra SSO with A Cloud Guru, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure A Cloud Guru SSO](#configure-a-cloud-guru-sso)** - to configure the single sign-on settings on application side.
    1. **[Create A Cloud Guru test user](#create-a-cloud-guru-test-user)** - to have a counterpart of B.Simon in A Cloud Guru that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **A Cloud Guru** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a value using the following pattern:
    `urn:auth0:acloudguru:<CLIENT_CONNECTION_NAME>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://auth.acloud.guru/login/callback?connection=<CLIENT_CONNECTION_NAME>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type the URL:
    `https://learn.acloud.guru/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [A Cloud Guru Client support team](mailto:sso@acloud.guru) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your A Cloud Guru application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier(Name ID)** is **user.userprincipalname** but A Cloud Guru expects this to be mapped with the user's given name. For that you can use **user.givenname** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)

1. In addition to above, A Cloud Guru application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| ----------------- | --------- |
    | email  | user.emailaddress |
	| family_name | user.surname |
	| given_name | user.givenname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up A Cloud Guru** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure A Cloud Guru SSO

To configure single sign-on on **A Cloud Guru** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [A Cloud Guru support team](mailto:sso@acloud.guru). They set this setting to have the SAML SSO connection set properly on both sides.

### Create A Cloud Guru test user

In this section, a user called Britta Simon is created in A Cloud Guru. A Cloud Guru supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in A Cloud Guru, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to A Cloud Guru Sign on URL where you can initiate the login flow.  

* Go to A Cloud Guru Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the A Cloud Guru for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the A Cloud Guru tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the A Cloud Guru for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure A Cloud Guru you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
