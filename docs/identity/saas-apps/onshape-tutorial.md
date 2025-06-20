---
title: Configure Onshape for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Onshape.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Onshape so that I can control who has access to Onshape, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Onshape for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Onshape with Microsoft Entra ID. When you integrate Onshape with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Onshape.
* Enable your users to be automatically signed-in to Onshape with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Onshape single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Onshape supports **SP and IDP** initiated SSO
* Onshape supports **Just In Time** user provisioning
> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.


## Adding Onshape from the gallery

To configure the integration of Onshape into Microsoft Entra ID, you need to add Onshape from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Onshape** in the search box.
1. Select **Onshape** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-onshape'></a>

## Configure and test Microsoft Entra SSO for Onshape

Configure and test Microsoft Entra SSO with Onshape using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Onshape.

To configure and test Microsoft Entra SSO with Onshape, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Onshape SSO](#configure-onshape-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Onshape test user](#create-onshape-test-user)** - to have a counterpart of B.Simon in Onshape that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Onshape** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. If prompted to save your single sign-on setting, select **Yes**. 
1. The Onshape application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, the Onshape application expects few more attributes shown below to be passed to it in the SAML response. These attributes are also pre-populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| --------------- | --------- |
	| firstName | user.givenname |
	| lastName | user.surname |
	| companyName | <COMPANY_NAME> |

    > [!NOTE]
    > You *must* change the value of the **companyName** attribute to the *domain prefix* of your Onshape enterprise. For example, if you access the Onshape application by using a URL like `https://acme.onshape.com`, your domain prefix is *acme*. The attribute value must be only the prefix, not the entire DNS name.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Onshape** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Onshape SSO

For information about how to configure single sign-on on the **Onshape** side, see [Integrating with Microsoft Entra ID](https://cad.onshape.com/help/Content/MS_AzureAD.htm).

### Create Onshape test user

In this section, a user called Britta Simon is created in Onshape. Onshape supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Onshape, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Onshape Sign on URL where you can initiate the login flow.  

* Go to Onshape Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Onshape for which you set up the SSO 

You can also use Microsoft My Apps to test the application in any mode. When you select the Onshape tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Onshape for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Onshape you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
