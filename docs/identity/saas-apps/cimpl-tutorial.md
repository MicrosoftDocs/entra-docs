---
title: Configure Cimpl for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cimpl.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cimpl so that I can control who has access to Cimpl, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Cimpl for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cimpl with Microsoft Entra ID. When you integrate Cimpl with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cimpl.
* Enable your users to be automatically signed-in to Cimpl with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cimpl single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Cimpl supports **SP** initiated SSO.

## Add Cimpl from the gallery

To configure the integration of Cimpl into Microsoft Entra ID, you need to add Cimpl from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cimpl** in the search box.
1. Select **Cimpl** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cimpl'></a>

## Configure and test Microsoft Entra SSO for Cimpl

Configure and test Microsoft Entra SSO with Cimpl using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cimpl.

To configure and test Microsoft Entra SSO with Cimpl, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cimpl SSO](#configure-cimpl-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cimpl test user](#create-cimpl-test-user)** - to have a counterpart of B.Simon in Cimpl that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cimpl** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://sso.etelesolv.com/<TENANTNAME>`
    
    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://sso.etelesolv.com/<TENANTNAME>`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact Cimpl team at **+1 866-982-8250** to get these values.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Cimpl** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cimpl SSO

To configure single sign-on on **Cimpl** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from the application configuration to Cimpl support at **+1 866-982-8250**. They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cimpl test user

The objective of this section is to create a user called Britta Simon in Cimpl. Work with Cimpl support at **+1 866-982-8250** to add the users in the Cimpl account.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Cimpl Sign-on URL where you can initiate the login flow. 

* Go to Cimpl Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Cimpl tile in the My Apps, this option redirects to Cimpl Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Cimpl you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
