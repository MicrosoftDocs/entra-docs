---
title: Configure GlobeSmart for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and GlobeSmart.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and GlobeSmart so that I can control who has access to GlobeSmart, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure GlobeSmart for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate GlobeSmart with Microsoft Entra ID. When you integrate GlobeSmart with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to GlobeSmart.
* Enable your users to be automatically signed-in to GlobeSmart with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* GlobeSmart single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* GlobeSmart supports **SP and IDP** initiated SSO
* GlobeSmart supports **Just In Time** user provisioning

## Adding GlobeSmart from the gallery

To configure the integration of GlobeSmart into Microsoft Entra ID, you need to add GlobeSmart from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **GlobeSmart** in the search box.
1. Select **GlobeSmart** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-globesmart'></a>

## Configure and test Microsoft Entra SSO for GlobeSmart

Configure and test Microsoft Entra SSO with GlobeSmart using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in GlobeSmart.

To configure and test Microsoft Entra SSO with GlobeSmart, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure GlobeSmart SSO](#configure-globesmart-sso)** - to configure the single sign-on settings on application side.
    1. **[Create GlobeSmart test user](#create-globesmart-test-user)** - to have a counterpart of B.Simon in GlobeSmart that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **GlobeSmart** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** box, type a value using the following pattern:

    | Environment  | URL |
    |-------------|----|
    | Sandbox | `urn:auth0:aperianglobal-staging:<INSTANCE_NAME>`|
    | Production | `urn:auth0:aperianglobal-production:<INSTANCE_NAME>`|
    | | |


    b. In the **Reply URL** text box, type a URL using the following pattern:

    | Environment  | URL |
    |-------------|----|
    | Sandbox | `https://aperianglobal-staging.auth0.com/login/callback?connection=<INSTANCE_NAME>`|
    | Production | `https://auth.aperianglobal.com/login/callback?connection=<INSTANCE_NAME>`|
    | | |

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:

    | Environment  | URL |
    |-------------|----|
    | Sandbox | `https://staging.aperianglobal.com?sp=<INSTANCE_NAME>`|
    | Production | `https://globesmart.aperianglobal.com?sp=<INSTANCE_NAME>`|
    | | |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [GlobeSmart Client support team](mailto:support@aperianglobal.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. GlobeSmart application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, GlobeSmart application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source attribute|
	| ---------------- | --------- |
	| firstName | user.givenname |
	| lastName | user.surname |
	| user_id | user.userprincipalname |
    | email | user.mail |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up GlobeSmart** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure GlobeSmart SSO

To configure single sign-on on **GlobeSmart** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [GlobeSmart support team](mailto:support@aperianglobal.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create GlobeSmart test user

In this section, a user called Britta Simon is created in GlobeSmart. GlobeSmart supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in GlobeSmart, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to GlobeSmart Sign on URL where you can initiate the login flow.  

* Go to GlobeSmart Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the GlobeSmart for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the GlobeSmart tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the GlobeSmart for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure GlobeSmart you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
