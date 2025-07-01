---
title: Configure Asset Bank for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Asset Bank.

author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Asset Bank so that I can control who has access to Asset Bank, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Asset Bank for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Asset Bank with Microsoft Entra ID. When you integrate Asset Bank with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Asset Bank.
* Enable your users to be automatically signed-in to Asset Bank with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Asset Bank single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Asset Bank supports **SP** initiated SSO.
* Asset Bank supports **Just In Time** user provisioning.

## Add Asset Bank from the gallery

To configure the integration of Asset Bank into Microsoft Entra ID, you need to add Asset Bank from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Asset Bank** in the search box.
1. Select **Asset Bank** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-asset-bank'></a>

## Configure and test Microsoft Entra SSO for Asset Bank

Configure and test Microsoft Entra SSO with Asset Bank using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Asset Bank.

To configure and test Microsoft Entra SSO with Asset Bank, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Asset Bank SSO](#configure-asset-bank-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Asset Bank test user](#create-asset-bank-test-user)** - to have a counterpart of B.Simon in Asset Bank that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Asset Bank** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<companyname>.assetbank-server.com/shibboleth`

    b. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<companyname>.assetbank-server.com`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier and Sign on URL. Contact [Asset Bank Client support team](mailto:support@assetbank.co.uk) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up Asset Bank** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Asset Bank SSO

To configure single sign-on on **Asset Bank** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Asset Bank support team](mailto:support@assetbank.co.uk). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Asset Bank test user

In this section, a user called Britta Simon is created in Asset Bank. Asset Bank supports just-in-time user provisioning, which is enabled by default. There's no action item for you in this section. If a user doesn't already exist in Asset Bank, a new one is created after authentication.

> [!NOTE]
> If you need to create a user manually, you need to contact the [Asset Bank support team](mailto:support@assetbank.co.uk).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Asset Bank Sign-on URL where you can initiate the login flow. 

* Go to Asset Bank Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Asset Bank tile in the My Apps, this option redirects to Asset Bank Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Asset Bank you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
