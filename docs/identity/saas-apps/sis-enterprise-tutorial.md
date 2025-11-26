---
title: Configure SIS Enterprise for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and SIS Enterprise.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and SIS Enterprise so that I can control who has access to SIS Enterprise, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure SIS Enterprise for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate SIS Enterprise with Microsoft Entra ID. When you integrate SIS Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to SIS Enterprise.
* Enable your users to be automatically signed-in to SIS Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites
The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* SIS Enterprise single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.


* SIS Enterprise supports **IDP** initiated SSO.

* SIS Enterprise supports **Just In Time** user provisioning.


## Adding SIS Enterprise from the gallery

To configure the integration of SIS Enterprise into Microsoft Entra ID, you need to add SIS Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **SIS Enterprise** in the search box.
1. Select **SIS Enterprise** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)


<a name='configure-and-test-azure-ad-sso-for-sis-enterprise'></a>

## Configure and test Microsoft Entra SSO for SIS Enterprise

Configure and test Microsoft Entra SSO with SIS Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in SIS Enterprise.

To configure and test Microsoft Entra SSO with SIS Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure SIS Enterprise SSO](#configure-sis-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create SIS Enterprise test user](#create-sis-enterprise-test-user)** - to have a counterpart of B.Simon in SIS Enterprise that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **SIS Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to Edit Basic SAML Configuration.](common/edit-urls.png)

1. On the **Set up single sign-on with SAML** page, enter the values for the following fields:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<ENVIRONMENT>.tractionguest.com/saml/metadata`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<ENVIRONMENT>.tractionguest.com/sessions/sso/callback`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [SIS Enterprise support team](mailto:https://signinenterprise.com/support/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up SIS Enterprise** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure SIS Enterprise SSO

To configure single sign-on on **SIS Enterprise** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [SIS Enterprise support team](mailto:https://signinenterprise.com/support/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create SIS Enterprise test user

In this section, a user called Britta Simon is created in SIS Enterprise. SIS Enterprise supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in SIS Enterprise, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the SIS Enterprise for which you set up the SSO

* You can use Microsoft My Apps. When you select the SIS Enterprise tile in the My Apps, you should be automatically signed in to the SIS Enterprise for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure SIS Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
