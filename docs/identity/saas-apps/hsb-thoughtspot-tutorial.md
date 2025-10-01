---
title: Configure HSB ThoughtSpot for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and HSB ThoughtSpot.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and HSB ThoughtSpot so that I can control who has access to HSB ThoughtSpot, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure HSB ThoughtSpot for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate HSB ThoughtSpot with Microsoft Entra ID. When you integrate HSB ThoughtSpot with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to HSB ThoughtSpot.
* Enable your users to be automatically signed-in to HSB ThoughtSpot with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* HSB ThoughtSpot single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* HSB ThoughtSpot supports **SP** initiated SSO
* HSB ThoughtSpot supports **Just In Time** user provisioning

## Adding HSB ThoughtSpot from the gallery

To configure the integration of HSB ThoughtSpot into Microsoft Entra ID, you need to add HSB ThoughtSpot from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **HSB ThoughtSpot** in the search box.
1. Select **HSB ThoughtSpot** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-hsb-thoughtspot'></a>

## Configure and test Microsoft Entra SSO for HSB ThoughtSpot

Configure and test Microsoft Entra SSO with HSB ThoughtSpot using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in HSB ThoughtSpot.

To configure and test Microsoft Entra SSO with HSB ThoughtSpot, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure HSB ThoughtSpot SSO](#configure-hsb-thoughtspot-sso)** - to configure the single sign-on settings on application side.
    1. **[Create HSB ThoughtSpot test user](#create-hsb-thoughtspot-test-user)** - to have a counterpart of B.Simon in HSB ThoughtSpot that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **HSB ThoughtSpot** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    In the **Sign-on URL** text box, type one of the following URLs:

    | Sign-on URL |
    | ------------- |
    | `https://hsbthoughtspot.mruscloud.com:443` |
    | `https://hsbthoughtspot.mruscloud.com/#/login` |
    |

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up HSB ThoughtSpot** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure HSB ThoughtSpot SSO

To configure single sign-on on **HSB ThoughtSpot** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [HSB ThoughtSpot support team](mailto:HSB-BDL-IT-SAPBO-ADMIN@hsb.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create HSB ThoughtSpot test user

In this section, a user called Britta Simon is created in HSB ThoughtSpot. HSB ThoughtSpot supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in HSB ThoughtSpot, a new one is created after authentication.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to HSB ThoughtSpot Sign-on URL where you can initiate the login flow. 

* Go to HSB ThoughtSpot Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the HSB ThoughtSpot tile in the My Apps, this option redirects to HSB ThoughtSpot Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure HSB ThoughtSpot you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
