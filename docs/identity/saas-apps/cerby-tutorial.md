---
title: Configure Cerby for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cerby.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cerby so that I can control who has access to Cerby, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Cerby for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cerby with Microsoft Entra ID. When you integrate Cerby with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cerby.
* Enable your users to be automatically signed-in to Cerby with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cerby single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Cerby supports **SP** initiated SSO.
* Cerby supports **Just In Time** user provisioning.
* Cerby supports [Automated user provisioning](cerby-provisioning-tutorial.md).

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding Cerby from the gallery

To configure the integration of Cerby into Microsoft Entra ID, you need to add Cerby from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cerby** in the search box.
1. Select **Cerby** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-cerby'></a>

## Configure and test Microsoft Entra SSO for Cerby

Configure and test Microsoft Entra SSO with Cerby using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cerby.

To configure and test Microsoft Entra SSO with Cerby, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cerby SSO](#configure-cerby-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cerby test user](#create-cerby-test-user)** - to have a counterpart of B.Simon in Cerby that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cerby** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `urn:amazon:cognito:sp:<ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CustomerName>-cerbyauth.auth.us-east-2.amazoncognito.com/saml2/idpresponse`

	c. In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | Sign on URL |
    |--------|
    | `https://app.cerby.com` |
    | `https://<CustomerName>.cerby.com` |
    |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Cerby Client support team](mailto:help@cerby.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Cerby application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows an example for this. The default value of **Name** is **user.userprincipalname** but Cerby expects this to be mapped with the user's givenname. For that you can use **user.givenname** attribute from the list or use the appropriate attribute value based on your organization configuration.

	![image](common/default-attributes.png)

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cerby SSO

To configure single sign-on on Cerby side, you need to send the **App Federation Metadata Url** to [Cerby support team](mailto:help@cerby.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cerby test user

In this section, a user called Britta Simon is created in Cerby. Cerby supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Cerby, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Cerby Sign-on URL where you can initiate the login flow. 

* Go to Cerby Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Cerby tile in the My Apps, this option redirects to Cerby Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Cerby you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
