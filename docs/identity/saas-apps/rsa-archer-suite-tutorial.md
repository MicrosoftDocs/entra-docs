---
title: Configure RSA Archer Suite for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and RSA Archer Suite.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and RSA Archer Suite so that I can control who has access to RSA Archer Suite, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure RSA Archer Suite for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate RSA Archer Suite with Microsoft Entra ID. When you integrate RSA Archer Suite with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to RSA Archer Suite.
* Enable your users to be automatically signed-in to RSA Archer Suite with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* RSA Archer Suite single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* RSA Archer Suite supports **SP** initiated SSO.
* RSA Archer Suite supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add RSA Archer Suite from the gallery

To configure the integration of RSA Archer Suite into Microsoft Entra ID, you need to add RSA Archer Suite from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **RSA Archer Suite** in the search box.
1. Select **RSA Archer Suite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-rsa-archer-suite'></a>

## Configure and test Microsoft Entra SSO for RSA Archer Suite

Configure and test Microsoft Entra SSO with RSA Archer Suite using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in RSA Archer Suite.

To configure and test Microsoft Entra SSO with RSA Archer Suite, perform following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure RSA Archer Suite SSO](#configure-rsa-archer-suite-sso)** - to configure the single sign-on settings on application side.
    1. **[Create RSA Archer Suite test user](#create-rsa-archer-suite-test-user)** - to have a counterpart of B.Simon in RSA Archer Suite that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **RSA Archer Suite** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Identifier (Entity ID)** text box, type the value:
    `RSAArcherSuite_TENANT_STRING`

	b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<BASE_URL>/default.aspx?IDP=<REALM_NAME>`

	> [!NOTE]
	> The Sign on URL value isn't real. Update the value with the actual Sign on URL. Contact [RSA Archer Suite Client support team](mailto:archersupport@rsa.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. RSA Archer Suite application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, RSA Archer Suite application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name |  Source Attribute|
	| -------------- | --------- |
	| FirstName | user.givenname |
	| LastName | user.surname |
	| PhoneNumber | user.telephonenumber |
	| City | user.city |
	| Zipcode | user.postalcode |
	| State | user.state |
	| Street | user.streetaddress |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up RSA Archer Suite** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure RSA Archer Suite SSO

1. Sign into the RSA Archer Suite website in a different browser as an administrator.

1. Perform the following steps in the following page.

	![Configure RSA Archer Suite SSO.](./media/rsa-archer-suite-tutorial/configuration.png)

	a. Go to the **Single Sign-On** tab and select **SAML** as a **Single Sign-On Mode** from the dropdown.

	b. Select **Allow manual bypass** checkbox.

	c. Give a valid name in the **Instance Entity ID** textbox.

	d. Paste the **Thumbprint Value** into the **Certificate Thumbprint** textbox.

	e. Select **Select** button and upload the downloaded **Federation Metadata XML** file from Azure portal.

	f. **Save** the Single Sign-On Settings. 

### Create RSA Archer Suite test user

In this section, a user called B.Simon is created in RSA Archer Suite. RSA Archer Suite supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in RSA Archer Suite, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to RSA Archer Suite Sign-on URL where you can initiate the login flow. 

* Go to RSA Archer Suite Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the RSA Archer Suite tile in the My Apps, this option redirects to RSA Archer Suite Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure RSA Archer Suite you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
