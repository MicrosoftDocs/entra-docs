---
title: Configure Cloud Management Portal for Microsoft Azure for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cloud Management Portal for Microsoft Azure.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cloud Management Portal for Microsoft Azure so that I can control who has access to Cloud Management Portal for Microsoft Azure, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Cloud Management Portal for Microsoft Azure for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cloud Management Portal for Microsoft Azure with Microsoft Entra ID. When you integrate Cloud Management Portal for Microsoft Azure with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cloud Management Portal for Microsoft Azure.
* Enable your users to be automatically signed-in to Cloud Management Portal for Microsoft Azure with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cloud Management Portal for Microsoft Azure single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Cloud Management Portal for Microsoft Azure supports **SP** initiated SSO.

## Add Cloud Management Portal for Microsoft Azure from the gallery

To configure the integration of Cloud Management Portal for Microsoft Azure into Microsoft Entra ID, you need to add Cloud Management Portal for Microsoft Azure from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cloud Management Portal for Microsoft Azure** in the search box.
1. Select **Cloud Management Portal for Microsoft Azure** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cloud-management-portal-for-microsoft-azure'></a>

## Configure and test Microsoft Entra SSO for Cloud Management Portal for Microsoft Azure

Configure and test Microsoft Entra SSO with Cloud Management Portal for Microsoft Azure using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cloud Management Portal for Microsoft Azure.

To configure and test Microsoft Entra SSO with Cloud Management Portal for Microsoft Azure, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cloud Management Portal for Microsoft Azure SSO](#configure-cloud-management-portal-for-microsoft-azure-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cloud Management Portal for Microsoft Azure test user](#create-cloud-management-portal-for-microsoft-azure-test-user)** - to have a counterpart of B.Simon in Cloud Management Portal for Microsoft Azure that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cloud Management Portal for Microsoft Azure** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:
  
    a. In the **Identifier** box, type a URL using one of the following patterns:

    | **Identifier** |
    |------|
    | `https://<subdomain>.igcm.com` |
    | `https://<subdomain>.newsignature.com` |

    b. In the **Reply URL** text box, type a URL using one of the following patterns:

    | **Reply URL** |
    |----|
    | `https://<subdomain>.igcm.com/<instancename>` |
    | `https://<subdomain>.newsignature.com` |
    | `https://<subdomain>.newsignature.com/<instancename>` |
    
    c. In the **Sign-on URL** text box, type a URL using one of the following patterns:

    | **Sign-on URL** |
    |------|
    | `https://portal.newsignature.com/<instancename>` |
    | `https://portal.igcm.com/<instancename>` |

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Cloud Management Portal for Microsoft Azure Client support team](mailto:jczernuszka@newsignature.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Cloud Management Portal for Microsoft Azure** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cloud Management Portal for Microsoft Azure SSO

To configure single sign-on on **Cloud Management Portal for Microsoft Azure** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to [Cloud Management Portal for Microsoft Azure support team](mailto:jczernuszka@newsignature.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cloud Management Portal for Microsoft Azure test user

In this section, you create a user called Britta Simon in Cloud Management Portal for Microsoft Azure. Work with [Cloud Management Portal for Microsoft Azure support team](mailto:jczernuszka@newsignature.com) to add the users in the Cloud Management Portal for Microsoft Azure platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Cloud Management Portal for Microsoft Azure Sign-on URL where you can initiate the login flow. 

* Go to Cloud Management Portal for Microsoft Azure Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Cloud Management Portal for Microsoft Azure tile in the My Apps, this option redirects to Cloud Management Portal for Microsoft Azure Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Cloud Management Portal for Microsoft Azure you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
