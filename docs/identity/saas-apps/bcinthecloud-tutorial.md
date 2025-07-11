---
title: Configure BC in the Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and BC in the Cloud.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and BC in the Cloud so that I can control who has access to BC in the Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure BC in the Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate BC in the Cloud with Microsoft Entra ID. When you integrate BC in the Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to BC in the Cloud.
* Enable your users to be automatically signed-in to BC in the Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* BC in the Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* BC in the Cloud supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add BC in the Cloud from the gallery

To configure the integration of BC in the Cloud into Microsoft Entra ID, you need to add BC in the Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **BC in the Cloud** in the search box.
1. Select **BC in the Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-bc-in-the-cloud'></a>

## Configure and test Microsoft Entra SSO for BC in the Cloud

Configure and test Microsoft Entra SSO with BC in the Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in BC in the Cloud.

To configure and test Microsoft Entra SSO with BC in the Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure BC in the Cloud SSO](#configure-bc-in-the-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create BC in the Cloud test user](#create-bc-in-the-cloud-test-user)** - to have a counterpart of B.Simon in BC in the Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **BC in the Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
    `https://app.bcinthecloud.com`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://app.bcinthecloud.com/router/loginSaml/<customerid>`

    > [!NOTE]
    > This value isn't real. Update this value with the actual Sign-On URL. Contact [BC in the Cloud Client support team](https://www.bcinthecloud.com/supportcenter/) to get this value.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up BC in the Cloud** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure BC in the Cloud SSO

To configure single sign-on on **BC in the Cloud** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [BC in the Cloud support team](https://www.bcinthecloud.com/supportcenter/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create BC in the Cloud test user

In this section, you create a user called Britta Simon in BC in the Cloud. Work with [BC in the Cloud support team](https://www.bcinthecloud.com/supportcenter/) to add the users in the BC in the Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to BC in the Cloud Sign-on URL where you can initiate the login flow. 

* Go to BC in the Cloud Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the BC in the Cloud tile in the My Apps, this option redirects to BC in the Cloud Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure BC in the Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
