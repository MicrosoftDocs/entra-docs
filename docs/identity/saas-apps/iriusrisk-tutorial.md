---
title: Configure IriusRisk for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and IriusRisk.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IriusRisk so that I can control who has access to IriusRisk, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure IriusRisk for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate IriusRisk with Microsoft Entra ID. When you integrate IriusRisk with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to IriusRisk.
* Enable your users to be automatically signed-in to IriusRisk with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* IriusRisk single sign-on enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* IriusRisk supports **SP** initiated SSO.
* IriusRisk supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add IriusRisk from the gallery

To configure the integration of IriusRisk into Microsoft Entra ID, you need to add IriusRisk from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **IriusRisk** in the search box.
1. Select **IriusRisk** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-iriusrisk'></a>

## Configure and test Microsoft Entra SSO for IriusRisk

Configure and test Microsoft Entra SSO with IriusRisk using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in IriusRisk.

To configure and test Microsoft Entra SSO with IriusRisk, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure IriusRisk SSO](#configure-iriusrisk-sso)** - to configure the single sign-on settings on application side.
    1. **[Create IriusRisk test user](#create-iriusrisk-test-user)** - to have a counterpart of B.Simon in IriusRisk that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **IriusRisk** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the value:
    `iriusrisk-sp`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<companyname>.iriusrisk.com/ui#!login`

	> [!NOTE]
	> The Sign-on URL value isn't real. Update this value with the actual Sign-On URL. Contact [IriusRisk Client support team](mailto:info@continuumsecurity.net) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up IriusRisk** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure IriusRisk SSO

To configure single sign-on on **IriusRisk** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [IriusRisk support team](mailto:info@continuumsecurity.net). They set this setting to have the SAML SSO connection set properly on both sides.

### Create IriusRisk test user

In this section, a user called Britta Simon is created in IriusRisk. IriusRisk supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in IriusRisk, a new one is created after authentication.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to IriusRisk Sign-on URL where you can initiate the login flow. 

* Go to IriusRisk Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the IriusRisk tile in the My Apps, this option redirects to IriusRisk Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure IriusRisk you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
