---
title: Configure Bealink for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Bealink.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Bealink so that I can control who has access to Bealink, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Bealink for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Bealink with Microsoft Entra ID. When you integrate Bealink with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Bealink.
* Enable your users to be automatically signed-in to Bealink with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Bealink single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Bealink supports **SP and IDP** initiated SSO.
* Bealink supports **Just In Time** user provisioning.

## Add Bealink from the gallery

To configure the integration of Bealink into Microsoft Entra ID, you need to add Bealink from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Bealink** in the search box.
1. Select **Bealink** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-bealink'></a>

## Configure and test Microsoft Entra SSO for Bealink

Configure and test Microsoft Entra SSO with Bealink using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Bealink.

To configure and test Microsoft Entra SSO with Bealink, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Bealink SSO](#configure-bealink-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Bealink test user](#create-bealink-test-user)** - to have a counterpart of B.Simon in Bealink that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Bealink** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://app.bealink.io/Saml2https://app.bealink.io/Saml2?company=<ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.bealink.io/Saml2/Acs?company=<ID>`

	c. In the **Sign-on URL** text box, type the URL:
    `https://app.bealink.io/`

	> [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Bealink Client support team](mailto:support@bealink.io) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Bealink SSO

To configure single sign-on on **Bealink** side, you need to send the **App Federation Metadata Url** to [Bealink support team](mailto:support@bealink.io). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Bealink test user

In this section, a user called B.Simon is created in Bealink. Bealink supports just-in-time provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Bealink, a new one is created when you attempt to access Bealink.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Bealink Sign on URL where you can initiate the login flow.  

* Go to Bealink Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Bealink for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Bealink tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Bealink for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Bealink you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
