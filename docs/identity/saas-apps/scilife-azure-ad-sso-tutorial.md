---
title: Microsoft Entra SSO integration with Scilife Microsoft Entra SSO
description: Learn how to configure single sign-on between Microsoft Entra ID and Scilife Microsoft Entra SSO.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Scilife Microsoft Entra SSO so that I can control who has access to Scilife Microsoft Entra SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with Scilife Microsoft Entra SSO

In this article, you'll learn how to integrate Scilife Microsoft Entra SSO with Microsoft Entra ID. With the help of this application SSO integration is made simple and hassle free as most of the configuration will take place on its own with minimalist efforts. When you integrate Scilife Microsoft Entra SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Scilife Microsoft Entra SSO.
* Enable your users to be automatically signed-in to Scilife Microsoft Entra SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for Scilife Microsoft Entra SSO in a test environment. Scilife Microsoft Entra SSO supports **SP** initiated single sign-on and **Just In Time** user provisioning.

## Prerequisites

To integrate Microsoft Entra ID with Scilife Microsoft Entra SSO, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Scilife Microsoft Entra SSO single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the Scilife Microsoft Entra SSO application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-scilife-azure-ad-sso-from-the-azure-ad-gallery'></a>

### Add Scilife Microsoft Entra SSO from the Microsoft Entra gallery

Add Scilife Microsoft Entra SSO from the Microsoft Entra application gallery to configure single sign-on with Scilife Microsoft Entra SSO. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Scilife Microsoft Entra SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier** textbox, type a URL using one of the following patterns:

	| **Identifier** |
	|--------------|
	| `https://ldap-Environment.scilife.io/simplesaml/module.php/saml/sp/metadata.php/<CustomerUrlPrefix>-<Environment>-sp` |
	| `https://ldap.scilife.io/simplesaml/module.php/saml/sp/metadata.php/<CustomerUrlPrefix>-sp` |

	b. In the **Reply URL** textbox, type a URL using one of the following patterns:

	| **Reply URL** |
	|---------|
	| `https://<CustomerUrlPrefix>.scilife.io/<languageCode>/login` |
	| `https://ldap.scilife.io/simplesaml/module.php/saml/sp/metadata.php/<CustomerUrlPrefix>-sp` |
	| `https://ldap.scilife.io/simplesaml/module.php/saml/sp/saml2-acs.php/<CustomerUrlPrefix>-sp` |
	| `https://<CustomerUrlPrefix>-<Environment>.scilife.io/<languageCode>/login` |
	| `https://ldap-<Environment>.scilife.io/simplesaml/module.php/saml/sp/metadata.php/<CustomerUrlPrefix>-<Environment>-sp` |
	| `https://ldap-<Environment>.scilife.io/simplesaml/module.php/saml/sp/saml2-acs.php/<CustomerUrlPrefix>-<Environment>-sp` |

	c. In the **Sign on URL** textbox, type a URL using one of the following patterns:

	| **Sign on URL** |
	|-----------|
	| `https://<CustomerUrlPrefix>.scilife.io/<languageCode>/login` |
	| `https://<CustomerUrlPrefix>-<Environment>.scilife.io/<languageCode>/login` |

	> [!Note]
	> These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Scilife Microsoft Entra SSO support team](mailto:support@scilife.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Scilife Microsoft Entra SSO application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, Scilife Microsoft Entra SSO application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
    | email | user.mail |
	| firstname | user.givenname |
	| lastname | user.surname |
	| ldap_user_id | user.userprincipalname |
	| mobile | user.mobilephone |

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Scilife Microsoft Entra SSO** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

<a name='configure-scilife-azure-ad-sso'></a>

## Configure Scilife Microsoft Entra SSO

1. Log in to your Scilife Microsoft Entra SSO company site as an administrator.

1. Go to **Manage** > **Active Directory Settings** and perform the following steps:

	![Screenshot shows the Scilife Azure administration portal.](media/scilife-azure-ad-sso-tutorial/manage.png "Admin")

	1. Enable **Configure Active Directory**.

	1. Select **AD Azure** type from the drop-down.

	1. Download the **Federation Metadata XML file** and **Upload MetadataXML** file by clicking on **Choose file**.

	1. Click **Parse Metadata**.

1. Enter **Tenant ID**, **Application ID** and **Client ID** in the following fields.
		
	![Screenshot shows the Scilife Azure tenant ID.](media/scilife-azure-ad-sso-tutorial/tenant.png "App")

1. Copy **AD TRUST URL**, paste this value into the **Identifier (Entity ID)** text box in the **Basic SAML Configuration** section.

1. Copy **AD CONSUMER SERVICE URL**, paste this value into the **Reply URL (Assertion Consumer Service URL)** text box in the **Basic SAML Configuration** section.

	![Screenshot shows the Scilife Azure portal URLs.](media/scilife-azure-ad-sso-tutorial/portal.png "Azure Configuration")

1. Click **Save Configuration**.

<a name='create-scilife-azure-ad-sso-test-user'></a>

### Create Scilife Microsoft Entra SSO test user

In this section, a user called B.Simon is created in Scilife Microsoft Entra SSO. Scilife Microsoft Entra SSO supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Scilife Microsoft Entra SSO, a new one is commonly created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Scilife Microsoft Entra SSO Sign-on URL where you can initiate the login flow. 

* Go to Scilife Microsoft Entra SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Scilife Microsoft Entra SSO tile in the My Apps, this will redirect to Scilife Microsoft Entra SSO Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure Scilife Microsoft Entra SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
