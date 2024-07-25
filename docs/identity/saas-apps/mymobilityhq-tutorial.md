---
title: Microsoft Entra SSO integration with myMobilityHQ
description: Learn how to configure single sign-on between Microsoft Entra ID and myMobilityHQ.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and myMobilityHQ so that I can control who has access to myMobilityHQ, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with myMobilityHQ

In this article, you learn how to integrate myMobilityHQ with Microsoft Entra ID. myMobilityHQ is the secure portal that allows your company mobility managers to see a real-time dashboard of the status of their expatriate tax program. When you integrate myMobilityHQ with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to myMobilityHQ.
* Enable your users to be automatically signed-in to myMobilityHQ with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You configure and test Microsoft Entra single sign-on for myMobilityHQ in a test environment. myMobilityHQ supports only **SP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with myMobilityHQ, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* myMobilityHQ single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the myMobilityHQ application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-mymobilityhq-from-the-azure-ad-gallery'></a>

### Add myMobilityHQ from the Microsoft Entra gallery

Add myMobilityHQ from the Microsoft Entra application gallery to configure single sign-on with myMobilityHQ. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **myMobilityHQ** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type a value using one of the following patterns:

	| **Identifier** |
	|------------|
	| `urn:auth0:prod:s<COMPANYNAME>` |
	| `urn:auth0:stage:s<COMPANYNAME>` |

	b. In the **Reply URL** textbox, type a URL using one of the following patterns:

	| **Reply URL** |
	|---------|
	| `https://stage.vialto.auth0app.com/login/callback?connection=s<COMPANYNAME>` |
	| `https://prod.vialto.auth0app.com/login/callback?connection=s<COMPANYNAME>` |
	| `https://auth-stage.vialto.com/login/callback?connection=s<COMPANYNAME>` |
	| `https://auth.vialto.com/login/callback?connection=s<COMPANYNAME>` |

	c. In the **Sign on URL** textbox, type one of the following URLs:
	
	| **Sign on URL** |
	|-------------|
	| `https://mymobilityhq-stage.vialto.com`|
	| `https://mymobilityhq.vialto.com` |

	> [!Note]
    > These values are not real. Update these values with the actual Identifier and Reply URL. Contact [myMobilityHQ support team](mailto:gbl_vialto_iam_engineering_support@vialto.com) to get these values. You can also refer to the patterns shown in the Basic SAML Configuration section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, click copy button to copy **App Federation Metadata Url** and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

## Configure myMobilityHQ SSO

To configure single sign-on on **myMobilityHQ** side, you need to send the **App Federation Metadata Url** to [myMobilityHQ support team](mailto:gbl_vialto_iam_engineering_support@vialto.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create myMobilityHQ test user

In this section, you create a user called Britta Simon in myMobilityHQ. Work with [myMobilityHQ support team](mailto:gbl_vialto_iam_engineering_support@vialto.com) to add the users in the myMobilityHQ platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to myMobilityHQ Sign-on URL where you can initiate the login flow. 

* Go to myMobilityHQ Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the myMobilityHQ tile in the My Apps, this will redirect to myMobilityHQ Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure myMobilityHQ you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
