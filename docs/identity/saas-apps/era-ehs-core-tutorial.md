---
title: Configure ERA_EHS_CORE for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ERA_EHS_CORE.

author: nguhiu
manager: mwongerapk
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ERA_EHS_CORE so that I can control who has access to ERA_EHS_CORE, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ERA_EHS_CORE for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ERA_EHS_CORE with Microsoft Entra ID. When you integrate ERA_EHS_CORE with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ERA_EHS_CORE.
* Enable your users to be automatically signed-in to ERA_EHS_CORE with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* ERA_EHS_CORE single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ERA_EHS_CORE supports **SP** initiated SSO.

## Add ERA_EHS_CORE from the gallery

To configure the integration of ERA_EHS_CORE into Microsoft Entra ID, you need to add ERA_EHS_CORE from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ERA_EHS_CORE** in the search box.
1. Select **ERA_EHS_CORE** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-era_ehs_core'></a>

## Configure and test Microsoft Entra SSO for ERA_EHS_CORE

Configure and test Microsoft Entra SSO with ERA_EHS_CORE using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ERA_EHS_CORE.

To configure and test Microsoft Entra SSO with ERA_EHS_CORE, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ERA_EHS_CORE SSO](#configure-era_ehs_core-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ERA_EHS_CORE test user](#create-era_ehs_core-test-user)** - to have a counterpart of B.Simon in ERA_EHS_CORE that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ERA_EHS_CORE** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://www.era-env.com/era_ehs_core/<customername>`
    
    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | **Reply URL** |
    |-----------|
    | `https://www.era-env.com/era_ehs_core/<customername>/home/externallogin` |
    | `https://www.era-env.com/era_ehs_core/saml2/spxflow/Acs` |

    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://www.era-env.com/era_ehs_core/<customername>/home/externallogin`

    > [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [ERA_EHS_CORE Client support team](mailto:tech_support@era-ehs.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

	![Screenshot shows the Certificate download link.](common/copy-metadataurl.png "Certificate")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ERA_EHS_CORE SSO

To configure single sign-on on **ERA_EHS_CORE** side, you need to send the **App Federation Metadata Url** to [ERA_EHS_CORE support team](mailto:tech_support@era-ehs.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ERA_EHS_CORE test user

In this section, you create a user called Britta Simon at ERA_EHS_CORE. Work with [ERA_EHS_CORE support team](mailto:tech_support@era-ehs.com) to add the users in the ERA_EHS_CORE platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to ERA_EHS_CORE Sign-on URL where you can initiate the login flow. 

* Go to ERA_EHS_CORE Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the ERA_EHS_CORE tile in the My Apps, this option redirects to ERA_EHS_CORE Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure ERA_EHS_CORE you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
