---
title: Microsoft Entra SSO integration with OpenText Directory Services (OTDS)
description: Learn how to configure single sign-on between Microsoft Entra ID and Directory Services.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with OpenText Directory Services (OTDS)

In this article, you will learn how to integrate OpenText Directory Services (OTDS) with Microsoft Entra ID. When you integrate OTDS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to OTDS.
* Enable your users to be automatically signed-in to OTDS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* OpenText Directory Services (OTDS).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* OTDS supports both **SAML** and **OIDC** authentication
* OTDS supports **SP and IDP** initiated SSO.
* OTDS supports **Just In Time** user provisioning.
* OTDS supports [Automated user provisioning](open-text-directory-services-provisioning-tutorial.md).

## Add Directory Services from the gallery

To configure the integration of Directory Services into Microsoft Entra ID, you need to add Directory Services from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **OpenText** in the search box.
![Screenshot shows the search result.](./media/open-text-directory-services-tutorial/otds-azure-gallery.png "Enable automatic user provisioning")
1. Select **OpenText Directory Services** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-open-text-directory-services'></a>

## Configure and test Microsoft Entra SSO for OpenText Directory Services

Configure and test Microsoft Entra SSO with OTDS using a test user, for example **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Directory Services.

To configure and test Microsoft Entra SSO with Directory Services, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure OTDS SSO](#configure-directory-services-sso)** - to configure the single sign-on settings on application side.
    1. **[Create OTDS test user](#create-directory-services-test-user)** - to have a counterpart of B.Simon in Directory Services that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

### SAML Authentication
Follow these steps to enable Microsoft Entra SSO using SAML Authentication.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **OpenText Directory Services** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.

   ![Screenshot shows single sign-op possabilities.](./media/open-text-directory-services-tutorial/otds-azure-sso-method-saml.png "Select SAML single sign-on method")

1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

   ![Screenshot shows SAML configuration.](./media/open-text-directory-services-tutorial/otds-azure-saml-basic-config.png "Edit Basic SAML Configuration")

    a. In the **Identifier** text box, type a URL using one of the following patterns:

    | Identifier |
    |------------|
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/login` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/otdsws/login` |
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/<OTDS_TENANT>/<TENANTID>/login` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/login` |
    |

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    |------------|
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/login?authhandler=<AUTH-HANDLER-NAME>` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/otdsws/login?authhandler=<AUTH-HANDLER-NAME>` |
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/<OTDS_TENANT>/<TENANTID>/login?authhandler=<AUTH-HANDLER-NAME>` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/login?authhandler=<AUTH-HANDLER-NAME>` |
    |

1. Perform the following step, if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using one of the following patterns:
    
    | Sign-on URL |
    |------------|
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/login` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/otdsws/login` |
    | `https://<HOSTNAME.DOMAIN.com>/otdsws/<OTDS_TENANT>/<TENANTID>/login` |
    | `https://<HOSTNAME.DOMAIN.com>/<OTDS_TENANT>/<TENANTID>/login` |
    |

	> [!NOTE]
	> These values are examples. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Directory Services support team](mailto:support@opentext.com) to get these values. You can also refer to the patterns shown above in the **Basic SAML Configuration** section. Alternatively, if you have already setup the Authentication Handler in OTDS, you can get the configuration xml from `https://<HOSTNAME.DOMAIN.com>/otdsws/login?SAMLMetadata=<AUTH-HANDLER-NAME>`.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure OpenText Directory Services SSO

### SAML Authentication
To configure single sign-on on **OTDS** side, you need to send the **App Federation Metadata Url** or **App Federation Metadata XML** to [Directory Services support team](mailto:support@opentext.com). They set this setting to have the SAML SSO connection set properly on both sides.

If you have access to your own OTDS installation, you can perform the following steps

In OTDS, create a SAML 2.0 Authentication Handler.
* Select Browse to select the metadata file downloaded above
* Configure the OTDS SP Endpoint to be the exact same URL entered into Azure AD above

   ![Screenshot shows OTDS SAML configuration.](./media/open-text-directory-services-tutorial/otds-saml-handler.png "Edit OTDS SAML Configuration")

* If you used the default settings in the attribute mappings on Azure AD, set the authentication principal attribute to cn.

   ![Screenshot shows OTDS SAML configuration.](./media/open-text-directory-services-tutorial/otds-saml-handler-config.png "Edit OTDS SAML Configuration")

* Save the authentication handler and attempt to access the application. You should now be automatically redirected to Azure and be able to sign in.

> [!NOTE]
> There is no need to configure certificates on the OTDS side since Azure AD does not expect or require applications to sign their SAML authentication requests. However, should you require Single Logout (SLO) out to be initiated from OTDS, you must configure signing on the authentication handler. See the latest OpenText Directory Services Installation and Administration Guide for details.
> Enabling Single Logout (SLO) out may in turn require that the **XML Signature Algorithm** is changed from `http://www.w3.org/2000/09/xmldsig#rsa-sha1` to `http://www.w3.org/2001/04/xmldsig-more#rsa-sha256`

> [!NOTE]
> Once the Authentication handler has been created, the configuration is available for download via the following URL: `https://<HOSTNAME.DOMAIN.com>/otdsws/login?SAMLMetadata=<AUTH-HANDLER-NAME>`. You can download this XML for comparison / import in Entra if required.

> [!NOTE]
> OTDS also supports automatic user provisioning, you can find more details [here](./open-text-directory-services-provisioning-tutorial.md) on how to configure automatic user provisioning.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Directory Services Sign-on URL where you can initiate the login flow.  

* Go to Directory Services Sign-on URL directly and initiate the login flow from there.