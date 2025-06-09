---
title: Configure Insightly SAML for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Insightly SAML.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

---

# Configure Insightly SAML for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Insightly SAML with Microsoft Entra ID. When you integrate Insightly SAML with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Insightly SAML.
* Enable your users to be automatically signed-in to Insightly SAML with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Insightly SAML single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Insightly SAML supports **IDP** initiated SSO.

## Adding Insightly SAML from the gallery

To configure the integration of Insightly SAML into Microsoft Entra ID, you need to add Insightly SAML from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Insightly SAML** in the search box.
1. Select **Insightly SAML** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for Insightly SAML

Configure and test Microsoft Entra SSO with Insightly SAML using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Insightly SAML.

To configure and test Microsoft Entra SSO with Insightly SAML, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Insightly SAML SSO](#configure-insightly-saml-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Insightly SAML test user](#create-insightly-saml-test-user)** - to have a counterpart of B.Simon in Insightly SAML that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Insightly SAML** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a URL using one of the following patterns:

    | **Identifier** |
    |------------|
    | `https://crm.na1.insightly.com/user/saml?instanceId=<ID>` |
    | `https://crm.au1.insightly.com/user/saml?instanceId=<ID>` |

    b. In the **Reply URL** textbox, type a URL using one of the following patterns:

    | **Reply URL** |
    |------------|
    | `https://crm.na1.insightly.com/user/saml?instanceId=<ID>` |
    | `https://crm.au1.insightly.com/user/saml?instanceId=<ID>` |

	> [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [Insightly SAML support team](mailto:support@insight.ly) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Insightly SAML** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Insightly SAML SSO

To configure single sign-on on **Insightly SAML** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [Insightly SAML support team](mailto:support@insight.ly). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Insightly SAML test user

In this section, you create a user called B.Simon in Insightly SAML. Work with [Insightly SAML support team](mailto:support@insight.ly) to add the users in the Insightly SAML platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select Test this application in Microsoft Entra admin center and you should be automatically signed in to the Insightly SAML for which you set up the SSO.
 
* You can use Microsoft My Apps. When you select the Insightly SAML tile in the My Apps, you should be automatically signed in to the Insightly SAML for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Insightly SAML you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).