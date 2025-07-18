---
title: Configure Qmarkets Idea & Innovation Management for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Qmarkets Idea & Innovation Management.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Qmarkets Idea & Innovation Management so that I can control who has access to Qmarkets Idea & Innovation Management, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Qmarkets Idea & Innovation Management for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Qmarkets Idea & Innovation Management with Microsoft Entra ID. When you integrate Qmarkets Idea & Innovation Management with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Qmarkets Idea & Innovation Management.
* Enable your users to be automatically signed-in to Qmarkets Idea & Innovation Management with their Microsoft Entra accounts.
* Manage your accounts in one central location.


## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Qmarkets Idea & Innovation Management single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.


* Qmarkets Idea & Innovation Management supports **SP and IDP** initiated SSO.
* Qmarkets Idea & Innovation Management supports **Just In Time** user provisioning.


## Adding Qmarkets Idea & Innovation Management from the gallery

To configure the integration of Qmarkets Idea & Innovation Management into Microsoft Entra ID, you need to add Qmarkets Idea & Innovation Management from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Qmarkets Idea & Innovation Management** in the search box.
1. Select **Qmarkets Idea & Innovation Management** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-qmarkets-idea--innovation-management'></a>

## Configure and test Microsoft Entra SSO for Qmarkets Idea & Innovation Management

Configure and test Microsoft Entra SSO with Qmarkets Idea & Innovation Management using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Qmarkets Idea & Innovation Management.

To configure and test Microsoft Entra SSO with Qmarkets Idea & Innovation Management, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Qmarkets Idea & Innovation Management SSO](#configure-qmarkets-idea--innovation-management-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Qmarkets Idea & Innovation Management test user](#create-qmarkets-idea--innovation-management-test-user)** - to have a counterpart of B.Simon in Qmarkets Idea & Innovation Management that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Qmarkets Idea & Innovation Management** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<app_url>/sso/saml2/metadata/qmarkets_sp_<endpoint_id>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<app_url>/sso/saml2/acs/qmarkets_sp_<endpoint_id>`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<app_url>/sso/saml2/endpoint/qmarkets_sp_<endpoint_id>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Qmarkets Idea & Innovation Management Client support team](mailto:support@qmarkets.net) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Qmarkets Idea & Innovation Management SSO

To configure single sign-on on **Qmarkets Idea & Innovation Management** side, you need to send the **App Federation Metadata Url** to [Qmarkets Idea & Innovation Management support team](mailto:support@qmarkets.net). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Qmarkets Idea & Innovation Management test user

In this section, a user called Britta Simon is created in Qmarkets Idea & Innovation Management. Qmarkets Idea & Innovation Management supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Qmarkets Idea & Innovation Management, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Qmarkets Idea & Innovation Management Sign on URL where you can initiate the login flow.  

* Go to Qmarkets Idea & Innovation Management Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Qmarkets Idea & Innovation Management for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the Qmarkets Idea & Innovation Management tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Qmarkets Idea & Innovation Management for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Qmarkets Idea & Innovation Management you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
