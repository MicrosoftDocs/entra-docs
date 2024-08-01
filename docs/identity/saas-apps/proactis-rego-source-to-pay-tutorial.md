---
title: Microsoft Entra SSO integration with Proactis Rego Source-to-Pay
description: Learn how to configure single sign-on between Microsoft Entra ID and Proactis Rego Source-to-Pay.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Proactis Rego Source-to-Pay so that I can control who has access to Proactis Rego Source-to-Pay, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Proactis Rego Source-to-Pay

In this article, you learn how to integrate Proactis Rego Source-to-Pay with Microsoft Entra ID. Proactis Rego is a powerful Source-to-Pay software platform designed for mid-market organizations. It's easy to use and integrate, giving you control over your spend and supply-chain risks. When you integrate Proactis Rego Source-to-Pay with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Proactis Rego Source-to-Pay.
* Enable your users to be automatically signed-in to Proactis Rego Source-to-Pay with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You are able to configure and test Microsoft Entra single sign-on for Proactis Rego Source-to-Pay in a test environment. Proactis Rego Source-to-Pay supports **SP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with Proactis Rego Source-to-Pay, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Proactis Rego Source-to-Pay single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Proactis Rego Source-to-Pay application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-proactis-rego-source-to-pay-from-the-azure-ad-gallery'></a>

### Add Proactis Rego Source-to-Pay from the Microsoft Entra gallery

Add Proactis Rego Source-to-Pay from the Microsoft Entra application gallery to configure single sign-on with Proactis Rego Source-to-Pay. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Proactis Rego Source-to-Pay** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type a URL using one of the following patterns:

	| **Identifier** |
	|---------|
	| `https://consult.esize.nl/domain/<domainId>` |
	| `https://start.esize.nl/domain/<domainId>` |
	| `https://bsmuk-uat.proactiscloud.com/domain/<domainId>` |
	| `https://bsmuk.proactiscloud.com/domain/<domainId>` |
	| `https://pxus-con.proactiscloud.com/domain/<domainId>` |
	| `https://bsmus.proactiscloud.com/domain/domainId` |

	b. In the **Reply URL** textbox, type a URL using one of the following patterns:

	| **Reply URL** |
	|---------|
	| `https://consult.esize.nl/saml/domain/<domainId>/login` |
	| `https://start.esize.nl/saml/domain/<domainId>/login` |
	| `https://bsmuk-uat.proactiscloud.com/saml/domain/<domainId>/login` |
	| `https://bsmuk.proactiscloud.com/saml/domain/<domainId>/login` |
	| `https://pxus-con.proactiscloud.com/saml/domain/<domainId>/login` |
	| `https://bsmus.proactiscloud.com/saml/domain/<domainId>/login` |

	c. In the **Sign on URL** textbox, type a URL using one of the following patterns:

	| **Sign on URL** |
	|---------|
	| `https://consult.esize.nl/saml/domain/<domainId>` |
	| `https://start.esize.nl/saml/domain/<domainId>` |
	| `https://bsmuk-uat.proactiscloud.com/saml/domain/<domainId>` |
	| `https://bsmuk.proactiscloud.com/saml/domain/<domainId>` |
	| `https://pxus-con.proactiscloud.com/saml/domain/<domainId>` |
	| `https://bsmus.proactiscloud.com/saml/domain/<domainId>` |

	> [!Note]
    > These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Proactis Rego Source-to-Pay support team](mailto:itcrowd@proactis.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration section**.

 1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (PEM)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot of the Certificate download link.](common/certificate-base64-download.png "Certificate")

1. On the **Set up Proactis Rego Source-to-Pay** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

## Configure Proactis Rego Source-to-Pay SSO

To configure single sign-on on **Proactis Rego Source-to-Pay** side, you need to send the downloaded **Certificate (PEM)** and appropriate copied URLs from the application configuration to [Proactis Rego Source-to-Pay support team](mailto:itcrowd@proactis.com). They set this setting to have the SAML SSO connection set properly on both sides

### Create Proactis Rego Source-to-Pay test user

In this section, you create a user called Britta Simon at Proactis Rego Source-to-Pay. Work with [Proactis Rego Source-to-Pay support team](mailto:itcrowd@proactis.com) to add the users in the Proactis Rego Source-to-Pay platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Proactis Rego Source-to-Pay Sign-on URL where you can initiate the login flow. 

* Go to Proactis Rego Source-to-Pay Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Proactis Rego Source-to-Pay tile in the My Apps, this will redirect to Proactis Rego Source-to-Pay Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Next steps

Once you configure Proactis Rego Source-to-Pay you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
