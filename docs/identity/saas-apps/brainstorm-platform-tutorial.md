---
title: Microsoft Entra SSO integration with BrainStorm Platform
description: Learn how to configure single sign-on between Microsoft Entra ID and BrainStorm Platform.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/09/2023
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BrainStorm Platform so that I can control who has access to BrainStorm Platform, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with BrainStorm Platform

In this article, you learn how to integrate BrainStorm Platform with Microsoft Entra ID. The BrainStorm Platform empowers end users to personalize their experience, empowering them to embrace long-term behavioral change. When you integrate BrainStorm Platform with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BrainStorm Platform.
* Enable your users to be automatically signed-in to BrainStorm Platform with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You are able to configure and test Microsoft Entra single sign-on for BrainStorm Platform in your BrainStorm environment. BrainStorm Platform supports only **SP** initiated single sign-on and **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Prerequisites

To integrate Microsoft Entra ID with BrainStorm Platform, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal.
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* BrainStorm Platform single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the BrainStorm Platform application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-brainstorm-platform-from-the-azure-ad-gallery'></a>

### Add BrainStorm Platform from the Microsoft Entra gallery

Add BrainStorm Platform from the Microsoft Entra application gallery to configure single sign-on with BrainStorm Platform. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **BrainStorm Platform** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type the value:
	`urn:brainstorminc:auth:wsfed`

	b. In the **Reply URL** textbox, type the URL:
	`https://auth.brainstorminc.com/signin-wsfed`

	c. In the **Sign on URL** textbox, type a URL using the following pattern:
	`https://auth.brainstorminc.com/auth/wsfed?providerId=<ID>`

	> [!NOTE]
	> This value is not real. Update this value with the actual Sign on URL. Contact [BrainStorm Platform Client support team](mailto:support@brainstorminc.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. BrainStorm Platform application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, the BrainStorm platform application allows few more attributes to be passed back in SAML response, which are shown below.  These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
    | title | user.jobtitle
	| department | user.department |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, click copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

## Configure BrainStorm Platform SSO

To configure single sign-on on **BrainStorm Platform** side, you need to send the **App Federation Metadata Url** to [BrainStorm Platform support team](mailto:support@brainstorminc.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create BrainStorm Platform test user

In this section, a user called B.Simon is created in BrainStorm Platform. BrainStorm Platform supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in BrainStorm Platform, a new one is commonly created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to BrainStorm Platform Sign-on URL where you can initiate the login flow. 

* Go to BrainStorm Platform Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the BrainStorm Platform tile in the My Apps, this will redirect to BrainStorm Platform Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure BrainStorm Platform you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
