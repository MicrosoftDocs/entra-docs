---
title: Configure AppRemo for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and AppRemo.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and AppRemo so that I can control who has access to AppRemo, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure AppRemo for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate AppRemo with Microsoft Entra ID. When you integrate AppRemo with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to AppRemo.
* Enable your users to be automatically signed-in to AppRemo with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* AppRemo single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* AppRemo supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Adding AppRemo from the gallery

To configure the integration of AppRemo into Microsoft Entra ID, you need to add AppRemo from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **AppRemo** in the search box.
1. Select **AppRemo** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-appremo'></a>

## Configure and test Microsoft Entra SSO for AppRemo

Configure and test Microsoft Entra SSO with AppRemo using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in AppRemo.

To configure and test Microsoft Entra SSO with AppRemo, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure AppRemo SSO](#configure-appremo-sso)** - to configure the single sign-on settings on application side.
    1. **[Create AppRemo test user](#create-appremo-test-user)** - to have a counterpart of B.Simon in AppRemo that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **AppRemo** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    |------------|
    | `https://<ENVIRONMENT>.exexwf.com/wf`|
    | `https://<ENVIRONMENT>.appremo.jp/wf`|
    | `https://<ENVIRONMENT>.fr.appremo.jp/wf`|
    | `https://<ENVIRONMENT>.mlt.appremo.jp/wf`|
    |

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    |------------|
    | `https://<ENVIRONMENT>.exexwf.com/auth/saml`|
    | `https://<ENVIRONMENT>.appremo.jp/auth/saml`|
    | `https://<ENVIRONMENT>.fr.appremo.jp/auth/saml`|
    | `https://<ENVIRONMENT>.mlt.appremo.jp/auth/saml`|
    |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Reply URL. Contact [AppRemo Client support team](mailto:AR-support@system-exe.co.jp) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up AppRemo** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)
<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure AppRemo SSO

To configure single sign-on on **AppRemo** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [AppRemo support team](mailto:AR-support@system-exe.co.jp). They set this setting to have the SAML SSO connection set properly on both sides.

### Create AppRemo test user

In this section, you create a user called Britta Simon in AppRemo. Work with [AppRemo support team](mailto:AR-support@system-exe.co.jp) to add the users in the AppRemo platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to AppRemo Sign-on URL where you can initiate the login flow. 

* Go to AppRemo Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the AppRemo tile in the My Apps, this option redirects to AppRemo Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).


## Related content

Once you configure AppRemo you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
