---
title: Configure Yokoy for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Yokoy.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 01/22/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Yokoy so that I can control who has access to Yokoy, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Yokoy for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Yokoy with Microsoft Entra ID. When you integrate Yokoy with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Yokoy.
* Enable your users to be automatically signed-in to Yokoy with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Yokoy single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Yokoy supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Yokoy from the gallery

To configure the integration of Yokoy into Microsoft Entra ID, you need to add Yokoy from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Yokoy** in the search box.
1. Select **Yokoy** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-Yokoy'></a>

## Configure and test Microsoft Entra SSO for Yokoy

Configure and test Microsoft Entra SSO with Yokoy using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Yokoy.

To configure and test Microsoft Entra SSO with Yokoy, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Yokoy SSO](#configure-yokoy-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Yokoy test user](#create-yokoy-test-user)** - to have a counterpart of B.Simon in Yokoy that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Yokoy** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** page, perform the following steps:

    a. In the **Identifier** text box, type the value:
    `VERSAL`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://Yokoy.com/sso/saml/orgs/<organization_id>`

    > [!NOTE]
    > The Reply URL value isn't real. Update this value with the actual Reply URL. Contact Yokoy Client support team to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Yokoy application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes, whereas **nameidentifier** is mapped with **user.userprincipalname**. Yokoy application expects **nameidentifier** to be mapped with **user.mail**, so you need to edit the attribute mapping by selecting **Edit** icon and change the attribute mapping.

    ![Screenshot shows the image of Yokoy application.](common/edit-attribute.png "Attributes")

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up Yokoy** section, copy one or more appropriate URLs based on your requirement.

    ![Screenshot shows to copy appropriate configuration URL.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Yokoy SSO

To configure single sign-on on **Yokoy** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to Yokoy support team. They set this setting to have the SAML SSO connection set properly on both sides.

### Create Yokoy test user

In this section, you create a user called B.Simon in Yokoy. Follow the Creating a SAML test user support guide to create the user B.Simon within your organization. Users must be created and activated in Yokoy before you use single sign-on. 

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration using a Yokoy course embedded within your website.
See the Embedding Organizational Courses **SAML Single Sign-On**
support guide for instructions on how to embed a Yokoy course with support for Microsoft Entra single sign-on. 

You'll need to create a course, share it with your organization, and publish it in order to test course embedding. 

## Related content

Once you configure Yokoy you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
