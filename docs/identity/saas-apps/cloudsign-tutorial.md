---
title: Configure CloudSign for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and CloudSign.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and CloudSign so that I can control who has access to CloudSign, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure CloudSign for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate CloudSign with Microsoft Entra ID. When you integrate CloudSign with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CloudSign.
* Enable your users to be automatically signed-in to CloudSign with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* CloudSign single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* CloudSign supports **SP** initiated SSO.

## Add CloudSign from the gallery

To configure the integration of CloudSign into Microsoft Entra ID, you need to add CloudSign from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **CloudSign** in the search box.
1. Select **CloudSign** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cloudsign'></a>

## Configure and test Microsoft Entra SSO for CloudSign

Configure and test Microsoft Entra SSO with CloudSign using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in CloudSign.

To configure and test Microsoft Entra SSO with CloudSign, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure CloudSign SSO](#configure-cloudsign-sso)** - to configure the single sign-on settings on application side.
    1. **[Create CloudSign test user](#create-cloudsign-test-user)** - to have a counterpart of B.Simon in CloudSign that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **CloudSign** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a value using the following pattern:
    `urn:amazon:cognito:sp:ap-northeast-1_<CUSTOM_ID>`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://cloudsign-<CUSTOM_ID>.auth.ap-northeast-1.amazoncognito.com/saml2/idpresponse`

	c. In the **Sign on URL** text box, type the URL:
    `https://www.cloudsign.jp/login`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier and Reply URL. Contact [CloudSign Client support team](mailto:contact@cloudsign.jp) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up CloudSign** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure CloudSign SSO

To configure single sign-on on CloudSign side, follow the instructions on the [CloudSign support page](https://help.cloudsign.jp/ja/articles/4000055).

### Create CloudSign test user

In this section, you create a user called B.Simon in CloudSign. Work with [CloudSign support team](mailto:contact@cloudsign.jp) to add the users in the CloudSign platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to CloudSign Sign-on URL where you can initiate the login flow. 

* Go to CloudSign Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the CloudSign tile in the My Apps, this option redirects to CloudSign Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure CloudSign you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
