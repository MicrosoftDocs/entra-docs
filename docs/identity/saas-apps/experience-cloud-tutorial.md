---
title: Configure Experience Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Experience Cloud.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Experience Cloud so that I can control who has access to Experience Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Experience Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Experience Cloud with Microsoft Entra ID. When you integrate Experience Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Experience Cloud.
* Enable your users to be automatically signed-in to Experience Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Experience Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Experience Cloud supports **SP and IDP** initiated SSO.

## Add Experience Cloud from the gallery

To configure the integration of Experience Cloud into Microsoft Entra ID, you need to add Experience Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Experience Cloud** in the search box.
1. Select **Experience Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-experience-cloud'></a>

## Configure and test Microsoft Entra SSO for Experience Cloud

Configure and test Microsoft Entra SSO with Experience Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Experience Cloud.

To configure and test Microsoft Entra SSO with Experience Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Experience Cloud SSO](#configure-experience-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Experience Cloud test user](#create-experience-cloud-test-user)** - to have a counterpart of B.Simon in Experience Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Experience Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, if you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using one of the following patterns:
   
   | **Identifier** |
   |-------|
   | `https://<cluster>.medallia.com/sso/<company>` |
   | `https://<cluster>.medallia.ca/sso/<company>` |
   | `https://<cluster>.medallia.eu/sso/<company>` |
   | `https://<cluster>.medallia.au/sso/<company>` |
   
    b. In the **Reply URL** text box, type a URL using one of the following patterns:

   | **Reply URL** |
   |------|
   | `https://<cluster>.medallia.com/sso/<company>/logonSubmit.do` |
   | `https://<cluster>.medallia.ca/sso/<company>/logonSubmit.do` |
   | `https://<cluster>.medallia.eu/sso/<company>/logonSubmit.do` |
   | `https://<cluster>.medallia.au/sso/<company>/logonSubmit.do` |

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | **Sign-on URL** |
    |------|
    | `https://<cluster>.medallia.com/sso/<company>` |
    | `https://<cluster>.medallia.ca/sso/<company>` |
    | `https://<cluster>.medallia.eu/sso/<company>` |
    | `https://<cluster>.medallia.au/sso/<company>` |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Experience Cloud Client support team](mailto:support@medallia.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Experience Cloud** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Experience Cloud SSO

To configure single sign-on on **Experience Cloud** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Experience Cloud support team](mailto:support@medallia.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Experience Cloud test user

In this section, you create a user called B.Simon in Experience Cloud. Work with [Experience Cloud support team](mailto:support@medallia.com) to add the users in the Experience Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Experience Cloud Sign on URL where you can initiate the login flow.  

* Go to Experience Cloud Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Experience Cloud for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Experience Cloud tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Experience Cloud for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Experience Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
