---
title: Configure FactSet for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and FactSet.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and FactSet so that I can control who has access to FactSet, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure FactSet for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate FactSet with Microsoft Entra ID. When you integrate FactSet with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to FactSet URLs via the Federation.
* Enable your users to be automatically signed-in to FactSet with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* FactSet single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* FactSet supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add FactSet from the gallery

To configure the integration of FactSet into Microsoft Entra ID, you need to add FactSet from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **FactSet** in the search box.
1. Select **FactSet** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-factset'></a>

## Configure and test Microsoft Entra SSO for FactSet

Configure and test Microsoft Entra SSO with FactSet using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in FactSet.

To configure and test Microsoft Entra SSO with FactSet, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure FactSet SSO](#configure-factset-sso)** - to configure the single sign-on settings on application side.
    1. **[Create FactSet test user](#create-factset-test-user)** - to have a counterpart of B.Simon in FactSet that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **FactSet** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** text box, type the URL:
    `https://auth.factset.com`

    b. In the **Reply URL** text box, type the URL:
    `https://auth.factset.com/sp/ACS.saml2`

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the metadata file and save it on your computer.

	![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up FactSet** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate URL.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure FactSet SSO

To configure single sign-on on FactSet side you need to visit FactSet's [Control Center](https://controlcenter.factset.com) and configure the **Federation Metadata XML** and appropriate copied URLs from Azure portal under **Control Center's Security > Single Sign-On (SSO)** page. If you require access to this page, please contact [FactSet Support Team](https://www.factset.com/contact-us) and request FactSet product 8514 (Control Center - Source IPs, Security + Authentication).

### Create FactSet test user

Work with your FactSet account support representatives or contact [FactSet Support Team](https://www.factset.com/contact-us) to add the users in the FactSet platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following option.

* FactSet only supports SP-initiated SAML. You may test SSO by visiting any authenticated FactSet URL such as [Issue Tracker](https://issuetracker.factset.com) or [FactSet-Web](https://my.factset.com), select **Single Sign-On (SSO)** on the logon portal and supply your email address in the subsequent page. Please see supplied [documentation](https://download.factset.com/documents/web/FactSet_Single_Sign-On.pdf) for additional information and usage.  

## Related content

Once you configure FactSet you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
