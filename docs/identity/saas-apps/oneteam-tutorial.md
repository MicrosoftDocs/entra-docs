---
title: Configure Oneteam for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Oneteam.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Oneteam so that I can control who has access to Oneteam, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Oneteam for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Oneteam with Microsoft Entra ID. When you integrate Oneteam with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Oneteam.
* Enable your users to be automatically signed-in to Oneteam with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Oneteam single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Oneteam supports **SP** and **IDP** initiated SSO.

* Oneteam supports **Just In Time** user provisioning.

## Add Oneteam from the gallery

To configure the integration of Oneteam into Microsoft Entra ID, you need to add Oneteam from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Oneteam** in the search box.
1. Select **Oneteam** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-oneteam'></a>

## Configure and test Microsoft Entra SSO for Oneteam

Configure and test Microsoft Entra SSO with Oneteam using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Oneteam.

To configure and test Microsoft Entra SSO with Oneteam, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Oneteam SSO](#configure-oneteam-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Oneteam test user](#create-oneteam-test-user)** - to have a counterpart of B.Simon in Oneteam that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Oneteam** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://api.one-team.io/teams/<team name>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://api.one-team.io/teams/<team name>/auth/saml/callback`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<team name>.one-team.io/`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact Oneteam Client support team to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

7. On the **Set up Oneteam** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Oneteam SSO

To configure single sign-on on **Oneteam** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to Oneteam support team. They set this setting to have the SAML SSO connection set properly on both sides.

### Create Oneteam test user

In this section, a user called Britta Simon is created in Oneteam. Oneteam supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Oneteam, a new one is created after authentication.

>[!NOTE]
>If you need to create a user manually, you can raise the support ticket with Oneteam support team.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Oneteam Sign on URL where you can initiate the login flow.  

* Go to Oneteam Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Oneteam for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Oneteam tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Oneteam for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Oneteam you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
