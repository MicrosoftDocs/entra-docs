---
title: Configure ClarivateWOS for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ClarivateWOS.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ClarivateWOS so that I can control who has access to ClarivateWOS, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ClarivateWOS for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ClarivateWOS with Microsoft Entra ID. When you integrate ClarivateWOS with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ClarivateWOS.
* Enable your users to be automatically signed-in to ClarivateWOS with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ClarivateWOS single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ClarivateWOS supports **SP** initiated SSO.

* ClarivateWOS supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ClarivateWOS from the gallery

To configure the integration of ClarivateWOS into Microsoft Entra ID, you need to add ClarivateWOS from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ClarivateWOS** in the search box.
1. Select **ClarivateWOS** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-clarivatewos'></a>

## Configure and test Microsoft Entra SSO for ClarivateWOS

Configure and test Microsoft Entra SSO with ClarivateWOS using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ClarivateWOS.

To configure and test Microsoft Entra SSO with ClarivateWOS, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ClarivateWOS SSO](#configure-clarivatewos-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ClarivateWOS test user](#create-clarivatewos-test-user)** - to have a counterpart of B.Simon in ClarivateWOS that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ClarivateWOS** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** box, type the URL:
    `https://sp.tshhosting.com/shibboleth`

    b. In the **Reply URL** text box, type the URL:
    `https://www.webofknowledge.com/?auth=Shibboleth`

    c. In the **Sign-on URL** text box, type the URL:
    `https://www.webofknowledge.com/`

1. ClarivateWOS application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![image](common/default-attributes.png)

1. In addition to above, ClarivateWOS application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.
	
	| Name | Source Attribute |
	| -------- | --------- |
	| email | user.userprincipalname |
    | firstName | user.givenname |
    | lastName | user.surname |
    | application | "WOK" |

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ClarivateWOS SSO

To configure single sign-on on **ClarivateWOS** side, you need to send the **App Federation Metadata Url** to [ClarivateWOS support team](mailto:shibbolethsupport@clarivate.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ClarivateWOS test user

In this section, a user called Britta Simon is created in ClarivateWOS. ClarivateWOS supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in ClarivateWOS, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ClarivateWOS Sign-on URL where you can initiate the login flow. 

* Go to ClarivateWOS Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ClarivateWOS tile in the My Apps, this option redirects to ClarivateWOS Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ClarivateWOS you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
