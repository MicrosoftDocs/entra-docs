---
title: Configure Avionte Bold SAML Federated SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Avionte Bold SAML Federated SSO.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Avionte Bold SAML Federated SSO so that I can control who has access to Avionte Bold SAML Federated SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Avionte Bold SAML Federated SSO for Single sign-on with Microsoft Entra ID

In this article, you learn how to integrate Avionte Bold SAML Federated SSO with Microsoft Entra ID. Avionte provides staffing and recruiting software solutions for the staffing industry. When you integrate Avionte Bold SAML Federated SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Avionte Bold SAML Federated SSO.
* Enable your users to be automatically signed-in to Avionte Bold SAML Federated SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You configure and test Microsoft Entra single sign-on for Avionte Bold SAML Federated SSO in a test environment. Avionte Bold SAML Federated SSO supports **SP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with Avionte Bold SAML Federated SSO, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Avionte Bold SAML Federated SSO single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Avionte Bold SAML Federated SSO application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-avionte-bold-saml-federated-sso-from-the-azure-ad-gallery'></a>

### Add Avionte Bold SAML Federated SSO from the Microsoft Entra gallery

Add Avionte Bold SAML Federated SSO from the Microsoft Entra application gallery to configure single sign-on with Avionte Bold SAML Federated SSO. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Avionte Bold SAML Federated SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type a value using the following pattern:
	`urn:auth0:avionte:<CustomerEnvironment>-federated-saml-sso` 
	
	b. In the **Reply URL** textbox, type a URL using the following pattern:
	`https://login.myavionte.com/login/callback?connection=<CustomerEnvironment>-federated-saml-sso`

	c. In the **Sign on URL** textbox, type a URL using the following pattern:
	`https://login.myavionte.com/login/callback?connection=<CustomerEnvironment>-federated-saml-sso`

	> [!Note]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Avionte Bold SAML Federated SSO support team](mailto:Support@avionte.com) to get these values. You can also refer to the patterns shown in the Basic SAML Configuration section.

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Avionte Bold SAML Federated SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

## Configure Avionte Bold SAML Federated SSO

To configure single sign-on on **Avionte Bold SAML Federated SSO** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Avionte Bold SAML Federated SSO support team](mailto:Support@avionte.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Avionte Bold SAML Federated SSO test user

In this section, you create a user called Britta Simon at Avionte Bold SAML Federated SSO. Work with [Avionte Bold SAML Federated SSO support team](mailto:Support@avionte.com) to add the users in the Avionte Bold SAML Federated SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Avionte Bold SAML Federated SSO Sign-on URL where you can initiate the login flow. 

* Go to Avionte Bold SAML Federated SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Avionte Bold SAML Federated SSO tile in the My Apps, this option redirects to Avionte Bold SAML Federated SSO Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Avionte Bold SAML Federated SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
