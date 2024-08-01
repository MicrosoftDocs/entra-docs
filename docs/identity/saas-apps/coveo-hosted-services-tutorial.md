---
title: Microsoft Entra SSO integration with Coveo Hosted Services
description: Learn how to configure single sign-on between Microsoft Entra ID and Coveo Hosted Services.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Coveo Hosted Services so that I can control who has access to Coveo Hosted Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Coveo Hosted Services

In this article, you'll learn how to integrate Coveo Hosted Services with Microsoft Entra ID. Coveo is an enterprise insight engine aimed at providing relevant content in the right context. Access to the Coveo Relevance Platform can be configured through SSO with Microsoft Entra ID. When you integrate Coveo Hosted Services with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Coveo Hosted Services.
* Enable your users to be automatically signed-in to Coveo Hosted Services with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for Coveo Hosted Services in a test environment. Coveo Hosted Services supports both **SP** and **IDP** initiated single sign-on.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Prerequisites

To integrate Microsoft Entra ID with Coveo Hosted Services, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Coveo Hosted Services single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Coveo Hosted Services application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-coveo-hosted-services-from-the-azure-ad-gallery'></a>

### Add Coveo Hosted Services from the Microsoft Entra gallery

Add Coveo Hosted Services from the Microsoft Entra application gallery to configure single sign-on with Coveo Hosted Services. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Coveo Hosted Services** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type one of the following URLs:

    | **Identifier** |
    |--------------|
    | `https://platform.cloud.coveo.com/saml/metadata` |
    | `https://platform-eu.cloud.coveo.com/saml metadata` |
    | `https://platform-au.cloud.coveo.com/saml/metadata` |
    | `https://platformhipaa.cloud.coveo.com/saml/metadata` |

    b. In the **Reply URL** textbox, type one of the following URLs:

    | **Reply URL** |
    |-----------|
    | `https://platform.cloud.coveo.com/saml/SSO` |
    | `https://platform-eu.cloud.coveo.com/saml/SSO` |
    | `https://platform-au.cloud.coveo.com/saml/SSO` |
    | `https://platformhipaa.cloud.coveo.com/saml/SSO` |

1. If you want to configure **SP** initiated SSO, then perform the following step:  

    In the **Sign on URL** textbox, type one of the following URLs:

    | **Sign on URL** |
    |-------------|
    | `https://platform.cloud.coveo.com/login` |
    | `https://platform-eu.cloud.coveo.com/login` |
    | `https://platform-au.cloud.coveo.com/login` |

1. Your Coveo Hosted Services application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Unique User Identifier** is **user.userprincipalname** but Coveo Hosted Services expects this to be mapped with the user's email address. For that you can use **user.mail** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Coveo Hosted Services application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
    | user.email | user.email |
    | user.groups | user.groups |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Coveo Hosted Services** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

## Configure Coveo Hosted Services SSO

To configure single sign-on on **Coveo Hosted Services** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Coveo Hosted Services support team](mailto:support@coveo.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Coveo Hosted Services test user

In this section, you create a user called Britta Simon in Coveo Hosted Services. Work with [Coveo Hosted Services support team](mailto:support@coveo.com) to add the users in the Coveo Hosted Services platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Click on **Test this application**, this will redirect to Coveo Hosted Services Sign on URL where you can initiate the login flow.  

* Go to Coveo Hosted Services Sign on URL directly and initiate the login flow from there.

#### IDP initiated:

* Click on **Test this application**, and you should be automatically signed in to the Coveo Hosted Services for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you click the Coveo Hosted Services tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Coveo Hosted Services for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure Coveo Hosted Services you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
