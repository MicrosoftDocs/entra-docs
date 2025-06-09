---
title: Configure OnPage (SSO) for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and OnPage (SSO).
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/27/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Directory Services so that I can control who has access to Directory Services, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure OnPage (SSO) for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate OnPage (SSO) with Microsoft Entra ID. When you integrate OnPage (SSO) with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to OnPage (SSO).
* Enable your users to be automatically signed-in to OnPage (SSO) with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* OnPage (SSO) single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* OnPage (SSO) supports **SP** initiated SSO.

## Add OnPage (SSO) from the gallery

To configure the integration of OnPage (SSO) into Microsoft Entra ID, you need to add OnPage (SSO) from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **OnPage (SSO)** in the search box.
1. Select **OnPage (SSO)** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

[!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

## Configure and test Microsoft Entra SSO for OnPage (SSO)

Configure and test Microsoft Entra SSO with OnPage (SSO) using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in OnPage (SSO).

To configure and test Microsoft Entra SSO with OnPage (SSO), perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Create a Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure OnPage (SSO)](#configure-onpage-sso)** - to configure the single sign-on settings on application side.
    1. **[Create OnPage (SSO) test user](#create-onpage-sso-test-user)** - to have a counterpart of B.Simon in OnPage (SSO) that's linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **OnPage (SSO)** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<SUBDOMAIN>.onpagecorp.com/`

    b. In the **Reply URL** text box, type one of the following URLs:

    | Reply URL |
    |----|
    | `https://sso.onsetmobile.com/dc/v1/callback` |
    | `https://sso.onsetmobile.com/md/v1/callback` |

    c. In the **Sign on URL** text box, type one of the following URLs:

    | Sign on URL |
    |----|
    | `https://sso.onpage.com/dc/v1` |
    | `https://sso.onpage.com/md/v1` |

	> [!NOTE]
	> The Identifier value isn't real. Update the value with the actual Identifier. Contact [OnPage (SSO) support team](mailto:support@onpagecorp.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section in the Microsoft Entra admin center.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Raw)** and select **Download** to download the certificate and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificateraw.png "Certificate")

1. On the **Set up OnPage (SSO)** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration URLs.](common/copy-configuration-urls.png "Metadata")

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure OnPage (SSO)

To configure single sign-on on **OnPage (SSO)** side, you need to send the downloaded **Certificate (Raw)** and appropriate copied URLs from Microsoft Entra admin center to [OnPage (SSO) support team](mailto:support@onpagecorp.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create OnPage (SSO) test user

In this section, you create a user called B.Simon in OnPage (SSO). Work with [OnPage (SSO) support team](mailto:support@onpagecorp.com) to add the users in the OnPage (SSO) platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
* Select **Test this application** in Microsoft Entra admin center. this option redirects to OnPage (SSO) Sign-on URL where you can initiate the login flow.
 
* Go to OnPage (SSO) Sign-on URL directly and initiate the login flow from there.
 
* You can use Microsoft My Apps. When you select the OnPage (SSO) tile in the My Apps, this option redirects to OnPage (SSO) Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure OnPage (SSO) you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).