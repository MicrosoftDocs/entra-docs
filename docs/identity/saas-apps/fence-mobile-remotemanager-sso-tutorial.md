---
title: Configure FENCE-Mobile RemoteManager SSO for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FENCE-Mobile RemoteManager SSO.

author: nguhiu
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FENCE-Mobile RemoteManager SSO so that I can control who has access to FENCE-Mobile RemoteManager SSO, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FENCE-Mobile RemoteManager SSO for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FENCE-Mobile RemoteManager SSO with Microsoft Entra ID. When you integrate FENCE-Mobile RemoteManager SSO with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FENCE-Mobile RemoteManager SSO.
* Enable your users to be automatically signed-in to FENCE-Mobile RemoteManager SSO with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FENCE-Mobile RemoteManager SSO single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FENCE-Mobile RemoteManager SSO supports **SP** initiated SSO.

## Adding FENCE-Mobile RemoteManager SSO from the gallery

To configure the integration of FENCE-Mobile RemoteManager SSO into Microsoft Entra ID, you need to add FENCE-Mobile RemoteManager SSO from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FENCE-Mobile RemoteManager SSO** in the search box.
1. Select **FENCE-Mobile RemoteManager SSO** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-fence-mobile-remotemanager-sso'></a>

## Configure and test Microsoft Entra SSO for FENCE-Mobile RemoteManager SSO

Configure and test Microsoft Entra SSO with FENCE-Mobile RemoteManager SSO using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FENCE-Mobile RemoteManager SSO.

To configure and test Microsoft Entra SSO with FENCE-Mobile RemoteManager SSO, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FENCE-Mobile RemoteManager SSO](#configure-fence-mobile-remotemanager-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FENCE-Mobile RemoteManager SSO test user](#create-fence-mobile-remotemanager-sso-test-user)** - to have a counterpart of B.Simon in FENCE-Mobile RemoteManager SSO that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FENCE-Mobile RemoteManager SSO** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `api://www.fence-mrm.bsc.fujitsu.com/<TID>/<GUID>`

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | Reply URL |
    | --------------- |
    | `https://www.fence-mrm.bsc.fujitsu.com/SConsole/SSOServlet?tid=<TID>` |
    | `https://ctl.fence-mrm.bsc.fujitsu.com/SControl/SSOServlet?tid=<TID>` |
    | `https://www.fence-mrm.bsc.fujitsu.com/IMDMLogin/SSOServlet?tid=<TID>` |
    |

    
    c. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://www.fence-mrm.bsc.fujitsu.com/SConsole/login.jsf?tid=<TID>`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [FENCE-Mobile RemoteManager SSO Client support team](mailto:fj-FMRM_Dev_Azure@dl.jp.fujitsu.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up FENCE-Mobile RemoteManager SSO** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FENCE-Mobile RemoteManager SSO

To configure single sign-on on **FENCE-Mobile RemoteManager SSO** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [FENCE-Mobile RemoteManager SSO support team](mailto:fj-FMRM_Dev_Azure@dl.jp.fujitsu.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create FENCE-Mobile RemoteManager SSO test user

In this section, you create a user called Britta Simon in FENCE-Mobile RemoteManager SSO. Work with [FENCE-Mobile RemoteManager SSO support team](mailto:fj-FMRM_Dev_Azure@dl.jp.fujitsu.com) to add the users in the FENCE-Mobile RemoteManager SSO platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to FENCE-Mobile RemoteManager SSO Sign-on URL where you can initiate the login flow. 

* Go to FENCE-Mobile RemoteManager SSO Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the FENCE-Mobile RemoteManager SSO tile in the My Apps, this option redirects to FENCE-Mobile RemoteManager SSO Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure FENCE-Mobile RemoteManager SSO you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
