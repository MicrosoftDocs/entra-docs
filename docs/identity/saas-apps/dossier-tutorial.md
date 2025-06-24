---
title: Configure Dossier for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Dossier.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Dossier so that I can control who has access to Dossier, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Dossier for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Dossier with Microsoft Entra ID. When you integrate Dossier with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Dossier.
* Enable your users to be automatically signed-in to Dossier with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with Dossier, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* Dossier single sign-on enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Dossier supports **SP** initiated SSO.

## Add Dossier from the gallery

To configure the integration of Dossier into Microsoft Entra ID, you need to add Dossier from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Dossier** in the search box.
1. Select **Dossier** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-dossier'></a>

## Configure and test Microsoft Entra SSO for Dossier

Configure and test Microsoft Entra SSO with Dossier using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Dossier.

To configure and test Microsoft Entra SSO with Dossier, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Dossier SSO](#configure-dossier-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Dossier test user](#create-dossier-test-user)** - to have a counterpart of B.Simon in Dossier that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Dossier** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a value using the following pattern: `Dossier/<CLIENTNAME>`

    > [!NOTE]
	> For identifier value it should be in the format of `Dossier/<CLIENTNAME>` or any user personalized value.

    b. In the **Reply URL** textbox, type a URL using the following pattern:
	
    | **Reply URL** |
    |--------|
    |`https://<SUBDOMAIN>.dossiersystems.com/azuresso`|
    |`https://dossier.<CLIENTDOMAINNAME>/azuresso`|
    
	c. In the **Sign on URL** text box, type a URL using the following pattern:

    | **Sign on URL** |
    |----------|
    |`https://<SUBDOMAIN>.dossiersystems.com/azuresso/account/SignIn`|
    |`https://dossier.<CLIENTDOMAINNAME>/azuresso/account/SignIn`|

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Dossier Client support team](mailto:support@intellimedia.ca) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select the copy button to copy **App Federation Metadata Url** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

1. On the **Set up Dossier** section, copy the appropriate URL(s) as per your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Dossier SSO

To configure single sign-on on **Dossier** side, you need to send the **App Federation Metadata Url** to [Dossier support team](mailto:support@intellimedia.ca). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Dossier test user

In this section, you create a user called Britta Simon in Dossier. Work with [Dossier support team](mailto:support@intellimedia.ca) to add the users in the Dossier platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Dossier Sign-on URL where you can initiate the login flow. 

* Go to Dossier Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Dossier tile in the My Apps, this option redirects to Dossier Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Dossier you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
