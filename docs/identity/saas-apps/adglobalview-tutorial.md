---
title: Configure ADP Globalview (Deprecated) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ADP Globalview (Deprecated).

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ADP Globalview (Deprecated) so that I can control who has access to ADP Globalview (Deprecated), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ADP Globalview (Deprecated) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ADP Globalview (Deprecated) with Microsoft Entra ID. When you integrate ADP Globalview (Deprecated) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ADP Globalview (Deprecated).
* Enable your users to be automatically signed-in to ADP Globalview (Deprecated) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ADP Globalview (Deprecated) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ADP Globalview (Deprecated) supports **IDP** initiated SSO.

## Adding ADP Globalview (Deprecated) from the gallery

To configure the integration of ADP Globalview (Deprecated) into Microsoft Entra ID, you need to add ADP Globalview (Deprecated) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ADP Globalview (Deprecated)** in the search box.
1. Select **ADP Globalview (Deprecated)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-adp-globalview-deprecated'></a>

## Configure and test Microsoft Entra SSO for ADP Globalview (Deprecated)

Configure and test Microsoft Entra SSO with ADP Globalview (Deprecated) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ADP Globalview (Deprecated).

To configure and test Microsoft Entra SSO with ADP Globalview (Deprecated), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure ADP Globalview (Deprecated) SSO](#configure-adp-globalview-deprecated-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ADP Globalview (Deprecated) test user](#create-adp-globalview-deprecated-test-user)** - to have a counterpart of B.Simon in ADP Globalview (Deprecated) that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ADP Globalview (Deprecated)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

    
    In the **Identifier** text box, type a URL using one of the following patterns:

    | Identifier |
    | ----------- |
    | `https://<subdomain>.globalview.adp.com/federate` |
    | `https://<subdomain>.globalview.adp.com/federate2` |
    |

	> [!NOTE]
	> This value isn't  real. Update the value with the actual Identifier. Contact [ADP Globalview (Deprecated) Client support team](https://www.adp.com/contact-us/overview.aspx) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up ADP Globalview (Deprecated)** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ADP Globalview (Deprecated) SSO

To configure single sign-on on **ADP Globalview (Deprecated)** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [ADP Globalview (Deprecated) support team](https://www.adp.com/contact-us/overview.aspx). They set this setting to have the SAML SSO connection set properly on both sides.

### Create ADP Globalview (Deprecated) test user

In this section, you create a user called B.Simon in ADP Globalview (Deprecated). Work with [ADP Globalview (Deprecated) support team](https://www.adp.com/contact-us/overview.aspx) to add the users in the ADP Globalview (Deprecated) platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the ADP Globalview (Deprecated) for which you set up the SSO

* You can use Microsoft My Apps. When you select the ADP Globalview (Deprecated) tile in the My Apps, you should be automatically signed in to the ADP Globalview (Deprecated) for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure ADP Globalview (Deprecated) you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
