---
title: Configure The Cloud Security Fabric for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and The Cloud Security Fabric.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and The Cloud Security Fabric so that I can control who has access to The Cloud Security Fabric, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure The Cloud Security Fabric for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate The Cloud Security Fabric with Microsoft Entra ID. When you integrate The Cloud Security Fabric with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to The Cloud Security Fabric.
* Enable your users to be automatically signed-in to The Cloud Security Fabric with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* The Cloud Security Fabric single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* The Cloud Security Fabric supports **SP** initiated SSO.

## Add The Cloud Security Fabric from the gallery

To configure the integration of The Cloud Security Fabric into Microsoft Entra ID, you need to add The Cloud Security Fabric from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **The Cloud Security Fabric** in the search box.
1. Select **The Cloud Security Fabric** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-the-cloud-security-fabric'></a>

## Configure and test Microsoft Entra SSO for The Cloud Security Fabric

Configure and test Microsoft Entra SSO with The Cloud Security Fabric using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in The Cloud Security Fabric.

To configure and test Microsoft Entra SSO with The Cloud Security Fabric, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure The Cloud Security Fabric SSO](#configure-the-cloud-security-fabric-sso)** - to configure the single sign-on settings on application side.
    1. **[Create The Cloud Security Fabric test user](#create-the-cloud-security-fabric-test-user)** - to have a counterpart of B.Simon in The Cloud Security Fabric that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **The Cloud Security Fabric** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

	a. In the **Sign on URL** text box, type a URL using one of the following patterns:

      | **Sign on URL** |
      |--------|
      | `https://platform.cloudlock.com` |
      | `https://app.cloudlock.com` |
      
   b. In the **Identifier (Entity ID)** text box, type a URL using one of the following patterns:

      | **Identifier** |
      |---------|
      | `https://platform.cloudlock.com/gate/saml/sso/<subdomain>` |
      | `https://app.cloudlock.com/gate/saml/sso/<subdomain>` |
     
	> [!NOTE]
	> The Identifier value isn't real. Update the value with the actual Identifier. Contact [The Cloud Security Fabric Client support team](mailto:support@cloudlock.com) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

5. To Modify the **Signing** options as per your requirement, select **Edit** button to open **SAML Signing Certificate** dialog.

	a. Select the **Sign SAML response and assertion** option for **Signing Option**.

	b. Select the **SHA-256** option for **Signing Algorithm**.

	c. Select **Save**.	

6. On the **Set up The Cloud Security Fabric** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure The Cloud Security Fabric SSO

To configure single sign-on on **The Cloud Security Fabric** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [The Cloud Security Fabric support team](mailto:support@cloudlock.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create The Cloud Security Fabric test user

In this section, you create a user called B.Simon in The Cloud Security Fabric. Work with [The Cloud Security Fabric support team](mailto:support@cloudlock.com) to add the users in the The Cloud Security Fabric platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to The Cloud Security Fabric Sign-on URL where you can initiate the login flow. 

* Go to The Cloud Security Fabric Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the The Cloud Security Fabric tile in the My Apps, this option redirects to The Cloud Security Fabric Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure The Cloud Security Fabric you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
