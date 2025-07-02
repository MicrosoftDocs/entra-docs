---
title: Configure pymetrics for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and pymetrics.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and pymetrics so that I can control who has access to pymetrics, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure pymetrics for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate pymetrics with Microsoft Entra ID. When you integrate pymetrics with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to pymetrics.
* Enable your users to be automatically signed-in to pymetrics with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* pymetrics single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* pymetrics supports **SP** initiated SSO. If you need to configure an **IDP** initiated flow, please reach out to [pymetrics support](mailto:solutions-engineering@pymetrics.com).
* pymetrics supports **Just In Time** user provisioning.

## Add pymetrics from the gallery

To configure the integration of pymetrics into Microsoft Entra ID, you need to add pymetrics from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **pymetrics** in the search box.
1. Select **pymetrics** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-pymetrics'></a>

## Configure and test Microsoft Entra SSO for pymetrics

Configure and test Microsoft Entra SSO with pymetrics using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in pymetrics.

To configure and test Microsoft Entra SSO with pymetrics, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure pymetrics SSO](#configure-pymetrics-sso)** - to configure the single sign-on settings on application side.
    1. **[Create pymetrics test user](#create-pymetrics-test-user)** - to have a counterpart of B.Simon in pymetrics that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **pymetrics** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://www.pymetrics.com/saml2-sp/<CUSTOMERNAME>/<CUSTOMERNAME>/metadata/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://www.pymetrics.com/saml2-sp/<CUSTOMERNAME>/<CUSTOMERNAME>/?acs`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://www.pymetrics.com/saml2-sp/<CUSTOMERNAME>/<CUSTOMERNAME>/?sso`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [pymetrics Client support team](mailto:solutions-engineering@pymetrics.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. The pymetrics application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following table shows the list of default attributes. These attributes are prepopulated but you can review them as per your requirements.
	
	| Name | Source Attribute|
	| --------------- | --------- |
	| UserFirstName | user.givenname |
	| UserLastName | user.surname |
	| UserEmail | user.userprincipalname |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up pymetrics** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure pymetrics SSO

To configure single sign-on on **pymetrics** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [pymetrics support team](mailto:solutions-engineering@pymetrics.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create pymetrics test user

In this section, a user called Britta Simon is created in pymetrics. pymetrics supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in pymetrics, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to pymetrics Sign-on URL where you can initiate the login flow. 

* Go to pymetrics Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the pymetrics tile in the My Apps, this option redirects to pymetrics Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure pymetrics you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
