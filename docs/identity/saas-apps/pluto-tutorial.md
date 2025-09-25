---
title: Configure Pluto for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Pluto.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Pluto so that I can control who has access to Pluto, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Pluto for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Pluto with Microsoft Entra ID. When you integrate Pluto with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Pluto.
* Enable your users to be automatically signed-in to Pluto with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Pluto single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Pluto supports **SP** initiated SSO.
* Pluto supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Pluto from the gallery

To configure the integration of Pluto into Microsoft Entra ID, you need to add Pluto from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Pluto** in the search box.
1. Select **Pluto** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-pluto'></a>

## Configure and test Microsoft Entra SSO for Pluto

Configure and test Microsoft Entra SSO with Pluto using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Pluto.

To configure and test Microsoft Entra SSO with Pluto, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Pluto SSO](#configure-pluto-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Pluto test user](#create-pluto-test-user)** - to have a counterpart of B.Simon in Pluto that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Pluto** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://api.pluto.bio`

    b. In the **Reply URL** text box, type the URL:
    `https://api.pluto.bio/auth/social/complete/saml/`

    c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://pluto.bio/login/<organization-shortname>`

	> [!NOTE]
	> This value isn't real. Update this value with the actual Sign-on URL. Contact [Pluto Client support team](mailto:support@pluto.bio) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Pluto application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/edit-attribute.png)

1. In addition to above, Pluto application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirement.

	| Name |  Source Attribute |
	|-------| --------- |
    | email | user.mail |
    | first_name | user.givenname |
    | last_name | user.surname |

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Pluto** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)    

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Pluto SSO

To configure single sign-on on **Pluto** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Pluto support team](mailto:support@pluto.bio). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Pluto test user

In this section, a user called Britta Simon is created in Pluto. Pluto supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Pluto, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Pluto Sign-on URL where you can initiate the login flow. 

* Go to Pluto Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Pluto tile in the My Apps, this option redirects to Pluto Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Pluto you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
